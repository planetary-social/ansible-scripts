# health-check

This role adds a metric to the text file consumed by node exporter, that returns the response of a healthcheck endpoint.

For example: you have a an endpoint at /_health, that returns 200 if things are okay and 500 if not.  This can be used with this healthcheck
so the node_exporter metrics show whether the server is considered healthy.

The metric will be called `nos_health_check`

There is not an opinion on where the endpoint is, or how it is built, just that it returns an http status code.

## Variables

health_check_endpoint

