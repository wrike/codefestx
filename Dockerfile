FROM google/dart AS build-env
WORKDIR /app/

ADD pubspec.* /app/
RUN pub get
RUN pub global activate webdev
ENV PATH="${PATH}:/root/.pub-cache/bin"
ADD . /app/
RUN webdev build --output /app/build/

FROM nginx:stable

COPY --from=build-env /app/build/web /usr/share/nginx/html
COPY default.conf /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/nginx.conf

RUN groupadd -r angular
RUN useradd -m -r -g angular angular

RUN touch /var/run/nginx.pid && \
  chown angular:angular /var/run/nginx.pid && \
  chown -R angular:angular /var/cache/nginx

USER angular

EXPOSE 8080
