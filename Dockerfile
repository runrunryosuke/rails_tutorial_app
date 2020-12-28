ARG RUBY_VERSION
FROM ruby:$RUBY_VERSION

ARG BUNDLER_VERSION

# linux-headers: raindrops
ENV BASE_PACKAGES="git openssl less"\
    BUILD_PACKAGES="bash curl-dev ruby-dev build-base"\
    DEV_PACKAGES="zlib-dev libxml2-dev libxslt-dev tzdata yaml-dev mysql-dev"\
    RUBY_PACKAGES="ruby-json yaml nodejs-current nodejs-npm yarn"\
    GEM_PACKAGES="linux-headers"

RUN apk update &&\
    apk upgrade &&\
    apk add --update --no-cache\
    $BASE_PACKAGES\
    $BUILD_PACKAGES\
    $DEV_PACKAGES\
    $RUBY_PACKAGES\
    $GEM_PACKAGES

ENV LANG=C.UTF-8\
    GEM_HOME=/bundle\
    BUNDLE_JOBS=4\
    BUNDLE_RETRY=3
ENV BUNDLE_PATH $GEM_HOME
ENV BUNDLE_APP_CONFIG=$BUNDLE_PATH\
    BUNDLE_BIN=$BUNDLE_PATH/bin
ENV PATH /app/bin:$BUNDLE_BIN:$PATH

RUN gem update --system &&\
    gem install bundler:$BUNDLER_VERSION &&\
    gem install rails &&\
    mkdir -p /app

WORKDIR /app
