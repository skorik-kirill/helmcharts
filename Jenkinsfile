def notifySuccessful() {
         emailext (
      to: 'skorikkirill7@gmail.com',
      subject: "Success test: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
      body: """Test: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':
        Check console output ;'${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]""",
    )
      }
node('pod') {
   
    checkout scm: [$class: 'GitSCM', branches: [[name: '*/master']], userRemoteConfigs: [[url: 'https://github.com/skorik-kirill/helmcharts.git']]]
   
      def app 
      
   
    stage(' test docker   ') {
       container('docker') {
      sh 'docker ps '
       }
       }
   stage('docker build '){
      container('docker'){
       app = docker.build("us.gcr.io/sincere-hybrid-274219/wordpress1")
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
     
    def response= sh(script: 'curl -s -o /dev/null -w "%{http_code}\n" http://de113727.ngrok.io', returnStdout: true)
     //sh  ' echo $response' 
           println("Response: " +response)
            if(response != 200){
                  println("Test passed continue to deploy")
                  println("sent e-mail success test")
            }
            else{ 
                     container('kubectl'){
                      sh 'helm delete  wordpress1 --purge'
                        }
                  println("sent e-mail false test")
                  println("Fix your image")
                  sh 'exit 1'
                     
            }
   }
  // notifySuccessful()
   
       stage('delete test deployment'){
          container('kubectl'){
            sh 'helm delete  wordpress1 --purge'
          }
       }
}

