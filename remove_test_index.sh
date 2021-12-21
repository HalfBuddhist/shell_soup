sene=$1

for ((i=3; i<=8; i ++))
do
    echo "Delete sene $sene, on date 07-0$i"
    echo "Command: curl -XDELETE localhost:9200/orion-changan-s$sene-2019.07.0$i"
    curl -XDELETE localhost:9200/orion-changan-s$sene-2019.07.0$i
done