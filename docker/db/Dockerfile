FROM  mariadb:latest

ENV MYSQL_ROOT_PASSWORD root
ENV MYSQL_DATABASE eyesproject
ENV MYSQL_USER ep_user
ENV MYSQL_PASSWORD ep_password

VOLUME ./data /var/lib/mysql

COPY init.sql /docker-entrypoint-initdb.d/

EXPOSE 3306