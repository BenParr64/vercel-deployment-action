#!/bin/sh

BRANCH_NAME=$(echo "$GITHUB_REF" | awk -F/ '{print $3}')
echo "BRANCH_NAME: $BRANCH_NAME"

while true; do
  DEPLOYMENT=$(curl --silent -H "Authorization: Bearer $GITHUB_TOKEN" https://api.vercel.com/v3/now/deployments?projectId="$GITHUB_REPOSITORY_ID")
  if echo "$DEPLOYMENT" | grep -q "\"$BRANCH_NAME\""; then
    echo "Deployment complete"
    break
  fi
  echo "Waiting for deployment to complete..."
  sleep 10
done

REPO_ID=$(curl --silent -H "Authorization: Bearer $GITHUB_TOKEN" https://api.github.com/repos/"$GITHUB_REPOSITORY" | jq -r .id)
echo "GitHub repository ID: $REPO_ID"


URL=$(curl --silent -H "Authorization: Bearer $GITHUB_TOKEN" https://api.vercel.com/v3/now/deployments?projectId="$REPO_ID" | jq -r ".deployments[] | select(.name==\"$BRANCH_NAME\") | .url")


echo "::set-output name=url::$URL"
