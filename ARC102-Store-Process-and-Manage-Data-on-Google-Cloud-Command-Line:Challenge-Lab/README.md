
## Store, Process, and Manage Data on Google Cloud - Command Line: Challenge Lab (ARC102)

[![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.svg)](https://ssh.cloud.google.com/cloudshell/open?cloudshell_git_repo=https://github.com/fatihatunnisa/cloudskillsboost-google&cloudshell_working_dir=ARC102-Store-Process-and-Manage-Data-on-Google-Cloud-Command-Line:Challenge-Lab&cloudshell_tutorial=README.md)

[![Google Cloud Functions Architecture](https://img.shields.io/badge/View-Architecture-blue?logo=googlecloud)](https://cloud.google.com/functions/docs/tutorials/storage)

---

## 📌 Table of Contents
- [Lab Overview](#-lab-overview)
- [Prerequisites](#-prerequisites)
- [Script Features](#-script-features)
- [Installation](#-installation)
- [Usage](#-usage)
- [Customization](#-customization)
- [Output Examples](#-output-examples)
- [Troubleshooting](#-troubleshooting)
- [Cleanup](#-cleanup)
- [Contributing](#-contributing)
- [License](#-license)

---

## 🔍 Lab Overview

This repository contains an automation script for the Google Cloud Skills Boost lab **GSPXXX: Wild Thumbnail Generator**. The script completes all lab tasks including:

- Creating a Cloud Storage bucket for wildlife photographs
- Creating a Pub/Sub topic for thumbnail notifications
- Deploying a 2nd-gen Cloud Function triggered by image uploads
- Generating 64x64 thumbnails for `.jpg` and `.png` files
- Publishing thumbnail filenames to Pub/Sub

---

## 🛠️ Prerequisites

Before running the script:

- Active Google Cloud Project
- Owner or Editor permissions
- Cloud Shell or gcloud CLI installed
- Enabled APIs:
  - `cloudfunctions.googleapis.com`
  - `pubsub.googleapis.com`
  - `eventarc.googleapis.com`
  - `storage.googleapis.com`

---

## ✨ Script Features

| Feature              | Description                                 | Emoji |
|----------------------|---------------------------------------------|-------|
| **Auto-Setup**        | Creates bucket, topic, and function         | ⚙️     |
| **Thumbnail Logic**   | Resizes images to 64x64                     | 🖼️     |
| **Pub/Sub Messaging** | Publishes thumbnail filenames               | 📣     |
| **IAM Fix**           | Grants required Eventarc permissions       | 🔐     |
| **Visual Feedback**   | Color-coded output with emoji indicators   | 🎨     |
| **Validation**        | Skips existing resources                    | ⏭️     |
| **Error Handling**    | Detects and reports deployment issues       | ❌     |

---

## 📥 Installation

### ✅ Method 1: Cloud Shell

```bash
git clone https://github.com/fatihatunnisa/cloudskillsboost-google.git
cd cloudskillsboost-google/ARC102-Store-Process-and-Manage-Data-on-Google-Cloud-Command-Line:Challenge-Lab
```

### ✅ Method 2: Direct Download

```bash
wget https://raw.githubusercontent.com/fatihatunnisa/cloudskillsboost-google/main/ARC102-Store-Process-and-Manage-Data-on-Google-Cloud-Command-Line:Challenge-Lab/ARC102.sh
chmod +x ARC102.sh
```

---

## 🚀 Usage

### 🔹 Basic Execution

```bash
./ARC102.sh
```

### 🔹 Advanced Options

| 🏷️ Flag           | 📝 Description               |
|-------------------|------------------------------|
| `--no-cleanup`    | Skip image upload            |
| `--verbose`       | Show detailed output         |
| `--region=REGION` | Set deployment region manually  |

---

## 🧰 Customization

Set environment variables to override defaults:

```bash
export BUCKET_NAME="custom-bucket"
export TOPIC_NAME="custom-topic"
export FUNCTION_NAME="custom-function"
```

---

## 📊 Output Examples

### ✅ Successful Execution

```plaintext
🪣 Bucket created: wild-bucket-qwiklabs-gcp-01-9134212e8d2e
📣 Topic created: wild-topic-278
⚙️ Cloud Function deployed: wild-thumbnail-generator
🖼️ Image uploaded: wildlife.jpg
✅ Thumbnail created: wildlife64x64_thumbnail.jpg
```

---

## 🐛 Troubleshooting

### 🔧 Common Issues

1. **🔐 IAM Role Missing**

```bash
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:service-$PROJECT_NUMBER@gs-project-accounts.iam.gserviceaccount.com" \
  --role="roles/pubsub.publisher"
```

2. **📉 Notification Quota Exceeded**

```bash
gcloud storage buckets notifications list gs://your-bucket
gcloud storage buckets notifications delete NOTIFICATION_ID --bucket=your-bucket
```

3. **🚫 API Not Enabled**

```bash
gcloud services enable cloudfunctions.googleapis.com pubsub.googleapis.com eventarc.googleapis.com
```

---

## 🧹 Cleanup

### 🧼 Manual Cleanup

```bash
gcloud functions delete wild-thumbnail-generator --region=us-east1
gcloud pubsub topics delete wild-topic-278
gsutil rm -r gs://wild-bucket-qwiklabs-gcp-01-9134212e8d2e
```

---

## 🤝 Contributing

Want to improve this script? Follow these steps:

1. 🍴 Fork the repository  
2. 🛠️ Create a feature branch: `git checkout -b feature/improvement`  
3. 💾 Commit your changes: `git commit -am 'Add some feature'`  
4. 🚀 Push to GitHub: `git push origin feature/improvement`  
5. 📬 Open a Pull Request

---

## 📜 License

This project is licensed under the **Apache License 2.0**. See the [LICENSE](LICENSE) file for details.

---

## 🔗 Additional Resources

- 📘 [Cloud Functions Documentation](https://cloud.google.com/functions/docs)
- 🧠 [Eventarc Trigger Setup](https://cloud.google.com/eventarc/docs/run/quickstart-storage)
- 🧪 [Cloud Storage Quotas](https://cloud.google.com/storage/quotas)
```

Let me know if you'd like me to generate the matching folder structure or link this to a GitHub repo template.