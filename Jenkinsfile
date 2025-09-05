pipeline {
    agent any
    
	tools{
       maven 'maven3'
        
    }

    stages {
        stage('Git checkout') {
            steps {
              git branch: 'main', url: 'https://github.com/adarsh0331/project10.git'  
            }
        }
        stage('Compile stage maven') {
            steps {
                sh 'mvn clean install'
            }
        }

        stage('SONARQUBE ANALYSIS ') {
            steps {
                echo " SONARQUBE ANALYSIS"
				sh ''' mvn sonar:sonar \\
                      -Dsonar.host.url=http://3.80.128.201:9000/ \\
                      -Dsonar.login=squ_464b30c7f49ad6b99a5d0cd66bb6b88ccc5a7df3'''
				
            }
        }
		           
       stage('docker build') {
            steps {

                    sh 'docker build -t devops/mc14:v1 .'

            }
        }

        }
		
		}
