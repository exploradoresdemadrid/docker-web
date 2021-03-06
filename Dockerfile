FROM ubuntu as build
RUN apt update && apt install -y httrack 
RUN mkdir /var/httrack && cd /var/httrack && httrack --structure=0 -v -w https://tecnologia.exploradoresdemadrid.org/
RUN cd /var/httrack && \
    find ./ -type f -exec sed -i '/by\sHTTrack\sWebsite\sCopier/d' {} \; && \
    find ./ -type f -exec sed -i 's/index\.html//g' {} \; && \
    find ./ -type f -exec sed -i 's/\.html//g' {} \;

FROM nginx:1.19.6-alpine
COPY --from=build /var/httrack/tecnologia.exploradoresdemadrid.org/ /usr/share/nginx/html/
COPY nginx.conf /etc/nginx/nginx.conf
