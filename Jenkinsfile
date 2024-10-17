pipeline {
    agent {
        docker {
            image 'my-php-image' // Имя созданного Docker-образа
            args '-v /path/to/composer/cache:/root/.composer' // Используем кэш Composer
        }
    }

    stages {
        stage('Checkout') {
            steps {
                // Получаем код с репозитория
                git branch: 'main', url: 'https://github.com/your-repo-url.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                // Устанавливаем зависимости через Composer
                sh 'composer install'
            }
        }

        stage('Run Tests') {
            steps {
                // Запускаем тесты с помощью PHPUnit
                sh 'phpunit'
            }
        }

        stage('Run Phing') {
            steps {
                // Выполняем задачи через Phing
                sh 'phing'
            }
        }
    }
}
