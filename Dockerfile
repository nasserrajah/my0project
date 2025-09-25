# Use PHP 8.2 image
FROM php:8.2-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git unzip libonig-dev libzip-dev curl npm

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring zip

# Install Composer directly
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set working directory
WORKDIR /var/www/html

# Copy project files
COPY . .

# Install PHP dependencies
RUN composer install --no-dev --optimize-autoloader

# Install Node dependencies if needed
RUN npm install
RUN npm run build

# Expose port
EXPOSE 8000

# Start Laravel server
CMD php artisan serve --host 0.0.0.0 --port 8000
