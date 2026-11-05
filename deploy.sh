#!/usr/bin/env bash
# Rebuild the image and restart the container.
set -euo pipefail
cd "$(dirname "$0")"

# The sandbox cannot write ~/.docker, so keep Docker CLI state in the workspace.
export DOCKER_CONFIG="$(cd .. && pwd)/.docker"
mkdir -p "$DOCKER_CONFIG"

# BuildKit/buildx is not installed in this environment; use the classic builder.
DOCKER_BUILDKIT=0 docker build -f deploy/Dockerfile -t qwerty-learner:local .

# compose.yaml pins image qwerty-learner:local, so this only recreates the container.
docker compose up -d --no-build
docker image prune -f >/dev/null 2>&1 || true
