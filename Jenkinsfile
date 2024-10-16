pipeline {
    agent {
        docker {
            image 'php:8.2-cli'  // Указываем контейнер с нужной версией PHP
            args '-v /path/to/composer/cache:/root/.composer'  // Пример использования кеша Composer
        }
    }

    environment {
        COMPOSER_CACHE_DIR = '/root/.composer/cache'
    }

    stages {
        stage('Checkout') {
            steps {
                // Клонирование кода из GitHub
                git branch: 'master', url: 'https://github.com/peyotell/template.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                // Установка зависимостей через Composer
                sh 'composer install --prefer-dist --no-interaction'
            }
        }

        stage('Run Tests') {
            steps {
                // Запуск PHPUnit тестов
                sh './vendor/bin/phpunit'
            }
        }

        stage('Build') {
            steps {
                // Пример сборки проекта (если есть шаг сборки)
                echo 'Building the project...'
                // sh 'phing build' // Включить, если используешь Phing
            }
        }

        stage('Deploy') {
            when {
                branch 'master'  // Выполнять деплой только для основной ветки
            }
            steps {
                // Пример деплоя через SSH или другой механизм
                echo 'Deploying application...'
                // sh 'phing deploy' // Включить, если деплой через Phing
                // Или используем SCP/RSYNC для деплоя
                // sh 'scp -r ./build/* user@your-server:/path/to/deploy/'
            }
        }
    }

    post {
        always {
            // Действия, которые нужно выполнить после выполнения пайплайна
            echo 'Pipeline finished.'
        }
        success {
            // Действия при успешном завершении (например, уведомление)
            echo 'Build and tests passed successfully.'
        }
        failure {
            // Действия при неудаче (например, отправка уведомления об ошибке)
            echo 'Build or tests failed.'
        }
    }
}
