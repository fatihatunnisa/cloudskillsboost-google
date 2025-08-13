 # Google Cloud Pub/Sub: Qwik Start - Command Line (GSP095)

[![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.svg)](https://ssh.cloud.google.com/cloudshell/open?cloudshell_git_repo=https://github.com/fatihatunnisa/cloudskillsboost-google&cloudshell_working_dir=GSP095-Qwik-Start-PubSub-Command-Line&cloudshell_tutorial=README.md)

[![Google Cloud Pub/Sub Architecture](https://img.shields.io/badge/View-Architecture-blue?logo=googlecloud)](https://cloud.google.com/pubsub/architecture)

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

## 🔍 Lab Overview
This repository contains an automation script for Google Cloud Skills Boost lab **GSP095: Pub/Sub: Qwik Start - Command Line**. The script completes all lab tasks including:

- Pub/Sub topic creation and management
- Subscription configuration
- Message publishing and pulling
- Resource cleanup

## 🛠️ Prerequisites
Before running the script:
- Active Google Cloud Project
- Owner or Editor permissions
- Cloud Shell or gcloud CLI installed
- Pub/Sub API enabled (`pubsub.googleapis.com`)

## ✨ Script Features
| Feature | Description | Emoji Indicator |
|---------|-------------|-----------------|
| **Auto-Setup** | Configures environment automatically | ⚙️ |
| **Topic Management** | Creates/Deletes topics | 📢 |
| **Subscription Handling** | Manages pull subscriptions | 📩 |
| **Message Operations** | Publishes & pulls messages | ✉️ |
| **Visual Feedback** | Color-coded output with emojis | 🎨 |
| **Error Handling** | Comprehensive error checking | ❗ |
| **Cleanup** | Optional resource cleanup | 🧹 |

## 📥 Installation
### Method 1: Cloud Shell
```bash
git clone https://github.com/fatihatunnisa/cloudskillsboost-google.git
cd cloudskillsboost-google/GSP095-Qwik-Start-PubSub-Command-Line
Method 2: Direct Download
bash
wget https://raw.githubusercontent.com/fatihatunnisa/cloudskillsboost-google/main/GSP095-Qwik-Start-PubSub-Command-Line/GSP095.sh
chmod +x GSP095.sh
🚀 Usage
Basic Execution
bash
./GSP095.sh
Advanced Options
Flag	Description
--no-cleanup	Skip resource deletion
--verbose	Show detailed output
--region=REGION	Set compute region
Example with Flags
bash
./GSP095.sh --no-cleanup --verbose --region=us-east1
🛠️ Customization
Configure these environment variables if needed:

bash
export PROJECT_ID="your-project-id"    # Override default project
export TOPIC_NAME="custom-topic"      # Custom topic name
export SUBSCRIPTION_NAME="custom-sub" # Custom subscription name
export MESSAGE_COUNT=5                # Number of test messages
📊 Output Examples
Successful Execution
plaintext
🚀 Starting GSP095 Pub/Sub Lab Automation 🚀

✅ [1/6] Authentication verified (student@qwiklabs.net)
✅ [2/6] Project set (qwiklabs-gcp-03-12345678)
✅ [3/6] Created topic: myTopic
✅ [4/6] Created subscription: mySubscription
✉️ [5/6] Published 3 test messages
🔍 [6/6] Pulled messages successfully

🎉 Lab completed in 2m 18s 🎉
🐛 Troubleshooting
Common Issues
Authentication Errors

bash
gcloud auth login
gcloud config set account $(gcloud auth list --format="value(account)")
Permission Denied

bash
chmod +x GSP095.sh
API Not Enabled

bash
gcloud services enable pubsub.googleapis.com
Resource Quotas

bash
gcloud quotas list --service=pubsub.googleapis.com
🧹 Cleanup
Automatic Cleanup
Enabled by default. Disable with:

bash
./GSP095.sh --no-cleanup
Manual Cleanup
bash
# List all resources
gcloud pubsub topics list
gcloud pubsub subscriptions list

# Delete specific resources
gcloud pubsub topics delete myTopic
gcloud pubsub subscriptions delete mySubscription
🤝 Contributing
Fork the repository

Create your feature branch (git checkout -b feature/improvement)

Commit your changes (git commit -am 'Add some feature')

Push to the branch (git push origin feature/improvement)

Open a Pull Request

📜 License
This project is licensed under the Apache License 2.0 - see the LICENSE file for details.

📚 Additional Resources
Official Pub/Sub Documentation

GSP095 Lab Guide

gcloud CLI Reference

