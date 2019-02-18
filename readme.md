# docker-svnserve
A simple subversion server, managed with supervisor.

## What is svnserve ?

svnserve is a unofficial docker image for the [svnserve][1] subversion server.

This image is based on Ubuntu docker image, and use [supervisor][2] daemons manager.

## Why?

There are already a number of avaliable docker images for subversion and svnserve hosting. But most of them either are:

- Too involved; Containers shouldn't be like aplications themselves with configuration in environment variables, etc. Instead, images should be extensible so other users can create their own images with customizations, based on yours.
- Bloated; Based on heavy *fat-container* base images.
- Don't handle signals properly, forcing docker to send `SIGKILL` to the process.

## How to use this image

The image is intented to run as a daemon; it exposed the default svnserve port (`3690`). It does not define volume (this is one purpose, because volumes can not be undefined).

It's up to you to map a volume to ```/opt/svn```, so your data persist.

It's also up to you to manage configuration of this svn root, using the directory ```/opt/svn/conf```. If there is no svn root, one is created automatically

### Direct use
Create a container based on this image:
```
docker run \
    --detatch \
    --name svnserve \
    --restart always \
    --expose 3690:3690/tcp \
    --volume /local/path/to/svn:/opt/svn \
    gbouthenot/svnserve
```

With the above comand, `svnserve` will:
- run in daemon mode
- listen on the standard port on all host's interfaces
- (re)start with the system 
- serve repositories from `/local/path/to/svn` in the host's filesystem.

### Use with docker-compose
File ```docker-compose.yml```:
```
version: '2'
services:
  svnserve:
    image: gbouthenot/svnserve
    restart: always
    ports:
      - "3690:3690"
    volumes:
      - ./svnroot/:/opt/svn/
```

Same functionnality than above, except the svnroot is specified as a relative directory.


### Adminstration

You should backup ```/opt/svn```

You should configure the server with the directory /opt/svn/conf.

If this directory does not exist, it is populated on first run. Then you can for example set password for your user in ```conf/passwd```:
```
[users]
harry = harryssecret
sally = sallyssecret
```

[1]: https://subversion.apache.org/
[2]: http://supervisord.org/
