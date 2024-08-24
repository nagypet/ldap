FROM openjdk:8u111-jre-alpine

LABEL org.opencontainers.image.authors="peter.nagy@perit.hu"

VOLUME /tmp

RUN apk add --no-cache tzdata

# setting image timezone to Europe/Budapest
ENV TZ=Europe/Budapest
RUN ln -snf /usr/share/zoneinfo/"$TZ" /etc/localtime && echo "$TZ" > /etc/timezone

EXPOSE 10389

RUN apk add --no-cache openssl
RUN mkdir /ldap
WORKDIR /ldap
RUN wget https://github.com/intoolswetrust/ldap-server/releases/download/v.1.0.0/ldap-server.jar

COPY users.ldif /ldap/users.ldif

CMD ["java","-jar","ldap-server.jar", "users.ldif"]

