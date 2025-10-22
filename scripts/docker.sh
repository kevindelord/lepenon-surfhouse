#!/usr/bin/env sh
# Documentation: 	https://github.com/envygeeks/jekyll-docker
# Blog Article: 	https://ddewaele.github.io/running-jekyll-in-docker/
# Open local website at: http://localhost:3000


# Removing container
# docker rm -f newblog
# (
# 	set -e

# 	export JEKYLL_VERSION=4.3

# 	# Remove docker container if existing
# 	docker rm -f lepenonsurfhouse &>/dev/null 
# 	# docker run --rm -v "$PWD":/srv/jekyll -w /srv/jekyll jekyll/jekyll:4 sh -c "rm -rf .jekyll-cache _site && jekyll build"

# 	# Build and serve the website
# 	docker run --rm -v "$PWD:/srv/jekyll" --name lepenonsurfhouse -p 3000:4000 -it ghcr.io/arm64-compat/jekyll:$JEKYLL_VERSION jekyll serve --config _config.yml,_translations.yml --incremental --watch

# 	#docker run --platform linux/amd64 --name lepenonsurfhouse --volume="$PWD:/srv/jekyll" -p 3000:4000 -it jekyll/jekyll:$JEKYLL_VERSION jekyll serve --trace --config _config.yml,_translations.yml --incremental --watch
# )


#!/bin/bash
set -e

#export JEKYLL_VERSION=4.2.2
#4.3.4
# -it jekyll/jekyll:$JEKYLL_VERSION \
# -v "$PWD:/srv/jekyll" \

# Remove existing container if running
docker rm -f lepenonsurfhouse &>/dev/null || true

# 🧹 Clean build output inside Docker (consistent arch)
# docker run --rm --platform linux/amd64 \
#   -v "$PWD":/srv/jekyll \
#   -w /srv/jekyll \
#   jekyll/jekyll:$JEKYLL_VERSION \
#   sh -c "rm -rf .jekyll-cache _site && bundle install && jekyll build"

# -w /srv/jekyll \
docker run --rm \
	--platform linux/amd64 \
	-v $(pwd):/site \
	-it bretfisher/jekyll-serve \
	sh -c "rm -rf .jekyll-cache _site && bundle install && jekyll build"

# 🚀 Serve site (mapped to http://localhost:3000)
docker run \
  --name lepenonsurfhouse \
  --platform linux/amd64 \
  -v $(pwd):/site \
  -p 3000:4000 \
  -it bretfisher/jekyll-serve \
  jekyll serve --trace --config _config.yml,_translations.yml --incremental --watch
