#!/usr/bin/env bash

DO_WHAT=$1

case $DO_WHAT in
    split)
        python3 do.py --do_what=split --num_parts=${2} ;;
    map)
        python3 do.py --do_what=map  --part_id=${2} ;;
    reduce)
        python3 do.py --do_what=reduce ;;
    *)
	exit ;;
esac
