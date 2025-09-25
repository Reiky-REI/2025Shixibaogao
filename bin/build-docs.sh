#!/usr/bin/env bash

# build and upload the archive
cd docs/
make html
cd build
# Create tar.gz archive of the html folder with a timestamp
timestamp=$(date +%Y%m%d%H%M%S)
archive_name="html_docs_$timestamp.tar.gz"
tar -czf $archive_name html

# Create docs folder on the remote host if it doesn't exist
ssh $1 "mkdir -p /opt/statics/docs"

# Upload the archive to the remote host using rsync
rsync -avz $archive_name $1:/opt/statics/docs

# Extract the archive on the remote host
ssh $1 "tar -xzf /opt/statics/docs/$archive_name -C /opt/statics/docs"

