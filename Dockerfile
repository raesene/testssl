FROM ubuntu:14.04

MAINTAINER Rory McCune <rorym@mccune.org.uk>

#Disable Interactive Functions
ENV DEBIAN_FRONTEND noninteractive

#wget needed to download files, bsdmainutils for hexdump dnsutils for dig
RUN apt-get update -y && \
	apt-get install -y wget bsdmainutils dnsutils && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

RUN mkdir testssl
WORKDIR /testssl

RUN wget -q -O openssl.tar.gz https://testssl.sh/openssl-1.0.2e-chacha.pm.ipv6.Linux.tar.gz && \
	tar -xzvf openssl.tar.gz && \
	wget -q -O testssl.sh https://testssl.sh/testssl.sh && \
	chmod +x /testssl/testssl.sh

ENV OPENSSL /testssl/bin/openssl.Linux.i686

ENTRYPOINT ["/testssl/testssl.sh"]
CMD ["-h"]

