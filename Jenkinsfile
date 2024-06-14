pipeline {
    agent {
        docker {
            image 'hashicorp/terraform:1.7.3' // Use a Docker image with Terraform pre-installed
            args '--entrypoint="" -u root:root' // Override the ENTRYPOINT and run as root to avoid permission issues
        }
    }
    environment {
        GH_TOKEN = credentials('github-credentials')
    }
    stages {
        stage('Checkout Repository') {
            steps {
                cleanWs()
                checkout scm
            }
        }
        stage('Initialize Terraform') {
            steps {
                sh 'terraform init'
            }
        }
        stage('Terraform Format') {
            steps {
                sh 'terraform fmt -check'
            }
        }
        stage('Validate Terraform') {
            steps {
                sh 'terraform validate'
            }
        }
    }
    post {
        always {
            echo 'Pipeline complete'
        }
        success {
            echo 'Pipeline succeeded'
        }
        failure {
            echo 'Pipeline failed'
        }
    }
}
