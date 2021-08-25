FROM maven:3.6.3-jdk-11-slim as build-hapi

COPY src/ /tmp/hapi-fhir-jpaserver-starter/src/
COPY target/ /tmp/hapi-fhir-jpaserver-starter/target/

# # 65532 is the nonroot user's uid
# # used here instead of the name to allow Kubernetes to easily detect that the container
# # is running as a non-root (uid != 0) user.
USER 65532:65532

FROM tomcat:9.0.38-jdk11-openjdk-slim-buster

RUN mkdir -p /data/hapi/lucenefiles && chmod 775 /data/hapi/lucenefiles
COPY --from=build-hapi /tmp/hapi-fhir-jpaserver-starter/target/*.war /usr/local/tomcat/webapps/

ARG IMAGE_BUILD_TIMESTAMP
ENV IMAGE_BUILD_TIMESTAMP=${IMAGE_BUILD_TIMESTAMP}
RUN echo IMAGE_BUILD_TIMESTAMP=${IMAGE_BUILD_TIMESTAMP}

EXPOSE 8080

CMD ["catalina.sh", "run"]
