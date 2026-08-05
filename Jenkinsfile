node{
   def tomcatIp = '192.168.208.217'
   def tomcatUser = 'devops'
   def stopTomcat = "ssh ${tomcatUser}@${tomcatIp} /opt/fas/apache-tomcat-9.0.33/bin/shutdown.sh"
   def startTomcat = "ssh ${tomcatUser}@${tomcatIp} /opt/fas/apache-tomcat-9.0.33/bin/startup.sh"
   def copyWar = "scp -o StrictHostKeyChecking=no target/myweb.war ${tomcatUser}@${tomcatIp}:/opt/fas/apache-tomcat-9.0.33/webapps/"
   
   def copyApache = "scp -o StrictHostKeyChecking=no apache-tomcat-9.0.33.tar.gz ${tomcatUser}@${tomcatIp}:/opt/fas/"
   
    def extractTomcat = "ssh ${tomcatUser}@${tomcatIp} tar -xvf /opt/fas/apache-tomcat-9.0.33.tar.gz -C /opt/fas/"
   stage('SCM Checkout'){
        git branch: 'master', 
	        credentialsId: 'ahmedbule2004',
	        url: 'https://github.com/ahmedbule2004/myweb'
   }
   stage('Maven Build'){
        def mvnHome = tool name: 'maven3', type: 'maven'
		sh "${mvnHome}/bin/mvn clean package"
   }
   stage('Email Notification'){
      mail bcc: '', body: '''Hi Welcome to jenkins email alerts
      Thanks
      Hari''', cc: '', from: '', replyTo: '', subject: 'Jenkins Job', to: 'ahmedbule@gmail.com'
  } 
  
  
    stage('Install Tomcat'){
        
	// Add step to create Folder
	

       sshagent(['tomcat-dev']) {
	 		
		sh "${copyApache}"
		sh "${extractTomcat}"
	   } 
   } 
  
    
  stage('Deploy Dev'){
	   sh 'mv target/myweb*.war target/myweb.war' 
       	   
       sshagent(['tomcat-dev']) {
	 		sh "${stopTomcat}"
		 	sh "${copyWar}"
			sh "${startTomcat}"
	   } 
   } 
}
