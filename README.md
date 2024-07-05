# Live Debugging tutorial for debugging Java applications

A sample app for debugging Java code using Dynatrace

## Setup

1. Clone the sample app from this repository:

```bash
git clone https://github.com/jhendrick/tutorial-java-workshop.git
cd tutorial-java-workshop
``` 

2. Update the Dockerfile with your Dynatrace environment URL

```bash
ENV DT_ENVIRONMENT_URL={yourenvid}.live.dynatrace.com
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