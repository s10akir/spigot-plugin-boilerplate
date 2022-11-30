FROM openjdk:19-jdk-slim AS build-env

ENV SPIGOT_VER 1.19.2

WORKDIR /build
RUN apt-get update && apt-get install git curl -y && apt-get clean && rm -rf /var/lib/apt/lists
RUN curl https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar -o BuildTools.jar
RUN java -jar BuildTools.jar --rev $SPIGOT_VER
RUN mkdir minecraft
RUN cp spigot-${SPIGOT_VER}.jar minecraft/spigot.jar
RUN mkdir data
RUN echo "eula=true" > data/eula.txt


FROM openjdk:19-jdk-slim

WORKDIR /data
COPY --from=build-env /build/minecraft /minecraft
COPY --from=build-env /build/data /data

EXPOSE 25565
EXPOSE 25575
ENTRYPOINT java -jar -Xms2G -Xmx4G /minecraft/spigot.jar nogui