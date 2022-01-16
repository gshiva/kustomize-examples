#!/bin/sh
touch kustomization.yaml
kustomize edit add resource secret.yaml
kustomize edit add resource service.yaml
kustomize edit add resource deployment.yaml
