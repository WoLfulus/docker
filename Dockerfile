FROM node:11-alpine AS node

RUN ls -lah /usr/lib/

FROM docker:stable

COPY --from=node /usr/lib/libgcc* /usr/lib/
COPY --from=node /usr/lib/libstdc++* /usr/lib/
COPY --from=node /usr/local/ /usr/local/

RUN apk add --no-cache bash openssl git jq curl \
    && wget -O kubectl https://storage.googleapis.com/kubernetes-release/release/$(wget -qSO- https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl && mv ./kubectl /usr/bin/kubectl \
    && wget -O get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get \
    && chmod +x ./get_helm.sh && ./get_helm.sh && rm -f ./get_helm.sh \
    && wget -O skaffold https://storage.googleapis.com/skaffold/releases/$(wget -qSO- https://api.github.com/repos/GoogleContainerTools/skaffold/releases/latest | jq .tag_name | tr -d "\"")/skaffold-linux-amd64 \
    && chmod +x ./skaffold && mv ./skaffold /usr/bin/skaffold

RUN npm install -g gulp-cli
