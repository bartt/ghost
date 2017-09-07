FROM ghost:alpine

ENV GHOST_INSTALL /var/lib/ghost
ENV GHOST_CONTENT /var/lib/ghost/content

ARG SMTP_SERVICE="Gmail"
ARG SMTP_HOST="smtp.gmail.com"
ARG SMTP_PORT="465"
ARG SMTP_AUTH_USER=""
ARG SMTP_AUTH_PASS=""
ARG SMTP_FROM="$SMTP_AUTH_USER"

RUN set -ex; \
    su-exec node ghost config mail.transport "SMTP"; \
    su-exec node ghost config mail.from "$SMTP_FROM"; \
    su-exec node ghost config mail.options.service "$SMTP_SERVICE"; \
    su-exec node ghost config mail.options.host "$SMTP_HOST"; \
    su-exec node ghost config mail.options.port "$SMTP_PORT"; \
    su-exec node ghost config mail.options.auth.user "$SMTP_AUTH_USER"; \
    su-exec node ghost config mail.options.auth.pass "$SMTP_AUTH_PASS"; \
