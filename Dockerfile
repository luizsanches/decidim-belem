FROM ruby:2.7.3-alpine3.13

WORKDIR /taselado

COPY Gemfile .
COPY Gemfile.lock .

RUN apk update \
 && apk add --no-cache --virtual .build \
      build-base \
      linux-headers \
      postgresql-dev \
      libxml2-dev \
      libxslt-dev \
 && bundle config build.nokogiri \
      --use-system-libraries \
      --with-xml2-lib=/usr/include/libxml2 \
      --with-xml2-include=/usr/include/libxml2 \
 && bundle config set no-cache 'true' \
 && bundle config set deployment 'true' \
 && bundle install \
 && apk add --no-cache --virtual .runtime \
      curl \
      libpq \
      libxml2 \
      libxslt \
      tzdata \
      imagemagick \
      nodejs \
 && rm -rf /root/.bundle \
 && rm -rf /usr/lib/node_modules \
 && apk del --no-cache .build

COPY . .

RUN source .env.dockerbuild \
 && apk add --no-cache --virtual .build yarn \
 && yarn install --production \
 && bundle exec rake assets:precompile \
 && bundle exec rake tmp:clear \
 && bundle exec rake log:clear \
 && yarn cache clean \
 && rm -rf node_modules \
 && apk del --no-cache .build

EXPOSE 3000

ENTRYPOINT ["/taselado/entrypoints.sh"]
