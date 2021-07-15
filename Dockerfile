FROM ubuntu:18.04

ENV NGX_MRB_VERSION 2.2.3
ENV NGINX_CONFIG_OPT_ENV \
			--with-http_stub_status_module \
			--with-http_ssl_module \
			--prefix=/usr/local/nginx \
			--with-http_realip_module \
			--with-http_addition_module \
			--with-http_sub_module \
			--with-http_gunzip_module \
			--with-http_gzip_static_module \
			--with-http_random_index_module \
			--with-http_secure_link_module

RUN apt-get -y update \
		&& apt-get install -y \
			sudo \
			openssh-server \
			git \
			curl \
			rake \
			ruby ruby-dev \
			bison \
			libcurl4-openssl-dev libssl-dev \
			libhiredis-dev \
			libmarkdown2-dev \
			libcap-dev \
			libcgroup-dev \
			make \
			libpcre3 libpcre3-dev \
			libmysqlclient-dev \
			gcc

RUN cd /usr/local/src/ \
			&& wget https://github.com/matsumotory/ngx_mruby/archive/refs/tags/v${NGX_MRB_VERSION}.tar.gz \
			&& tar -xvf v${NGX_MRB_VERSION}.tar.gz \
			&& cd ngx_mruby-${NGX_MRB_VERSION} \
			&& sh build.sh \
			&& make install

CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]
