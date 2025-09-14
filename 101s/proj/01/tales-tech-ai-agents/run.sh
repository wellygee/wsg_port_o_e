#!/bin/bash

# This script is used to run the KT Sales Agents application.
# Ensure that you have the necessary permissions to execute this script.

echo "Starting the KT Sales Agents application..."

cd src

# Start the application
docker compose up --build

# 2
cd /ui

npm run start

# 3
npx @modelcontextprotocol/inspector node build/index.js