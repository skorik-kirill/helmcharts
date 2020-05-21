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
      stage('test site'){
       steps{
          script{
             def response= sh(script: 'curl -s -o /dev/null -w "%{http_code}\n"  http://34.71.232.200/wordpress1/', returnStdout: true)
     //sh  ' echo $response' 
           println("Response: " +response)
             def intResponse = response as int
            if( intResponse == 200 ){
                  println("Test passed continue to deploy")
                  println("sent e-mail success test")
                    // notifySuccessful()
                     container('kubectl'){
                     sh 'helm delete  wordpress1 --purge'
                     }
            }
            else{ 
                     container('kubectl'){
                      sh 'helm delete  wordpress1 --purge'
                        }
                   //  notifyFailed()
                  println("sent e-mail false test")
                  println("Fix your image")
                  sh 'exit 1'        
                         }
                    }
                }
             }
            stage('docker build and push site 2'){
      steps{  
      container('docker'){
         script{
             def app
       app = docker.build("us.gcr.io/sincere-hybrid-274219/wordpress2","${WORKSPACE}/wordpress2")
         docker.withRegistry('https://us.gcr.io', 'gcr:ClusterGPR') {
              app.push("${env.BUILD_NUMBER}")
              app.push("latest")    
                   }
                }
             }
         }
      }
            stage('deploy helm chart for site 2') {
               steps{
                  container('kubectl'){
                     script{
                       sh 'helm install --name wordpress2 ${PWD}/wordpress2'
                        sleep 15 
                     }
                  }
               }
             }
      stage('test site 2'){
       steps{
          script{
             def response= sh(script: 'curl -s -o /dev/null -w "%{http_code}\n"  http://34.71.232.200/wordpress2/', returnStdout: true)
     //sh  ' echo $response' 
           println("Response: " +response)
             def intResponse = response as int
            if( intResponse == 200 ){
                  println("Test passed continue to deploy")
                  println("sent e-mail success test")
                    // notifySuccessful()
                     container('kubectl'){
                     sh 'helm delete  wordpress2 --purge'
                     }
            }
            else{ 
                     container('kubectl'){
                      sh 'helm delete  wordpress2 --purge'
                        }
                   //  notifyFailed()
                  println("sent e-mail false test")
                  println("Fix your image")
                  sh 'exit 1'        
                         }
                    }
                }
             }
          }
        }
