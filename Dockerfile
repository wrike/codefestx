FROM google/dart:2.2 AS build-env
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

EXPOSE 8080
