pipeline {
   agent {label 'pod'}
         stages{
                  stage('Test docker'){
                           steps{
                              container('docker'){
                                    sh 'docker ps'
                           }
                        }
                  }
                  
             
         
   stage('docker build '){
      steps{
         def app
          echo "BUILD DOCKER IMAGE AND TEST FOR SITE1
      container('docker'){
         
       app = docker.build("us.gcr.io/sincere-hybrid-274219/wordpress1","${WORKSPACE}/wordpress1")
         docker.withRegistry('https://us.gcr.io', 'gcr:ClusterGPR') {
              app.push("${env.BUILD_NUMBER}")
              app.push("latest")    
               }
          }
      }
   }
            stage('test kubectl'){
               steps{
       container('kubectl'){
          sh 'kubectl version'
          sh 'kubectl get pod'
          sh 'helm list'
                  }
               }
            }
            
         }
}
