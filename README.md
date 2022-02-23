# TektonTrail
This project contains some demo code for tekton pipeline. 

For starting the pipeline follow below steps:

1. Install tekton, Eventlistener, Trigger.
   
   To install the core component of Tekton, Tekton Pipelines, run the command below:
   
   `kubectl apply --filename https://storage.googleapis.com/tekton-releases/pipeline/latest/`
   
   To install Trigger and Eventlistener, run the command below:
   
   `kubectl apply --filename https://storage.googleapis.com/tekton-releases/triggers/latest/release.yaml`
   `kubectl apply --filename https://storage.googleapis.com/tekton-releases/triggers/latest/interceptors.yaml`
   
   For more details regarding above resources. check below links:
   https://tekton.dev/docs/getting-started/
   https://tekton.dev/vault/triggers-main/install/
   
2. Install tasks to be used in the pipeline.

     `git-clone: kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/git-clone/0.5/git-clone.yaml`
     
     `kaniko: kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/kaniko/0.5/kaniko.yaml`
     
     `yq: kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/yq/0.3/yq.yaml`
     
     `kubeconfig-creator: kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/kubeconfig-creator/0.1/kubeconfig-creator.yaml `
     
     `yaml-modify: kubectl apply -f task/modifyPermission.yaml`
     
     `deploy-image: kubectl apply -f task/deploy_image.yaml`
  
 3. Install pipeline:
 
    `kubectl apply -f pipeline.yaml`
 
 4. Create service account and required roles for pipeline and trigger.
 
   ` kubectl apply -f docker_auth.yaml`
   
   `kubectl apply -f gitlab_auth.yaml`
   
   `kubectl apply -f Trigger/access.yaml`
   
   `kubectl apply -f Trigger/admin_role.yaml`
   
 5. Create trigger and eventlistener.
 
    `kubectl apply -f Trigger/gitlab_trigger.yaml`
 
 6. Check that eventlistener pod is getting created correctly.
 
 7. Expose eventlistener service. this will be used while creating webhook for github/gitlab.
   
    `kubectl apply -f Trigger/Ingress_istio.yaml`
    
     Note: In the above file, update the host as per the users test enviornment.
     
 8. To test,
    
    create a gitlab webhook and try sending a push event. Once event is send successfully from gitlab, pipeline should automatically get started for the project.
    
    If pipeline does not get started, check the eventlistener pod's log for error.
    
 Note: In order to check resource easily, user can install tekton dashboard, if req.
     
