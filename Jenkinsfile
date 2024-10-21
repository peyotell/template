pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Получаем код из репозитория
                git branch: 'master', url: 'https://github.com/peyotell/template.git'
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

        stage('Run Tests') {
            steps {
                script {
                    // Запускаем контейнер на основе созданного Docker-образа
                    dockerImage.inside {
                        // Устанавливаем зависимости с помощью Composer
                        sh 'composer install'

                        // Даем права на выполнение для phpunit и phing
                        // sh 'chmod +x vendor/bin/phpunit vendor/bin/phing'

                        // Запускаем тесты с PHPUnit
                        sh 'vendor/bin/phpunit --configuration phpunit.xml'

                        // Выполняем задачи с Phing
                        sh 'vendor/bin/phing'
                    }
                }
            }
        }

        stage('Deploy to Server') {
            steps {
                script {
                    // Удаляем старый контейнер, если он есть
                    sh 'docker rm -f my-php-app || true'

                    // Запускаем новый контейнер
                    sh '''
                    docker run -d -p 80:80 \
                        --name my-php-app \
                        -v /path/to/data:/var/www/html \
                        my-php-app
                    '''
                }
            }
        }
    }

    post {
        always {
            // Всегда очищаем ненужные контейнеры
            script {
                sh 'docker system prune -f'
            }
        }
    }    
}
