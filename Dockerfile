# syntax = docker/dockerfile:1

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.3.3
FROM ruby:$RUBY_VERSION-slim as base

# Rails app lives here
WORKDIR /rails
FROM build

# Set production environment
ENV RAILS_ENV="development" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle"

# Update gems and bundler
RUN gem update --system --no-document && \
    gem install -N bundler

# Install packages needed to install nodejs
RUN --mount=type=cache,id=dev-apt-cache,sharing=locked,target=/var/cache/apt \
    --mount=type=cache,id=dev-apt-lib,sharing=locked,target=/var/lib/apt \
    apt-get update -qq && \
    apt-get install --no-install-recommends -y curl 

# Install Node.js
ARG NODE_VERSION=20.4.0
ENV PATH=/usr/local/node/bin:$PATH
RUN curl -sL https://github.com/nodenv/node-build/archive/master.tar.gz | tar xz -C /tmp/ && \
    /tmp/node-build-master/bin/node-build "${NODE_VERSION}" /usr/local/node && \
    rm -rf /tmp/node-build-master


# Throw-away build stages to reduce size of final image
FROM base as prebuild

# Install packages needed to build gems and node modules
RUN --mount=type=cache,id=dev-apt-cache,sharing=locked,target=/var/cache/apt \
    --mount=type=cache,id=dev-apt-lib,sharing=locked,target=/var/lib/apt \
    apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential libmagickwand-dev libvips node-gyp pkg-config python-is-python3


FROM prebuild as node

# Install yarn
ARG YARN_VERSION=1.22.17
RUN npm install -g yarn@$YARN_VERSION

FROM prebuild as postgres
# Install PostgreSQL
RUN apt-get update -qq && \
    apt-get install -yq --no-install-recommends \
    postgresql-client && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Add PostgreSQL configuration
COPY --chown=ruby:rails config/database.yml /rails/config/database.yml
# Copy built artifacts: gems, application
COPY  "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY . /rails
# RUN chown -R ruby:rails /rails

# COPY --chown=rails:rails config/database.yml.postgres /rails/config/database.yml
# libvips \
#     ghostscript

# Copy built artifacts: gems, application
# COPY  "${BUNDLE_PATH}" "${BUNDLE_PATH}"
# COPY  "/rails" "/rails"
COPY --chown=ruby:ruby Gemfile* ./

COPY --chown=ruby:ruby package.json *yarn* ./

COPY --chown=ruby . .



# Run and own only the runtime files as a non-root user for security
# ARG UID=1000 \
#     GID=1000
# RUN groupadd -f -g $GID rails && \
#     useradd -u $UID -g $GID rails --create-home --shell /bin/bash && \
#     mkdir /data && \
#     chown -R rails:rails db log storage tmp /data public/deal_images

# Create the 'rails' group if it doesn't already exist
RUN getent group rails || groupadd rails

# Create the 'ruby' user if it doesn't already exist, and add it to the 'rails' group
RUN id -u ruby &>/dev/null || useradd -m -g rails ruby


USER ruby:rails
# User ruby

# Deployment options
# ENV DATABASE_URL="sqlite3:///db/production.sqlite3" \
#     RAILS_LOG_TO_STDOUT="1" \
#     RAILS_SERVE_STATIC_FILES="true"

# ENV DATABASE_URL="sqlite3://./db/production.sqlite3"
ENV RAILS_LOG_TO_STDOUT="1" \
RAILS_SERVE_STATIC_FILES="true"

# Entrypoint prepares the database.
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# RUN chown -R /rails/public/

# Start the server by default, this can be overwritten at runtime
EXPOSE 3000
VOLUME /data
CMD ["./bin/rails", "server"]
