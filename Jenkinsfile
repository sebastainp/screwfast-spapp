pipeline {
  environment {
    SERVICE_NAME = "screwfast-webapp"
    IMAGE_TAG = "131" // Manually setting the version/tag for testing
    IMAGE_NAME = "vishal8266/screwfast-webapp" // Docker Hub repository name
    EC2_IP = "ec2-13-51-204-119.eu-north-1.compute.amazonaws.com" // Replace with actual EC2 IP
    SSH_KEY = credentials('EC2_SSH_KEY') // Using SSH key stored in Jenkins credentials
  }
  
  agent any
  
  stages {
    stage('Cloning Git') {
      steps {
        git([
          url: 'https://github.com/webapp-react/screwfast-webapp.git',
          branch: 'master',
          credentialsId: 'GitHub'
        ])
      }
    }
    
    stage('Prepare Deployment') {
      steps {
        script {
          // Update the deploy.yaml file or any configuration if required
          sh '''
            sed -i 's,IMAGE_NAME_PLACEHOLDER,${IMAGE_NAME},' deploy.yaml
            sed -i 's,IMAGE_TAG_PLACEHOLDER,${IMAGE_TAG},' deploy.yaml
          '''
        }
      }
    }
 
    stage('Build and Deploy App on EC2') {
      steps {
        script {
          withCredentials([file(credentialsId: 'EC2_SSH_KEY', variable: 'SSH_KEY_PATH')]) {
            sh '''
              # Ensure proper permissions on the .pem file
              chmod 400 $SSH_KEY_PATH
 
              # SSH into EC2 instance and deploy Docker container
              ssh -o StrictHostKeyChecking=no -i $SSH_KEY_PATH ubuntu@${EC2_IP} <<EOF
                # Pull the latest Docker image
                docker pull ${IMAGE_NAME}:${IMAGE_TAG}
 
                # Stop and remove the existing container if any
                docker stop ${SERVICE_NAME} || true
                docker rm ${SERVICE_NAME} || true
 
                # Run the Docker container
                docker run -d --name ${SERVICE_NAME} -p 80:3000 ${IMAGE_NAME}:${IMAGE_TAG}
EOF
            '''
          }
        }
      }
    }
  }
 
  post {
    always {
      cleanWs() // Cleanup workspace to ensure no sensitive files remain
    }
  }
}
