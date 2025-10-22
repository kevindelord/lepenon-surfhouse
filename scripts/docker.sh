#!/usr/bin/env sh
# Documentation: 	https://github.com/envygeeks/jekyll-docker
# Blog Article: 	https://ddewaele.github.io/running-jekyll-in-docker/
# Open local website at: http://localhost:3000

#!/bin/bash
set -e

# Remove existing container if running
docker rm -f lepenonsurfhouse &>/dev/null || true

# 🚀 Serve site (mapped to http://localhost:3000)
docker run \
  --name lepenonsurfhouse \
  --platform linux/amd64 \
  -v $(pwd):/site \
  -p 3000:4000 \
  -it bretfisher/jekyll-serve \
  jekyll serve --config _config.yml,_translations.yml --incremental --watch --host 0.0.0.0
