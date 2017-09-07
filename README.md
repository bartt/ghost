# ghost
Docker Alpine Image packaging for Ghost with a SMTP mailer

Adds SMTP settings for [Ghost](http://ghost.org) to the production configuration for the [ghost:alpine](https://github.com/docker-library/ghost/blob/c5c8e3ce1c14a057029b4d7f5770d8fe54ae695b/1/alpine/Dockerfile) Docker image.

Build your own image with your personal settings like so after cloning this repo

```
docker build --build-arg SMTP_AUTH_USER=noreply@example.com --build-arg SMTP_AUTH_PASS=s3cr3t -t example/ghost:alpine .
```

Then spin up a container with this image, log into the Ghost. Go to the Labs section and send yourself a test email.
