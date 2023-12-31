# syntax = docker/dockerfile:1

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.2.2
FROM ruby:$RUBY_VERSION-slim as base

# Rails app lives here
WORKDIR /rails

# Set production environment
ENV RAILS_ENV="development" \
    BUNDLE_DEPLOYMENT="1"

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

# Install node modules
COPY --link package.json yarn.lock ./
RUN yarn install --check-files


FROM prebuild as build

# Build options
ENV PATH="/usr/local/node/bin:$PATH"

# Install application gems
COPY --link Gemfile Gemfile.lock ./
RUN --mount=type=cache,id=bld-gem-cache,sharing=locked,target=/srv/vendor \
    bundle config set app_config .bundle && \
    bundle config set path /srv/vendor && \
    bundle install && \
    bundle exec bootsnap precompile --gemfile && \
    bundle clean && \
    mkdir -p vendor && \
    bundle config set path vendor && \
    cp -ar /srv/vendor .

# Copy node modules
COPY --from=node /rails/node_modules /rails/node_modules
COPY --from=node /usr/local/node /usr/local/node
ENV PATH=/usr/local/node/bin:$PATH

# Copy application code
COPY --link . .

# Precompile bootsnap code for faster boot times
RUN bundle exec bootsnap precompile app/ lib/

# Precompiling assets for production without requiring secret RAILS_MASTER_KEY
# RUN SECRET_KEY_BASE=DUMMY ./bin/rails assets:precompile
ENV RAILS_MASTER_KEY=79747573b8965e75ce01e5f48d172361
RUN ./bin/rails assets:precompile


# Final stage for app image
FROM base

# Install packages needed for deployment
RUN --mount=type=cache,id=dev-apt-cache,sharing=locked,target=/var/cache/apt \
    --mount=type=cache,id=dev-apt-lib,sharing=locked,target=/var/lib/apt \
    apt-get update -qq && \
    apt-get install -yq --no-install-recommends \
    curl \
    imagemagick \
    libsqlite3-0 \
    libvips \
    ghostscript

# Copy built artifacts: gems, application
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

# Run and own only the runtime files as a non-root user for security
ARG UID=1000 \
    GID=1000
RUN groupadd -f -g $GID rails && \
    useradd -u $UID -g $GID rails --create-home --shell /bin/bash && \
    mkdir /data && \
    chown -R rails:rails db log storage tmp /data public/deal_images
USER rails:rails

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
