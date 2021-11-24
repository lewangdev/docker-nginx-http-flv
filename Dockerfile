FROM alpine:latest as builder

ARG NGINX_VERSION=1.21.1
ARG NGINX_HTTP_FLV_VERSION=1.2.9


RUN	apk update		&&	\
	apk add				\
		git			\
		gcc			\
		binutils		\
		gmp			\
		isl			\
		libgomp			\
		libatomic		\
		libgcc			\
		openssl			\
		pkgconf			\
		pkgconfig		\
		mpc1			\
		libstdc++		\
		ca-certificates		\
		libssh2			\
		curl			\
		expat			\
		pcre			\
		musl-dev		\
		libc-dev		\
		pcre-dev		\
		zlib-dev		\
		openssl-dev		\
		curl			\
		make


RUN	cd /tmp/									&&	\
	curl --remote-name http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz			&&	\
	git clone https://github.com/winshining/nginx-http-flv-module.git -b v${NGINX_HTTP_FLV_VERSION}

RUN	cd /tmp										&&	\
	tar xzf nginx-${NGINX_VERSION}.tar.gz						&&	\
	cd nginx-${NGINX_VERSION}							&&	\
	./configure										\
		--prefix=/opt/nginx								\
		--with-http_ssl_module								\
		--add-module=../nginx-http-flv-module					&&	\
	make										&&	\
	make install

FROM alpine:latest
LABEL org.opencontainers.image.authors="lewang.dev@gmail.com"
RUN apk update		&& \
	apk add			   \
		openssl		   \
		libstdc++	   \
		ca-certificates	   \
		pcre

COPY --from=0 /opt/nginx /opt/nginx
COPY --from=0 /tmp/nginx-http-flv-module/stat.xsl /opt/nginx/conf/stat.xsl
RUN rm /opt/nginx/conf/nginx.conf
COPY nginx.conf /opt/nginx/conf/nginx.conf
COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 1935
EXPOSE 8080

CMD ["/opt/nginx/sbin/nginx", "-g", "daemon off;"]
