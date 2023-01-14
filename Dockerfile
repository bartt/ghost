FROM ghost:alpine

ENV GHOST_INSTALL=/var/lib/ghost GHOST_CONTENT=/var/lib/ghost/content

# Patch AMP so that photo carousel iframes work
# Remove Ghost advertising from AMP pages &
# Remove packages only needed to build and install the S3 storage adapter
COPY amp-iframe.patch amp-template.patch $GHOST_INSTALL/current
RUN apk update && apk add sqlite patch python3 build-base && \
    npm install ghost-storage-adapter-s3-bartt && \
    mkdir -pv ./content.orig/adapters/storage/s3 && \
    cp -v ./node_modules/ghost-storage-adapter-s3-bartt/*.js ./content.orig/adapters/storage/s3 && \
    cd $GHOST_INSTALL/current && patch --verbose -F6 -p1 < amp-iframe.patch && \
    rm -v $GHOST_INSTALL/current/amp-iframe.patch && \
    cd $GHOST_INSTALL/current && patch --verbose -F6 -p1 < amp-template.patch && \
    rm -v $GHOST_INSTALL/current/amp-template.patch && apk del patch python3 build-base

# SMTP mail parameters
ARG SMTP_SERVICE="Gmail"
ARG SMTP_HOST="smtp.gmail.com"
ARG SMTP_PORT="465"
ARG SMTP_AUTH_USER=""
ARG SMTP_AUTH_PASS=""
ARG SMTP_FROM="$SMTP_AUTH_USER"

# Required S3 storage adapter parameters
ARG AWS_ACCESS_KEY_ID=""
ARG AWS_SECRET_ACCESS_KEY=""
ARG AWS_DEFAULT_REGION="us-west-1"
ARG GHOST_STORAGE_ADAPTER_S3_PATH_BUCKET="/icloud"
ARG GHOST_STORAGE_ADAPTER_S3_ENDPOINT="https://s3.us-west-1.wasabisys.com"

# Optional S3 storage adapter parameters
ARG GHOST_STORAGE_ADAPTER_S3_ACL="public-read"
ARG GHOST_STORAGE_ADAPTER_S3_ASSET_HOST=""
ARG GHOST_STORAGE_ADAPTER_S3_FORCE_PATH_STYLE="true"
ARG GHOST_STORAGE_ADAPTER_S3_PATH_PREFIX="/Blog"
ARG GHOST_STORAGE_ADAPTER_S3_SSE=""
ARG GHOST_STORAGE_ADAPTER_S3_SIGNATURE_VERSION="v4"

# Set the STMP section in the Ghost configuration file to the provided SMTP build arguments.
RUN set -ex; \
    su-exec node ghost config mail.transport "SMTP"; \
    su-exec node ghost config mail.from "$SMTP_FROM"; \
    su-exec node ghost config mail.options.service "$SMTP_SERVICE"; \
    su-exec node ghost config mail.options.host "$SMTP_HOST"; \
    su-exec node ghost config mail.options.port "$SMTP_PORT"; \
    su-exec node ghost config mail.options.auth.user "$SMTP_AUTH_USER"; \
    su-exec node ghost config mail.options.auth.pass "$SMTP_AUTH_PASS";

# Set the S3 storage section in the Ghost configuration file to the provided S3 build arguments.
RUN set -ex; \
    su-exec node ghost config storage.active "s3"; \
    su-exec node ghost config storage.files "s3"; \
    su-exec node ghost config storage.images "s3"; \
    su-exec node ghost config storage.media "s3"; \
    su-exec node ghost config storage.videos "s3"; \
    su-exec node ghost config storage.s3.accessKeyId "$AWS_ACCESS_KEY_ID"; \
    su-exec node ghost config storage.s3.acl "$GHOST_STORAGE_ADAPTER_S3_ACL"; \
    su-exec node ghost config storage.s3.assetHost "$GHOST_STORAGE_ADAPTER_S3_ASSET_HOST"; \
    su-exec node ghost config storage.s3.bucket "$GHOST_STORAGE_ADAPTER_S3_PATH_BUCKET"; \
    su-exec node ghost config storage.s3.endpoint "$GHOST_STORAGE_ADAPTER_S3_ENDPOINT"; \
    su-exec node ghost config storage.s3.forcePathStyle "$GHOST_STORAGE_ADAPTER_S3_FORCE_PATH_STYLE"; \
    su-exec node ghost config storage.s3.pathPrefix "$GHOST_STORAGE_ADAPTER_S3_PATH_PREFIX"; \
    su-exec node ghost config storage.s3.region "$AWS_DEFAULT_REGION"; \
    su-exec node ghost config storage.s3.secretAccessKey "$AWS_SECRET_ACCESS_KEY"; \
    su-exec node ghost config storage.s3.serverSideEncryption "$GHOST_STORAGE_ADAPTER_S3_SSE"; \
    su-exec node ghost config storage.s3.signatureVersion "$GHOST_STORAGE_ADAPTER_S3_SIGNATURE_VERSION"; \
    su-exec node ghost config storage.s3.staticFileURLPrefix "/content/files"; 

# Set the Portal URL to a custom version without Ghost branding
RUN set -ex; \
    su-exec node ghost config portal.url "https://unpkg.com/@the-code-mill/portal@latest/umd/portal.min.js";