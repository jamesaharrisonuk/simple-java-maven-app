#!/usr/bin/env bash

DIR=$(pwd)

echo 'The following Maven command installs your Maven-built Java application'
echo 'into the local Maven repository, which will ultimately be stored in'
echo 'Jenkins''s local Maven repository (and the "maven-repository" Docker data'
echo 'volume).'

mvn jar:jar install:install help:evaluate -Dexpression=project.name


echo 'The following command extracts the value of the <name/> element'
echo 'within <project/> of your Java/Maven project''s "pom.xml" file.'

NAME=$(mvn -q -DforceStdout help:evaluate -Dexpression=project.name | awk '{ print $1}')


echo 'The following command behaves similarly to the previous one but'
echo 'extracts the value of the <version/> element within <project/> instead.'

VERSION=$(mvn -q -DforceStdout help:evaluate -Dexpression=project.version | awk '{ print $1}')



echo 'Full directory listing of repo'
find .


echo 'The following command runs and outputs the execution of your Java'
echo 'application (which Jenkins built using Maven) to the Jenkins UI.'

echo 'variables'
java  -jar ${DIR}/target/${NAME}-${VERSION}.jar
echo 'hardcoded'
java -jar /var/jenkins_home/workspace/Github_Pipeline_2/target/my-app-1.0-SNAPSHOT.jar
