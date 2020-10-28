FROM tomcat:9
# Take the war and copy to webapps of tomcat
COPY target/spring-boot-mockito-0.0.1.war /usr/local/tomcat/webapps
CMD ["catalina.sh","run"]
