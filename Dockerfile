FROM wordpress:4-apache
RUN apt-get update && apt-get install -y git
WORKDIR /usr/src/wordpress/wp-content/themes
RUN rm -rf twentyfifteen twentyseventeen twentysixteen
RUN rm -f index.php
RUN git clone https://github.com/skorik-kirill/content.git ./
WORKDIR /var/www/html
