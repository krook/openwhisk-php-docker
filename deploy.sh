#!/bin/bash
#
# Copyright 2017 IBM Corp. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the “License”);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#  https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an “AS IS” BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Color vars to be used in shell script output
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m'

# Load configuration variables
source local.env

function usage() {
  echo -e "${YELLOW}Usage: $0 [--install,--uninstall,--env]${NC}"
}

function install() {
  # Exit if any command fails
  set -e

  echo -e "${YELLOW}Installing OpenWhisk actions, triggers, and rules for check-deposit..."

  # Build the Docker action. It's stored in the public Docker Hub.
  docker login --username "$DOCKER_HUB_USERNAME" --password "$DOCKER_HUB_PASSWORD"
  sh -c "cd dockerSkeleton && ./buildAndPush.sh $DOCKER_HUB_USERNAME/$DOCKER_HUB_IMAGE"
  wsk action create --docker phpinfo-action $DOCKER_HUB_USERNAME/$DOCKER_HUB_IMAGE

  echo -e "${GREEN}Install Complete${NC}"

  echo -e "${GREEN}Starting Test${NC}"
  wsk action invoke --blocking --result phpinfo-action --param name Tahoma

}

function uninstall() {
  echo -e "${RED}Uninstalling..."

  echo "Removing actions..."
  wsk action delete phpinfo-action

  echo -e "${GREEN}Uninstall Complete${NC}"
}

function showenv() {
  echo -e "${YELLOW}"
  echo DOCKER_HUB_USERNAME=$DOCKER_HUB_USERNAME
  echo DOCKER_HUB_PASSWORD=$DOCKER_HUB_PASSWORD
  echo DOCKER_HUB_PASSWORD=$DOCKER_HUB_IMAGE
  echo -e "${NC}"
}

case "$1" in
"--install" )
install
;;
"--uninstall" )
uninstall
;;
"--env" )
showenv
;;
* )
usage
;;
esac
