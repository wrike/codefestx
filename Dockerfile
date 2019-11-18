FROM google/dart:2.4.0 AS build-env
WORKDIR /app/

ADD pubspec.* /app/
ENV PATH="${PATH}:/root/.pub-cache/bin:/${HOME}/.pub-cache/bin"
RUN pub get --no-precompile
RUN pub global activate webdev
ADD . /app/
RUN pub get --offline --no-precompile
RUN webdev build --output /app/build/

FROM nginx:stable

RUN apt update \
 && apt install -y curl

COPY --from=build-env /app/build/web /usr/share/nginx/html
COPY default.conf /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 8080
