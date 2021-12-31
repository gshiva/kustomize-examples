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

This example uses a slightly modified kubernetes [wordpress example](https://github.com/kubernetes-sigs/kustomize/blob/master/examples/wordpress/README.md) to demonstrate using kustomize to switch out a yaml deployment file `persistentVolumeClaim` [volume](https://kubernetes.io/docs/concepts/storage/persistent-volumes/) to a confgMap [volume](https://kubernetes.io/docs/concepts/storage/volumes/) using kustomize overlays.


1. install [kustomize](https://kubectl.docs.kubernetes.io/installation/kustomize/binaries/)
2. install [kubectl](https://kubernetes.io/docs/tasks/tools/)
3. example K8S app files under github example as follows
WIP







- other references
https://kubectl.docs.kubernetes.io/references/kustomize/kustomization/configmapgenerator/
https://blog.stack-labs.com/code/kustomize-101/
