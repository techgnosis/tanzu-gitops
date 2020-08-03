FROM adoptopenjdk:14.0.2_8-jdk-hotspot

COPY spring-petclinic /opt/spring-petclinic

WORKDIR /opt/spring-petclinic/

RUN ./mvnw test && ./mvnw validate

WORKDIR /opt
RUN rm -rf spring-petclinic