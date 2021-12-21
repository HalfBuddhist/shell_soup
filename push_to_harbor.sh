#!/bin/bash

harbor_base="harbor.ainnovation.com/jupyter"

function do_one_push() {
  image_name=$1
  image_tag=$2

  docker tag "${image_name}:${image_tag}" "${harbor_base}/${image_name}:${image_tag}"
  docker push "${harbor_base}/${image_name}:${image_tag}"
  echo "push ${harbor_base}/${image_name}:${image_tag} finish."

}


tag_list=("1.6.0" "1.10.0" "1.12.0" "1.15.0" "2.0.0")
image_name_list=("tensorflow-notebook" "tensorflow-gpu-notebook")
for name in "${image_name_list[@]}"; do
  for tag in "${tag_list[@]}"; do
    do_one_push "${name}" "${tag}"
  done
done
