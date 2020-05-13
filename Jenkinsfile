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
          sleep 30
         }
       }
   stage('test site'){
     //sh 'curl http://add194f6.ngrok.io' 
      sh 'response=$(curl -s -o /dev/null -w "%{http_code}\n" http://www.example.org/)' 
      sh 'echo $response'
   }
   
       stage('delete test deployment'){
          container('kubectl'){
            sh 'helm delete  wordpress1 --purge'
          }
       }
   }

