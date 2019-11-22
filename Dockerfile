FROM phusion/passenger-ruby25
MAINTAINER Michal Mocnak <michal@narra.eu>
LABEL Vendor="narra" Version="1.0"

# Set correct environment variables.
ENV HOME /root

# Set narra build env
RUN mkdir -p /build/narra
ADD . /build/narra

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

# Install NARRA master node
RUN /build/narra/scripts/install.sh

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
