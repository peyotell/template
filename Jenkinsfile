pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                echo "============================ Checkout ======================"
                // Клонируем код из репозитория GitHub 
                git branch: 'master', url: 'https://github.com/peyotell/template.git'
            }
        }

        stage('Update DNS') {
            steps {
                script {
                    def password = "4WayTfBtNl9Gl3g1" // Убедитесь, что это безопасно
                    sh """
                    echo "${password}" | sudo -S sh -c 'echo "nameserver 8.8.8.8" > /etc/resolv.conf && echo "nameserver 8.8.4.4" >> /etc/resolv.conf'
                    """
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    echo "============================ Build ======================"
                    // Собираем кастомный образ на основе Dockerfile
                    def customImage = docker.build('my-custom-php-image')
                    
                    // Запускаем тесты и билд внутри контейнера
                    customImage.inside {
                        sh 'composer install'
                        sh 'phing build'
                        sh 'phpunit'
                    }
                }
            }
        }

        stage('Run Tests') {
            steps {
                echo "============================ Run Tests ======================"
                // Запуск тестов через PHPUnit
                sh './vendor/bin/phpunit'
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
