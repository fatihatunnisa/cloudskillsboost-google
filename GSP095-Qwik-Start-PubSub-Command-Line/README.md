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
### ✅ Method 1: Cloud Shell
```bash
git clone https://github.com/fatihatunnisa/cloudskillsboost-google.git
cd cloudskillsboost-google/GSP095-Qwik-Start-PubSub-Command-Line
```


### ✅ Method 2: Direct Download
```bash
wget https://raw.githubusercontent.com/fatihatunnisa/cloudskillsboost-google/main/GSP095-Qwik-Start-PubSub-Command-Line/GSP095.sh
chmod +x GSP095.sh
```

---

## 🚀 Usage

### 🔹 Basic Execution
```bash
./GSP095.sh
```

### 🔹 Advanced Options

| 🏷️ Flag           | 📝 Description               |
|-------------------|------------------------------|
| `--no-cleanup`    | Skip resource deletion       |
| `--verbose`       | Show detailed output         |
| `--region=REGION` | Set compute region manually  |

### 🔹 Example
```bash
./GSP095.sh --no-cleanup --verbose --region=us-east1
```

---

## 🧰 Customization

Set environment variables to override defaults:
```bash
export PROJECT_ID="your-project-id"
export TOPIC_NAME="custom-topic"
export SUBSCRIPTION_NAME="custom-sub"
export MESSAGE_COUNT=5
```

---

## 📊 Output Examples

### ✅ Successful Execution
```plaintext
🚀 Starting GSP095 Pub/Sub Lab Automation 🚀

✅ [1/6] Authentication verified (student@qwiklabs.net)
✅ [2/6] Project set (qwiklabs-gcp-03-12345678)
✅ [3/6] Created topic: myTopic
✅ [4/6] Created subscription: mySubscription
✉️ [5/6] Published 3 test messages
🔍 [6/6] Pulled messages successfully

🎉 Lab completed in 2m 18s 🎉
```

---

## 🐛 Troubleshooting

### 🔧 Common Issues

1. **🔐 Authentication Errors**
   ```bash
   gcloud auth login
   gcloud config set account $(gcloud auth list --format="value(account)")
   ```

2. **🚫 Permission Denied**
   ```bash
   chmod +x GSP095.sh
   ```

3. **📡 API Not Enabled**
   ```bash
   gcloud services enable pubsub.googleapis.com
   ```

4. **📉 Resource Quotas**
   ```bash
   gcloud quotas list --service=pubsub.googleapis.com
   ```

---

## 🧹 Cleanup

### 🧼 Automatic Cleanup
Enabled by default. Disable with:
```bash
./GSP095.sh --no-cleanup
```

### 🧼 Manual Cleanup
```bash
gcloud pubsub topics list
gcloud pubsub subscriptions list

gcloud pubsub topics delete myTopic
gcloud pubsub subscriptions delete mySubscription
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

- 📘 [Official Pub/Sub Documentation](https://cloud.google.com/pubsub/docs)
- 🧪 [GSP095 Lab Guide](https://www.cloudskillsboost.google/catalog_lab/3584)
- 🧰 [gcloud CLI Reference](https://cloud.google.com/sdk/gcloud/reference/pubsub)

---
```

Let me know if you'd like a matching `LICENSE` file, a visual diagram, or a badge set for CI/linting. We can also extend this into a multi-lab automation suite if you're building a full toolkit.