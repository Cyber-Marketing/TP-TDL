FROM ubuntu:latest

WORKDIR /tp

ENV LANG=C.UTF-8

RUN apt update \
	&& apt install -y sudo wget curl git xz-utils zip unzip --no-install-recommends 

RUN rm -f /etc/ssl/certs/ca-bundle.crt \
	&& apt install -y ca-certificates \
	&& update-ca-certificates

# Clean Up
RUN	apt-get autoremove -y \
	&& apt-get clean -y \
	&& rm -rf /var/lib/apt/lists/* 

RUN	mkdir ~/development/

# Flutter SDK
# https://flutter.dev/docs/development/tools/sdk/releases?tab=linux
ENV FLUTTER_CHANNEL="beta"
ENV FLUTTER_VERSION="3.27.0-0.1.pre"

RUN curl -C - --output flutter.tar.xz https://storage.googleapis.com/flutter_infra_release/releases/${FLUTTER_CHANNEL}/linux/flutter_linux_${FLUTTER_VERSION}-${FLUTTER_CHANNEL}.tar.xz \
	&& tar -xf flutter.tar.xz -C ~/development/ \
	&& rm flutter.tar.xz

ENV FLUTTER_HOME=~/development/flutter
ENV PATH=$FLUTTER_HOME/bin:$PATH

COPY . .

EXPOSE 8000

# RUN echo 'export PATH="~/development/flutter/bin:$PATH"' >> ~/.profile \
# 	&& echo $PATH
# RUN . ~/.profile

# RUN yes | flutter doctor \
# 	&& flutter config --no-analytics \
# 	&& flutter update-packages
