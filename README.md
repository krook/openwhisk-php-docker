# OpenWhisk PHP Docker
Example of a PHP script run within a Docker container as a custom action on OpenWhisk.

This example uses the Docker skeleton for custom actions which creates a Python action proxy to implement the HTTP `/init` and `/run` endpoints that OpenWhisk expects. The PHP environment and custom code are also added in the same [Dockerfile](dockerSkeleton/Dockerfile).

A [wrapper file is used to invoke the PHP CLI](dockerSkeleton/phpwrapper.sh) and execute the [custom PHP code](dockerSkeleton/phpinfo.php).

This is just a first pass. There are probably better ways to do this.

## Install
* Copy `template.local.env` to `local.env` and add your Docker Hub credentials.
* Open a terminal window and run `wsk activation poll`
* Open another terminal window and run `./deploy.sh --install`

## Uninstall
* Run `./deploy.sh --uninstall`

# License
[Apache 2.0](LICENSE.txt)
