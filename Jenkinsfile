pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "my-devops-app:latest"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git url: 'https://github.com/adarsh0331/project10.git', branch: 'main'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {   // Jenkins -> Manage Jenkins -> Configure System -> SonarQube servers
                    script {
                        def scannerHome = tool 'SonarScannerCLI'   // Jenkins -> Manage Jenkins -> Tools -> SonarQube Scanner installations
                        sh """
                            ${scannerHome}/bin/sonar-scanner \
                            -Dsonar.projectKey=my-devops-app \
                            -Dsonar.sources=. \
                            -Dsonar.host.url=http://52.66.142.214:9000 \
                            -Dsonar.login=squ_643d162ae309b24b5bdd55de630795e75f204a52
                        """
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "sudo docker build -t $DOCKER_IMAGE ."
            }
        }

        stage('Deploy App') {
            steps {
                sh """
                    sudo docker ps -q --filter "name=my-devops-app" | grep -q . && docker stop my-devops-app && docker rm my-devops-app || true
                    sudo docker run -d --name my-devops-app -p 5000:5000 $DOCKER_IMAGE
                """
            }
        }
    }

    post {
        always {
            echo "Pipeline finished!"
        }
        failure {
            echo "Pipeline failed ❌"
        }
        success {
            echo "Pipeline completed successfully ✅"
        }
    }
}
