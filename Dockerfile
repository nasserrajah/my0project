# Use official PHP image with extensions
FROM php:8.2-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git unzip libonig-dev libzip-dev curl npm

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring zip

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html

# Copy project
COPY . .

# Install PHP dependencies
RUN composer install --no-dev --optimize-autoloader

# Install Node dependencies if needed
RUN npm install
RUN npm run build

# Expose port
EXPOSE 8000

# Start Laravel
CMD php artisan serve --host 0.0.0.0 --port 8000
