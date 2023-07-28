# Use the official Ruby image as the base image
FROM ruby:3.2.2-alpine

ENV BUNDLER_VERSION=2.0.2

# Install system dependencies
RUN apk add --update --no-cache \
  binutils-gold \
  build-base \
  curl \
  file \
  g++ \
  gcc \
  git \
  less \
  libstdc++ \
  libffi-dev \
  libc-dev \ 
  linux-headers \
  libxml2-dev \
  libxslt-dev \
  libgcrypt-dev \
  make \
  netcat-openbsd \
  nodejs \
  openssl \
  pkgconfig \
  postgresql-dev \
  tzdata \
  yarn \
  imagemagick \
  imagemagick-dev \
  imagemagick-libs

# Install bundler
ENV BUNDLE_PATH /gems
RUN gem install bundler
RUN gem install nokogiri --platform=ruby


# Set the working directory inside the container
WORKDIR /app

# Copy the Gemfile and Gemfile.lock to the container
COPY Gemfile Gemfile.lock ./

# RUN bundle config build.nokogiri --use-system-libraries


# Install Ruby gems
RUN bundle lock --add-platform x86_64-linux
RUN bundle check || bundle install 

COPY package.json yarn.lock ./

RUN yarn install --check-files

# Copy the rest of the application code to the container
COPY . .

# RUN bundle exec rails assets:precompile


ENTRYPOINT ["./entrypoints/docker-entrypoint.sh"]


# Expose port 3000 to access the Rails application
EXPOSE 3000

# Start the Rails server using Puma (adjust as needed)
# CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
