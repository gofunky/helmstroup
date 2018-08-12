FROM gofunky/helmsman:latest as helm

FROM microsoft/azure-cli:2.0.43

ARG HELM_VERSION="v2.8.1"

COPY --from=helm /bin/kubectl /bin/kubectl

RUN curl -L https://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz | tar zxv -C /tmp \
    && mv /tmp/linux-amd64/helm /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm \
    && mkdir -p ~/.helm/plugins \
    && helm plugin install https://github.com/hypnoglow/helm-s3.git \
    && helm plugin install https://github.com/nouney/helm-gcs \
    && rm -rf /tmp/linux-amd64

COPY --from=helm /bin/helmsman /bin/helmsman
