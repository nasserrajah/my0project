# Use official PHP image
FROM php:8.2-cli

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git unzip libzip-dev curl \
    && docker-php-ext-install pdo_mysql mbstring zip

# Install Composer
COPY --from=composer:2.6 /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Install PHP dependencies
RUN composer install --no-dev --optimize-autoloader

# Generate app key if missing
# RUN php artisan key:generate --force

# Expose Render port (10000 required)
EXPOSE 10000

# Start Laravel server
CMD php artisan serve --host 0.0.0.0 --port 10000
