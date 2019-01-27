FROM node:latest
MAINTAINER The CentOS Project <cloud-ops@centos.org>

# Perform updates
RUN yum -y update; yum clean all

#RUN yum install openjdk-8-jre -y
RUN yum install java-1.8.0-openjdk -y

#RUN ech "JAVA_HOME=/usr/bin/java">> .bashrc
#RUN ech "JAVA_HOME=/usr/">> ~/.bashrc

#ENV JAVA_HOME /usr/lib/jvm/java/bin

ADD https://archive.apache.org/dist/tomcat/tomcat-8/v8.0.29/bin/apache-tomcat-8.0.29.tar.gz /tmp
RUN cd /tmp && tar -xvzf apache-tomcat-8.0.29.tar.gz
RUN cd /tmp && mv apache-tomcat-8.0.29 /opt/
EXPOSE 8080
ADD http://mirrors.jenkins.io/war-stable/latest/jenkins.war /opt/apache-tomcat-8.0.29/webapps/
ADD GlaxyConnect/openmrs.war /opt/apache-tomcat-8.0.29/webapps/
ADD GlaxyConnect/main.jsp /opt/apache-tomcat-8.0.29/webapps/ROOT
RUN chmod 755 /opt/apache-tomcat-8.0.29/webapps
CMD ["/opt/apache-tomcat-8.0.29/bin/catalina.sh", "run"]
