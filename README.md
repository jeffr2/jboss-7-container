# jboss-7-container

## instruction to build:
```bash
podman build -t jboss-test .
or
docker build -t jboss-test .
```
## instruction to run:
```bash
podman run --name my-jboss-test -d -p 8080:8080 -p 9990:9990 -p 9999:9999 jboss-test
or
docker run --name my-jboss-test -d -p 8080:8080 -p 9990:9990 -p 9999:9999 jboss-test
```
