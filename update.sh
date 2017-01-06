#!/bin/bash
set -e

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

rabbitmqClustererVersion="$(curl -sSL https://github.com/rabbitmq/rabbitmq-clusterer/releases/latest | awk '/<title>Release/ {print substr($2,2)}')"

set -x
sed -ri 's/^(ENV RABBITMQ_CLUSTERER_VERSION) .*/\1 '"$rabbitmqClustererVersion"'/' Dockerfile
