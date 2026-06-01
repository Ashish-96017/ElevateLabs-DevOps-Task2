pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t flask-cicd-app .'
            }
        }

        stage('Test') {
            steps {
                bat 'docker run --rm flask-cicd-app pytest test_app.py -v'
            }
        }

        stage('Deploy') {
    steps {
        bat '''
        docker rm -f flask-app 2>nul
        docker run -d -p 5000:5000 --name flask-app flask-cicd-app
        '''
    }
}

      stage('Health Check') {
    steps {
        bat '''
        timeout /t 5 >nul
        curl http://localhost:5000/health
        '''
    }
}

    post {
        success {
            echo 'Pipeline Success'
        }

        failure {
            echo 'Pipeline Failed'
        }
    }
}
