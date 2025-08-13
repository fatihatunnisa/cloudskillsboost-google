#!/bin/bash
# Filename: GSP095-Qwik-Start-PubSub-Command-Line
# Lab: Pub/Sub: Qwik Start - Command Line
# Course: Google Cloud Skills Boost (GSP095)

# Color and emoji variables
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color
ROCKET="🚀"
CHECK="✅"
TRASH="🗑️"
ENVELOPE="✉️"

echo -e "\n${GREEN}${ROCKET} Starting GSP095 - Pub/Sub Command Line Lab ${ROCKET}${NC}\n"

# Task 1: Create Pub/Sub topics
echo -e "${BLUE}TASK 1: Creating Pub/Sub topics...${NC}"
gcloud pubsub topics create myTopic
echo -e "${GREEN}${CHECK} Created topic: myTopic${NC}"

gcloud pubsub topics create Test1
echo -e "${GREEN}${CHECK} Created topic: Test1${NC}"

gcloud pubsub topics create Test2
echo -e "${GREEN}${CHECK} Created topic: Test2${NC}"

# List topics
echo -e "\n${YELLOW}Current Pub/Sub topics:${NC}"
gcloud pubsub topics list

# Task 2: Delete test topics
echo -e "\n${RED}${TRASH} Deleting test topics...${NC}"
gcloud pubsub topics delete Test1
echo -e "${GREEN}${CHECK} Deleted topic: Test1${NC}"

gcloud pubsub topics delete Test2
echo -e "${GREEN}${CHECK} Deleted topic: Test2${NC}"

# Task 3: Create subscriptions
echo -e "\n${BLUE}TASK 3: Creating subscriptions...${NC}"
gcloud pubsub subscriptions create --topic myTopic mySubscription
echo -e "${GREEN}${CHECK} Created subscription: mySubscription${NC}"

gcloud pubsub subscriptions create --topic myTopic Test1
echo -e "${GREEN}${CHECK} Created subscription: Test1${NC}"

gcloud pubsub subscriptions create --topic myTopic Test2
echo -e "${GREEN}${CHECK} Created subscription: Test2${NC}"

# List subscriptions
echo -e "\n${YELLOW}Current subscriptions for myTopic:${NC}"
gcloud pubsub topics list-subscriptions myTopic

# Task 4: Delete test subscriptions
echo -e "\n${RED}${TRASH} Deleting test subscriptions...${NC}"
gcloud pubsub subscriptions delete Test1
echo -e "${GREEN}${CHECK} Deleted subscription: Test1${NC}"

gcloud pubsub subscriptions delete Test2
echo -e "${GREEN}${CHECK} Deleted subscription: Test2${NC}"

# Task 5: Publish messages
echo -e "\n${BLUE}TASK 5: Publishing messages...${NC}"
gcloud pubsub topics publish myTopic --message "Hello"
echo -e "${GREEN}${CHECK} Published message: 'Hello'${NC}"

gcloud pubsub topics publish myTopic --message "Publisher's name is $(whoami)"
echo -e "${GREEN}${CHECK} Published message with your username${NC}"

gcloud pubsub topics publish myTopic --message "Publisher likes pizza"
echo -e "${GREEN}${CHECK} Published message about pizza${NC}"

# Task 6: Pull messages
echo -e "\n${YELLOW}${ENVELOPE} Pulling messages one by one:${NC}"
for i in {1..3}; do
    gcloud pubsub subscriptions pull mySubscription --auto-ack
done

# Task 7: Publish and pull multiple messages
echo -e "\n${BLUE}TASK 7: Publishing multiple messages...${NC}"
for msg in "First" "Second" "Third"; do
    gcloud pubsub topics publish myTopic --message "${msg} message"
    echo -e "${GREEN}${CHECK} Published: '${msg} message'${NC}"
done

echo -e "\n${YELLOW}${ENVELOPE} Pulling all messages at once:${NC}"
gcloud pubsub subscriptions pull mySubscription --limit=3 --auto-ack

# Final cleanup (optional for Qwiklabs)
echo -e "\n${RED}${TRASH} Cleaning up lab resources...${NC}"
gcloud pubsub subscriptions delete mySubscription
gcloud pubsub topics delete myTopic
echo -e "${GREEN}${CHECK} All lab resources cleaned up${NC}"

echo -e "\n${GREEN}Lab GSP095 completed successfully! ${CHECK}${NC}"