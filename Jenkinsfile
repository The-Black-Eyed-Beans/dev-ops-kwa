pipeline {
	agent any

    tools {
        terraform "Terraform1.1.7"    
    }

    environment {
        REGION = "us-east-1"
        AWS_USER_ID = credentials("jenkins-aws-user-id")
    }
    //
    stages {
        stage("Init") {
            steps {
                echo "Initializing"
                sh "cd terraform && terraform init"
            }
        }

        stage("Plan") {
            steps {
                echo "Planning"
                sh "cd deploy"
                // sh "cd terraform/deploy"
                // sh "terraform init"
                sh "terraform plan -var-file=input.tfvars"
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