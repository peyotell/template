pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Получаем код из репозитория
                git branch: 'master', url: 'https://github.com/your-repo-url.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Собираем Docker-образ на основе Dockerfile в рабочей директории Jenkins
                    dockerImage = docker.build('my-php-image')
                }
            }
        }

        stage('Run Tests Inside Docker') {
            steps {
                script {
                    // Запускаем контейнер на основе созданного Docker-образа
                    dockerImage.inside {
                        // Устанавливаем зависимости с помощью Composer
                        sh 'composer install'

                        // Запускаем тесты с PHPUnit
                        sh 'phpunit'

                        // Выполняем задачи с Phing
                        sh 'phing'
                    }
                }
            }
        }
    }
}
