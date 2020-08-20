# k8s install step
## experimental environment 
- 2vCPUs 
- 4GB
- Fedora 29 64bit with ARM
## step
- install docker
    - `curl -fsSL https://get.docker.com | bash -s docker`
        - As a container, Docker is installed on all servers using installation scripts
    - start docker
        ```
        systemctl daemon-reload
        systemctl restart docker.service
        ```
- `yum -y install --enablerepo=updates-testing kubernetes`
- `yum -y install etcd iptables`
- DNS config
    ```
    echo "192.168.0.153 fed-master
    192.168.0.139 fed-node" >> /etc/hosts
    ```
-  config /etc/kubernetes/config
    ```
    echo "# Comma separated list of nodes in the etcd cluster
    KUBE_MASTER="–master=http://fed-master:8080″
    # logging to stderr means we get it in the systemd journal
    KUBE_LOGTOSTDERR="–logtostderr=true"
    # journal message level, 0 is debug
    KUBE_LOG_LEVEL="–v=0″
    # Should this cluster be allowed to run privileged docker containers
    KUBE_ALLOW_PRIV="–allow_privileged=false"" >> /etc/kubernetes/config
    ```
- stop iptables-services firewalld
    ```
    systemctl disable iptables-services firewalld
    systemctl stop iptables-services firewalld
    ```