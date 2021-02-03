# Deployment


## 一、初始化
```
在所有节点安装执行（master、node等）
vi /etc/hosts
# github
199.232.68.133 raw.githubusercontent.com

curl -sSL https://raw.githubusercontent.com/matt-pei/Deployment/main/install_kube.sh | sh -s 1.19.5
```

## 二、初始化master节点

> 关于初始化时用到的环境变量
>
> APISERVER_NAME 不能是 master 的 hostname
>
> APISERVER_NAME 必须全为小写字母、数字、小数点，不能包含减号
>
> POD_SUBNET 所使用的网段不能与 master节点/worker节点 所在的网段重叠。该字段的取值为一个 CIDR 值，如果您对 CIDR 这个概念还不熟悉，请仍然执行 export POD_SUBNET=10.100.0.1/16 命令，不做修改


```
export MASTER_IP=
# 替换 apiserver.demo 为您想要的 dnsName
export APISERVER_NAME=
# Kubernetes容器组所在的网段,该网段安装完成后,由kubernetes创建,事先并不存在于您的物理网络中
export POD_SUBNET=10.100.0.1/16
echo "${MASTER_IP}    ${APISERVER_NAME}" >> /etc/hosts

```


