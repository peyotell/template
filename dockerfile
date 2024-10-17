# Используем официальный образ PHP
FROM php:8.3.0-cli

RUN echo "nameserver 8.8.8.8" > /etc/resolv.conf

# Обновляем список репозиториев и устанавливаем необходимые зависимости
RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    gnupg2 \
    curl \
    && apt-key update \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Добавляем дополнительные репозитории, если требуется (например, для сторонних пакетов)
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys <GPG-ключ> || true

# Повторно обновляем списки пакетов с новыми репозиториями
RUN apt-get update

# Устанавливаем Git, Unzip, Wget и другие необходимые инструменты
RUN apt-get install -y --no-install-recommends \
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

# Устанавливаем переменные окружения, чтобы глобальные пакеты Composer были в PATH
ENV PATH="/root/.composer/vendor/bin:${PATH}"

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем проект в контейнер
COPY . /app

# Устанавливаем зависимости проекта
RUN composer install
