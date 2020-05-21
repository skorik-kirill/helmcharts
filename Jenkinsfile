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
   stage('docker build and push '){
      steps{
         
         
      container('docker'){
         script{
             def app
       app = docker.build("us.gcr.io/sincere-hybrid-274219/wordpress1","${WORKSPACE}/wordpress1")
         docker.withRegistry('https://us.gcr.io', 'gcr:ClusterGPR') {
              app.push("${env.BUILD_NUMBER}")
              app.push("latest")    
               }
          }
      }
   }
  }
            stage('deploy helm chart') {
               steps{
                  container('kubectl'){
                     script{
                       sh 'helm install --name wordpress1 ${PWD}/wordpress1'
                        sleep 15 
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
