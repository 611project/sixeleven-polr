FROM nginx:latest

# Default Configuration
ENV DB_HOST mysql
ENV APP_URL polr.me
ENV APP_NAME Polr
ENV REG_TYPE none
ENV ADMIN_USER admin
ENV ADMIN_PASSWORD secret
ENV ADMIN_EMAIL admin@example.tld
ENV SETUP_PASSWORD none
ENV REG_TYPE none
ENV IP_METHOD \$_SERVER['REMOTE_ADDR']
ENV PRIVATE false

RUN apt-get update
RUN apt-get install -y php5-cli php5-fpm php5-mysqlnd php5-mcrypt git
RUN rm /etc/nginx/conf.d/*
RUN sed -i '/^;catch_workers_output/ccatch_workers_output = yes' /etc/php5/fpm/pool.d/www.conf && \
    sed -i '/^;access.log/caccess.log = /var/log/fpm-access.log' /etc/php5/fpm/pool.d/www.conf && \
    sed -i '/^;php_flag\[display_errors\]/cphp_flag[display_errors] = off' /etc/php5/fpm/pool.d/www.conf && \
    sed -i '/^;php_admin_value\[error_log\]/cphp_admin_value[error_log] = /var/log/fpm-php.www.log' /etc/php5/fpm/pool.d/www.conf && \
    sed -i '/^;php_admin_flag\[log_errors\]/cphp_admin_flag[log_errors] = on' /etc/php5/fpm/pool.d/www.conf
ADD dockercfg.php /scripts/
ADD conf/polr.conf /etc/nginx/conf.d/
ADD run.sh /
CMD bash /run.sh
