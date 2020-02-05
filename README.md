# docker-pyload
Install pyload git version into a Linux container

![pyload](https://github.com/pyload/pyload/blob/master/pyload/webui/themes/Default/img/pyload-logo.png)

## Tag
Several tag are available:
* latest: see alpine
* alpine: [/Dockerfile_alpine](https://github.com/digrouz/docker-pyload/blob/master/Dockerfile_alpine)

## Description

pyLoad is a free and open source downloader for 1-click-hosting sites like rapidshare.com or uploaded.to. It supports link decryption as well as all important container formats.

https://github.com/pyload/pyload

## Usage
    docker create --name=pyload  \
      -v <path to downloads>:/downloads  \
      -v <path to config>:/config   \
      -v /etc/localtime:/etc/localtime:ro   \
      -e DOCKUID=<UID default:10005> \
      -e DOCKGID=<GID default:10005> \
      -e DOCKMAIL=<mail address> \
      -e DOCKRELAY=<smtp relay> \
      -e DOCKMAILDOMAIN=<originating mail domain> \
      -p 8000:8000  \
      -p 7227:7227  \
      -p 9666:9666 digrouz/pyload


## Environment Variables

When you start the `pyload` image, you can adjust the configuration of the `pyload` instance by passing one or more environment variables on the `docker run` command line.

### `DOCKUID`

This variable is not mandatory and specifies the user id that will be set to run the application. It has default value `10005`.

### `DOCKGID`

This variable is not mandatory and specifies the group id that will be set to run the application. It has default value `10005`.

### `DOCKRELAY`

This variable is not mandatory and specifies the smtp relay that will be used to send email. Do not specify any if mail notifications are not required.

### `DOCKMAIL`

This variable is not mandatory and specifies the mail that has to be used to send email. Do not specify any if mail notifications are not required.

### `DOCKMAILDOMAIN`

This variable is not mandatory and specifies the address where the mail appears to come from for user authentication. Do not specify any if mail notifications are not required.

### `DOCKUPGRADE`

This variable is not mandatory and specifies if the container has to launch software update at startup or not. Valid values are `0` and `1`. It has default value `0`.

## Notes

* The docker entrypoint can upgrade operating system at each startup. To enable this feature, just add `-e DOCKUPGRADE=1` at container creation.
* The port 8000 is used for webui
* The port 7227 is used for the api
* The port 9666 is used for click n load plugin

## Issues

If you encounter an issue please open a ticket at [github](https://github.com/digrouz/docker-pyload/issues)

