#! /bin/bash

TAG=$1

# Prefix of file name is the tag.
DOCKERRUN_FILE="Dockerrun.aws.json"
DOCKERRUN_TEMPLATE="./deployment/Dockerrun.aws.json.template"
EB_EXTENSIONS_DIR=".ebextensions"
EB_ZIP="$TAG-eb-config.zip"

EB_BUCKET=$AWS_DEPLOY_BUCKET
APP_NAME=$AWS_APP_NAME
REGION=$AWS_REGION

# Replace tags in template file and create config file
sed -e "s/<TAG>/$TAG/" < $DOCKERRUN_TEMPLATE > $DOCKERRUN_FILE
zip -r $EB_ZIP $DOCKERRUN_FILE $EB_EXTENSIONS_DIR

aws s3 cp $EB_ZIP s3://$EB_BUCKET/$EB_ZIP
