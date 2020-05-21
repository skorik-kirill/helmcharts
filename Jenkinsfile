pipeline {
   agent {label 'pod'}
         stages{
                  stage('Test docker'){
                     container('docker'){
                           steps{
                                    sh 'docker ps'
                           }
                        }
                  }
                  
              
         }
}
