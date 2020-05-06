node{
   def tomcatIp = '192.168.208.140'
   def tomcatUser = 'tomcat'
   def stopTomcat = "ssh ${tomcatUser}@${tomcatIp} /opt/webview/deva-web/webapptomcat/apache-tomcat-9.0.33/bin/shutdown.sh"
   def startTomcat = "ssh ${tomcatUser}@${tomcatIp} /opt/webview/deva-web/webapptomcat/apache-tomcat-9.0.33/bin/startup.sh"
   def copyWar = "scp -o StrictHostKeyChecking=no target/myweb.war ${tomcatUser}@${tomcatIp}:/opt/webview/deva-web/webapptomcat/apache-tomcat-9.0.33/webapps/"
   
   def copyApache = "scp -o StrictHostKeyChecking=no apache-tomcat-9.0.33.tar.gz ${tomcatUser}@${tomcatIp}:/opt/webview/deva-web/webapptomcat/"
   
    def extractTomcat = "ssh ${tomcatUser}@${tomcatIp} tar -xvf /opt/webview/deva-web/webapptomcat/apache-tomcat-9.0.33.tar.gz -C /opt/webview/deva-web/webapptomcat/"
   stage('SCM Checkout'){
        git branch: 'master', 
	        credentialsId: 'yusuf042014',
	        url: 'https://github.com/yusuf042014/myweb'
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
