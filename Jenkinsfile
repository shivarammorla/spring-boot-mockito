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

nexusArtifactUploader artifacts: [[artifactId: 'spring-boot-mockito', classifier: '', file: 'target/spring-boot-mockito-0.0.1.war', type: 'war']], credentialsId: 'new-nexus', groupId: 'com.example', nexusUrl: '13.232.247.9:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'hcltraining', version: '0.0.1'    
 //test
}
}
 stage('deploy war to tomcat from nexus') {
 
            steps {
                
               sh "wget http://13.232.247.9:8081/repository/hcltraining/com/example/spring-boot-mockito/0.0.1/spring-boot-mockito-0.0.1.war"
              sshagent(['Tomcat-credentials1']) {
                 
             // sh "ssh -o StrictHostKeyChecking=no /var/lib/jenkins/workspace/proj3-pipeline/spring-boot-mockito-0.0.1.war ubuntu@13.233.158.240:/var/lib/tomcat9/webapps" 
               sh "ssh -o StrictHostKeyChecking=no /var/lib/jenkins/workspace/proj3-pipeline/target/spring-boot-mockito-0.0.1.war ubuntu@13.233.158.240:/var/lib/tomcat9/webapps"
              }
            }
        }
}
}
