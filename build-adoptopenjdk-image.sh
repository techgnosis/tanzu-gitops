#! /usr/bin/env bash

set -euo pipefail

cd concourse/adoptopenjdk
docker build -t harbor.lab.home/library/adoptopenjdk:14.0.2_8-jdk-hotspot .
docker push harbor.lab.home/library/adoptopenjdk:14.0.2_8-jdk-hotspot