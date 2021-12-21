while [ 1 ]; do
	dd if=/dev/urandom bs=1024 count=1024 | ETCDCTL_API=3 etcdctl put key || break
done
