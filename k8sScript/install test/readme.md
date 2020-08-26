# experimental environment 
- master 
    - 2vCPUs | 4GB | kc1.large.2
Fedora 29 64bit with ARM
    - IP
        - 119.8.112.217
        - 192.168.0.212
- node
    - blue IP
        - 159.138.4.128
        - 192.168.0.225
    - green IP
        - 119.8.114.40
        - 192.168.0.205
# install log
- DNS config
    ```
    echo "192.168.0.212 master
    192.168.0.225 blue
    192.168.0.205 green" >> /etc/hosts
    ```
    in master
    ```
    sudo hostnamectl set-hostname master
    ```
    in blue
    ```
    sudo hostnamectl set-hostname blue
    ```
    in green
    ```
    sudo hostnamectl set-hostname green
    ```
- SSH access
    ```
    ssh-keygen -t rsa -C "1076998404@qq.com"
    ssh-copy-id root@master
    ssh-copy-id root@blue
    ssh-copy-id root@green
    ```
    - `ssh-keygen -t rsa -C "address@youremail.com`
        - k3sUp use SSH connect to server. First generate the SSH secret key
    - `ssh-copy-id root@serverIP`
        - Copy the SSH key remotely to the server
    - `ssh-copy-id root@agentIP`
        - Copy the SSH key remotely to the agent
- Installing runtime
    - `curl -fsSL https://get.docker.com | bash -s docker`
    - start docker
        ```
        systemctl daemon-reload
        systemctl restart docker.service
        ```
    - docker start with server
        ```
        systemctl enable docker
        systemctl start docker
        ```
- The above steps failed to install. Installing kubeadm, kubelet and kubectl again
    install kubelet kubeadm kubectl ipvsadm
    ```
    cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
    [kubernetes]
    name=Kubernetes
    baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
    enabled=1
    gpgcheck=1
    repo_gpgcheck=1
    gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
    exclude=kubelet kubeadm kubectl
    EOF
    # Set SELinux in permissive mode (effectively disabling it)
    sudo setenforce 0
    sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

    sudo yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes

    sudo systemctl enable --now kubelet
    sudo yum install -y ipvsadm
    ```
    install kubernetes-cni
    - aarch64 
    ```
    cat <<EOF > /etc/yum.repos.d/kubernetes.repo
    [kubernetes]
    name=Kubernetes
    baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-aarch64
    enabled=1
    gpgcheck=1
    repo_gpgcheck=1
    gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
    EOF
    yum clean all
    yum install kubernetes-cni -y
    ```
 - fix  missing file /run/flannel/subnet.env
    ```
    echo"FLANNEL_NETWORK=10.244.0.0/16
    FLANNEL_SUBNET=10.224.0.1/24
    FLANNEL_MTU=1450
    FLANNEL_IPMASQ=true">/run/flannel/subnet.env
    ```
 - start docker kubelet
    ```
    systemctl daemon-reload
    systemctl restart docker.service
    systemctl enable docker
    systemctl enable kubelet.service
    systemctl start docker
    systemctl start kubelet
    ```
- run the shell
    - in master
        - glone script
            - `git clone https://github.com/HANXU2018/kubernetes_f30_demo/`
            - `cd kubernetes_f30_demo`
            - `sh start_cloud.sh`
    - after install
        - check it
            - `kubectl get nodes`
                ```
                [root@master kubernetes_f30_demo]# kubectl get nodes
                NAME     STATUS   ROLES    AGE    VERSION
                blue     Ready    <none>   34s    v1.18.4
                green    Ready    <none>   46s    v1.18.8
                master   Ready    master   103s   v1.18.4
                ```
            - `kubectl get pods --all-namespaces`
                ```
                [root@master ~]# kubectl get pods --all-namespaces
                NAMESPACE     NAME                             READY   STATUS    RESTARTS   AGE
                kube-system   coredns-66bff467f8-k6f82         1/1     Running   0          89s
                kube-system   coredns-66bff467f8-vf2qg         1/1     Running   0          89s
                kube-system   etcd-master                      1/1     Running   0          86s
                kube-system   kube-apiserver-master            1/1     Running   0          86s
                kube-system   kube-controller-manager-master   1/1     Running   0          86s
                kube-system   kube-proxy-kkgd9                 1/1     Running   0          30s
                kube-system   kube-proxy-pjk4v                 1/1     Running   0          42s
                kube-system   kube-proxy-x88tt                 1/1     Running   0          89s
                kube-system   kube-scheduler-master            1/1     Running   0          86s
                kube-system   weave-net-dwxgm                  1/2     Running   0          30s
                kube-system   weave-net-m5chx                  2/2     Running   0          42s
                kube-system   weave-net-vrkx2                  2/2     Running   0          89s
                ```
        - demo test
            