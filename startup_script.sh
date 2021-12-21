#!/bin/bash
# description:script to initialize harbor when restart
# chkconfig: 2345 99 9
# 开机脚本启动设置
# update-rc.d harbor-startup defaults 99  # debian 系
# chkconfig --add harbor-startup && chkconfig  --level 2345 harbor-startup on  # redhad 系

case $1 in
    start)
        echo "Init harbor:"
        sleep 3m  # waiting for docker start

        dockers=("harbor-core" "harbor-adminserver" "harbor-db" "harbor-jobservice" "harbor-log" "harbor-portal" "nginx" "redis" "registry" "registryctl" "clair")
        for p in "${dockers[@]}"
        do
            echo "stop $p now:"
            docker stop $p
        done

        # start using docker-compose
        docker-compose -f {{ data_dir }}/harbor/docker-compose.yml -f {{ data_dir }}/harbor/docker-compose.clair.yml up -d
        ;;

    stop)
        echo "Stop harbor"
        docker-compose -f {{ data_dir }}/harbor/docker-compose.yml -f {{ data_dir }}/harbor/docker-compose.clair.yml stop
        ;;

    *)
        echo "Usage:$0(start|stop)"
        ;;
esac

exit 0
