environment {
DOCKER_USERNAME = "sebastainp@yahoo.com"
DOCKER_PASSWORD = "Sibi72Sep#"
IMAGE_NAME = "screwfastspapp"
IMAGE_TAG = "v1"
REGISTRY_CREDENTIAL = 'docker-hub-credentials'
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
  }
    stage('Build and Push Image') {
      steps {
        script {
          withCredentials([usernamePassword(credentialsId: REGISTRY_CREDENTIAL, usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
            sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'
            sh 'docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .'
            sh 'docker push ${IMAGE_NAME}:${IMAGE_TAG}'
          }
        }
      }
    }
    
