pipeline {
    agent {
        docker {
            image 'hashicorp/terraform:1.7.3' // Use a Docker image with Terraform pre-installed
            args '-u root:root' // Run as root to avoid permission issues
        }
    }
    environment {
        GH_TOKEN = credentials('github-credentials')
    }
    stages {
        stage('Initialize Terraform') {
            when {
                not {
                    branch 'main'
                }
            }
            steps {
                sh 'terraform init'
            }
        }
        stage('Terraform Format') {
            when {
                not {
                    branch 'main'
                }
            }
            steps {
                sh 'terraform fmt -check'
            }
        }
        stage('Validate Terraform') {
            when {
                not {
                    branch 'main'
                }
            }
            steps {
                sh 'terraform validate .'
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
