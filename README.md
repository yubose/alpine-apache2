This is only 8MB alpine based ache2 webserver.
Using this as base image to set other service such as svn server.

DocumentRoot is as /var/www/localhost/htdocs, it could map to host directory as startup.
/var/log/apache2 is the log direct, mapping it to a directory is recommend for the sanity of the container.

Start this container
docker container run -d --name alpine-httpd -p 80:80 -v ~/log/httpd:/var/log/apache2 hyugecloud/alpine-apache2

After the container starts,

curl http://localhost

Following response
<html><body><h1>It works!</h1></body></html>
should be return from the default index.html at the DocumentRoot
