pipeline {
    agent {
        docker {
            image 'php:8.2-cli'  // Используем образ PHP
            args '-v /path/to/composer/cache:/root/.composer'  // Используем кэш для Composer
        }
    }

    environment {
        COMPOSER_CACHE_DIR = '/root/.composer/cache'
    }

    stages {
        stage('Checkout') {
            steps {
                // Клонируем код из репозитория GitHub
                git branch: 'master', url: 'https://github.com/peyotell/template.git'
            }
        }

        stage('Install Composer') {
            steps {
                script {
                    // Устанавливаем Composer, если он отсутствует
                    sh '''
                    if ! command -v composer &> /dev/null; then
                        echo "Composer not found, installing..."
                        curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
                    else
                        echo "Composer is already installed."
                    fi
                    '''
                }
            }
        }

        stage('Debug') {
            steps {
                // Диагностика: проверка доступности PHP, Composer и PHPUnit
                sh 'php -v'
                sh 'composer --version'
                sh 'ls -lah /usr/local/bin'
            }
        }

        stage('Install Dependencies') {
            steps {
                // Установка зависимостей с помощью Composer
                sh 'composer install --prefer-dist --no-interaction'
            }
        }

        stage('Run Tests') {
            steps {
                // Запуск тестов через PHPUnit
                sh './vendor/bin/phpunit'
            }
        }

        stage('Build') {
            steps {
                // Шаг сборки (если необходимо)
                echo 'Building the project...'
                // Можешь добавить дополнительные команды сборки здесь
            }
        }

        stage('Deploy') {
            when {
                branch 'master'  // Деплой только из основной ветки
            }
            steps {
                // Шаг деплоя (если требуется)
                echo 'Deploying application...'
                // Пример деплоя через SCP/RSYNC или Phing
                // sh 'scp -r ./build/* user@your-server:/path/to/deploy/'
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished.'
        }
        success {
            echo 'Build and tests passed successfully.'
        }
        failure {
            echo 'Build or tests failed.'
        }
    }
}
