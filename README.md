# Live Debugging tutorial for debugging Java applications

A sample app for debugging Java code using Dynatrace

For the simplest setup, use with GitHub codespaces. Docker in Docker is configured so the Java application can be started within the codespace. Port 8080 is exposed in order to access the application from your local machine. The steps below follow the [guide](https://docs.dynatrace.com/docs/setup-and-configuration/setup-on-container-platforms/docker/set-up-oneagent-on-containers-for-application-only-monitoring) for deploying OneAgent with application only monitoring

## Setup

1. Clone the sample app from this repository or spin up an environment using codespaces:

```bash
git clone https://github.com/jhendrick/tutorial-java-workshop.git
cd tutorial-java-workshop
```
Note, even if you use codespaces, you will need to clone the repository locally in order to connect the source code repo later in the live debugger.

2. Update the Dockerfile with your Dynatrace environment URL and custom label

```bash
For example: <environmentURL> could be {environmentID}.live.dynatrace.com
 ```

```bash
ENV DT_LIVEDEBUGGER_LABELS=name:value
 ```

3. Sign in to Docker with your Dynatrace environment ID as username.

```bash
docker login <environmentURL> -u <environmentID>
```

4. Enter your <PAAS_TOKEN> when prompted.


5. Build and run the app


```bash
docker build -t tutorial-java-workshop .
```

```bash
docker run -p 8080:8080 tutorial-java-workshop
```

6. Open the app at http://localhost:8080

7. You can set a breakpoint in TodoController on line 32 (or anywhere in the addTodo() function
