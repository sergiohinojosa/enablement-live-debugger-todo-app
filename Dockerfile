FROM openjdk:8-jdk as build

RUN mkdir -p /app
WORKDIR /app
ADD build.gradle /app
ADD . /app
RUN ./gradlew -i bootJar

# ---------------------------------------------------------- #

FROM openjdk:8-jdk as release

ENV DT_API_URL=https://pjw27103.dev.dynatracelabs.com/api
ENV DT_ONEAGENT_TECHNOLOGY=java

ENV DT_PAAS_TOKEN=<insert token>

RUN mkdir -p /opt/dynatrace/oneagent && ARCHIVE=$(mktemp) && wget -O $ARCHIVE "$DT_API_URL/v1/deployment/installer/agent/unix/paas/latest?Api-Token=$DT_PAAS_TOKEN&flavor=default&arch=arm&include=$DT_ONEAGENT_TECHNOLOGY" && unzip -o -d /opt/dynatrace/oneagent $ARCHIVE && rm -f $ARCHIVE

ENV LD_PRELOAD /opt/dynatrace/oneagent/agent/lib64/liboneagentproc.so

ENV DT_LIVEDEBUGGER_LABELS=app:josh 

RUN mkdir -p /app
# Copy the jar image (which already include resoures)
COPY --from=build /app/build/libs/tutorial-1.0.0.jar  /app/tutorial-1.0.0.jar

ENTRYPOINT ["java", "-jar", "/app/tutorial-1.0.0.jar"]
