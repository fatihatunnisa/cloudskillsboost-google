#!/bin/bash
# Filename: ARC102-Store-Process-and-Manage-Data-on-Google-Cloud-Command-Line:Challenge-Lab
# Lab: Pub/Sub: Store, Process, and Manage Data on Google Cloud - Command Line: Challenge Lab
# Course: Google Cloud Skills Boost (ARC102)


# ─────────────────────────────────────────────
# Color & Icon Definitions
# ─────────────────────────────────────────────
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[1;34m'
NC='\033[0m' # No Color

ICON_BUCKET="🪣"
ICON_TOPIC="📣"
ICON_FUNCTION="⚙️"
ICON_IMAGE="🖼️"
ICON_DONE="✅"
ICON_SKIP="⏭️"
ICON_ERROR="❌"

# ─────────────────────────────────────────────
# Configuration
# ─────────────────────────────────────────────
REGION="us-east1"
BUCKET_NAME="wild-bucket-qwiklabs-gcp-01-9134212e8d2e"
TOPIC_NAME="wild-topic-278"
FUNCTION_NAME="wild-thumbnail-generator"
FUNCTION_DIR="wild-thumbnail-fn"
IMAGE_URL="https://storage.googleapis.com/cloud-training/arc102/wildlife.jpg"
IMAGE_FILE="wildlife.jpg"
THUMBNAIL_NAME="wildlife64x64_thumbnail.jpg"

# ─────────────────────────────────────────────
# IAM Fix for Eventarc Trigger
# ─────────────────────────────────────────────
echo -e "${BLUE}🔐 Ensuring IAM permissions for Cloud Storage service agent..."
PROJECT_ID=$(gcloud config get-value project)
PROJECT_NUMBER=$(gcloud projects describe $PROJECT_ID --format="value(projectNumber)")

gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:service-${PROJECT_NUMBER}@gs-project-accounts.iam.gserviceaccount.com" \
  --role="roles/pubsub.publisher" && \
echo -e "${GREEN}${ICON_DONE} IAM role granted to Cloud Storage service agent.${NC}" || \
echo -e "${RED}${ICON_ERROR} Failed to grant IAM role.${NC}"

# ─────────────────────────────────────────────
# Step 1: Create Cloud Storage Bucket
# ─────────────────────────────────────────────
echo -e "${BLUE}${ICON_BUCKET} Checking bucket: ${BUCKET_NAME}..."
if gsutil ls -b gs://$BUCKET_NAME &> /dev/null; then
  echo -e "${YELLOW}${ICON_SKIP} Bucket already exists, skipping.${NC}"
else
  gsutil mb -l $REGION gs://$BUCKET_NAME/ && \
  echo -e "${GREEN}${ICON_DONE} Bucket created.${NC}" || \
  echo -e "${RED}${ICON_ERROR} Failed to create bucket.${NC}"
fi

# ─────────────────────────────────────────────
# Step 2: Create Pub/Sub Topic
# ─────────────────────────────────────────────
echo -e "${BLUE}${ICON_TOPIC} Checking topic: ${TOPIC_NAME}..."
if gcloud pubsub topics describe $TOPIC_NAME &> /dev/null; then
  echo -e "${YELLOW}${ICON_SKIP} Topic already exists, skipping.${NC}"
else
  gcloud pubsub topics create $TOPIC_NAME && \
  echo -e "${GREEN}${ICON_DONE} Topic created.${NC}" || \
  echo -e "${RED}${ICON_ERROR} Failed to create topic.${NC}"
fi

# ─────────────────────────────────────────────
# Step 3: Prepare Cloud Function Code
# ─────────────────────────────────────────────
echo -e "${BLUE}${ICON_FUNCTION} Preparing Cloud Function code..."
mkdir -p $FUNCTION_DIR

cat > $FUNCTION_DIR/index.js <<EOF
"use strict";
const crc32 = require("fast-crc32c");
const { Storage } = require('@google-cloud/storage');
const gcs = new Storage();
const { PubSub } = require('@google-cloud/pubsub');
const imagemagick = require("imagemagick-stream");

exports.thumbnail = (event, context) => {
  const fileName = event.name;
  const bucketName = event.bucket;
  const size = "64x64";
  const bucket = gcs.bucket(bucketName);
  const topicName = "$TOPIC_NAME";
  const pubsub = new PubSub();

  if (fileName.search("64x64_thumbnail") === -1) {
    const filename_split = fileName.split('.');
    const filename_ext = filename_split[filename_split.length - 1];
    const filename_without_ext = fileName.substring(0, fileName.length - filename_ext.length);

    if (filename_ext.toLowerCase() === 'png' || filename_ext.toLowerCase() === 'jpg') {
      console.log(\`Processing Original: gs://\${bucketName}/\${fileName}\`);
      const gcsObject = bucket.file(fileName);
      const newFilename = filename_without_ext + size + '_thumbnail.' + filename_ext;
      const gcsNewObject = bucket.file(newFilename);
      const srcStream = gcsObject.createReadStream();
      const dstStream = gcsNewObject.createWriteStream();
      const resize = imagemagick().resize(size).quality(90);

      srcStream.pipe(resize).pipe(dstStream);

      return new Promise((resolve, reject) => {
        dstStream
          .on("error", (err) => {
            console.log(\`Error: \${err}\`);
            reject(err);
          })
          .on("finish", () => {
            console.log(\`Success: \${fileName} → \${newFilename}\`);
            gcsNewObject.setMetadata({
              contentType: 'image/' + filename_ext.toLowerCase()
            }, function(err, apiResponse) {});

            pubsub
              .topic(topicName)
              .publishMessage({ data: Buffer.from(newFilename) })
              .then(messageId => {
                console.log(\`Message \${messageId} published.\`);
              })
              .catch(err => {
                console.error('ERROR:', err);
              });
          });
      });
    } else {
      console.log(\`gs://\${bucketName}/\${fileName} is not an image I can handle\`);
    }
  } else {
    console.log(\`gs://\${bucketName}/\${fileName} already has a thumbnail\`);
  }
};
EOF

cat > $FUNCTION_DIR/package.json <<EOF
{
  "name": "thumbnails",
  "version": "1.0.0",
  "description": "Create Thumbnail of uploaded image",
  "scripts": {
    "start": "node index.js"
  },
  "dependencies": {
    "@google-cloud/pubsub": "^3.0.0",
    "@google-cloud/storage": "^6.0.0",
    "fast-crc32c": "1.0.4",
    "imagemagick-stream": "4.1.1"
  },
  "engines": {
    "node": ">=18"
  }
}
EOF

echo -e "${GREEN}${ICON_DONE} Function code prepared.${NC}"

# ─────────────────────────────────────────────
# Step 4: Deploy Cloud Function (2nd Gen)
# ─────────────────────────────────────────────
echo -e "${BLUE}${ICON_FUNCTION} Deploying Cloud Function..."
gcloud functions deploy $FUNCTION_NAME \
  --entry-point thumbnail \
  --runtime nodejs18 \
  --trigger-event google.storage.object.finalize \
  --trigger-resource $BUCKET_NAME \
  --region $REGION \
  --gen2 \
  --source $FUNCTION_DIR && \
echo -e "${GREEN}${ICON_DONE} Cloud Function deployed.${NC}" || \
echo -e "${RED}${ICON_ERROR} Failed to deploy Cloud Function.${NC}"

# ─────────────────────────────────────────────
# Step 5: Upload Image to Trigger Function
# ─────────────────────────────────────────────
echo -e "${BLUE}${ICON_IMAGE} Checking if thumbnail already exists..."
if gsutil ls gs://$BUCKET_NAME/$THUMBNAIL_NAME &> /dev/null; then
  echo -e "${YELLOW}${ICON_SKIP} Thumbnail already exists, skipping image upload.${NC}"
else
  wget -O $IMAGE_FILE $IMAGE_URL && \
  echo -e "${GREEN}${ICON_DONE} Image downloaded.${NC}" || \
  echo -e "${RED}${ICON_ERROR} Failed to download image.${NC}"

  gsutil cp $IMAGE_FILE gs://$BUCKET_NAME/ && \
  echo -e "${GREEN}${ICON_DONE} Image uploaded. Thumbnail should appear shortly.${NC}" || \
  echo -e "${RED}${ICON_ERROR} Failed to upload image.${NC}"
fi
