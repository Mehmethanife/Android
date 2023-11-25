FROM clojure as BUILD
COPY . /usr/src/app
WORKDIR /usr/src/app
RUN lein ring uberjar

FROM eclipse-temurin:17-jdk-alpine

RUN apk update && apk upgrade && apk add bash
ENV PORT 3000
EXPOSE 3000
COPY --from=BUILD /usr/src/app/target/*.jar /opt/
WORKDIR /opt
CMD ["/bin/bash", "-c", "find -type f -name '*standalone.jar' | xargs java -jar"]
