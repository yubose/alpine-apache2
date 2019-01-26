ARG         ALPINE_VERSION=${ALPINE_VERSION:-3.8}
FROM        alpine:${ALPINE_VERSION}

LABEL       maintainer="https://github.com/yubose"

# Create directory /run/apache2 for apache2 to store PID file
# Without create this directory, start httpd will stop silently.
# To suppress startup warning by assign a name to the server.
RUN         mkdir /run/apache2 \
            && apk add --upgrade --no-cache apache2 \
            && sed -i.orig -e "s/#ServerName.*:80/ServerName localhost:80/" /etc/apache2/httpd.conf \
            && rm -rf /var/cache/apk/*

EXPOSE      80
# -v host:/var/log/httpd:/var/log/apache2 for storing log infos.
VOLUME      ["/var/log/apache2"]

# Run httpd in foreground so that the container does not quit
# soon after start
# To run this container in the back ground use the -d option
#
#     $ sudo docker run -d hyugecloud/alpine-apache2
#

CMD         ["-D", "FOREGROUND"]

# Start httpd process when docker container run 
ENTRYPOINT  ["/usr/sbin/httpd"]
