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
                  
              echo "BUILD DOCKER IMAGE AND TEST FOR SITE1"
         
   stage('docker build '){
      container('docker'){
       app = docker.build("us.gcr.io/sincere-hybrid-274219/wordpress1","${WORKSPACE}/wordpress1")
               //app = docker.build("us.gcr.io/sincere-hybrid-274219/wordpress1","/home/jenkins/agent/workspace/helmTest_master/wordpress1")
       //sh 'docker build . -t us.gcr.io/sincere-hybrid-274219/wordpress1 -f ${PWD}/wordpress1/Dockerfile'
      }
   }
   stage('push image to GCR'){
      container('docker'){
         docker.withRegistry('https://us.gcr.io', 'gcr:ClusterGPR') {
              app.push("${env.BUILD_NUMBER}")
              app.push("latest")    
               }
            }
          }
            stage('test kubectl'){
       container('kubectl'){
          sh 'kubectl version'
          sh 'kubectl get pod'
          sh 'helm list'
          
         }
     }
            
         }
}
