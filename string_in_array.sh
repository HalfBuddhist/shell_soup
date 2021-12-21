#!/bin/sh
##数组
array=(
address
base
cart
company
store
)

STORAGE_VAR=store

# $1 如果存在，输出 $1 exists，$1 如果不存在，输出 $1 not exists
if [ "$1" != null ];then
  if [[ "${array[@]}"  =~ "${1}" ]]; then
    echo "$1 exists"
  elif [[ ! "${array[@]}"  =~ "${1}" ]]; then
    echo "$1 not exists"
  fi
else
  echo "请传入一个参数"
fi
