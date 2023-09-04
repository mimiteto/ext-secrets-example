#! /usr/bin/env bash

KTX="lasagna"
old_ctx=$(kubectl config current-context)

trap "kubectl get pods -A | grep -v Running; kubectl config use-context \"${old_ctx}\"" EXIT

kubectl config use-context "${KTX}"

flux reconcile source git flux-system
flux reconcile kustomization flux-system
kubectl get kustomizations.kustomize.toolkit.fluxcd.io -A -o json | jq ' .items[] | select(.spec.suspend==true) | .metadata.name'
kubectl get helmreleases.helm.toolkit.fluxcd.io -A -o json | jq ' .items[] | select(.spec.suspend==true) | .metadata.name'
watch -n 1 kubectl get kustomizations.kustomize.toolkit.fluxcd.io -A -o wide
kubectl get kustomizations.kustomize.toolkit.fluxcd.io -A -o json | jq ' .items[] | select(.spec.suspend==true) | .metadata.name'
kubectl get helmreleases.helm.toolkit.fluxcd.io -A -o json | jq ' .items[] | select(.spec.suspend==true) | .metadata.name'
