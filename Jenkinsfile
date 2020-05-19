#!/usr/bin/env groovy
def notifySuccessful() {
         emailext (
      to: 'skorikkirill7@gmail.com',
      subject: "Success test: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
      body: """Test: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]': Success!!!
        Check console output ;'${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]""",
    )
      }

def notifySuccessfulDeploy() {
         emailext (
      to: 'skorikkirill7@gmail.com',
      subject: "Success deploy: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
      body: """Deploy: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]': Success !!!
        Check console output ;'${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]""",
    )
      }
def notifySuccessfulBuild1() {
         emailext (
      to: 'skorikkirill7@gmail.com',
      subject: "Success deploy: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
      body: """Build: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]': Success build image for wordpress1 !!!
        Check console output ;'${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]""",
    )
      }
def notifySuccessfulBuild2() {
         emailext (
      to: 'skorikkirill7@gmail.com',
      subject: "Success deploy: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
      body: """Build: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]': Success build image for wordpress2 !!!
        Check console output ;'${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]""",
    )
      }
         

def notifySuccessfulForSecond() {
         emailext (
      to: 'skorikkirill7@gmail.com',
      subject: "Success test: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
      body: """Test: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]': Success site2!!!
        Check console output ;'${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]""",
    )
      }
def notifyFailed() {
         emailext (
      to: 'skorikkirill7@gmail.com',
      subject: "Failed test: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
      body: """Test: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]': Failed!!!
        Check console output ;'${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]""",
                )
                  }  
def notifyFailedForSecond() {
         emailext (
      to: 'skorikkirill7@gmail.com',
      subject: "Failed test: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
      body: """Test: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]': Failed site2!!!
        Check console output ;'${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]""",
                )
                  }  
 def notifyStarted() {
         emailext (
      to: 'skorikkirill7@gmail.com',
      subject: "Started build: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
      body: """Build: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]': Started!!!
        Check console output ;'${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]""",
    )
      }
node('pod') {
   notifyStarted()
    checkout scm: [$class: 'GitSCM', branches: [[name: '*/master']], userRemoteConfigs: [[url: 'https://github.com/skorik-kirill/helmcharts.git']]]
      def app 
      
        
                  
    stage(' test docker   ') {
       container('docker') {
      sh 'docker ps '
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
         notifySuccessfulBuild1() 
       stage('test kubectl'){
       container('kubectl'){
          sh 'kubectl version'
          sh 'kubectl get pod'
          sh 'helm list'
          
         }
     }
       stage('list derectory'){
       sh 'ls -l' 
       
       }
       stage('deploy helm chart'){
          container('kubectl'){
          //sh 'helm install --name mysql ${PWD}/mysql'
          sh 'helm install --name wordpress1 ${PWD}/wordpress1'
          sleep 15
         }
       }
   stage('test site'){
     //sh 'curl http://add194f6.ngrok.io' 
     
    def response= sh(script: 'curl -s -o /dev/null -w "%{http_code}\n"  http://34.71.232.200/wordpress1/', returnStdout: true)
     //sh  ' echo $response' 
           println("Response: " +response)
            def intResponse = response as int
            if( intResponse == 200 ){
                  println("Test passed continue to deploy")
                  println("sent e-mail success test")
                     notifySuccessful()
                     container('kubectl'){
                     sh 'helm delete  wordpress1 --purge'
                     }
            }
            else{ 
                     container('kubectl'){
                      sh 'helm delete  wordpress1 --purge'
                        }
                     notifyFailed()
                  println("sent e-mail false test")
                  println("Fix your image")
                  sh 'exit 1'
                     
            }
   }
  // notifySuccessful()
                          echo "BUILD DOCKER IMAGE AND TEST FOR SITE2"
      
         stage('docker build '){
      container('docker'){
       app = docker.build("us.gcr.io/sincere-hybrid-274219/wordpress2","${WORKSPACE}/wordpress2")
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
         notifySuccessfulBuild2() 
         stage('deploy helm chart'){
          container('kubectl'){
          //sh 'helm install --name mysql ${PWD}/mysql'
          sh 'helm install --name wordpress2 ${PWD}/wordpress2'
          sleep 15
         }
       }
   stage('test site'){
     //sh 'curl http://add194f6.ngrok.io' 
     
    def response2= sh(script: 'curl -s -o /dev/null -w "%{http_code}\n" http://34.71.232.200/wordpress2/', returnStdout: true)
     //sh  ' echo $response' 
           println("Response: " +response2)
            def intResponse2 = response2 as int
            if( intResponse2 == 200 ){
                  println("Test passed continue to deploy")
                  println("sent e-mail success test")
                     notifySuccessfulForSecond()
                     container('kubectl'){
                     sh 'helm delete  wordpress2 --purge'
                     }
            }
            else{ 
                     container('kubectl'){
                      sh 'helm delete  wordpress2 --purge'
                        }
                     notifyFailedForSecond()
                  println("sent e-mail false test")
                  println("Fix your image")
                  sh 'exit 1'
         
            }
         
   }
         
       //  stage('delete test deployment'){
         // container('kubectl'){
            //sh 'helm delete  wordpress1 --purge'
            // sh 'helm delete  wordpress2 --purge'
        //  }
    //   }
         
        
    
         
       // stage('deploy web-app with ansible'){
             //    container('ansible'){
               
            ///              sh 'su - skorikkirill7'
               //           sh 'whoami'
            //     sh 'ansible-playbook -i inventory.yml ${PWD}/wordpress1.yml'
               // sh 'ansible-playbook ansibletest.yml'
                          // ansiblePlaybook( 
           // playbook: '${WORKSPACE}/wordpress1.yml',
           //inventory: 'path/to/inventory.ini', 
              //  )
             //   }
         notifySuccessfulDeploy()
                  echo "THE END"        
             //  }
}
