NAMESPACE='test'
ZK_NODE_CNT=$1
ZK_CLIENT_PORT=2181

# form the zk path
# 127.0.0.1:2181,127.0.0.1:2182,[::1]:2183
ZK_PATH="zookeeper-${NAMESPACE}-1:${ZK_CLIENT_PORT}"
for ((i=2; i<=$ZK_NODE_CNT; i ++))
do
    ZK_PATH="${ZK_PATH},zookeeper-${NAMESPACE}-${i}:${ZK_CLIENT_PORT}"
done
echo $ZK_PATH
