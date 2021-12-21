namespace=$1
kubectl get deploy -n $namespace | tail +2 | awk '{print $1}' | xargs -i kubectl patch deploy {}  -n $namespace  -p '{
  "spec": {
    "template": {
      "spec":{
        "nodeSelector": {
          "is_orca_manager": "yes"
        }
      }
    }
  }
}'
