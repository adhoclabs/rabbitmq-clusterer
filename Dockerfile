FROM rabbitmq:3.6.6-management

ENV RABBITMQ_CLUSTERER_VERSION 1.0.3
ENV RABBITMQ_CLUSTERER_CONFIG_VERSION 46
ENV RABBITMQ_DELAYED_EXCHANGE_VERSION 0.0.1
ENV RABBITMQ_BOOT_MODULE rabbit_clusterer
ENV RABBITMQ_SERVER_ADDITIONAL_ERL_ARGS "-pa /plugins/rabbitmq_clusterer.ez/rabbitmq_clusterer-${RABBITMQ_CLUSTERER_VERSION}/ebin"

RUN set -x \
        && apt-get update && apt-get install -y --no-install-recommends ca-certificates wget && rm -rf /var/lib/apt/lists/* \
        && wget -O /usr/lib/rabbitmq/lib/rabbitmq_server-${RABBITMQ_VERSION}/plugins/rabbitmq_clusterer-${RABBITMQ_CLUSTERER_VERSION}.ez https://github.com/rabbitmq/rabbitmq-clusterer/releases/download/v${RABBITMQ_CLUSTERER_VERSION}/rabbitmq_clusterer-${RABBITMQ_CLUSTERER_VERSION}.ez \
        && wget -O /usr/lib/rabbitmq/lib/rabbitmq_server-${RABBITMQ_VERSION}/plugins/rabbitmq_delayed_message_exchange-${RABBITMQ_DELAYED_EXCHANGE_VERSION}.ez https://bintray.com/rabbitmq/community-plugins/download_file?file_path=rabbitmq_delayed_message_exchange-${RABBITMQ_DELAYED_EXCHANGE_VERSION}.ez \
        && apt-get purge -y --auto-remove ca-certificates wget

RUN rabbitmq-plugins enable --offline rabbitmq_clusterer

RUN rabbitmq-plugins enable rabbitmq_delayed_message_exchange

COPY docker-entrypoint.sh /usr/local/bin/

EXPOSE 15671 15672
