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
          sh 'helm install --name wordpress1 ${PWD}/wordpress1'
       }
    }
}
