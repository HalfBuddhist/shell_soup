for i in {4..6};do
  docker run --rm -t -i -v /data/gitlab-runner${i}/config:/etc/gitlab-runner --name gitlab-runner${i} gitlab/gitlab-runner register \
          --non-interactive \
          --executor "docker" \
          --docker-image docker:stable \
          --url "https://gitlab.ainnovation.com/" \
          --registration-token "oX2WzjDgW8w9Jr8ixNui" \
          --description "docker-runner${i}" \
          --tag-list "docker,aws" \
          --run-untagged \
          --locked="false" \
          --docker-privileged
;done