k8s-polynote
============

[Polynote](https://github.com/polynote/polynote) On Kubernetes

* Polynote 0.5.1
* Spark 3.3.1
* Hadoop 3.3.2
 * hadoop-aws-3.3.2

# Deploy

```
$ helm install --namespace default polynote .
```

### Deploy using package on the github pages

```
$ helm install polynote https://minyk.github.io/k8s-polynote/polynote-0.2.0.tgz
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
$ docker build . -t minyk/polynote:0.5.1-2.12-spark3.3 \
    --build-arg POLYNOTE_VERSION=0.5.1 --build-arg SCALA_VERSION=2.12
```

# Advanced Deploy

### Use extraContainers to deploy sidecar containers with polynote

Deploy `minio/sidekick` aside of polynote. values.yaml:
```yaml
extraContainers:
  - name: side-kick
    image: "minio/sidekick:v0.1.4"
    imagePullPolicy: Always
    args:
      - --address
      - :9000
      - http://10.0.3.19:8080
      - http://10.0.3.20:8080
      - http://10.0.3.21:8080
    ports:
      - containerPort: 9000
```

### Use extraVolumes/ extraVolumeMounts to deploy sidecar containers with spark executor.

Mount `spark-pod-template` file into polynote continer. values.yaml:
```yaml
extraVolumes:
  - name: spark-pod-template
    configMap:
      name: spark-pod-template

extraVolumeMounts:
  - name: spark-pod-template
    mountPath: /opt/spark-pod-template
```

spark-pod-template.yaml:
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: spark-pod-template
  labels:
    app: spark-pod-template
data:
  driver.yaml: |-
    apiVersion: v1
    Kind: Pod
    metadata:
      labels:
        podtemplate: sidekick
    spec:
      containers:
      - name: spark-kubernetes-executor
      - name: side-kick
        image: "minio/sidekick:v0.1.4"
        imagePullPolicy: Always
        args:
          - --address
          - :9000
          - http://10.0.3.19:8080
          - http://10.0.3.20:8080
        ports:
          - containerPort: 9000

  executor.yaml: |-
    apiVersion: v1
    Kind: Pod
    metadata:
      labels:
        podtemplate: sidekick
    spec:
      containers:
      - name: spark-kubernetes-executor
      - name: side-kick
        image: "minio/sidekick:v0.1.4"
        imagePullPolicy: Always
        args:
          - --address
          - :9000
          - http://10.0.3.19:8080
          - http://10.0.3.20:8080
        ports:
          - containerPort: 9000
```

spark configuration:
```
spark.kubernetes.executor.podTemplateFile /opt/spark-pod-template/executor.yaml
spark.hadoop.fs.s3a.endpoint http://localhost:9000
```
