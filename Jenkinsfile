pipeline {
    agent any

    environment {
        SONARQUBE = credentials('sonar-token')
       // DOCKER_CREDENTIALS = credentials('docker-hub')
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/adarsh0331/project10.git'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarScanner') {
                    sh '''
                        sonar-scanner                         -Dsonar.projectKey=my-devops-app                         -Dsonar.sources=.                         -Dsonar.host.url=http://<SONARQUBE_SERVER>:9000                         -Dsonar.login=$SONARQUBE
                    '''
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                    docker build -t my-devops-app:latest .
                '''
            }
        }

        stage('Push Docker Image') {
            steps {
                sh '''
                    echo $DOCKER_CREDENTIALS_PSW | docker login -u $DOCKER_CREDENTIALS_USR --password-stdin
                    docker tag my-devops-app:latest <your-dockerhub-username>/my-devops-app:latest
                    docker push <your-dockerhub-username>/my-devops-app:latest
                '''
            }
        }

        stage('Deploy App') {
            steps {
                sh '''
                    docker rm -f my-devops-app || true
                    docker run -d --name my-devops-app -p 5000:5000 <your-dockerhub-username>/my-devops-app:latest
                '''
            }
        }
    }
}
