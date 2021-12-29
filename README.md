# Kustomize Examples

## Example1: frontend-app
Follow https://www.densify.com/kubernetes-tools/kustomize with slight adjustments.

1. install kustomize
https://kubectl.docs.kubernetes.io/installation/kustomize/binaries/
2. install https://kubernetes.io/docs/tasks/tools/install-kubectl-windows/
3. example K8S app files under `frontend-app` directory as follows

- deployment.yaml
- service.yaml
- hpa.yaml
- kustomization.yaml
  - dev/
    - kustomization.yaml
    - hpa.yaml
4. display config without customization
    ```
    kustomize.exe build frontend-app/base/
    ```
5. display config with `dev` customization
    ```
    kustomize.exe build frontend-app/overlays/dev
    ```
