pipeline {
    agent any
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
}

