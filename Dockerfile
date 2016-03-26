# Dockerfile
# GitHub and do a maven build it
FROM emooti/tutorbase
MAINTAINER Uta Kapp "utakapp@gmail.com"
RUN apt-get -y update

ENV REFRESHED_AT 2016-02-29
ENV MAVEN_OPTS="-Xms512m -Xmx2048m -XX:MaxPermSize=512m"
ENV GIT_DISCOVERY_ACROSS_FILESYSTEM 1
RUN sed -i -- 's/<Servers>/<Servers> <server><id>TomcatServer<\/id><username>admin<\/username> <password>pwd<\/password><\/server>/g' /usr/share/maven/conf/settings.xml
RUN mkdir emootitutor
RUN cd emootitutor && pwd && git init && ls
RUN cd emootitutor && git remote
#pull from GitHub
# build Emootibantransformer

RUN cd emootitutor && git remote add emootitutor https://github.com/emooti/EmootiTutor.git
RUN cd emootitutor && git pull emootitutor HEAD
RUN cd emootitutor/Tutorial1/HelloEmooti && mvn clean compile install
RUN cd emootitutor/Tutorial1/Sprint1 && mvn clean package
#RUN mkdir /var/lib/tomcat7/webapps/
VOLUME ["/emootitutor/Tutorial1/Sprint1/target"]
# RUN ls -l /emootitutor/Tutorial1/Sprint1/target

# COPY  Tutorial1/Sprint1/target/EmootiBan-1.0-Sprint1.war .
# cd /emootitutor/Tutorial1/Sprint1 && ls
# RUN cd /emootitutor/Tutorial1 && chmod +x ci.sh
# VOLUME ["/var/lib/tomcat7/webapps/"]
# RUN cp /emootitutor/Tutorial1/Sprint1/target/*.war /var/lib/tomcat7/webapps
# RUN ls /var/lib/tomcat7/webapps
# build war when executing container
# ENTRYPOINT ["/bin/bash" "/emootitutor/Tutorial1/ci.sh"]
# CMD []
