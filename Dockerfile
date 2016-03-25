# Dockerfile
# GitHub and do a maven build it

FROM emooti/tutorbase
MAINTAINER Uta Kapp "utakapp@gmail.com"

ENV REFRESHED_AT 2016-02-29
ENV MAVEN_OPTS="-Xms512m -Xmx2048m -XX:MaxPermSize=512m"
ENV GIT_DISCOVERY_ACROSS_FILESYSTEM 1
RUN sed -i -- 's/<Servers>/<Servers> <server><id>TomcatServer<\/id><username>admin<\/username> <password>pwd<\/password><\/server>/g' /usr/share/maven/conf/settings.xml
RUN mkdir emootitutor/Tutorial1
RUN cd emootitutor/Tutorial1 && pwd && git init && ls
RUN cd emootitutor/Tutorial1 && git remote

# pull from GitHub

RUN cd emootitutor/Tutorial1 && git remote add emootitutor/Tutorial1 https://github.com/emootitutorial1/SourceCode.git
RUN cd emootitutor/Tutorial1 && git pull emootitutor/Tutorial1 HEAD
RUN cd emootitutor/Tutorial1/HelloEmooti && mvn clean compile install
RUN cd emootitutor/Tutorial1/Sprint1 && mvn clean package
VOLUME ["/emootitutor/Tutorial1/Sprint1/target"]
#mvn tomcat7:deploy
