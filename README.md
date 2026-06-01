# ElevateLabs-DevOps-Task2

## Jenkins CI/CD Pipeline with Docker

**DevOps Internship | ElevateLabs**

---

## Project Overview

This project demonstrates a complete CI/CD (Continuous Integration and Continuous Deployment) pipeline using Jenkins, Docker, GitHub, and a Flask web application.

The pipeline automates the software delivery process by building the application, running automated tests, deploying a Docker container, and performing a health check to verify successful deployment.

---

## CI/CD Workflow

```text
Developer Pushes Code
        ↓
      GitHub
        ↓
      Jenkins
        ↓
 Build Docker Image
        ↓
   Run Tests
        ↓
 Deploy Container
        ↓
  Health Check
        ↓
      Success
```

---

## Technologies Used

* Jenkins
* Docker
* Python
* Flask
* Pytest
* GitHub

---

## Project Structure

```text
ElevateLabs-DevOps-Task2/
├── app.py
├── test_app.py
├── requirements.txt
├── Dockerfile
├── Jenkinsfile
└── README.md
```

---

## Pipeline Stages

### 1. Checkout

Jenkins pulls the latest source code from GitHub.

### 2. Build

A Docker image is created using the Dockerfile.

### 3. Test

Automated tests are executed using Pytest.

### 4. Deploy

The old container is stopped and a new container is deployed.

### 5. Health Check

The application health endpoint is verified to ensure successful deployment.

---

## Application Endpoints

### Home Endpoint

```http
GET /
```

Response:

```json
{
  "message": "Hello from Jenkins CI/CD Pipeline!",
  "status": "running",
  "version": "1.0.0"
}
```

### Health Check Endpoint

```http
GET /health
```

Response:

```json
{
  "status": "healthy"
}
```

---

## Running the Application Locally

### Install Dependencies

```bash
pip install -r requirements.txt
```

### Run Application

```bash
python app.py
```

### Run Tests

```bash
pytest test_app.py -v
```

---

## Docker Commands

### Build Docker Image

```bash
docker build -t flask-cicd-app .
```

### Run Docker Container

```bash
docker run -d -p 5000:5000 --name flask-app flask-cicd-app
```

### Verify Running Containers

```bash
docker ps
```

---

## Jenkins Setup

1. Install Jenkins
2. Install Git Plugin
3. Install Pipeline Plugin
4. Install Docker Pipeline Plugin
5. Create a Pipeline Job
6. Connect Jenkins with GitHub Repository
7. Configure Jenkinsfile
8. Run Pipeline

---

## Key DevOps Concepts Demonstrated

* Continuous Integration (CI)
* Continuous Deployment (CD)
* Pipeline as Code
* Docker Containerization
* Automated Testing
* Automated Deployment
* Health Monitoring
* Version Control with GitHub

---

## Interview Questions

### What is CI/CD?

CI/CD is a software development practice that automates code integration, testing, and deployment to improve delivery speed and reliability.

### What is Jenkins?

Jenkins is an open-source automation server used to build, test, and deploy applications automatically.

### What is Docker?

Docker is a containerization platform that packages applications and their dependencies into portable containers.

### What is a Jenkinsfile?

A Jenkinsfile is a text file that defines the CI/CD pipeline as code using Groovy syntax.

### Why use Docker in CI/CD?

Docker ensures that applications run consistently across development, testing, and production environments.

---

## Author

Ashish Vijaybhai Shakoriya

DevOps Internship Task 2
ElevateLabs Internship

---

**Project Status:** Successfully Implemented Jenkins CI/CD Pipeline with Docker Integration.
