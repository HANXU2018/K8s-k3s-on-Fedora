# install log
- DNS config
    ```
    echo "192.168.0.112 master
    192.168.0.65 blue
    192.168.0.118 green" >> /etc/hosts
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
            - The above steps failed to install. Installing kubeadm, kubelet and kubectl again
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
            - run start_master.sh
                ```
                [root@ecs-1f5b-0002-7eea kubernetes_f30_demo]# sh start_master.sh
                PING green (192.168.0.118) 56(84) bytes of data.
                64 bytes from green (192.168.0.118): icmp_seq=1 ttl=64 time=0.627 ms

                --- green ping statistics ---
                1 packets transmitted, 1 received, 0% packet loss, time 0ms
                rtt min/avg/max/mdev = 0.627/0.627/0.627/0.000 ms
                PING blue (192.168.0.65) 56(84) bytes of data.
                64 bytes from blue (192.168.0.65): icmp_seq=1 ttl=64 time=0.440 ms

                --- blue ping statistics ---
                1 packets transmitted, 1 received, 0% packet loss, time 0ms
                rtt min/avg/max/mdev = 0.440/0.440/0.440/0.000 ms
                PING master (192.168.0.112) 56(84) bytes of data.
                64 bytes from master (192.168.0.112): icmp_seq=1 ttl=64 time=0.027 ms

                --- master ping statistics ---
                1 packets transmitted, 1 received, 0% packet loss, time 0ms
                rtt min/avg/max/mdev = 0.027/0.027/0.027/0.000 ms
                Redirecting to /bin/systemctl start rngd.service
                [reset] Reading configuration from the cluster...
                [reset] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -oyaml'
                [preflight] Running pre-flight checks
                [reset] Removing info for node "ecs-1f5b-0002-7eea" from the ConfigMap "kubeadm-config" in the "kube-system" Namespace
                {"level":"warn","ts":"2020-08-23T21:16:14.957+0800","caller":"clientv3/retry_interceptor.go:61","msg":"retrying of unary invoker failed","target":"endpoint://client-9cf3c37f-55e8-4f90-a280-cff2d43fbb08/192.168.0.112:2379","attempt":0,"error":"rpc error: code = Unknown desc = etcdserver: re-configuration failed due to not enough started members"}
                {"level":"warn","ts":"2020-08-23T21:16:15.011+0800","caller":"clientv3/retry_interceptor.go:61","msg":"retrying of unary invoker failed","target":"endpoint://client-9cf3c37f-55e8-4f90-a280-cff2d43fbb08/192.168.0.112:2379","attempt":0,"error":"rpc error: code = Unknown desc = etcdserver: re-configuration failed due to not enough started members"}
                {"level":"warn","ts":"2020-08-23T21:16:15.121+0800","caller":"clientv3/retry_interceptor.go:61","msg":"retrying of unary invoker failed","target":"endpoint://client-9cf3c37f-55e8-4f90-a280-cff2d43fbb08/192.168.0.112:2379","attempt":0,"error":"rpc error: code = Unknown desc = etcdserver: re-configuration failed due to not enough started members"}
                {"level":"warn","ts":"2020-08-23T21:16:15.335+0800","caller":"clientv3/retry_interceptor.go:61","msg":"retrying of unary invoker failed","target":"endpoint://client-9cf3c37f-55e8-4f90-a280-cff2d43fbb08/192.168.0.112:2379","attempt":0,"error":"rpc error: code = Unknown desc = etcdserver: re-configuration failed due to not enough started members"}
                {"level":"warn","ts":"2020-08-23T21:16:15.754+0800","caller":"clientv3/retry_interceptor.go:61","msg":"retrying of unary invoker failed","target":"endpoint://client-9cf3c37f-55e8-4f90-a280-cff2d43fbb08/192.168.0.112:2379","attempt":0,"error":"rpc error: code = Unknown desc = etcdserver: re-configuration failed due to not enough started members"}
                {"level":"warn","ts":"2020-08-23T21:16:16.589+0800","caller":"clientv3/retry_interceptor.go:61","msg":"retrying of unary invoker failed","target":"endpoint://client-9cf3c37f-55e8-4f90-a280-cff2d43fbb08/192.168.0.112:2379","attempt":0,"error":"rpc error: code = Unknown desc = etcdserver: re-configuration failed due to not enough started members"}
                {"level":"warn","ts":"2020-08-23T21:16:18.300+0800","caller":"clientv3/retry_interceptor.go:61","msg":"retrying of unary invoker failed","target":"endpoint://client-9cf3c37f-55e8-4f90-a280-cff2d43fbb08/192.168.0.112:2379","attempt":0,"error":"rpc error: code = Unknown desc = etcdserver: re-configuration failed due to not enough started members"}
                {"level":"warn","ts":"2020-08-23T21:16:21.522+0800","caller":"clientv3/retry_interceptor.go:61","msg":"retrying of unary invoker failed","target":"endpoint://client-9cf3c37f-55e8-4f90-a280-cff2d43fbb08/192.168.0.112:2379","attempt":0,"error":"rpc error: code = Unknown desc = etcdserver: re-configuration failed due to not enough started members"}
                {"level":"warn","ts":"2020-08-23T21:16:28.023+0800","caller":"clientv3/retry_interceptor.go:61","msg":"retrying of unary invoker failed","target":"endpoint://client-9cf3c37f-55e8-4f90-a280-cff2d43fbb08/192.168.0.112:2379","attempt":0,"error":"rpc error: code = Unknown desc = etcdserver: re-configuration failed due to not enough started members"}
                {"level":"warn","ts":"2020-08-23T21:16:40.948+0800","caller":"clientv3/retry_interceptor.go:61","msg":"retrying of unary invoker failed","target":"endpoint://client-9cf3c37f-55e8-4f90-a280-cff2d43fbb08/192.168.0.112:2379","attempt":0,"error":"rpc error: code = Unknown desc = etcdserver: re-configuration failed due to not enough started members"}
                {"level":"warn","ts":"2020-08-23T21:17:07.319+0800","caller":"clientv3/retry_interceptor.go:61","msg":"retrying of unary invoker failed","target":"endpoint://client-9cf3c37f-55e8-4f90-a280-cff2d43fbb08/192.168.0.112:2379","attempt":0,"error":"rpc error: code = Unknown desc = etcdserver: re-configuration failed due to not enough started members"}
                W0823 21:17:07.319997   16144 removeetcdmember.go:61] [reset] failed to remove etcd member: etcdserver: re-configuration failed due to not enough started members
                .Please manually remove this etcd member using etcdctl
                [reset] Stopping the kubelet service
                [reset] Unmounting mounted directories in "/var/lib/kubelet"
                [reset] Deleting contents of config directories: [/etc/kubernetes/manifests /etc/kubernetes/pki]
                [reset] Deleting files: [/etc/kubernetes/admin.conf /etc/kubernetes/kubelet.conf /etc/kubernetes/bootstrap-kubelet.conf /etc/kubernetes/controller-manager.conf /etc/kubernetes/scheduler.conf]
                [reset] Deleting contents of stateful directories: [/var/lib/etcd /var/lib/kubelet /var/lib/dockershim /var/run/kubernetes /var/lib/cni]

                The reset process does not clean CNI configuration. To do so, you must remove /etc/cni/net.d

                The reset process does not reset or clean up iptables rules or IPVS tables.
                If you wish to reset iptables, you must do so manually by using the "iptables" command.

                If your cluster was setup to utilize IPVS, run ipvsadm --clear (or similar)
                to reset your system's IPVS tables.

                The reset process does not clean your kubeconfig files and you must remove them manually.
                Please, check the contents of the $HOME/.kube/config file.

                starting with kubeadm init!!!

                W0823 21:17:11.546273   16799 configset.go:202] WARNING: kubeadm cannot validate component configs for API groups [kubelet.config.k8s.io kubeproxy.config.k8s.io]
                [init] Using Kubernetes version: v1.18.8
                [preflight] Running pre-flight checks
                        [WARNING Service-Docker]: docker service is not enabled, please run 'systemctl enable docker.service'
                        [WARNING IsDockerSystemdCheck]: detected "cgroupfs" as the Docker cgroup driver. The recommended driver is "systemd". Please follow the guide at https://kubernetes.io/docs/setup/cri/
                [preflight] Pulling images required for setting up a Kubernetes cluster
                [preflight] This might take a minute or two, depending on the speed of your internet connection
                [preflight] You can also perform this action in beforehand using 'kubeadm config images pull'
                [kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
                [kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
                [kubelet-start] Starting the kubelet
                [certs] Using certificateDir folder "/etc/kubernetes/pki"
                [certs] Generating "ca" certificate and key
                [certs] Generating "apiserver" certificate and key
                [certs] apiserver serving cert is signed for DNS names [ecs-1f5b-0002-7eea kubernetes kubernetes.default kubernetes.default.svc kubernetes.default.svc.cluster.local] and IPs [10.96.0.1 192.168.0.112]
                [certs] Generating "apiserver-kubelet-client" certificate and key
                [certs] Generating "front-proxy-ca" certificate and key
                [certs] Generating "front-proxy-client" certificate and key
                [certs] Generating "etcd/ca" certificate and key
                [certs] Generating "etcd/server" certificate and key
                [certs] etcd/server serving cert is signed for DNS names [ecs-1f5b-0002-7eea localhost] and IPs [192.168.0.112 127.0.0.1 ::1]
                [certs] Generating "etcd/peer" certificate and key
                [certs] etcd/peer serving cert is signed for DNS names [ecs-1f5b-0002-7eea localhost] and IPs [192.168.0.112 127.0.0.1 ::1]
                [certs] Generating "etcd/healthcheck-client" certificate and key
                [certs] Generating "apiserver-etcd-client" certificate and key
                [certs] Generating "sa" key and public key
                [kubeconfig] Using kubeconfig folder "/etc/kubernetes"
                [kubeconfig] Writing "admin.conf" kubeconfig file
                [kubeconfig] Writing "kubelet.conf" kubeconfig file
                [kubeconfig] Writing "controller-manager.conf" kubeconfig file
                [kubeconfig] Writing "scheduler.conf" kubeconfig file
                [control-plane] Using manifest folder "/etc/kubernetes/manifests"
                [control-plane] Creating static Pod manifest for "kube-apiserver"
                [control-plane] Creating static Pod manifest for "kube-controller-manager"
                W0823 21:17:17.094172   16799 manifests.go:225] the default kube-apiserver authorization-mode is "Node,RBAC"; using "Node,RBAC"
                [control-plane] Creating static Pod manifest for "kube-scheduler"
                W0823 21:17:17.095368   16799 manifests.go:225] the default kube-apiserver authorization-mode is "Node,RBAC"; using "Node,RBAC"
                [etcd] Creating static Pod manifest for local etcd in "/etc/kubernetes/manifests"
                [wait-control-plane] Waiting for the kubelet to boot up the control plane as static Pods from directory "/etc/kubernetes/manifests". This can take up to 4m0s
                [apiclient] All control plane components are healthy after 24.001969 seconds
                [upload-config] Storing the configuration used in ConfigMap "kubeadm-config" in the "kube-system" Namespace
                [kubelet] Creating a ConfigMap "kubelet-config-1.18" in namespace kube-system with the configuration for the kubelets in the cluster
                [upload-certs] Skipping phase. Please see --upload-certs
                [mark-control-plane] Marking the node ecs-1f5b-0002-7eea as control-plane by adding the label "node-role.kubernetes.io/master=''"
                [mark-control-plane] Marking the node ecs-1f5b-0002-7eea as control-plane by adding the taints [node-role.kubernetes.io/master:NoSchedule]
                [bootstrap-token] Using token: xep2ne.d42w9hjmqfngfaet
                [bootstrap-token] Configuring bootstrap tokens, cluster-info ConfigMap, RBAC Roles
                [bootstrap-token] configured RBAC rules to allow Node Bootstrap tokens to get nodes
                [bootstrap-token] configured RBAC rules to allow Node Bootstrap tokens to post CSRs in order for nodes to get long term certificate credentials
                [bootstrap-token] configured RBAC rules to allow the csrapprover controller automatically approve CSRs from a Node Bootstrap Token
                [bootstrap-token] configured RBAC rules to allow certificate rotation for all node client certificates in the cluster
                [bootstrap-token] Creating the "cluster-info" ConfigMap in the "kube-public" namespace
                [kubelet-finalize] Updating "/etc/kubernetes/kubelet.conf" to point to a rotatable kubelet client certificate and key
                [addons] Applied essential addon: CoreDNS
                [addons] Applied essential addon: kube-proxy

                Your Kubernetes control-plane has initialized successfully!

                To start using your cluster, you need to run the following as a regular user:

                mkdir -p $HOME/.kube
                sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
                sudo chown $(id -u):$(id -g) $HOME/.kube/config

                You should now deploy a pod network to the cluster.
                Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
                https://kubernetes.io/docs/concepts/cluster-administration/addons/

                Then you can join any number of worker nodes by running the following on each as root:

                kubeadm join 192.168.0.112:6443 --token xep2ne.d42w9hjmqfngfaet \
                    --discovery-token-ca-cert-hash sha256:46399b907f659f69b2e023380c4875918e064762c6e4277d9e91c384c03aacd5
                NAME                 STATUS     ROLES    AGE   VERSION
                ecs-1f5b-0002-7eea   NotReady   master   4s    v1.18.8
                serviceaccount/weave-net created
                clusterrole.rbac.authorization.k8s.io/weave-net created
                clusterrolebinding.rbac.authorization.k8s.io/weave-net created
                role.rbac.authorization.k8s.io/weave-net created
                rolebinding.rbac.authorization.k8s.io/weave-net created
                daemonset.apps/weave-net created

                ```
                - There are still error
                    - master node notready
                    ```
                    [root@ecs-1f5b-0002-7eea kubernetes_f30_demo]# kubectl get node
                    NAME                 STATUS     ROLES    AGE   VERSION
                    ecs-1f5b-0002-7eea   NotReady   master   83s   v1.18.8
                    ```
                    - scheduler and  controller-manager Unhealthy                    
                    ```
                    [root@ecs-1f5b-0002-7eea kubernetes_f30_demo]# kubectl get componentstatuses
                    NAME                 STATUS      MESSAGE                                                                                     ERROR
                    scheduler            Unhealthy   Get http://127.0.0.1:10251/healthz: dial tcp 127.0.0.1:10251: connect: connection refused
                    controller-manager   Unhealthy   Get http://127.0.0.1:10252/healthz: dial tcp 127.0.0.1:10252: connect: connection refused
                    etcd-0               Healthy     {"health":"true"}
                    ```
