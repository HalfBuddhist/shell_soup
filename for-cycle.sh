drives=("sda" "sdb" "sdc" "sde" "sdf")
for drive in ${drives[@]}; do
	echo "/dev/$drive"
done
