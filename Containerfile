FROM ubuntu:26.04 AS source

ADD --checksum=sha256:582930fab1a75bf59152d5bd94fd3a238b0f34c8d61ec6c7f317c0fa5bf8266e \
    https://github.com/FreeTubeApp/FreeTube/releases/download/v0.25.2-beta/freetube_0.25.2_beta_amd64.deb \
    /tmp/freetube.deb

FROM ghcr.io/containerpak/gtk3:main

RUN --mount=type=bind,from=source,source=/tmp/freetube.deb,target=/run/freetube.deb \
    apt-get update && \
    apt-get install -y /run/freetube.deb && \
    cpak-clean-junk
