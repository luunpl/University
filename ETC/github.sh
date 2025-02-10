#!/bin/bash

# Navigate to repository
cd ~/Personal/University

# Pull the latest changes from the remote repository
git pull origin main

# Stage all changes
git add .

# Commit the changes with a message
git commit -m "Daily Commit"

# Push the changes to the remote repository
git push origin main