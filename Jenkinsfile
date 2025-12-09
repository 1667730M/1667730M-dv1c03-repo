pipeline {
    agent any

    environment {
        IMAGE_NAME = "myapacheapp"
        CONTAINER_NAME = "myapachecontainer"
        HOST_PORT = "32700"
    }

    stages {

        // stage('Checkout') {
        //     steps {
        //         git branch: 'main', url: 'https://github.com/1667730M/1667730M-dv1c03-repo.git'
        //     }
        // }

        stage('Build Docker Image') {
            steps {
                script {
                    bat "docker build -t %IMAGE_NAME%:latest ."
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    // Stop old container if it exists
                    bat "docker stop %CONTAINER_NAME% || exit 0"
                    bat "docker rm %CONTAINER_NAME% || exit 0"

                    // Run Apache container in detached mode
                    bat "docker run -d --name %CONTAINER_NAME% -p %HOST_PORT%:80 %IMAGE_NAME%:latest"

                    // Wait ~3 seconds for Apache to start
                    bat "ping -n 4 127.0.0.1 > nul"
                }
            }
        }

        stage('Test HTTP Response') {
            steps {
                script {
                    bat "curl -I http://localhost:%HOST_PORT% | find \"200 OK\""
                }
            }
        }
    }
}
