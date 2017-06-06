# OpenWhisk PHP Docker
Example of a PHP action run within a Docker container as a custom action on OpenWhisk.

This example uses the Docker skeleton for custom actions which creates a Python action proxy to implement the HTTP `/init` and `/run` endpoints that OpenWhisk expects. The PHP environment and custom code are also added in the same [Dockerfile](dockerSkeleton/Dockerfile).

A [wrapper file is used to invoke the PHP CLI](dockerSkeleton/phpwrapper.sh) and execute the [custom PHP code](dockerSkeleton/phpinfo.php).
