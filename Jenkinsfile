pipeline {
    agent any

    environment {
        IMAGE_NAME = "1667730m-temp-server-image"
        CONTAINER_NAME = "1667730m-web-server"
        HOST_PORT = "32700"
    }

    stages {

        stage('1667730m-S1') {
            steps {
                echo "1667730m-S1: Release environment is ready."
            }
        }

        stage('1667730m-S2') {
            steps {
                // Assume condition is met
                echo "1667730m-S2: Release Windows checked - Continue the pipeline"
            }
        }

        stage('1667730m-S3') {
            steps {
                echo "1667730m-S3: Setting up new web server container..."

                // Stop old container if exists
                bat "docker stop %CONTAINER_NAME% || exit 0"
                bat "docker rm %CONTAINER_NAME% || exit 0"

                // Build and run new container on port 32700
                bat "docker build -t %IMAGE_NAME%:latest ."
                bat "docker run -d --name %CONTAINER_NAME% -p %HOST_PORT%:80 %IMAGE_NAME%:latest"

                echo "Waiting for Apache to start..."
                bat "ping -n 4 127.0.0.1 > nul"

                echo "1667730m-S3: Web Server is setup and running"
            }
        }

        stage('1667730m-parallel-S4') {
            parallel {
                stage('1667730m-S4A') {
                    steps {
                        echo "1667730m-S4A: SQL Injection (SQLi) Test - Report Generated"
                    }
                }

                stage('1667730m-S4B') {
                    steps {
                        echo "1667730m-S4B: Cross-Site Scripting (XSS) Test - Report Generated"
                    }
                }
            }
        }

        stage('1667730m-S5') {
            steps {
                script {
                    // Prompt user to continue or abort
                    def userChoice = input(
                        message: "1667730m, after checking security reports, continue the pipeline?",
                        ok: "Proceed",
                        parameters: []
                    )

                    echo "1667730m-S5: Approve to continue the pipeline."
                    // Set environment variable to indicate approval
                    env.PROCEED_STAGE6 = "true"
                }
            }
        }

        stage('1667730m-S6') {
            when {
                expression {
                    return env.PROCEED_STAGE6 == "true"
                }
            }
            steps {
                echo "1667730m-S6: Getting ready for next phase"
            }
        }
    }
}
