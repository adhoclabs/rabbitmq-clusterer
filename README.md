# rabbitmq-clusterer
rabbitmq-clusterer Docker image based on the official RabbitMQ Docker image

When enabling new plugins, the advice of the official RabbitMQ Dockerfile
maintainers is to create another Dockerfile with rabbitmq as it's base.

This Dockerfile adds support for clustering rabbitmq using clusterer[0].


[0] https://github.com/rabbitmq/rabbitmq-clusterer
