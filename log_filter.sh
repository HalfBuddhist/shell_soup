FILENAME=$1
echo "Filter: $FILENAME"

cat $FILENAME | grep "ERROR" | grep -v "resolved" | grep -v "lf'" \
 | grep -v "err='S" | grep -v "hvac_power" | grep -v "electricity"  \
 | grep -v "machine" | grep -v "nan found" > err
