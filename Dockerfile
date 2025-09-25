# Use a public PHP image that doesn't require login
FROM bitnami/php-fpm:8.2

# Install system dependencies
RUN install_packages git unzip libzip-dev npm

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring zip

# Install Composer directly
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set working directory
WORKDIR /app

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
