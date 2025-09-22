<img width="940" height="374" alt="image" src="https://github.com/user-attachments/assets/bcb19acc-e742-4e1f-85d5-447a1803e993" />


# DevOps CI/CD Pipeline with Jenkins, SonarQube, and Docker

This project demonstrates a complete **DevOps CI/CD pipeline** using:

- **GitHub** → Code repository  
- **Jenkins** → CI/CD automation  
- **SonarQube** → Code quality analysis  
- **Docker** → Containerization and deployment  
- **Flask** → Simple Python web application  

---

## 📌 Project Structure

project10

│── app.py     # Flask application

│── requirements.txt  # Python dependencies

│── Dockerfile   # Docker image instructions

│── Jenkinsfile  # Jenkins pipeline configuration

│── README.md    # Project documentation



### 1. Prerequisites (what you need)

A machine (VM or cloud) running Ubuntu OR linux 20.04+ (or similar).

For SonarQube: ≥ 4 GB RAM recommended (2 GB minimum, but community features and Elasticsearch perform better with 4GB).

For Jenkins: 2+ GB recommended.

Installed tools on that machine (we’ll install them below): git, docker, docker-compose, java (for Jenkins), pip (optional).

A GitHub account and repository (you already have project10).

A SonarQube token (we’ll create SonarQube server locally and generate token).

Basic familiarity with terminal commands (I’ll include exact commands).

### 2. Set up Docker (so we can run Jenkins & Sonar easily):

```sudo yum install docker -y```

```Sudo systemctl start docker```

`sudo docker pull sonarqube`

### http://<your-server-ip>:9000

Default credentials: admin / admin (log in and change password).

### 3. Create a Sonar token:

### In Sonar UI: top-right → My Account → Security → Generate Token → name it e.g. jenkins-token. Copy token.

### 4. Install Jenkins (on same server )
```
sudo yum update –y
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum upgrade
sudo sudo dnf install java-17-amazon-corretto -y
sudo yum install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins  
```
Access Jenkins: http://<server-ip>:8080.
Follow initial unlock instructions (use the /var/lib/jenkins/secrets/initialAdminPassword).

Install recommended plugins when prompted (or install required ones later).

### 5. Install Jenkins plugins and tools

In Jenkins UI → Manage Jenkins → Manage Plugins:

### Install:

Git plugin

Pipeline

Docker Pipeline

SonarQube Scanner for Jenkins

### 6. Configure SonarQube in Jenkins

**Manage Jenkins** → Configure System → SonarQube servers

**Add SonarQube:**

**Name:** SonarQube

**Server URL:** http://<server-ip>:9000

Server authentication token: enter token from Sonar UI (the jenkins-token) — click Add → Jenkins credential as secret text, give ID (optional).

Save.

**Manage Jenkins** → Global Tool Configuration → SonarQube Scanner

Add SonarQube Scanner installation:

**Name:** SonarScannerCLI

Optionally tick Install automatically (Jenkins will download scanner).

### 7. Add Sonar token as Jenkins Credential (best practice)

Manage Jenkins → Credentials → System → Global credentials → Add Credentials:

**Kind:** Secret text

**Secret:** <your-sonar-token>

**ID:** SONARQUBE_TOKEN (choose this ID)

**Description:** SonarQube token

We’ll reference this in the pipeline.

### 8. Make sure Jenkins user can run Docker

If Jenkins runs on the same host and will build/run Docker images, add jenkins user to docker group:

`sudo usermod -aG docker jenkins`

### 9. Create Jenkins Pipeline Job

### Jenkins → New Item → name project10-pipeline → Pipeline → OK.

### Pipeline → Definition: Pipeline script or Pipeline script from SCM.

If from SCM, choose Git, repo URL and Branch main, script path Jenkinsfile.

Save and Build Now.
