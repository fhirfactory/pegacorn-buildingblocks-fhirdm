FROM maven:3.6.3-jdk-11-slim
WORKDIR /tmp/hapi-fhir-jpaserver-starter

COPY pom.xml .
RUN mvn -ntp dependency:go-offline

# COPY src/ /tmp/hapi-fhir-jpaserver-starter/src/
# RUN mvn clean install -DskipTests
