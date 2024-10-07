pipeline {
    agent any
    environment {
        AWS_ACCOUNT_ID = '992382640915'
        AWS_REGION = 'ap-south-1'
        ECR_REPO_NAME = 'node-api-repo'
        IMAGE_TAG = "${env.BUILD_ID}"
    }

    stages {
        stage('Git checkout') {
            steps {
              git branch: 'main', credentialsId: 'github', url: 'https://github.com/RAM28EC/nodejsapi-assignment.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO_NAME}:${IMAGE_TAG}")
                }
            }
        }
        stage('Login to AWS ECR') {
            steps {
                script {
                    sh 'aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com || exit 1'
                }
            }
        }
        stage('Push Docker Image to ECR') {
            steps {
                script {
                    dockerImage.push()
                }
            }
        }
        stage('Clean up Docker images') {
            steps {
                script {
                    sh "docker rmi ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO_NAME}:${IMAGE_TAG} || true"
                }
            }
        }
    }
}
