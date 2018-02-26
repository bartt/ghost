# ghost
Docker Alpine Image packaging for Ghost with a SMTP mailer & WebDAV storage adapter. This Docker image replaces Ghost's local storage with a WebDAV server.

## SMTP

Adds SMTP settings for [Ghost](http://ghost.org) to the production configuration for the [ghost:alpine](https://github.com/docker-library/ghost/blob/c5c8e3ce1c14a057029b4d7f5770d8fe54ae695b/1/alpine/Dockerfile) Docker image.

Build your own image with your personal SMTP settings like so after cloning this repo

```
docker build --build-arg SMTP_AUTH_USER=noreply@example.com --build-arg SMTP_AUTH_PASS=s3cr3t -t example/ghost:alpine .
```

Then spin up a container with this image, log into the Ghost. Go to the Labs section and send yourself a test email.

## WebDAV

Adds [WebDAV storage adapter](https://github.com/bartt/ghost-webdav-storage-adapter) setting for [Ghost](http://ghost.org) to the production configuration for the [ghost:alpine](https://github.com/docker-library/ghost/blob/c5c8e3ce1c14a057029b4d7f5770d8fe54ae695b/1/alpine/Dockerfile) Docker image. 

Build your own image with your personal WebDAV storage settings like so after cloning this repo

```
docker build --build-arg WEBDAV_SERVER_URL=https://example.com/remote.php/webdav/ --build-arg WEBDAV_USERNAME=me --build-arg WEBDAV_PASSWORD=s3cr3t -t example/ghost:alpine .
```
