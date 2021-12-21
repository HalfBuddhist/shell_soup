for i in {4..6};do
        docker run -d --name gitlab-runner${i} --restart always \
           -v /data/gitlab-runner${i}/config:/etc/gitlab-runner \
           -v /var/run/docker.sock:/var/run/docker.sock \
           gitlab/gitlab-runner:latest
done