# usage: nohup bash stat_pod_mem.sh kube-system kube-flannel-ds-m9rdk >> pod_mem.log 2>&1 &
NAME_SPACE=$1
POD_NAME=$2

while((1))
do
    /opt/kube/bin/kubectl top pod -n  $NAME_SPACE |grep $POD_NAME | awk '{print $3}' | awk -F 'M' '{print $1}'
    sleep 5
done
