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
    ```
5. display config with `dev` customization
    ```
    kustomize build frontend-app/overlays/dev
    ```
6. apply `dev` customized app to k8s cluster
    ```
    kustomize build frontend-app/overlays/dev | kubectl apply -f -
    #OR
    kubectl apply -k  overlays/dev
    ```
