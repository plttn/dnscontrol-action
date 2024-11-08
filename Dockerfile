FROM alpine:3.17.2@sha256:69665d02cb32192e52e07644d76bc6f25abeb5410edc1c7a81a10ba3f0efb90a

LABEL repository="https://github.com/koenrh/dnscontrol-action"
LABEL maintainer="Koen Rouwhorst <info@koenrouwhorst.nl>"

LABEL "com.github.actions.name"="DNSControl"
LABEL "com.github.actions.description"="Deploy your DNS configuration to multiple providers."
LABEL "com.github.actions.icon"="cloud"
LABEL "com.github.actions.color"="yellow"

ENV DNSCONTROL_VERSION="4.14.3"
ENV DNSCONTROL_CHECKSUM="8c7e8a181beb17b130a6365bc81ffd024176951b5082d51539412198907e1e48"

RUN apk -U --no-cache upgrade && \
    apk add --no-cache bash ca-certificates curl libc6-compat tar

RUN curl -sL "https://github.com/StackExchange/dnscontrol/releases/download/v4.14.3/dnscontrol_4.14.3_linux_amd64.tar.gz" \
  -o dnscontrol.tar.gz && tar -xzvf dnscontrol.tar.gz -C dnscontrol-folder && \
  # echo "$DNSCONTROL_CHECKSUM  dnscontrol" | sha256sum -c - && \
  chmod +x dnscontrol-folder/dnscontrol && \
  mv dnscontrol-folder/dnscontrol /usr/local/bin/dnscontrol

RUN ["dnscontrol", "version"]

COPY README.md entrypoint.sh bin/filter-preview-output.sh /
ENTRYPOINT ["/entrypoint.sh"]
