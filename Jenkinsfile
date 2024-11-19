pipeline {
  environment {
    SERVICE_NAME = "screwfast-webapp"
    IMAGE_TAG = "131" // Manually setting the version/tag for testing
    IMAGE_NAME = "vishal8266/screwfast-webapp" // Docker Hub repository name
    EC2_IP = "ec2-3-106-56-12.ap-southeast-2.compute.amazonaws.com"
    SSH_KEY = credentials('spubuntu2') // Using SSH key stored in Jenkins credentials
   // EC2_IP = "3.106.244.42" // Replace with actual EC2 IP
   // SSH_KEY = credentials('EC2SSH') // Using SSH key stored in Jenkins credentials
    // SSH_KEY_PATH = "/home/ec2-user"
  }
  
  agent any
  
  stages {
    stage('Cloning Git') {
      steps {
        git([
          url: 'https://github.com/sebastainp/screwfast-spapp.git',
          branch: 'main',
          credentialsId: 'GitHub'
        ])
      }
    }
    
    //stage('Prepare Deployment') {
     // steps {
      //  script {
          // Update the deploy.yaml file or any configuration if required
        //  sh '''
          //  sed -i 's,IMAGE_NAME_PLACEHOLDER,${IMAGE_NAME},' deploy.yaml
          // sed -i 's,IMAGE_TAG_PLACEHOLDER,${IMAGE_TAG},' deploy.yaml
         // '''
       // }
     // }
   // }
 
    stage('Build and Deploy App on EC2') {
      steps {
        script {
          withCredentials([file(credentialsId: 'spubuntu2', variable: 'SSH_KEY_PATH')]) {
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
