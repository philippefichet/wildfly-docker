FROM openjdk:8u92-jdk-alpine
MAINTAINER Philippe FICHET <philippe.fichet@laposte.net>

RUN apk add --no-cache wget gzip tar

# Add the WildFly distribution to /opt, and make wildfly the owner of the extracted tar content
# Make sure the distribution is available from a well-known place
# Set the WILDFLY_VERSION env variable
ENV WILDFLY_VERSION 10.1.0.Final
ENV WILDFLY_HOME /opt/wildfly/wildfly-$WILDFLY_VERSION
ENV WILDFLY_ADMIN_USER admin
ENV WILDFLY_ADMIN_PASSWORD megapassword
RUN mkdir -p /opt/wildfly/
RUN mkdir -p /opt/wildfly/
RUN cd /opt/wildfly/ && \
    wget http://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz -O - | \
    gunzip | \
    tar xvf -

# Expose the ports we're interested in
EXPOSE 8080 8443 9990

#ENV JAVA_OPTS="-server -Xms512m -Xmx1024m -XX:MetaspaceSize=128M -XX:MaxMetaspaceSize=256m -Djava.net.preferIPv4Stack=true -Djboss.modules.system.pkgs=org.jboss.byteman -Djava.awt.headless=true -XX:+UseG1GC -Djavamelody.datasources=java:jboss/datasources/feedreader"

# Set the default command to run on boot
# This will boot WildFly in the standalone mode and bind to all interface
CMD ["/opt/wildfly/wildfly-10.1.0.Final/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
