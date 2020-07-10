# hadolint ignore=DL3007
FROM alpine:latest

ENV HADOLINT_VERSION 1.18.0
LABEL version="1.9.0"
LABEL name="hadolint-action"
LABEL repository="http://github.com/burdzwastaken/hadolint-action"
LABEL homepage="http://github.com/burdzwastaken/hadolint-action"
LABEL hadolint_version="v${HADOLINT_VERSION}"
LABEL maintainer="Matt Burdan <github@burdz.net>"

LABEL "com.github.actions.name"="hadolint"
LABEL "com.github.actions.description"="Runs hadolint against PR's to validate there are no violations"
LABEL "com.github.actions.icon"="terminal"
LABEL "com.github.actions.color"="red"

# hadolint ignore=DL3018
RUN apk add --no-cache \
        bash \
        ca-certificates \
        coreutils \
        curl \
        jq

RUN curl -fsSL -o /usr/bin/hadolint "https://github.com/hadolint/hadolint/releases/download/v${HADOLINT_VERSION}/hadolint-Linux-x86_64" && \
        chmod +x /usr/bin/hadolint

COPY hadolint-action.sh /usr/local/bin/hadolint-action

CMD ["hadolint-action"]
