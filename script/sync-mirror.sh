#! /bin/bash

cce="swr.cn-north-4.myhuaweicloud.com/cce-hdms"
ecr="388144527693.dkr.ecr.cn-northwest-1.amazonaws.com.cn/hdms"
ecr_d="388144527693.dkr.ecr.cn-northwest-1.amazonaws.com.cn/603a187702a848278fd46e256d8f80d3/378"

function aws_docker_login {
    # ECR验证docker
    aws ecr get-login-password --region cn-northwest-1 | docker login --username AWS --password-stdin 388144527693.dkr.ecr.cn-northwest-1.amazonaws.com.cn
}


function cce_docker_login {
    docker login -u cn-north-4@MCAP8J60NJXTNWWD6KM6 -p 8bfb32d9aad3b1e30978d5f413bd3ecc7d8976b50964ceb7efb2548bf192544e swr.cn-north-4.myhuaweicloud.com
}


function sync_mirror {
    # loging aws ecr
    images=(
      "compiler-master-oem:21q1sp1-v0-201125"
      "id-editor:v19.4.1"
      "id-log-nginx:22q3sp1_v0_220429"
      "id-notification:22q1sp2-v0-211213"
      "id-sync:20Q2sp1-v0-200210"
      "id-upload:2022sp7-v0-220906"
      "id-validation:21q1sp2-v0-210106"
      "igapi:v19.4.2"
      "oso-check:20220902"
      "oso-export:22sp8-v0-0908"
      "oso-hcc-tile-update:22q3sp1-v0-220421"
      "webportal:21Q1_sp1_V1.1_201118"
      )
    a_images=(
        "hdms-compiler-worker:20221031"
        "oso-hcc-attr-process:hdms.20220927173000167"
        "oso-hcc-attr-process:hdms.20220927173000167"
        "oso-hstdata-st2pg:hmds.20220927173918400"
        "oso-rcs-service:hdms.20220927173810187"
        "oso-task:hdms.20220927173850192"
    )
    for i in ${images[*]};
    do 
      aws_docker_login && \
      docker pull ${ecr}/${i} && \
      docker tag ${ecr}/${i} ${cce}/${i} && \
      docker rmi ${ecr}/${i} && \
      cce_docker_login && \
      docker push ${cce}/${i} && \
      docker rmi ${cce}/${i};
    done
}

sync_mirror


docker pull 388144527693.dkr.ecr.cn-northwest-1.amazonaws.com.cn/603a187702a848278fd46e256d8f80d3/378/idistributor-auth:hdms.20220927171620133
388144527693.dkr.ecr.cn-northwest-1.amazonaws.com.cn/603a187702a848278fd46e256d8f80d3/378/idistributor-server:2022sp8-v1-220923.20220927114859335
388144527693.dkr.ecr.cn-northwest-1.amazonaws.com.cn/603a187702a848278fd46e256d8f80d3/378/idistributor-task:hdms.20220927173955197



docker tag 388144527693.dkr.ecr.cn-northwest-1.amazonaws.com.cn/603a187702a848278fd46e256d8f80d3/378/idistributor-auth:hdms.20220927171620133 swr.cn-north-4.myhuaweicloud.com/cce-hdms/id-auth:20220927171620133
docker push swr.cn-north-4.myhuaweicloud.com/cce-hdms/id-auth:20220927171620133

docker tag 388144527693.dkr.ecr.cn-northwest-1.amazonaws.com.cn/603a187702a848278fd46e256d8f80d3/378/idistributor-server:2022sp8-v1-220923.20220927114859335 swr.cn-north-4.myhuaweicloud.com/cce-hdms/id-server:20220927114859335
docker push swr.cn-north-4.myhuaweicloud.com/cce-hdms/id-server:20220927114859335

docker tag 388144527693.dkr.ecr.cn-northwest-1.amazonaws.com.cn/603a187702a848278fd46e256d8f80d3/378/idistributor-task:hdms.20220927173955197 swr.cn-north-4.myhuaweicloud.com/cce-hdms/