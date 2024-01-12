# ------------------------------------------------------------------------------
# Base - AMD64 & ARM64 compatible
# ------------------------------------------------------------------------------
FROM ruby:3.2.2-alpine as base

RUN apk add --no-cache --no-progress --no-check-certificate build-base less curl tzdata gcompat

ENV TZ Europe/London

# ------------------------------------------------------------------------------
# Dependencies
# ------------------------------------------------------------------------------
FROM base as deps

LABEL org.opencontainers.image.description "Application Dependencies"

RUN apk add --no-cache --no-progress --no-check-certificate postgresql-dev yarn

ENV APP_HOME /build

WORKDIR ${APP_HOME}

COPY package.json ${APP_HOME}/package.json
COPY yarn.lock ${APP_HOME}/yarn.lock
COPY .yarn ${APP_HOME}/.yarn
COPY .yarnrc.yml ${APP_HOME}/.yarnrc.yml

RUN yarn install

COPY Gemfile* ./

RUN bundle config set no-cache true
RUN bundle config set without development test
RUN bundle install --no-binstubs --retry=10 --jobs=4

# ------------------------------------------------------------------------------
# Production Stage
# ------------------------------------------------------------------------------
FROM base AS app

LABEL org.opencontainers.image.source=https://github.com/DFE-Digital/help-for-early-years-providers
LABEL org.opencontainers.image.description "Help for Early Years Providers"

RUN echo "Welcome to the EYFS Help for Early Years Providers Application" > /etc/motd
RUN apk add --no-cache --no-progress --no-check-certificate postgresql-dev yarn openssh
RUN echo "root:Docker!" | chpasswd && cd /etc/ssh/ && ssh-keygen -A

ENV APP_HOME /srv
ENV RAILS_ENV ${RAILS_ENV:-production} \
  GOVUK_APP_DOMAIN www.gov.uk

RUN mkdir -p ${APP_HOME}/tmp/pids ${APP_HOME}/log

WORKDIR ${APP_HOME}

COPY Gemfile* ./
COPY --from=deps /usr/local/bundle /usr/local/bundle

COPY config.ru ${APP_HOME}/config.ru
COPY Rakefile ${APP_HOME}/Rakefile
COPY public ${APP_HOME}/public
COPY bin ${APP_HOME}/bin
COPY lib ${APP_HOME}/lib
COPY config ${APP_HOME}/config
COPY db ${APP_HOME}/db
COPY app ${APP_HOME}/app

COPY package.json ${APP_HOME}/package.json
COPY yarn.lock ${APP_HOME}/yarn.lock
COPY .yarnrc.yml ${APP_HOME}/.yarnrc.yml
COPY --from=deps /build/.yarn ${APP_HOME}/.yarn
COPY --from=deps /build/node_modules ${APP_HOME}/node_modules

RUN SECRET_KEY_BASE=x ./bin/rails assets:precompile

COPY sshd_config /etc/ssh/
COPY ./bin/docker-entrypoint /

ENTRYPOINT ["docker-entrypoint"]

EXPOSE 3000

CMD ["bin/rails", "server"]
