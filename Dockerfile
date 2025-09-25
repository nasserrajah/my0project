# =========================
# Stage 0: Build environment
# =========================

# استخدم صورة PHP-FPM الرسمية مع إصدار PHP 8.2
FROM php:8.2-fpm

# تثبيت الأدوات الأساسية والمكتبات المطلوبة
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    curl \
    libonig-dev \
    pkg-config \
    nodejs \
    npm \
    libpng-dev \
    libjpeg-dev \
    && docker-php-ext-install pdo_mysql mbstring zip \
    && rm -rf /var/lib/apt/lists/*

# تثبيت Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# تعيين مجلد العمل
WORKDIR /app

# نسخ ملفات المشروع
COPY . .

# تثبيت حزم PHP (باستخدام cache)
RUN composer install --no-dev --optimize-autoloader --no-scripts --no-interaction

# تثبيت حزم Node.js وبناء المشروع
RUN npm install && npm run build

# عرض البورت الذي سيعمل عليه التطبيق
EXPOSE 8000

# تشغيل سيرفر Laravel
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
