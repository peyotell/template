# Используем официальный образ PHP
FROM php:8.3.0-cli

# Устанавливаем необходимые зависимости
RUN apt-get update && apt-get install -y --no-install-recommends\
    git \
    unzip \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Устанавливаем Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Устанавливаем Phing
RUN composer global require phing/phing

# Устанавливаем PHPUnit
RUN composer global require phpunit/phpunit

# Устанавливаем переменные окружения, чтобы использовать глобальные пакеты Composer
ENV PATH="/root/.composer/vendor/bin:${PATH}"

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем проект в контейнер
COPY . /app

# Устанавливаем зависимости приложения
RUN composer install
