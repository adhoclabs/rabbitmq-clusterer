# rabbitmq-clusterer
rabbitmq-clusterer Docker image based on the official RabbitMQ Docker image

When enabling new plugins, the advice of the official RabbitMQ Dockerfile
maintainers is to create another Dockerfile with rabbitmq as it's base.

This Dockerfile adds support for clustering rabbitmq using clusterer[0].

rabbitmq-clusterer is a plugin created and maintained by the RabbitMQ team to help facilitate clustering. It will automatically cluster nodes without the need for the typical "stop_app, join_cluster, start_app" dance. It can also start a cluster up from a completely stopped start with no user intervention.

It does this by making use of a "gospel" node that is the source of truth. All nodes will pause on startup waiting for the gospel node to come online. Once online, clusterer handles the rest.

This adds 3 new environment variables for configuration:

RABBITMQ_CLUSTERER_GOSPEL_NODE
RABBITMQ_CLUSTERER_CONFIG_VERSION
RABBITMQ_CLUSTERER_NODE_*

Where RABBITMQ_CLUSTERER_NODE_* is RABBITMQ_CLUSTERER_NODE_1, RABBITMQ_CLUSTERER_NODE_2, RABBITMQ_CLUSTERER_NODE_3, etc.

For a two node cluster, run:

docker run \
-e RABBITMQ_ERLANG_COOKIE=12345 \
-e RABBITMQ_CLUSTERER_NODE_1="rabbtest,disc" \
-e RABBITMQ_CLUSTERER_NODE_2="rabbtest2,disc" \
-e RABBITMQ_CLUSTERER_GOSPEL_NODE="rabbtest" \
--hostname rabbtest \
--name rabbtest \
-d samyaple/rabbitmq-clusterer

docker run \
-e RABBITMQ_ERLANG_COOKIE=12345 \
-e RABBITMQ_CLUSTERER_NODE_1="rabbtest,disc" \
-e RABBITMQ_CLUSTERER_NODE_2="rabbtest2,disc" \
-e RABBITMQ_CLUSTERER_GOSPEL_NODE="rabbtest" \
--hostname rabbtest2 \
--name rabbtest2 \
--link rabbtest \
-d samyaple/rabbitmq-clusterer


[0] https://github.com/rabbitmq/rabbitmq-clusterer
