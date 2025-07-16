#!/bin/bash

set -e

IMAGE="vladbelo2/ubuntu-lab"
TAG="latest"

echo "🔧 Building image..."
docker build -t $IMAGE:$TAG .

echo "🚀 Pushing to Docker Hub..."
docker push $IMAGE:$TAG

echo "✅ Done."
