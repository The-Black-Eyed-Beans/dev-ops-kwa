pipeline {
	agent any

    tools {
        terraform "Terraform1.1.7"    
    }

    environment {
        REGION = credentials("region-kwa")
        AWS_ACCESS_KEY = credentials("aws_access_key")
        AWS_SECRET_KEY = credentials("aws_secret_key")
    }

    stages {
        stage("Plan") {
            steps {
                echo "Planning"
                dir ("terraform/deploy") {
                    withCredentials([file(credentialsId: 'aws_key_file', variable: 'TFVARS')]) {
                        sh "terraform init"
                        sh "cp $TFVARS terraform.tfvars"
                        sh "terraform plan -out=output"
                    }
                }
            }
        }

        stage("Apply") {
            steps {
                echo "Applying"
                sh "cd terraform/deploy && terraform apply output"
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

    post {
        cleanup {
            sh "rm terraform/deploy/terraform.tfvars"
        }
    }

}