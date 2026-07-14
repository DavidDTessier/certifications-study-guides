#!/bin/sh

kubectl exec -it sa-key-mount  -- /bin/bash

SA_TOKEN=$(gcloud auth application-default print-access-token --scopes openid,https://www.googleapis.com/auth/userinfo.email,https://www.googleapis.com/auth/cloud-platform)

curl -H "Authorization: Bearer $SA_TOKEN" https://www.googleapis.com/oauth2/v3/tokeninfo