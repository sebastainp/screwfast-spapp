environment {
DOCKER_USERNAME = "sebastainp@yahoo.com"
DOCKER_PASSWORD = "Sibi72Sep#"
IMAGE_NAME = "screwfastspapp"
IMAGE_TAG = "v1"
REGISTRY_CREDENTIAL = 'docker-hub-credentials'
}

stage('Build and Push Image') {
      steps {
        script {
echo 'now in jenkinsfile' 
          withCredentials([usernamePassword(credentialsId: REGISTRY_CREDENTIAL, usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
            sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'
            sh 'docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .'
            sh 'docker push spatoshub/docker-poc:${IMAGE_TAG}'
          }
        }
      }
    }
