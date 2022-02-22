#!/usr/bin/env sh
  set -eu
  
  namespace="tekton-deploy"
  if [ "$namespace" != "" ] ; then
  
    IsAvailable= $(kubectl get ns| grep ${namespace})
  
    #if [ "$(IsAvailable)" == "" ] ; then
      echo "namespace not available"
    else
      echo "namespace available"
    fi
    
  fi
  
  
  
  - name: deploy-image
      runAfter: [create-config]
      workspaces:
        - name: source
          workspace: sources
        - name: shared-workspace
          workspace: shared-workspace
      taskSpec:
        workspaces:
        - name: source
        - name: shared-workspace
        steps:
          - name: deploy
            image: gcr.io/cloud-builders/kubectl@sha256:8ab94be8b2b4f3d117f02d868b39540fddd225447abf4014f7ba4765cb39f753 
            script: |
              #!/usr/bin/env bash
              set -e
              ls -l 
              cd $(workspaces.source.path)/artifacts/
              
              export KUBECONFIG="$(workspaces.shared-workspace.path)/kubeconfig"
              kubectl create namespace tekton-deploy
              kubectl apply -f mathematicsCRD.yaml -n tekton-deploy
              kubectl apply -f deployment.yaml -n tekton-deploy