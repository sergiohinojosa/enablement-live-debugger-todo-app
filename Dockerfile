FROM openjdk:8-jdk as build

RUN mkdir -p /app
WORKDIR /app
ADD build.gradle /app
ADD . /app
RUN ./gradlew -i bootJar

# ---------------------------------------------------------- #

FROM openjdk:8-jdk as release

# Update <environmentURL> below. Make sure to remove the < >:
# environmentURL=beq06176.dev.dynatracelabs.com
# TECHNOLOGY=java

COPY --from=<environmentURL>/linux/oneagent-codemodules:java / /
ENV LD_PRELOAD /opt/dynatrace/oneagent/agent/lib64/liboneagentproc.so

ENV DT_LIVEDEBUGGER_LABELS=app:josh 

RUN mkdir -p /app
# Copy the jar image (which already include resoures)
COPY --from=build /app/build/libs/tutorial-1.0.0.jar  /app/tutorial-1.0.0.jar

ENTRYPOINT ["java", "-jar", "/app/tutorial-1.0.0.jar"]
