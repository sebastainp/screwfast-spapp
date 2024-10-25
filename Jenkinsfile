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
    
