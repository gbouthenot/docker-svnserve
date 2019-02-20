FROM ubuntu:18.10
MAINTAINER gb@atomas.com

RUN apt-get update && \
    apt-get install -y --no-install-recommends subversion supervisor && \
    apt-get clean

COPY daemons.conf /etc/supervisor/conf.d/
COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 3690

WORKDIR "/opt/svn"

CMD ["default"]
