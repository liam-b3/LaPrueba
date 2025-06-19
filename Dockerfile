FROM php:8.2-cli

# Instala dependencias del sistema
RUN apt-get update && apt-get install -y \
    unzip \
    git \
    curl \
    libzip-dev \
    libpng-dev \
    libonig-dev \
    zip \
    sqlite3 \
    && docker-php-ext-install zip pdo pdo_sqlite

# Instala Composer
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

# Directorio de trabajo
WORKDIR /app

# Copia el contenido del proyecto
COPY . .

# Instala dependencias PHP
RUN composer install

# Comando para iniciar Laravel
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=10000"]