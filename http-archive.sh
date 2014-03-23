#!/bin/bash

# Get mirror
wget --mirror --page-requisites --html-extension --convert-links -x -e robots=off -P . $1

# Remove wget index.html to keep original folders index urls
LC_CTYPE=C LANG=C find . -name \*.html | xargs sed -i.bak "s/index\.html//g"

# Publish to Amazon S3 website enabled bucket
s3cmd mb s3://$2
s3cmd ws-create s3://$2 --ws-index=index.html
s3cmd put --acl-public --recursive $1/ s3://$2
