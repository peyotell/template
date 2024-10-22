pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Получаем код из репозитория
                git branch: 'master', url: 'https://github.com/peyotell/template.git'
            }
        }

        stage('Build Production Container') {
            steps {
                script {
                    sh 'ls -la'   
                    // Собираем Docker-образ на основе Dockerfile в рабочей директории Jenkins
                    docker.build('my-php-app', '-f Dockerfile.prod .')
                }
            }
        }

        stage('Build Deployment Container') {
            steps {
                script {
                    // Собираем временный контейнер
                    docker.build('my-php-app-deploy', '-f Dockerfile.deploy .')
                }
            }
        }


        stage('Run Tests') {
            steps {
                script {
                    // Запускаем временный контейнер на основе созданного Docker-образа для тестирования
                    def testContainer = docker.image('my-php-app-deploy')

                    // Запускаем контейнер на основе созданного Docker-образа
                    testContainer.inside {
                        // Устанавливаем зависимости с помощью Composer
                        sh 'composer install'

                        // Запускаем тесты с PHPUnit
                        sh 'vendor/bin/phpunit --configuration phpunit.xml'

                        // Выполняем задачи с Phing
                        sh 'vendor/bin/phing -buildfile scripts/build.xml'
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
                    sh """
                    docker run -d -p 80:80 \
                        --name my-php-app \
                        my-php-app        
                    """    
                    //-v /path/to/data:/var/www/html \                            
                }
            }
        }
    }

    post {
        always {
            script {
                // Удаляем временный контейнер после завершения
                sh 'docker rm -f my-php-app-deploy || true'
            }
        }
    }
}
