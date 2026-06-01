pipeline {
    agent any

    environment {
        IMAGE_NAME = "flask-cicd-app"
        IMAGE_TAG  = "latest"
        CONTAINER_NAME = "flask-app"
        APP_PORT   = "5000"
    }

    stages {

        stage('Checkout') {
            steps {
                echo '========== Stage 1: Checkout Code =========='
                checkout scm
                echo "Branch: ${env.GIT_BRANCH}"
                echo "Commit: ${env.GIT_COMMIT}"
            }
        }

        stage('Build Docker Image') {
            steps {
                echo '========== Stage 2: Build Docker Image =========='
                sh """
                    docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .
                    echo "Docker image built successfully: ${IMAGE_NAME}:${IMAGE_TAG}"
                """
            }
        }

        stage('Test') {
            steps {
                echo '========== Stage 3: Run Tests =========='
                sh """
                    docker run --rm \
                        ${IMAGE_NAME}:${IMAGE_TAG} \
                        python -m pytest test_app.py -v
                """
            }
        }

        stage('Deploy') {
            steps {
                echo '========== Stage 4: Deploy Application =========='
                sh """
                    # Stop and remove old container if it exists
                    docker stop ${CONTAINER_NAME} || true
                    docker rm   ${CONTAINER_NAME} || true

                    # Run new container
                    docker run -d \
                        --name ${CONTAINER_NAME} \
                        -p ${APP_PORT}:5000 \
                        --restart unless-stopped \
                        ${IMAGE_NAME}:${IMAGE_TAG}

                    echo "Container deployed successfully"
                """
            }
        }

        stage('Health Check') {
            steps {
                echo '========== Stage 5: Health Check =========='
                sh """
                    sleep 5
                    curl -f http://localhost:${APP_PORT}/health || exit 1
                    echo "Health check passed!"
                """
            }
        }
    }

    post {
        success {
            echo '✅ Pipeline SUCCEEDED — App is live!'
        }
        failure {
            echo '❌ Pipeline FAILED — Check logs above.'
            sh """
                docker stop ${CONTAINER_NAME} || true
                docker rm   ${CONTAINER_NAME} || true
            """
        }
        always {
            echo "Pipeline finished. Cleaning up dangling images..."
            sh "docker image prune -f || true"
        }
    }
}
