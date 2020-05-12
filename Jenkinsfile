node('pod') {
   
    checkout scm
   
      def app 
   
    stage(' test docker   ') {
       container('docker') {
      sh 'docker ps '
       }
       }
   stage('docker build '){
      continer('docker'){
       app = docker.build("us.gcr.io/sincere-hybrid-274219/wordpress1")
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
          sh 'helm install --name mysql ${PWD}/mysql'
          sh 'helm install --name wordpress2 ${PWD}/wordpress2'
          sleep 60
         }
       }
       
       stage('delete test deployment'){
          container('kubectl'){
            sh 'helm delete mysql wordpress2 --purge'
          }
       }
   }

