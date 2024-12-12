FROM adriancampos/nginx


ENV USUARIO="AdrianCV"
ENV PASSWORD="adriancv"
ARG TZ
ARG CONTEXT
ARG PROYECTO
USER root

RUN apt-get update && apt-get install -y curl gnupg software-properties-common

RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash -

RUN apt-get install -y nodejs

RUN node --version && npm --version

#COPY ./proyectos/${PROYECTO}/deploy/html /var/www/html
#instalo nginx/apache en usuario www-data
# el propietario de /var/www
#RUN chmod -R 755 /var/www/html
#RUN mkdir -p /var/log/nginx
#EXPOSE 80
EXPOSE 3000

RUN mkdir /root/admin/react
COPY ./dockerfiles/js/react/admin/ACVstart.sh /root/admin/react
RUN chmod +x /root/admin/react/ACVstart.sh


WORKDIR /root/admin
ENTRYPOINT ["/root/admin/react/ACVstart.sh"]