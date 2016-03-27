# Dockerfile
# GitHub and do a maven build
FROM emooti/tutorbase
MAINTAINER Uta Kapp "uta.kapp@emooti.org"

ENV REFRESHED_AT 2016-03-27
ENV MAVEN_OPTS="-Xms512m -Xmx2048m -XX:MaxPermSize=512m"
ENV GIT_DISCOVERY_ACROSS_FILESYSTEM 1
RUN sed -i -- 's/<servers>/<servers> <server><id>TomcatServer<\/id><username>admin<\/username> <password>pwd<\/password><\/server>/g' /usr/share/maven/conf/settings.xml
RUN mkdir emootitutor
RUN cd emootitutor && pwd && git init && ls
RUN cd emootitutor && git remote
#pull from GitHub
# build
RUN cd emootitutor && git remote add emootitutor https://github.com/emootitutorial1/SourceCode.git
RUN cd emootitutor && git pull emootitutor HEAD
RUN cd emootitutor/HelloEmooti && mvn compile install
RUN cd emootitutor/Sprint1 && mvn package
WORKDIR emootitutor/Sprint1
RUN echo "mvn tomcat7:deploy" >> cmd.sh
# /bin/sh -c "while true; do sh cmd.sh; sleep 5; done"
# docker run --name tutorial1build -i -t emooti/tutorial1build
