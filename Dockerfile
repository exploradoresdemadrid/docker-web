FROM ubuntu as build
RUN apt update && apt install -y httrack 
RUN mkdir /var/httrack && cd /var/httrack && httrack --structure=0 -v -%v1 −R3 -c10 -T20 -w http://www.exploradoresdemadrid.org/
RUN cd /var/httrack && \
    find ./ -type f -exec sed -i '/by\sHTTrack\sWebsite\sCopier/d' {} \; && \
    find ./ -type f -exec sed -i 's/index\.html//g' {} \; && \
    find ./ -type f -exec sed -i 's/\.html//g' {} \; && \
    find ./ -type f -exec sed -i 's/http:\/\/www\.exploradoresdemadrid/https:\/\/www\.exploradoresdemadrid/g' {} \;

FROM nginx:1.19.6-alpine
COPY --from=build /var/httrack/www.exploradoresdemadrid.org/ /usr/share/nginx/html/
COPY nginx.conf /etc/nginx/nginx.conf
