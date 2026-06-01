# Task 2 — Jenkins CI/CD Pipeline

**DevOps Internship | ElevateLabs**

---

## What This Project Does

A simple Flask web application with a fully automated Jenkins CI/CD pipeline.
Every time code is pushed to the repository, Jenkins automatically:
1. Pulls the latest code
2. Builds a Docker image
3. Runs automated tests
4. Deploys the container
5. Verifies the app is healthy

---

## Project Structure

```
jenkins-cicd-task/
├── app.py              # Flask web application
├── test_app.py         # Pytest test cases
├── requirements.txt    # Python dependencies
├── Dockerfile          # Container build instructions
├── Jenkinsfile         # CI/CD pipeline definition
└── README.md
```

---

## Pipeline Stages

| Stage | What It Does |
|-------|-------------|
| Checkout | Pulls latest code from GitHub |
| Build | Builds Docker image from Dockerfile |
| Test | Runs pytest inside Docker container |
| Deploy | Stops old container, starts new one |
| Health Check | Hits `/health` endpoint to confirm app is live |

---

## How to Run Locally

### Prerequisites
- Docker installed
- Python 3.11+

### Run without Jenkins
```bash
# Build image
docker build -t flask-cicd-app .

# Run container
docker run -d -p 5000:5000 --name flask-app flask-cicd-app

# Test endpoints
curl http://localhost:5000/
curl http://localhost:5000/health
```

### Run tests
```bash
pip install -r requirements.txt
pytest test_app.py -v
```

---

## Jenkins Setup Steps

### 1. Install Jenkins
```bash
# Ubuntu/Debian
sudo apt update
sudo apt install -y openjdk-17-jdk
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update
sudo apt install -y jenkins
sudo systemctl start jenkins
sudo systemctl enable jenkins
```
Access Jenkins at: `http://localhost:8080`

### 2. Required Jenkins Plugins
- Git Plugin
- Docker Pipeline Plugin
- Pipeline Plugin

### 3. Create Pipeline Job
1. New Item → Pipeline
2. Under "Pipeline" → select "Pipeline script from SCM"
3. SCM: Git → paste your GitHub repo URL
4. Script Path: `Jenkinsfile`
5. Save

### 4. Enable Auto-Trigger on Push
1. In job config → Build Triggers → check "GitHub hook trigger for GITScm polling"
2. In GitHub repo → Settings → Webhooks → Add webhook
3. URL: `http://YOUR_JENKINS_IP:8080/github-webhook/`

---

## API Endpoints

| Endpoint | Method | Response |
|----------|--------|----------|
| `/` | GET | App info + version |
| `/health` | GET | Health status |

---

## Interview Questions — Answers

**1. What is Jenkins and how is it used in CI/CD?**
Jenkins is an open-source automation server that automates the build, test, and deployment stages of software delivery. In CI/CD, Jenkins monitors a code repository and automatically runs a pipeline whenever changes are pushed, ensuring code is always tested and deployable.

**2. What is a Jenkinsfile?**
A Jenkinsfile is a text file written in Groovy DSL that defines the entire CI/CD pipeline as code. It lives in the root of the repository so pipeline changes are versioned alongside application code.

**3. How do you create and configure Jenkins pipelines?**
Create a "Pipeline" job in Jenkins, point it to a Git repository, specify the Jenkinsfile path, and configure triggers. The Jenkinsfile defines all stages and steps using either Declarative or Scripted syntax.

**4. What are common stages in a Jenkins pipeline?**
Checkout, Build, Test, Code Analysis (SonarQube), Build Docker Image, Push to Registry, Deploy to Staging, Integration Tests, Deploy to Production, Health Check.

**5. Declarative vs Scripted pipeline?**

| | Declarative | Scripted |
|--|------------|---------|
| Syntax | Structured `pipeline {}` block | Full Groovy code |
| Learning curve | Easy | Harder |
| Error checking | Built-in validation | Manual |
| Flexibility | Less flexible | Fully flexible |
| Recommended for | Most use cases | Complex custom logic |

Declarative is the modern standard and what this project uses.

---

*Submitted by: [Your Name] | ElevateLabs DevOps Internship*
