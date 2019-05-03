FROM node:11-alpine AS node

FROM docker:stable

COPY --from=node /usr/lib/libgcc* /usr/lib/
COPY --from=node /usr/lib/libstdc++* /usr/lib/
COPY --from=node /usr/local/ /usr/local/

ENV HELM_VERSION=v2.13.1
ENV KUBECTL_VERSION=v1.14.1
ENV SKAFFOLD_VERSION=v0.28.0

RUN apk add --no-cache bash openssl git jq curl \
    && wget -O /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl && chmod +x /usr/bin/kubectl \
    && wget -qO- https://raw.githubusercontent.com/helm/helm/master/scripts/get | DESIRED_VERSION=${HELM_VERSION} bash \
    && wget -O /usr/bin/skaffold https://storage.googleapis.com/skaffold/releases/${SKAFFOLD_VERSION}/skaffold-linux-amd64  && chmod +x /usr/bin/skaffold

RUN npm install -g gulp-cli @reddot/helmet
