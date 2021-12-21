content=$1
filename=$2
while [ 1 ]
do
    echo $(date) "$content" >> /mnt/cephfs/$filename
    sleep 6
done