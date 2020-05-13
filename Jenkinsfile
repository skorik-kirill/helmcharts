node('pod') {
   
    checkout scm
   
      def app 
      
   stage('ansible test'){
      ansiblePlaybook()
   }
   
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
          sleep 60
         }
       }
   //stage('test site'){
     // sh 'curl http://vh01.kirill.k8s.local/' 
   //}
       stage('delete test deployment'){
          container('kubectl'){
            sh 'helm delete  wordpress1 --purge'
          }
       }
   }

