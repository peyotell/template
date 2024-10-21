# Используем официальный PHP образ в качестве базового
FROM php:8.2-cli

# Устанавливаем необходимые системные зависимости
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    wget \
    curl \
    libzip-dev \
    && docker-php-ext-install zip \
    && rm -rf /var/lib/apt/lists/*

# Установка Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Установка PHPUnit
RUN composer global require phpunit/phpunit ^10.0 \
    && ln -s /root/.composer/vendor/bin/phpunit /usr/local/bin/phpunit

# Установка Phing
RUN composer global require phing/phing \
    && ln -s /root/.composer/vendor/bin/phing /usr/local/bin/phing

# Устанавливаем рабочую директорию
WORKDIR /app

# Команда по умолчанию
CMD ["php", "-a"]
