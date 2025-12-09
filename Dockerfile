FROM ubuntu:24.04

# Install Apache
RUN apt-get update && \
    apt-get install -y apache2 && \
    apt-get clean

# Copy HTML page
COPY index.html /var/www/html/myapp/index.html

# Copy Apache config
COPY myapp.conf /etc/apache2/sites-available/myapp.conf

# Enable site and disable default
RUN a2ensite myapp.conf && a2dissite 000-default.conf

# Expose Apache port
EXPOSE 80

# Start Apache in foreground
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
