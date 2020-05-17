k8s-polynote
============

[Polynote](https://github.com/polynote/polynote) On Kubernetes

* Polynote 0.3.8
* Spark 3.0.1-SNAPSHOT (branch-3.0)
* Hadoop 3.2
 * hadoop-aws-3.2.0

# Deploy

```
$ kubectl apply -f configmap.yaml
$ kubectl apply -f serviceaccount.yaml
$ kubectl apply -f service.yaml
$ kubectl apply -f headless.yaml
$ kubectl apply -f deployment.yaml
```


# Access

Use port-forward
* `8192`: Polynote UI
* `4040`: Spark UI


# Docker images

### Spark

from spark tgz:
```
$ docker build . -f kubernetes/dockerfiles/spark/Dockerfile -t minyk/spark:3.0.1-SNAPSHOT
```

### Polynote

from official image:
```
$ cd docker/polynote
$ docker build . -t minyk/polynote:0.3.8-2.12-spark3.0 \
    --build-arg POLYNOTE_VERSION=0.3.8 --build-arg SCALA_VERSION=2.12
```
