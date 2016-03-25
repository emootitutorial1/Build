# Dockerfile
# GitHub and do a maven build it
FROM emooti/tutorbase
MAINTAINER Uta Kapp "utakapp@gmail.com"

ENV REFRESHED_AT 2016-02-29
ENV MAVEN_OPTS="-Xms512m -Xmx2048m -XX:MaxPermSize=512m"
ENV GIT_DISCOVERY_ACROSS_FILESYSTEM 1
RUN sed -i -- 's/<Servers>/<Servers> <server><id>TomcatServer<\/id><username>admin<\/username> <password>pwd<\/password><\/server>/g' /usr/share/maven/conf/settings.xml
RUN mkdir emootitutor
RUN cd emootitutor && pwd && git init && ls
RUN cd emootitutor && git remote

# pull from GitHub

RUN cd emootitutor && git remote add emootitutor https://github.com/emooti/EmootiTutor.git
RUN cd emootitutor && git pull emootitutor HEAD
RUN cd emootitutor/Tutorial1/HelloEmooti && mvn clean compile install
RUN cd emootitutor/Tutorial1/Sprint1 && mvn clean package
VOLUME ["/emootitutor/Tutorial1/Sprint1/target"]
#mvn tomcat7:deploy
