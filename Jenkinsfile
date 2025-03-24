pipeline {
    agent any  // Run on any available agent

    environment {
        // Set environment variables (if any needed)
        TEST_IMAGE = 'python-web-test' // Docker image name
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from Git
                git 'https://github.com/TZIAllstar/AutotalksPrep'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image
                    sh 'docker build -t ${TEST_IMAGE} .'
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    // Run the tests using Docker
                    sh 'docker run --rm ${TEST_IMAGE}'
                }
            }
        }

        stage('Cleanup') {
            steps {
                script {
                    // Clean up (Optional)
                    sh 'docker system prune -f'  // Removes unused Docker images/containers
                }
            }
        }
    }

    post {
        success {
            echo 'Tests Passed!'
        }
        failure {
            echo 'Tests Failed!'
        }
    }
}
