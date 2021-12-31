FROM registry.access.redhat.com/ubi7/ubi
MAINTAINER jeffr2
USER root
ENV JBOSS_HOME /opt/app/jboss-as-7.1.1.Final
RUN yum install java-1.7.0-openjdk-devel http://mirror.centos.org/centos/8/BaseOS/x86_64/os/Packages/tree-1.7.0-15.el8.x86_64.rpm unzip -y && yum clean all && mkdir -pv /opt/app/
ADD https://download.jboss.org/jbossas/7.1/jboss-as-7.1.1.Final/jboss-as-7.1.1.Final.zip /tmp/
ADD https://repo1.maven.org/maven2/org/jboss/modules/jboss-modules/1.1.5.GA/jboss-modules-1.1.5.GA.jar /tmp/
RUN unzip /tmp/jboss-as-7.1.1.Final.zip -d /opt/app/ && tree /opt/app/ -d
RUN mv -f /tmp/jboss-modules-1.1.5.GA.jar $JBOSS_HOME/jboss-modules.jar
RUN useradd jboss -U && chown -R jboss:jboss $JBOSS_HOME
#WORKDIR /opt/app/
RUN $JBOSS_HOME/bin/add-user.sh admin admin123 --silent=true
RUN echo "JAVA_OPTS=\"\$JAVA_OPTS -Djboss.bind.address=0.0.0.0 -Djboss.bind.address.management=0.0.0.0\"" >> $JBOSS_HOME/bin/standalone.conf
EXPOSE 8080 9990 9999
ENTRYPOINT $JBOSS_HOME/bin/standalone.sh -c standalone-full-ha.xml
# jboss is now ready to work
# additional step - uncomment the line below and change to your app name
# ADD sample.war "$JBOSS_HOME/standalone/deployments/"
USER jboss
CMD /bin/bash
