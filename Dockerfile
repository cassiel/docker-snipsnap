# Because of its various XML dependencies, SnipSnap is only compatible with Java 5:
FROM lwis/java5

# Let's try a source build. We need git:

RUN apt-get update \
        && apt-get install -y git

# Let's get snipsnap:

RUN git clone https://github.com/cassiel/snipsnap.git

# Get SnipSnap distribution (which also seems to untar it):
#ADD dist/* /dist/

# Get Apache Ant:
ADD dist/* /dist/

# Try an Ant-based build:

ENV ANT_HOME    /dist/apache-ant-1.9.11
ENV ANT_CP      $ANT_HOME/lib/ant.jar:$ANT_HOME/lib/ant-launcher.jar
ENV JAVA_HOME   /jdk1.5.0_22

#RUN cd snipsnap && $JAVA_HOME/bin/java -Dant.home=$ANT_HOME -cp $ANT_CP org.apache.tools.ant.Main
RUN cd snipsnap && $ANT_HOME/bin/ant

# Expose server on 8000 externally:
#EXPOSE 8668:8000

# CMD [...]
