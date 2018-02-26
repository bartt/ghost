FROM ghost:alpine

RUN npm install -g ghost-webdav-storage-adapter

ENV GHOST_INSTALL /var/lib/ghost
ENV GHOST_CONTENT /var/lib/ghost/content

ARG SMTP_SERVICE="Gmail"
ARG SMTP_HOST="smtp.gmail.com"
ARG SMTP_PORT="465"
ARG SMTP_AUTH_USER=""
ARG SMTP_AUTH_PASS=""
ARG SMTP_FROM="$SMTP_AUTH_USER"

ARG WEBDAV_SERVER_URL="https://bartt.stackstorage.com/remote.php/webdav/"
ARG WEBDAV_USERNAME=""
ARG WEBDAV_PASSWORD=""
ARG WEBDAV_PATH_PREFIX="/Blog"
ARG WEBDAV_STORAGE_PATH_PREFIX=""

RUN set -ex; \
    su-exec node ghost config mail.transport "SMTP"; \
    su-exec node ghost config mail.from "$SMTP_FROM"; \
    su-exec node ghost config mail.options.service "$SMTP_SERVICE"; \
    su-exec node ghost config mail.options.host "$SMTP_HOST"; \
    su-exec node ghost config mail.options.port "$SMTP_PORT"; \
    su-exec node ghost config mail.options.auth.user "$SMTP_AUTH_USER"; \
    su-exec node ghost config mail.options.auth.pass "$SMTP_AUTH_PASS"; \
    su-exec node ghost config storage.active "webdav"; \
    su-exec node ghost config storage.webdav.url "$$WEBDAV_SERVER_URL"; \
    su-exec node ghost config storage.webdav.username "$$WEBDAV_USERNAME"; \
    su-exec node ghost config storage.webdav.password "$$WEBDAV_PASSWORD"; \
    su-exec node ghost config storage.webdav.pathPrefix "$$WEBDAV_PATH_PREFIX"; \
    su-exec node ghost config storage.webdav.storagePathPrefix "$$WEBDAV_STORAGE_PATH_PREFIX"; \
