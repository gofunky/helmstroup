FROM gofunky/helmsman:latest as helm

FROM microsoft/azure-cli:2.0.44

COPY --from=helm /bin/kubectl /usr/local/bin/kubectl
COPY --from=helm /usr/local/bin/helm /usr/local/bin/helm
COPY --from=helm /bin/helmsman /usr/local/bin/helmsman
