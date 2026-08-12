FROM ubuntu:26.04 AS source

ADD --checksum=sha256:582930fab1a75bf59152d5bd94fd3a238b0f34c8d61ec6c7f317c0fa5bf8266e \
    https://github.com/FreeTubeApp/FreeTube/releases/download/v0.25.2-beta/freetube_0.25.2_beta_amd64.deb \
    /tmp/freetube.deb

FROM ghcr.io/containerpak/mesa:main

COPY --from=source /tmp/freetube.deb /tmp/freetube.deb

RUN apt update && \
    apt install -y --no-install-recommends /tmp/freetube.deb && \
    rm /tmp/freetube.deb && \
    cpak-clean-junk
