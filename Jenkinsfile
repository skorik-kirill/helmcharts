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
      post{
      success{
            emailext body: "Build wordpress1: Job ${env.JOB_NAME} ${env.BUILD_NUMBER}: Build Success!!!", subject: 'Build result', to: 'skorikkirill7@gmail.com'  
      }
         failure {
              emailext body: "Build wordpress1: Job ${env.JOB_NAME} ${env.BUILD_NUMBER}: Build Fail!!!", subject: 'Test result', to: 'skorikkirill7@gmail.com'  
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
             
            post{
      success{
            emailext body: "Test wordpress1: Job ${env.JOB_NAME} ${env.BUILD_NUMBER}: Test Success!!!", subject: 'Test result', to: 'skorikkirill7@gmail.com'  
      }
               failure {
              emailext body: "Test wordpress1: Job ${env.JOB_NAME} ${env.BUILD_NUMBER}: Test Fail!!!", subject: 'Test result', to: 'skorikkirill7@gmail.com'  
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
               post{
      success{
            emailext body: "Build wordpress2: Job ${env.JOB_NAME} ${env.BUILD_NUMBER}: Build Success!!!", subject: 'Build result', to: 'skorikkirill7@gmail.com'  
      }
                    failure {
              emailext body: "Build wordpress2: Job ${env.JOB_NAME} ${env.BUILD_NUMBER}: Build Fail!!!", subject: 'Test result', to: 'skorikkirill7@gmail.com'  
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
             
         
            post{
      success{
            emailext body: "Test wordpress2: Job ${env.JOB_NAME} ${env.BUILD_NUMBER}: Test Success!!!", subject: 'Test result', to: 'skorikkirill7@gmail.com'  
      }
               failure {
              emailext body: "Test wordpress2: Job ${env.JOB_NAME} ${env.BUILD_NUMBER}: Test Fail!!!", subject: 'Test result', to: 'skorikkirill7@gmail.com'  
               }
      }
    }  
         
   
      stage('deploy with ansible'){
         agent {label 'master'}
         steps{
            script{
                sh 'su - skorikkirill7'
             sh ' su skorikkirill7 -c "ansible-playbook -i ansible/inventory.yml ${PWD}/ansible/wordpress1and2.yml"'    
            }
         }
      }
   post{
      success{
            emailext body: "Deploy: Job ${env.JOB_NAME} ${env.BUILD_NUMBER}: Success!!!", subject: 'Deploy result', to: 'skorikkirill7@gmail.com'  
      }
      failure {
         emailext body: "Deploy: Job ${env.JOB_NAME} ${env.BUILD_NUMBER}: Fail!!!", subject: 'Deploy result', to: 'skorikkirill7@gmail.com'  
      }
      }
        }
