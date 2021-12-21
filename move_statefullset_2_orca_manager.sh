namespace=$1
kubectl get statefulset  -n $namespace | tail +2 | awk '{print $1}' | xargs -i kubectl patch statefulset {}  -n $namespace  -p '{
  "spec": {
    "template": {
      "spec":{
        "nodeSelector": {
          "is_orca_manager": "yes"
        },
        "containers":[
            {
              "name":"alertmanager",
              "env":[
                {
                  "name":"RESTART_",
                  "value":"'$(date +%s)'"
                }
              ]
            }
          ]
      }
    }
  }
}'
