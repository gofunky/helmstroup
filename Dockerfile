FROM praqma/helmsman:latest as helm

FROM atlassian/default-image:2

ARG AZURE_CLI_VERSION "0.10.13"
ARG HELM_VERSION=v2.8.1

COPY --from=helm /bin/kubectl /bin/kubectl
COPY --from=helm /bin/helmsman /bin/helmsman

RUN curl -L http://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz | tar zxv -C /tmp \
    && mv /tmp/linux-amd64/helm /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm \
    && mkdir -p ~/.helm/plugins \
    && helm plugin install https://github.com/hypnoglow/helm-s3.git \
    && helm plugin install https://github.com/nouney/helm-gcs \
    && rm -rf /tmp/linux-amd64

RUN npm install --global azure-cli@${AZURE_CLI_VERSION} && \
      azure --completion >> ~/azure.completion.sh && \
      echo 'source ~/azure.completion.sh' >> ~/.bashrc

RUN azure config mode arm
