pipeline {
	agent any

    tools {
        terraform "Terraform1.1.7"    
    }

    environment {
        REGION = credentials("region-kwa")
        // AWS_USER_ID = credentials("jenkins-aws-user-id")
        BUCKET = "kwa-terraform-s3"
        KEY = "terraform-infrastructure"
        AWS_ACCESS_KEY = credentials("aws_access_key")
        AWS_SECRET_KEY = credentials("aws_secret_key")
    }
    //
    stages {
        stage("Init") {
            steps {
                echo "Initializing"
                withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'aws-key', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                    sh "cd terraform && terraform init"
                }
            }
        }

        stage("Plan") {
            steps {
                echo "Planning"
                dir ("terraform/deploy") {
                    // sh "cd terraform/deploy"
                    // sh "terraform init"
                    withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'aws-key', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                        sh "terraform init && terraform plan -out=output"
                    }
                }
            }
        }

        stage("Apply") {
            steps {
                echo "Applying"
                sh "cd terraform/deploy"
                sh "terraform apply -auto-approve 'output' > 'output_${BUILD_ID}.txt'"
            }
        }

        stage("Destroy") {
            steps {
                echo "Destroying"
                sh "cd terraform/deploy"
                sh "terraform destroy"
            }
        }
    }

}