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
    }
    //
    stages {
        stage("Init") {
            steps {
                echo "Initializing"
                sh 'cd terraform && terraform init -backend-config="bucket=${BUCKET}" -backend-config="key=${KEY}.t2state" -backend-config="region=${REGION}"'
            }
        }

        stage("Plan") {
            steps {
                echo "Planning"
                dir ("terraform/deploy") {
                    // sh "cd terraform/deploy"
                    // sh "terraform init"
                    sh "terraform plan -var-file=input.tfvars"
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