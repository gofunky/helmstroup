FROM gofunky/helmsman:latest as helm

FROM microsoft/azure-cli:2.0.46

COPY --from=helm /usr/local/bin/kubectl /usr/local/bin/kubectl
COPY --from=helm /usr/local/bin/helm /usr/local/bin/helm
COPY --from=helm /usr/local/bin/helmsman /usr/local/bin/helmsman
