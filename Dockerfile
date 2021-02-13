FROM ubuntu as build
RUN apt update && apt install -y httrack 
RUN mkdir /var/httrack && cd /var/httrack && httrack --structure=0 -v -w https://tecnologia.exploradoresdemadrid.org/

FROM nginx
COPY --from=build /var/httrack/tecnologia.exploradoresdemadrid.org/ /usr/share/nginx/html/
