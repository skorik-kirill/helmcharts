node('pod') {
   
    checkout scm
   
      
   
    stage(' docker ps  ') {
       container('docker') {
      sh 'docker ps '
        
       }
       stage('kubecctl'){
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
       stage('test deploy '){
          sh 'curl http://vh02.kirill.k8s.local/'
    }
       stage('delete test deployment'){
          container('kubectl'){
            sh 'helm delete mysql wordpress2 --purge'
          }
       }
   }
}
