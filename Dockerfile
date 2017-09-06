FROM ghost:alpine

ENV GHOST_INSTALL /var/lib/ghost
ENV GHOST_CONTENT /var/lib/ghost/content
ENV SMTP_SERVICE "Gmail"
ENV SMTP_AUTH_USER
ENV SMTP_AUTH_PASS

RUN set -ex; \
    su-exec node ghost config mail.transport "SMTP"; \
    su-exec node ghost config mail.options.service "$SMTP_SERVICE"; \
    su-exec node ghost config mail.options.auth.user "$SMTP_AUTH_USER"; \
    su-exec node ghost config mail.options.auth.pass "$SMTP_AUTH_PASS"; 
