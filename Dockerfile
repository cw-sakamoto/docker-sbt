FROM gcr.io/google_containers/ubuntu-slim:0.14
MAINTAINER Ryo Sakamoto <sakamoto@chatwork.com>

# Disable prompts from apt.
ENV DEBIAN_FRONTEND noninteractive

ENV SBT_VERSION 1.1.0

ENV SBT_HOME /usr/local/sbt
ENV PATH ${PATH}:${SBT_HOME}/bin

# install sbt
RUN apt-get update -y \
 && apt-get install -y --no-install-recommends ca-certificates jq curl wget openjdk-8-jdk unzip \
 && curl -L -o sbt-$SBT_VERSION.deb https://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb \
 && dpkg -i sbt-$SBT_VERSION.deb \
 && apt-get install sbt \
 && sbt sbtVersion \
 && rm sbt-$SBT_VERSION.deb \
 && rm -rf /var/lib/apt/lists/*

# Define working directory
WORKDIR /root
