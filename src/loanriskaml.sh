#!/bin/bash
gcloud storage cp gs://cloud-training/CBL455/INPUT-JSON .
# Alter INPUT-JSON file to generate custom predictions
export INPUT_DATA_FILE="INPUT-JSON" 
# Create PROJECT_NUMBER env var
gcloud config set project my-project-id
export PROJECT_NUMBER=$(gcloud projects describe $(gcloud config get-value project) --format="value(projectNumber)")
# create AUTOML_SERVICE env var
export AUTOML_SERVICE="https://automl-proxy-$PROJECT_NUMBER.us-central1.run.app/v1"
# request a prediction
curl -X POST -H "Content-Type: application/json" $AUTOML_SERVICE -d "@${INPUT_DATA_FILE}" -s | jq
