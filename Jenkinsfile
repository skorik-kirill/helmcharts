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
                  
              
         }
}
