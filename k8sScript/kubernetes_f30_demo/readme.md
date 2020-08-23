# install log
- DNS config
    ```
    echo "192.168.0.112 master
    192.168.0.65 blue
    192.168.0.118 green" >> /etc/hosts
    ```
- SSH access
    ```
        ssh-keygen -t rsa -C "1076998404@qq.com
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
    - log
    ```
        [root@ecs-1f5b-0002-7eea kubernetes_f30_demo]# ssh-keygen -t rsa -C "10769984@qq.com"

        Generating public/private rsa key pair.
        Enter file in which to save the key (/root/.ssh/id_rsa):
        Enter passphrase (empty for no passphrase):
        Enter same passphrase again:
        Your identification has been saved in /root/.ssh/id_rsa.
        Your public key has been saved in /root/.ssh/id_rsa.pub.
        The key fingerprint is:
        SHA256:OGXmVk09pgzHFt4+d3DGRZKey9NCbwCliq17EWXW2IU 10769984@qq.com
        The key's randomart image is:
        +---[RSA 2048]----+
        |           .oBo=+|
        |          .+XoEo.|
        |        + .O+=oo+|
        |       * +..o.=+ |
        |      o S o. oo=o|
        |       o ..   =o=|
        |        .  .   + |
        |         ..      |
        |        ..       |
        +----[SHA256]-----+
        [root@ecs-1f5b-0002-7eea kubernetes_f30_demo]#
        [root@ecs-1f5b-0002-7eea kubernetes_f30_demo]# ssh-copy-id root@master
        /usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/root/.ssh/id_rsa.pub"
        /usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
        /usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
        root@master's password:

        Number of key(s) added: 1

        Now try logging into the machine, with:   "ssh 'root@master'"
        and check to make sure that only the key(s) you wanted were added.

        [root@ecs-1f5b-0002-7eea kubernetes_f30_demo]# ssh-copy-id root@blue
        /usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/root/.ssh/id_rsa.pub"
        The authenticity of host 'blue (192.168.0.65)' can't be established.
        ECDSA key fingerprint is SHA256:AW64DQPu8/3k4Km7nmG9V/XIf0+UpbqMfrHxcJVA0sw.
        Are you sure you want to continue connecting (yes/no)? yes
        /usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
        /usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
        root@blue's password:

        Number of key(s) added: 1

        Now try logging into the machine, with:   "ssh 'root@blue'"
        and check to make sure that only the key(s) you wanted were added.

        [root@ecs-1f5b-0002-7eea kubernetes_f30_demo]# ssh-copy-id root@green
        /usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/root/.ssh/id_rsa.pub"
        The authenticity of host 'green (192.168.0.118)' can't be established.
        ECDSA key fingerprint is SHA256:yhiPxjcy2BfHAXYR09LcnblJAHcW3F1ljS6kPxLje14.
        Are you sure you want to continue connecting (yes/no)? yes
        /usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
        /usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
        root@green's password:
        Connection closed by 192.168.0.118 port 22
        [root@ecs-1f5b-0002-7eea kubernetes_f30_demo]# ssh-copy-id root@green
        /usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/root/.ssh/id_rsa.pub"
        /usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
        /usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
        root@green's password:

        Number of key(s) added: 1

        Now try logging into the machine, with:   "ssh 'root@green'"
        and check to make sure that only the key(s) you wanted were added.

    ```
- glone script
    - `git clone https://github.com/HANXU2018/kubernetes_f30_demo/`
    - `cd kubernetes_f30_demo`
- run  start_cloud.sh
    - log
        ```
            [root@ecs-1f5b-0002-7eea kubernetes_f30_demo]# ls
            kubernetes.repo  README.md       start_master.sh  stop_cloud.sh
            LICENSE          start_cloud.sh  start_nodes.sh   weave-kube.yaml
            [root@ecs-1f5b-0002-7eea kubernetes_f30_demo]# sh start_cloud.sh
            PING green (192.168.0.118) 56(84) bytes of data.
            64 bytes from green (192.168.0.118): icmp_seq=1 ttl=64 time=0.306 ms

            --- green ping statistics ---
            1 packets transmitted, 1 received, 0% packet loss, time 0ms
            rtt min/avg/max/mdev = 0.306/0.306/0.306/0.000 ms
            PING blue (192.168.0.65) 56(84) bytes of data.
            64 bytes from blue (192.168.0.65): icmp_seq=1 ttl=64 time=0.263 ms

            --- blue ping statistics ---
            1 packets transmitted, 1 received, 0% packet loss, time 0ms
            rtt min/avg/max/mdev = 0.263/0.263/0.263/0.000 ms
            PING master (192.168.0.112) 56(84) bytes of data.
            64 bytes from master (192.168.0.112): icmp_seq=1 ttl=64 time=0.016 ms

            --- master ping statistics ---
            1 packets transmitted, 1 received, 0% packet loss, time 0ms
            rtt min/avg/max/mdev = 0.016/0.016/0.016/0.000 ms
            Redirecting to /bin/systemctl start rngd.service
            bash: kubeadm: command not found
            bash: ipvsadm: command not found

            starting with kubeadm init!!!

            bash: kubeadm: command not found
            scp: /etc/kubernetes/admin.conf: No such file or directory
            chown: cannot access '/root/.kube/config': No such file or directory
            start_cloud.sh: line 42: kubectl: command not found

            Checking master

            start_cloud.sh: line 49: kubectl: command not found
            master ready...
            start_cloud.sh: line 56: kubectl: command not found
            cp: cannot stat '/etc/kubernetes/admin.conf': No such file or directory
            bash: kubeadm: command not found
            Using:
            bash: kubeadm: command not found
            setenforce: SELinux is disabled
            bash: ipvsadm: command not found
            bash: kubeadm: command not found
            setenforce: SELinux is disabled
            bash: ipvsadm: command not found

                    Welcome to Huawei Cloud Service

            Web console: https://host-192-168-0-118:9090/ or https://192.168.0.118:9090/

        ```
        - Installing kubeadm
            - Letting iptables see bridged traffic
                ```
                    cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
                    net.bridge.bridge-nf-call-ip6tables = 1
                    net.bridge.bridge-nf-call-iptables = 1
                    EOF
                    sudo sysctl --system
                ```
            - Installing runtime
                - `curl -fsSL https://get.docker.com | bash -s docker`
            - start docker
                ```
                systemctl daemon-reload
                systemctl restart docker.service
                ```
            - Installing kubeadm, kubelet and kubectl
                - Install CNI plugins (required for most pod network):
                    ```
                        CNI_VERSION="v0.8.2"
                        sudo mkdir -p /opt/cni/bin
                        curl -L "https://github.com/containernetworking/plugins/releases/download/${CNI_VERSION}/cni-plugins-linux-amd64-${CNI_VERSION}.tgz" | sudo tar -C /opt/cni/bin -xz
                    ```
                - Define the directory to download command files
                    ```
                        DOWNLOAD_DIR=/usr/local/bin
                        sudo mkdir -p $DOWNLOAD_DIR
                    ```
                - Install crictl (required for kubeadm / Kubelet Container Runtime Interface (CRI))
                    ```
                        CRICTL_VERSION="v1.17.0"
                        curl -L "https://github.com/kubernetes-sigs/cri-tools/releases/download/${CRICTL_VERSION}/crictl-${CRICTL_VERSION}-linux-amd64.tar.gz" | sudo tar -C $DOWNLOAD_DIR -xz
                    ```
                - Install kubeadm, kubelet, kubectl and add a kubelet systemd service:
                    ```
                        RELEASE="$(curl -sSL https://dl.k8s.io/release/stable.txt)"
                        cd $DOWNLOAD_DIR
                        sudo curl -L --remote-name-all https://storage.googleapis.com/kubernetes-release/release/${RELEASE}/bin/linux/amd64/{kubeadm,kubelet,kubectl}
                        sudo chmod +x {kubeadm,kubelet,kubectl}

                        RELEASE_VERSION="v0.2.7"
                        curl -sSL "https://raw.githubusercontent.com/kubernetes/release/${RELEASE_VERSION}/cmd/kubepkg/templates/latest/deb/kubelet/lib/systemd/system/kubelet.service" | sed "s:/usr/bin:${DOWNLOAD_DIR}:g" | sudo tee /etc/systemd/system/kubelet.service
                        sudo mkdir -p /etc/systemd/system/kubelet.service.d
                        curl -sSL "https://raw.githubusercontent.com/kubernetes/release/${RELEASE_VERSION}/cmd/kubepkg/templates/latest/deb/kubeadm/10-kubeadm.conf" | sed "s:/usr/bin:${DOWNLOAD_DIR}:g" | sudo tee /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
                    ```
                - Enable and start kubelet:
                    ```
                        systemctl enable --now kubelet
                    ```
            - run 
                - log
                    ```
                        [root@ecs-1f5b-0002-7eea kubernetes_f30_demo]# sh start_cloud.sh
                        PING green (192.168.0.118) 56(84) bytes of data.
                        64 bytes from green (192.168.0.118): icmp_seq=1 ttl=64 time=0.679 ms

                        --- green ping statistics ---
                        1 packets transmitted, 1 received, 0% packet loss, time 0ms
                        rtt min/avg/max/mdev = 0.679/0.679/0.679/0.000 ms
                        PING blue (192.168.0.65) 56(84) bytes of data.
                        64 bytes from blue (192.168.0.65): icmp_seq=1 ttl=64 time=0.494 ms

                        --- blue ping statistics ---
                        1 packets transmitted, 1 received, 0% packet loss, time 0ms
                        rtt min/avg/max/mdev = 0.494/0.494/0.494/0.000 ms
                        PING master (192.168.0.112) 56(84) bytes of data.
                        64 bytes from master (192.168.0.112): icmp_seq=1 ttl=64 time=0.023 ms

                        --- master ping statistics ---
                        1 packets transmitted, 1 received, 0% packet loss, time 0ms
                        rtt min/avg/max/mdev = 0.023/0.023/0.023/0.000 ms
                        Redirecting to /bin/systemctl start rngd.service
                        bash: /usr/local/bin/kubeadm: cannot execute binary file: Exec format error
                        bash: ipvsadm: command not found

                        starting with kubeadm init!!!

                        bash: /usr/local/bin/kubeadm: cannot execute binary file: Exec format error
                        scp: /etc/kubernetes/admin.conf: No such file or directory
                        chown: cannot access '/root/.kube/config': No such file or directory
                        start_cloud.sh: line 42: /usr/local/bin/kubectl: cannot execute binary file: Exec format erro                                                                                                                  r

                        Checking master

                        start_cloud.sh: line 49: /usr/local/bin/kubectl: cannot execute binary file: Exec format erro                                                                                                                  r
                        master ready...
                        start_cloud.sh: line 56: /usr/local/bin/kubectl: cannot execute binary file: Exec format erro                                                                                                                  r
                        cp: cannot stat '/etc/kubernetes/admin.conf': No such file or directory
                        bash: /usr/local/bin/kubeadm: cannot execute binary file: Exec format error
                        Using:
                        bash: kubeadm: command not found
                        setenforce: SELinux is disabled
                        bash: ipvsadm: command not found
                        bash: kubeadm: command not found
                        setenforce: SELinux is disabled
                        bash: ipvsadm: command not found

                                Welcome to Huawei Cloud Service

                        Web console: https://host-192-168-0-118:9090/ or https://192.168.0.118:9090/

                        Last login: Sun Aug 23 19:27:50 2020 from 192.168.0.112
                    ```
            - Installing kubeadm, kubelet and kubectl again
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



            ```
                yum -y install --enablerepo=updates-testing kubernetes kubeadm
                yum -y install etcd iptables
            ```