#!/bin/bash
if [ "$APP_ENV" != "dev" ]; then
  echo "Error: Misconfigured - set APP_ENV=dev"
  exit 1
fi
echo "App is working correctly!"