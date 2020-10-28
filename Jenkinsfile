pipeline
{
agent any
stages
{
stage('Checkout SCM')
{
steps
{
git credentialsId: 'github-creds', url: 'https://github.com/shivarammorla/spring-boot-mockito.git'
}
}

stage('SonarQube analysis') {
            steps {
                withSonarQubeEnv('sonarqube') {
                    sh 'mvn sonar:sonar'
                }
            }
 }

stage('build code from maven')
{
steps
{
 sh 'mvn install'
}
}
 
stage('push artifacts to nexus')
{
steps{
  //nexusArtifactUploader artifacts: [[artifactId: 'spring-boot-mockito', classifier: '', file: 'target/spring-boot-mockito-0.0.1', type: 'war']], credentialsId: 'nexus', groupId: 'com.example', nexusUrl: '13.232.247.9', nexusVersion: 'nexus3', protocol: 'http', repository: 'hcltraining', version: '0.0.1'

nexusArtifactUploader artifacts: [[artifactId: 'spring-boot-mockito', classifier: '', file: 'target/spring-boot-mockito-0.0.1.war', type: 'war']], credentialsId: 'new-nexus', groupId: 'com.example', nexusUrl: '52.66.246.168:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'hcltraining', version: '0.0.1'    
 //test
}
}
 stage('deploy war to tomcat from nexus') {
 
           steps {
                
               sh "wget http://52.66.246.168:8081/repository/hcltraining/com/example/spring-boot-mockito/0.0.1/spring-boot-mockito-0.0.1.war"
              sshagent(['Tomcat-credentials']) {
                
              //sh "ssh -o StrictHostKeyChecking=no /var/lib/jenkins/workspace/proj3-pipeline/spring-boot-mockito-0.0.1.war ubuntu@13.233.158.240:/var/lib/tomcat9/webapps" 
               sh "scp -o StrictHostKeyChecking=no /var/lib/jenkins/workspace/proj3-pipeline/target/spring-boot-mockito-0.0.1.war ubuntu@13.235.67.190:/var/lib/tomcat9/webapps"
              }
           }
        } 
      stage('Build Docker Image') {
            steps {
                sh 'docker build -t 52.66.246.168:8083/my-app:2.0.0 .'
            }
        }
       stage('Docker push to nexus') {
            steps {
                
                {
	    withCredentials([string(credentialsId: 'nexusrepopw', variable: 'nexusrepopw')])
                   sh 'docker login -u admin -p admin123 52.66.246.168:8083'
                }
                
                sh 'docker push 52.66.246.168:8083/my-app:2.0.0'
            }
        }     
      
            
}
}
