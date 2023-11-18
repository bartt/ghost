# ghost
Docker Alpine Image packaging for Ghost with a SMTP mailer & S3 storage adapter. This Docker image replaces Ghost's local storage with an adapter to an external S3 server.

## SMTP

Adds SMTP settings for [Ghost](http://ghost.org) to the production configuration for the [ghost:alpine](https://github.com/docker-library/ghost/blob/c5c8e3ce1c14a057029b4d7f5770d8fe54ae695b/1/alpine/Dockerfile) Docker image.

Build your own image with your personal SMTP settings like so after cloning this repo

```
docker build --build-arg SMTP_AUTH_USER=noreply@example.com --build-arg SMTP_AUTH_PASS=s3cr3t -t example/ghost:alpine .
```

Then spin up a container with this image, log into the Ghost. Go to the Labs section and send yourself a test email.

## S3

Adds [S3 storage adapter](https://github.com/bartt/ghost-storage-adapter-s3) setting for [Ghost](http://ghost.org) to the production configuration for the [ghost:alpine](https://github.com/docker-library/ghost/blob/c5c8e3ce1c14a057029b4d7f5770d8fe54ae695b/1/alpine/Dockerfile) Docker image. 

Build your own image with your personal S3 storage settings like so after cloning this repo

```
docker build --build-arg GHOST_STORAGE_ADAPTER_S3_ENDPOINT=https://s3.us-west-1.wasabisys.com --build-arg AWS_ACCESS_KEY_ID=me --build-arg AWS_SECRET_ACCESS_KEY=s3cr3t -t example/ghost:alpine .
```
