# Kustomize Examples

## Example: frontend-app
Follow https://www.densify.com/kubernetes-tools/kustomize with slight adjustments ([additional reference](https://kubectl.docs.kubernetes.io/guides/introduction/kustomize/#2-create-variants-using-overlays)).

1. install kustomize
https://kubectl.docs.kubernetes.io/installation/kustomize/binaries/
2. install https://kubernetes.io/docs/tasks/tools/
3. example K8S app files under `frontend-app` directory as follows
   - base/
     - deployment.yaml
     - service.yaml
     - hpa.yaml
     - kustomization.yaml
   - overlays/
     - dev/
       - kustomization.yaml
       - hpa.yaml
4. display config without customization
    ```
    kustomize build frontend-app/base/
    # OR
    kubectl kustomize frontend-app/base/
    ```
5. display config with `dev` customization
    ```
    kustomize build frontend-app/overlays/dev
    # OR
    kubectl kustomize frontend-app/overlays/dev/
    ```
6. apply `dev` customized app to k8s cluster
    ```
    kustomize build frontend-app/overlays/dev | kubectl apply -f -
    #OR
    kubectl apply -k  overlays/dev
    ```

## Example: volume

This example uses a slightly modified kubernetes [mysql example](https://github.com/kubernetes-sigs/kustomize/tree/master/examples/mySql) to demonstrate using kustomize to switch out a yaml deployment file `persistentVolumeClaim` [volume](https://kubernetes.io/docs/concepts/storage/persistent-volumes/) to a confgMap [volume](https://kubernetes.io/docs/concepts/storage/volumes/#configmap) using kustomize overlays.


1. install [kustomize](https://kubectl.docs.kubernetes.io/installation/kustomize/binaries/)
2. install [kubectl](https://kubernetes.io/docs/tasks/tools/)
3. example K8S app files under github example as follows
   - base/
     - service.yaml
     - deployment.yaml
     - secret.yaml
4. create kustomization config file
```
touch kustomization.yaml
kustomize edit add resource secret.yaml
kustomize edit add resource service.yaml
kustomize edit add resource deployment.yaml
```
5. apply the configuration to a free demo cluster by browsing to [this k8s.io tutorial](https://kubernetes.io/docs/tutorials/kubernetes-basics/create-cluster/cluster-interactive/) > click `Start Scenario` > Click `minikube start`
6. after the `Done` message displays, click within the console window and apply the example to the minikube cluster using these commands.
```
$ git clone https://github.com/thesystemninjaneer/kustomize-examples
Cloning into 'kustomize-examples'...
remote: Enumerating objects: 47, done.
remote: Counting objects: 100% (47/47), done.
remote: Compressing objects: 100% (33/33), done.
remote: Total 47 (delta 15), reused 42 (delta 10), pack-reused 0
Unpacking objects: 100% (47/47), done.
$
$ cd kustomize-examples/volume-example/
$ kubectl kustomize base
I0103 16:16:27.324328    4637 log.go:181] nil value at `template.spec.serviceAccountName` ignored in mutation attempt
I0103 16:16:27.324396    4637 log.go:181] nil value at `template.spec.volumes.configMap.name` ignored in mutation attempt
I0103 16:16:27.324411    4637 log.go:181] nil value at `template.spec.containers.env.valueFrom.configMapKeyRef.name` ignored in mutation attempt
I0103 16:16:27.324468    4637 log.go:181] nil value at `template.spec.initContainers.env.valueFrom.configMapKeyRef.name` ignored in mutation attempt
I0103 16:16:27.324481    4637 log.go:181] nil value at `template.spec.containers.envFrom.configMapRef.name` ignored in mutation attempt
I0103 16:16:27.324492    4637 log.go:181] nil value at `template.spec.initContainers.envFrom.configMapRef.name` ignored in mutation attempt
I0103 16:16:27.324503    4637 log.go:181] nil value at `template.spec.volumes.projected.sources.configMap.name` ignored in mutation attempt
I0103 16:16:27.324537    4637 log.go:181] nil value at `template.spec.volumes.secret.secretName` ignored in mutation attempt
I0103 16:16:27.324558    4637 log.go:181] nil value at `template.spec.containers.env.valueFrom.secretKeyRef.name` ignored in mutation attempt
I0103 16:16:27.324574    4637 log.go:181] nil value at `template.spec.initContainers.env.valueFrom.secretKeyRef.name` ignored in mutation attempt
I0103 16:16:27.324592    4637 log.go:181] nil value at `template.spec.containers.envFrom.secretRef.name` ignored in mutation attempt
I0103 16:16:27.324603    4637 log.go:181] nil value at `template.spec.initContainers.envFrom.secretRef.name` ignored in mutation attempt
I0103 16:16:27.324615    4637 log.go:181] nil value at `template.spec.imagePullSecrets.name` ignored in mutation attempt
I0103 16:16:27.324633    4637 log.go:181] nil value at `template.spec.volumes.projected.sources.secret.name` ignored in mutation attempt
I0103 16:16:27.324645    4637 log.go:181] nil value at `template.spec.volumes.persistentVolumeClaim.claimName` ignored in mutation attempt
apiVersion: v1
kind: Service
metadata:
  name: frontend-service
spec:
  app: frontend-deployment
  ports:
  - name: http
    port: 8080
  selector: null
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: frontend-deployment
spec:
  matchLabels:
    app: frontend-deployment
  metadata:
    labels:
      app: frontend-deployment
  selector: null
  spec:
    containers:
    - image: foo/bar:latest
      name: app
      ports:
      - containerPort: 8080
        name: http
        protocol: TCP
  template: null
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  creationTimestamp: null
  labels:
    io.kompose.service: grafana-data
  name: grafana-data
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 100Mi
status: {}
$ kubectl apply -k base
```
7. WIP






- other references
https://kubectl.docs.kubernetes.io/references/kustomize/kustomization/configmapgenerator/
https://blog.stack-labs.com/code/kustomize-101/
