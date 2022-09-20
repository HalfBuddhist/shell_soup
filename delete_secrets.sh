#!/bin/bash
# usage: delete_secrets.sh multus
component=$1
namespace="nvidia-network-operator-resources"
/opt/kube/bin/kubectl get secret -n ${namespace} | grep ${component}-token | awk '{print $1}'  > /tmp/total_${component}.txt
/opt/kube/bin/kubectl get pod -n ${namespace}  | grep ${component} | awk  '{print $1}'  | xargs -i /opt/kube/bin/kubectl describe pod {} -n ${namespace} | grep SecretName  | tr -d ' '  | awk -F ':' '{print $2}' >  /tmp/use_${component}.txt
sort /tmp/total_${component}.txt /tmp/use_${component}.txt /tmp/use_${component}.txt  | uniq -u > /tmp/should_delete_${component}.txt
cat /tmp/should_delete_${component}.txt | xargs -i /opt/kube/bin/kubectl delete secret -n ${namespace} {}