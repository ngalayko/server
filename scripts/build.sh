#!/usr/bin/env bash

set -e

echo "Building images..."

# NOTE: ./server is the root
BUILD_IMAGES=(
    "./dns:ngalayko/pihole"
    "./mysql:ngalayko/mysql"
    "./nginx:ngalayko/nginx"
    "./analytics:ngalayko/matomo"
    "./remark:ngalayko/remark"
    "./autoheal:ngalayko/autoheal"
    "./vpn:ngalayko/vpn"
    "./blog:ngalayko/blog"
)

docker login -u "${DOCKER_HUB_LOGIN}" -p "${DOCKER_HUB_PASSWORD}"

for build_image in "${BUILD_IMAGES[@]}"; do
    build="${build_image%:*}" 
    image="${build_image#*:}"

    echo "Building ${image}..."


    docker build "${build}" -t "${image}"
    docker push  "${image}"

    sleep 5
done

echo "Done"