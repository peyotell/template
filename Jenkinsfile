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
                echo "============================ Checkout ======================"
                // Клонируем код из репозитория GitHub
                git branch: 'master', url: 'https://github.com/peyotell/template.git'
            }
        }

        stage('Install Composer') {
            steps {
                echo "============================ Install Composer ======================"
                // Устанавливаем Composer, если он отсутствует
                sh '''
                php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
                php composer-setup.php --install-dir=/usr/local/bin --filename=composer
                php -r "unlink('composer-setup.php');"
                '''
            }
        }

        stage('Install Dependencies') {
            steps {
                echo "============================ Install Dependencies ======================"
                // Установка зависимостей с помощью Composer
                sh 'composer install --prefer-dist --no-interaction'
            }
        }

        stage('Run Tests') {
            steps {
                echo "============================ Run Tests ======================"
                // Запуск тестов через PHPUnit
                sh './vendor/bin/phpunit'
            }
        }

        stage('Build') {
            steps {
                echo "============================ Build ======================"
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
                echo "============================ Deploy ======================"
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
