FROM docker:stable

RUN apk add --no-cache bash curl openssl git jq && \
    wget -O kubectl https://storage.googleapis.com/kubernetes-release/release/$(wget -qSO- https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && mv ./kubectl /usr/bin/kubectl && \
    wget -O get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get && \
    chmod +x ./get_helm.sh && ./get_helm.sh && rm -f ./get_helm.sh && \
    wget -O skaffold https://github.com/GoogleContainerTools/skaffold/releases/download/$(wget -qSO- https://api.github.com/repos/GoogleContainerTools/skaffold/releases/latest | jq .tag_name | tr -d "\"")/skaffold-linux-amd64 && \
    chmod +x ./skaffold && mv ./skaffold /usr/bin/skaffold
