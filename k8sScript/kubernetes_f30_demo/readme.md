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
                    -  journalctl -f -u kubelet
                        ```
                        [root@ecs-1f5b-0002-7eea ~]#  journalctl -f -u kubelet
                        -- Logs begin at Fri 2020-01-03 11:16:18 CST. --
                        Aug 23 21:57:24 ecs-1f5b-0002-7eea kubelet[18080]:         {
                        Aug 23 21:57:24 ecs-1f5b-0002-7eea kubelet[18080]:             "type": "portmap",
                        Aug 23 21:57:24 ecs-1f5b-0002-7eea kubelet[18080]:             "capabilities": {"portMappings": true},
                        Aug 23 21:57:24 ecs-1f5b-0002-7eea kubelet[18080]:             "snat": true
                        Aug 23 21:57:24 ecs-1f5b-0002-7eea kubelet[18080]:         }
                        Aug 23 21:57:24 ecs-1f5b-0002-7eea kubelet[18080]:     ]
                        Aug 23 21:57:24 ecs-1f5b-0002-7eea kubelet[18080]: }
                        Aug 23 21:57:24 ecs-1f5b-0002-7eea kubelet[18080]: : [failed to find plugin "portmap" in path [/opt/cni/bin]]
                        Aug 23 21:57:24 ecs-1f5b-0002-7eea kubelet[18080]: W0823 21:57:24.122210   18080 cni.go:237] Unable to update cni config: no valid networks found in /etc/cni/net.d
                        Aug 23 21:57:24 ecs-1f5b-0002-7eea kubelet[18080]: E0823 21:57:24.172225   18080 kubelet.go:2188] Container runtime network not ready: NetworkReady=false reason:NetworkPluginNotReady message:docker: network plugin is not ready: cni config uninitialized
                        Aug 23 21:57:29 ecs-1f5b-0002-7eea kubelet[18080]: W0823 21:57:29.133833   18080 cni.go:202] Error validating CNI config list {
                        Aug 23 21:57:29 ecs-1f5b-0002-7eea kubelet[18080]:     "cniVersion": "0.3.0",
                        Aug 23 21:57:29 ecs-1f5b-0002-7eea kubelet[18080]:     "name": "weave",
                        Aug 23 21:57:29 ecs-1f5b-0002-7eea kubelet[18080]:     "plugins": [
                        Aug 23 21:57:29 ecs-1f5b-0002-7eea kubelet[18080]:         {
                        Aug 23 21:57:29 ecs-1f5b-0002-7eea kubelet[18080]:             "name": "weave",
                        Aug 23 21:57:29 ecs-1f5b-0002-7eea kubelet[18080]:             "type": "weave-net",
                        Aug 23 21:57:29 ecs-1f5b-0002-7eea kubelet[18080]:             "hairpinMode": true
                        Aug 23 21:57:29 ecs-1f5b-0002-7eea kubelet[18080]:         },
                        Aug 23 21:57:29 ecs-1f5b-0002-7eea kubelet[18080]:         {
                        Aug 23 21:57:29 ecs-1f5b-0002-7eea kubelet[18080]:             "type": "portmap",
                        Aug 23 21:57:29 ecs-1f5b-0002-7eea kubelet[18080]:             "capabilities": {"portMappings": true},
                        Aug 23 21:57:29 ecs-1f5b-0002-7eea kubelet[18080]:             "snat": true
                        Aug 23 21:57:29 ecs-1f5b-0002-7eea kubelet[18080]:         }
                        Aug 23 21:57:29 ecs-1f5b-0002-7eea kubelet[18080]:     ]
                        Aug 23 21:57:29 ecs-1f5b-0002-7eea kubelet[18080]: }
                        ```
                        - fix 
                            ```

                            kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
                            ```
                    - kubectl get pod --all-namespaces
                        ```
                        [root@master ~]# kubectl get pod --all-namespaces
                        NAMESPACE     NAME                                         READY   STATUS             RESTARTS   AGE
                        kube-system   coredns-66bff467f8-8h52z                     0/1     Pending            0          18m
                        kube-system   coredns-66bff467f8-vrkpc                     0/1     Pending            0          18m
                        kube-system   etcd-ecs-1f5b-0002-7eea                      1/1     Running            0          18m
                        kube-system   kube-apiserver-ecs-1f5b-0002-7eea            1/1     Running            0          18m
                        kube-system   kube-controller-manager-ecs-1f5b-0002-7eea   1/1     Running            0          18m
                        kube-system   kube-flannel-ds-arm64-6mpqj                  0/1     CrashLoopBackOff   4          2m25s
                        kube-system   kube-proxy-7994l                             1/1     Running            0          18m
                        kube-system   kube-scheduler-ecs-1f5b-0002-7eea            1/1     Running            0          18m
                        kube-system   weave-net-lm5kf                              2/2     Running            0          18m
                        ```
                        - fix 
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
                            - new error
                                ```
                                31544 cni.go:309] CNI failed to retrieve network namespace path: cannot find network namespace for the terminated c
                                ```
                                - fix 
                                    ```
                                    kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
                                    ```
                                - new error 
                                    ```
                                    [root@master ~]# journalctl -f -u kubelet
                                    -- Logs begin at Fri 2020-01-03 11:16:18 CST. --
                                    Aug 24 00:39:46 master kubelet[13195]: E0824 00:39:46.701792   13195 pod_workers.go:191] Error syncing pod b6ee96e7-63d6-40dc-b0a4-241acbb38761 ("coredns-66bff467f8-8h52z_kube-system(b6ee96e7-63d6-40dc-b0a4-241acbb38761)"), skipping: failed to "CreatePodSandbox" for "coredns-66bff467f8-8h52z_kube-system(b6ee96e7-63d6-40dc-b0a4-241acbb38761)" with CreatePodSandboxError: "CreatePodSandbox for pod \"coredns-66bff467f8-8h52z_kube-system(b6ee96e7-63d6-40dc-b0a4-241acbb38761)\" failed: rpc error: code = Unknown desc = failed to set up sandbox container \"4553bf6516f9fefafa490ad83218f27199123088e9efe3b3b47cb0082312f524\" network for pod \"coredns-66bff467f8-8h52z\": networkPlugin cni failed to set up pod \"coredns-66bff467f8-8h52z_kube-system\" network: open /run/flannel/subnet.env: no such file or directory"
                                    Aug 24 00:39:46 master kubelet[13195]: E0824 00:39:46.791354   13195 docker_sandbox.go:570] Failed to retrieve checkpoint for sandbox "6106e30606b50eda3ed6ee45e536adfedb841b6175fe355a2ceb14c33819a05d": checkpoint is not found
                                    Aug 24 00:39:46 master kubelet[13195]: W0824 00:39:46.797579   13195 docker_sandbox.go:400] failed to read pod IP from plugin/docker: networkPlugin cni failed on the status hook for pod "coredns-66bff467f8-vrkpc_kube-system": CNI failed to retrieve network namespace path: cannot find network namespace for the terminated container "0f82c59df8ee4ab9955efeba195d3d6504311af3fa0de3e8e6b9614eaadab7a5"
                                    Aug 24 00:39:46 master kubelet[13195]: W0824 00:39:46.798901   13195 pod_container_deletor.go:77] Container "0f82c59df8ee4ab9955efeba195d3d6504311af3fa0de3e8e6b9614eaadab7a5" not found in pod's containers
                                    Aug 24 00:39:46 master kubelet[13195]: W0824 00:39:46.803699   13195 cni.go:331] CNI failed to retrieve network namespace path: cannot find network namespace for the terminated container "0f82c59df8ee4ab9955efeba195d3d6504311af3fa0de3e8e6b9614eaadab7a5"
                                    Aug 24 00:39:46 master kubelet[13195]: W0824 00:39:46.809477   13195 docker_sandbox.go:400] failed to read pod IP from plugin/docker: networkPlugin cni failed on the status hook for pod "coredns-66bff467f8-8h52z_kube-system": CNI failed to retrieve network namespace path: cannot find network namespace for the terminated container "4553bf6516f9fefafa490ad83218f27199123088e9efe3b3b47cb0082312f524"
                                    Aug 24 00:39:46 master kubelet[13195]: W0824 00:39:46.828772   13195 docker_sandbox.go:400] failed to read pod IP from plugin/docker: networkPlugin cni failed on the status hook for pod "coredns-66bff467f8-8h52z_kube-system": CNI failed to retrieve network namespace path: Error: No such container: 6a4ebb8b80f6e7b8f9aec6077e017e522d55cb5edc3aff0f8d5e512700395178

                                    ```
                                    - fix 
                                        ```
                                        kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
                                        ```
                                        - new error
                                            ```
                                            [root@master ~]# systemctl status kubelet
                                            ● kubelet.service - kubelet: The Kubernetes Node Agent
                                            Loaded: loaded (/usr/lib/systemd/system/kubelet.service; enabled; vendor preset: disabled)
                                            Drop-In: /usr/lib/systemd/system/kubelet.service.d
                                                    └─10-kubeadm.conf
                                            Active: active (running) since Sun 2020-08-23 23:46:19 CST; 1h 4min ago
                                                Docs: https://kubernetes.io/docs/
                                            Main PID: 13195 (kubelet)
                                                Tasks: 67 (limit: 4625)
                                            Memory: 45.7M
                                            CGroup: /system.slice/kubelet.service
                                                    ├─12929 /opt/cni/bin/portmap
                                                    ├─12967 /usr/sbin/ip6tables -t nat -S CNI-HOSTPORT-DNAT --wait
                                                    └─13195 /usr/bin/kubelet --bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --kubeconfig=/etc/kubernetes/kubelet.conf --config=/var/lib/kubelet/config.yaml ->

                                            Aug 24 00:51:09 master kubelet[13195]: E0824 00:51:09.195702   13195 remote_runtime.go:105] RunPodSandbox from runtime service failed: rpc error: code = Unknown desc = failed to s>
                                            Aug 24 00:51:09 master kubelet[13195]: E0824 00:51:09.195758   13195 kuberuntime_sandbox.go:68] CreatePodSandbox for pod "coredns-66bff467f8-vrkpc_kube-system(a88e8892-eac0-40be-8>
                                            Aug 24 00:51:09 master kubelet[13195]: E0824 00:51:09.195775   13195 kuberuntime_manager.go:727] createPodSandbox for pod "coredns-66bff467f8-vrkpc_kube-system(a88e8892-eac0-40be->
                                            Aug 24 00:51:09 master kubelet[13195]: E0824 00:51:09.195847   13195 pod_workers.go:191] Error syncing pod a88e8892-eac0-40be-8c46-6b9235c282fd ("coredns-66bff467f8-vrkpc_kube-sys>
                                            Aug 24 00:51:09 master kubelet[13195]: W0824 00:51:09.283607   13195 docker_sandbox.go:400] failed to read pod IP from plugin/docker: networkPlugin cni failed on the status hook f>
                                            Aug 24 00:51:09 master kubelet[13195]: W0824 00:51:09.289350   13195 pod_container_deletor.go:77] Container "bddec61269831a5a425a0737a5fa0870f9d7fcf5194641ebfae868629b92c8f7" not >
                                            Aug 24 00:51:09 master kubelet[13195]: W0824 00:51:09.292117   13195 cni.go:331] CNI failed to retrieve network namespace path: cannot find network namespace for the terminated co>
                                            Aug 24 00:51:09 master kubelet[13195]: W0824 00:51:09.297926   13195 docker_sandbox.go:400] failed to read pod IP from plugin/docker: networkPlugin cni failed on the status hook f>
                                            Aug 24 00:51:09 master kubelet[13195]: W0824 00:51:09.304808   13195 pod_container_deletor.go:77] Container "0dec1e11019b59810d009a504b49f099b6fa1fa7a1a8c1b334c229d7ab336c13" not >
                                            Aug 24 00:51:09 master kubelet[13195]: W0824 00:51:09.307044   13195 cni.go:331] CNI failed to retrieve network namespace path: cannot find network namespace for the terminated co>
                                            lines 1-24/24 (END
                                            ```
                                            ```
                                            et.conf --kubeconfig=/etc/kubernetes/kubelet.conf --config=/var/lib/kubelet/config.yaml --cgroup-driver=cgroupfs --network-plugin=cni --pod-infra-container-image=k8s.gcr.io/pause:>

                                            ] RunPodSandbox from runtime service failed: rpc error: code = Unknown desc = failed to set up sandbox container "bddec61269831a5a425a0737a5fa0870f9d7fcf5194641ebfae868629b92c8f7">
                                            o:68] CreatePodSandbox for pod "coredns-66bff467f8-vrkpc_kube-system(a88e8892-eac0-40be-8c46-6b9235c282fd)" failed: rpc error: code = Unknown desc = failed to set up sandbox conta>
                                            o:727] createPodSandbox for pod "coredns-66bff467f8-vrkpc_kube-system(a88e8892-eac0-40be-8c46-6b9235c282fd)" failed: rpc error: code = Unknown desc = failed to set up sandbox cont>
                                            rror syncing pod a88e8892-eac0-40be-8c46-6b9235c282fd ("coredns-66bff467f8-vrkpc_kube-system(a88e8892-eac0-40be-8c46-6b9235c282fd)"), skipping: failed to "CreatePodSandbox" for "c>
                                            ] failed to read pod IP from plugin/docker: networkPlugin cni failed on the status hook for pod "coredns-66bff467f8-vrkpc_kube-system": CNI failed to retrieve network namespace pa>
                                            .go:77] Container "bddec61269831a5a425a0737a5fa0870f9d7fcf5194641ebfae868629b92c8f7" not found in pod's containers
                                            d to retrieve network namespace path: cannot find network namespace for the terminated container "bddec61269831a5a425a0737a5fa0870f9d7fcf5194641ebfae868629b92c8f7"
                                            ] failed to read pod IP from plugin/docker: networkPlugin cni failed on the status hook for pod "coredns-66bff467f8-8h52z_kube-system": CNI failed to retrieve network namespace pa>
                                            .go:77] Container "0dec1e11019b59810d009a504b49f099b6fa1fa7a1a8c1b334c229d7ab336c13" not found in pod's containers
                                            d to retrieve network namespace path: cannot find network namespace for the terminated container "0dec1e11019b59810d009a504b49f099b6fa1fa7a1a8c1b334c229d7ab336c13"

                                            ```
                                          - fix restart docker
                                            ```
                                            systemctl daemon-reload
                                            systemctl restart docker.service
                                            ```
                                            get info
                                            ```
                                            [root@master ~]# kubectl get nodes
                                            NAME                 STATUS   ROLES    AGE   VERSION
                                            ecs-1f5b-0002-7eea   Ready    master   68m   v1.18.8
                                            ```
        - docker start with server
            ```
            systemctl enable docker
            systemctl enable kubelet.service
            systemctl start docker
            systemctl start kubelet
            ```
        - run start_cloud.sh
            ```
            [root@master kubernetes_f30_demo]# sh start_cloud.sh
            PING green (192.168.0.118) 56(84) bytes of data.
            64 bytes from green (192.168.0.118): icmp_seq=1 ttl=64 time=0.360 ms

            --- green ping statistics ---
            1 packets transmitted, 1 received, 0% packet loss, time 0ms
            rtt min/avg/max/mdev = 0.360/0.360/0.360/0.000 ms
            PING blue (192.168.0.65) 56(84) bytes of data.
            64 bytes from blue (192.168.0.65): icmp_seq=1 ttl=64 time=0.565 ms

            --- blue ping statistics ---
            1 packets transmitted, 1 received, 0% packet loss, time 0ms
            rtt min/avg/max/mdev = 0.565/0.565/0.565/0.000 ms
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
            {"level":"warn","ts":"2020-08-24T00:57:09.462+0800","caller":"clientv3/retry_interceptor.go:61","msg":"retrying of unary invoker failed","target":"endpoint://client-2970029f-e1a1-4                                                    7b5-8972-ad904e84e2e8/192.168.0.112:2379","attempt":0,"error":"rpc error: code = Unknown desc = etcdserver: re-configuration failed due to not enough started members"}
            {"level":"warn","ts":"2020-08-24T00:57:09.517+0800","caller":"clientv3/retry_interceptor.go:61","msg":"retrying of unary invoker failed","target":"endpoint://client-2970029f-e1a1-4                                                    7b5-8972-ad904e84e2e8/192.168.0.112:2379","attempt":0,"error":"rpc error: code = Unknown desc = etcdserver: re-configuration failed due to not enough started members"}
            {"level":"warn","ts":"2020-08-24T00:57:09.630+0800","caller":"clientv3/retry_interceptor.go:61","msg":"retrying of unary invoker failed","target":"endpoint://client-2970029f-e1a1-4                                                    7b5-8972-ad904e84e2e8/192.168.0.112:2379","attempt":0,"error":"rpc error: code = Unknown desc = etcdserver: re-configuration failed due to not enough started members"}
            {"level":"warn","ts":"2020-08-24T00:57:09.844+0800","caller":"clientv3/retry_interceptor.go:61","msg":"retrying of unary invoker failed","target":"endpoint://client-2970029f-e1a1-4                                                    7b5-8972-ad904e84e2e8/192.168.0.112:2379","attempt":0,"error":"rpc error: code = Unknown desc = etcdserver: re-configuration failed due to not enough started members"}
            {"level":"warn","ts":"2020-08-24T00:57:10.263+0800","caller":"clientv3/retry_interceptor.go:61","msg":"retrying of unary invoker failed","target":"endpoint://client-2970029f-e1a1-4                                                    7b5-8972-ad904e84e2e8/192.168.0.112:2379","attempt":0,"error":"rpc error: code = Unknown desc = etcdserver: re-configuration failed due to not enough started members"}
            {"level":"warn","ts":"2020-08-24T00:57:11.098+0800","caller":"clientv3/retry_interceptor.go:61","msg":"retrying of unary invoker failed","target":"endpoint://client-2970029f-e1a1-4                                                    7b5-8972-ad904e84e2e8/192.168.0.112:2379","attempt":0,"error":"rpc error: code = Unknown desc = etcdserver: re-configuration failed due to not enough started members"}
            {"level":"warn","ts":"2020-08-24T00:57:12.809+0800","caller":"clientv3/retry_interceptor.go:61","msg":"retrying of unary invoker failed","target":"endpoint://client-2970029f-e1a1-4                                                    7b5-8972-ad904e84e2e8/192.168.0.112:2379","attempt":0,"error":"rpc error: code = Unknown desc = etcdserver: re-configuration failed due to not enough started members"}
            {"level":"warn","ts":"2020-08-24T00:57:16.036+0800","caller":"clientv3/retry_interceptor.go:61","msg":"retrying of unary invoker failed","target":"endpoint://client-2970029f-e1a1-4                                                    7b5-8972-ad904e84e2e8/192.168.0.112:2379","attempt":0,"error":"rpc error: code = Unknown desc = etcdserver: re-configuration failed due to not enough started members"}
            {"level":"warn","ts":"2020-08-24T00:57:22.537+0800","caller":"clientv3/retry_interceptor.go:61","msg":"retrying of unary invoker failed","target":"endpoint://client-2970029f-e1a1-4                                                    7b5-8972-ad904e84e2e8/192.168.0.112:2379","attempt":0,"error":"rpc error: code = Unknown desc = etcdserver: re-configuration failed due to not enough started members"}
            {"level":"warn","ts":"2020-08-24T00:57:35.462+0800","caller":"clientv3/retry_interceptor.go:61","msg":"retrying of unary invoker failed","target":"endpoint://client-2970029f-e1a1-4                                                    7b5-8972-ad904e84e2e8/192.168.0.112:2379","attempt":0,"error":"rpc error: code = Unknown desc = etcdserver: re-configuration failed due to not enough started members"}
            {"level":"warn","ts":"2020-08-24T00:58:01.835+0800","caller":"clientv3/retry_interceptor.go:61","msg":"retrying of unary invoker failed","target":"endpoint://client-2970029f-e1a1-4                                                    7b5-8972-ad904e84e2e8/192.168.0.112:2379","attempt":0,"error":"rpc error: code = Unknown desc = etcdserver: re-configuration failed due to not enough started members"}
            W0824 00:58:01.835976    2422 removeetcdmember.go:61] [reset] failed to remove etcd member: etcdserver: re-configuration failed due to not enough started members
            .Please manually remove this etcd member using etcdctl
            [reset] Stopping the kubelet service
            [reset] Unmounting mounted directories in "/var/lib/kubelet"
            [reset] Deleting contents of config directories: [/etc/kubernetes/manifests /etc/kubernetes/pki]
            [reset] Deleting files: [/etc/kubernetes/admin.conf /etc/kubernetes/kubelet.conf /etc/kubernetes/bootstrap-kubelet.conf /etc/kubernetes/controller-manager.conf /etc/kubernetes/sche                                                    duler.conf]
            [reset] Deleting contents of stateful directories: [/var/lib/etcd /var/lib/kubelet /var/lib/dockershim /var/run/kubernetes /var/lib/cni]

            The reset process does not clean CNI configuration. To do so, you must remove /etc/cni/net.d

            The reset process does not reset or clean up iptables rules or IPVS tables.
            If you wish to reset iptables, you must do so manually by using the "iptables" command.

            If your cluster was setup to utilize IPVS, run ipvsadm --clear (or similar)
            to reset your system's IPVS tables.

            The reset process does not clean your kubeconfig files and you must remove them manually.
            Please, check the contents of the $HOME/.kube/config file.

            starting with kubeadm init!!!

            W0824 00:58:15.010270   16910 configset.go:202] WARNING: kubeadm cannot validate component configs for API groups [kubelet.config.k8s.io kubeproxy.config.k8s.io]
            [init] Using Kubernetes version: v1.18.8
            [preflight] Running pre-flight checks
                    [WARNING Service-Docker]: docker service is not enabled, please run 'systemctl enable docker.service'
                    [WARNING IsDockerSystemdCheck]: detected "cgroupfs" as the Docker cgroup driver. The recommended driver is "systemd". Please follow the guide at https://kubernetes.io/docs/                                                    setup/cri/
            [preflight] Pulling images required for setting up a Kubernetes cluster
            [preflight] This might take a minute or two, depending on the speed of your internet connection
            [preflight] You can also perform this action in beforehand using 'kubeadm config images pull'
            [kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
            [kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
            [kubelet-start] Starting the kubelet
            [certs] Using certificateDir folder "/etc/kubernetes/pki"
            [certs] Generating "ca" certificate and key
            [certs] Generating "apiserver" certificate and key
            [certs] apiserver serving cert is signed for DNS names [master kubernetes kubernetes.default kubernetes.default.svc kubernetes.default.svc.cluster.local] and IPs [10.96.0.1 192.168                                                    .0.112]
            [certs] Generating "apiserver-kubelet-client" certificate and key
            [certs] Generating "front-proxy-ca" certificate and key
            [certs] Generating "front-proxy-client" certificate and key
            [certs] Generating "etcd/ca" certificate and key
            [certs] Generating "etcd/server" certificate and key
            [certs] etcd/server serving cert is signed for DNS names [master localhost] and IPs [192.168.0.112 127.0.0.1 ::1]
            [certs] Generating "etcd/peer" certificate and key
            [certs] etcd/peer serving cert is signed for DNS names [master localhost] and IPs [192.168.0.112 127.0.0.1 ::1]
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
            W0824 00:58:20.360056   16910 manifests.go:225] the default kube-apiserver authorization-mode is "Node,RBAC"; using "Node,RBAC"
            [control-plane] Creating static Pod manifest for "kube-scheduler"
            W0824 00:58:20.361303   16910 manifests.go:225] the default kube-apiserver authorization-mode is "Node,RBAC"; using "Node,RBAC"
            [etcd] Creating static Pod manifest for local etcd in "/etc/kubernetes/manifests"
            [wait-control-plane] Waiting for the kubelet to boot up the control plane as static Pods from directory "/etc/kubernetes/manifests". This can take up to 4m0s
            [apiclient] All control plane components are healthy after 25.502078 seconds
            [upload-config] Storing the configuration used in ConfigMap "kubeadm-config" in the "kube-system" Namespace
            [kubelet] Creating a ConfigMap "kubelet-config-1.18" in namespace kube-system with the configuration for the kubelets in the cluster
            [upload-certs] Skipping phase. Please see --upload-certs
            [mark-control-plane] Marking the node master as control-plane by adding the label "node-role.kubernetes.io/master=''"
            [mark-control-plane] Marking the node master as control-plane by adding the taints [node-role.kubernetes.io/master:NoSchedule]
            [bootstrap-token] Using token: mzxxwt.3bqw0rifzuhl3m5d
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

            kubeadm join 192.168.0.112:6443 --token mzxxwt.3bqw0rifzuhl3m5d \
                --discovery-token-ca-cert-hash sha256:3339124acb4577015e5894023b1c4840b74c16e69e9fb58c2436850aeff4b2db
            admin.conf                                                                                                                                        100% 5453    24.0MB/s   00:00
            serviceaccount/weave-net created
            clusterrole.rbac.authorization.k8s.io/weave-net created
            clusterrolebinding.rbac.authorization.k8s.io/weave-net created
            role.rbac.authorization.k8s.io/weave-net created
            rolebinding.rbac.authorization.k8s.io/weave-net created
            daemonset.apps/weave-net created

            Checking master

            master ready...
            NAME     STATUS   ROLES    AGE   VERSION
            master   Ready    master   4s    v1.18.4
            W0824 00:58:49.201503   18432 configset.go:202] WARNING: kubeadm cannot validate component configs for API groups [kubelet.config.k8s.io kubeproxy.config.k8s.io]
            Using: kubeadm join 192.168.0.112:6443 --token 8ajb2m.0n33ba6l6570jg8g     --discovery-token-ca-cert-hash sha256:3339124acb4577015e5894023b1c4840b74c16e69e9fb58c2436850aeff4b2db
            [preflight] Running pre-flight checks
            W0824 00:58:49.733897    5133 removeetcdmember.go:79] [reset] No kubeadm config, using etcd pod spec to get data directory
            [reset] No etcd config found. Assuming external etcd
            [reset] Please, manually reset etcd to prevent further issues
            [reset] Stopping the kubelet service
            [reset] Unmounting mounted directories in "/var/lib/kubelet"
            W0824 00:58:49.743341    5133 cleanupnode.go:99] [reset] Failed to evaluate the "/var/lib/kubelet" directory. Skipping its unmount and cleanup: lstat /var/lib/kubelet: no such file                                                     or directory
            [reset] Deleting contents of config directories: [/etc/kubernetes/manifests /etc/kubernetes/pki]
            [reset] Deleting files: [/etc/kubernetes/admin.conf /etc/kubernetes/kubelet.conf /etc/kubernetes/bootstrap-kubelet.conf /etc/kubernetes/controller-manager.conf /etc/kubernetes/sche                                                    duler.conf]
            [reset] Deleting contents of stateful directories: [/var/lib/dockershim /var/run/kubernetes /var/lib/cni]

            The reset process does not clean CNI configuration. To do so, you must remove /etc/cni/net.d

            The reset process does not reset or clean up iptables rules or IPVS tables.
            If you wish to reset iptables, you must do so manually by using the "iptables" command.

            If your cluster was setup to utilize IPVS, run ipvsadm --clear (or similar)
            to reset your system's IPVS tables.

            The reset process does not clean your kubeconfig files and you must remove them manually.
            Please, check the contents of the $HOME/.kube/config file.
            setenforce: SELinux is disabled
            [preflight] Running pre-flight checks
            W0824 00:58:52.057710    5204 removeetcdmember.go:79] [reset] No kubeadm config, using etcd pod spec to get data directory
            [reset] No etcd config found. Assuming external etcd
            [reset] Please, manually reset etcd to prevent further issues
            [reset] Stopping the kubelet service
            [reset] Unmounting mounted directories in "/var/lib/kubelet"
            W0824 00:58:52.066977    5204 cleanupnode.go:99] [reset] Failed to evaluate the "/var/lib/kubelet" directory. Skipping its unmount and cleanup: lstat /var/lib/kubelet: no such file                                                     or directory
            [reset] Deleting contents of config directories: [/etc/kubernetes/manifests /etc/kubernetes/pki]
            [reset] Deleting files: [/etc/kubernetes/admin.conf /etc/kubernetes/kubelet.conf /etc/kubernetes/bootstrap-kubelet.conf /etc/kubernetes/controller-manager.conf /etc/kubernetes/sche                                                    duler.conf]
            [reset] Deleting contents of stateful directories: [/var/lib/dockershim /var/run/kubernetes /var/lib/cni]

            The reset process does not clean CNI configuration. To do so, you must remove /etc/cni/net.d

            The reset process does not reset or clean up iptables rules or IPVS tables.
            If you wish to reset iptables, you must do so manually by using the "iptables" command.

            If your cluster was setup to utilize IPVS, run ipvsadm --clear (or similar)
            to reset your system's IPVS tables.

            The reset process does not clean your kubeconfig files and you must remove them manually.
            Please, check the contents of the $HOME/.kube/config file.
            setenforce: SELinux is disabled
            W0824 00:58:54.172290    5296 join.go:346] [preflight] WARNING: JoinControlPane.controlPlane settings will be ignored when control-plane flag is not set.
            [preflight] Running pre-flight checks
                    [WARNING Service-Docker]: docker service is not enabled, please run 'systemctl enable docker.service'
                    [WARNING IsDockerSystemdCheck]: detected "cgroupfs" as the Docker cgroup driver. The recommended driver is "systemd". Please follow the guide at https://kubernetes.io/docs/                                                    setup/cri/
            [preflight] Reading configuration from the cluster...
            [preflight] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -oyaml'
            [kubelet-start] Downloading configuration for the kubelet from the "kubelet-config-1.18" ConfigMap in the kube-system namespace
            [kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
            [kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
            [kubelet-start] Starting the kubelet
            [kubelet-start] Waiting for the kubelet to perform the TLS Bootstrap...

            This node has joined the cluster:
            * Certificate signing request was sent to apiserver and a response was received.
            * The Kubelet was informed of the new secure connection details.

            Run 'kubectl get nodes' on the control-plane to see this node join the cluster.

            [preflight] Running pre-flight checks
            W0824 00:59:05.651720    5368 join.go:346] [preflight] WARNING: JoinControlPane.controlPlane settings will be ignored when control-plane flag is not set.
                    [WARNING Service-Docker]: docker service is not enabled, please run 'systemctl enable docker.service'
                    [WARNING IsDockerSystemdCheck]: detected "cgroupfs" as the Docker cgroup driver. The recommended driver is "systemd". Please follow the guide at https://kubernetes.io/docs/                                                    setup/cri/
            [preflight] Reading configuration from the cluster...
            [preflight] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -oyaml'
            [kubelet-start] Downloading configuration for the kubelet from the "kubelet-config-1.18" ConfigMap in the kube-system namespace
            [kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
            [kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
            [kubelet-start] Starting the kubelet
            [kubelet-start] Waiting for the kubelet to perform the TLS Bootstrap...

            This node has joined the cluster:
            * Certificate signing request was sent to apiserver and a response was received.
            * The Kubelet was informed of the new secure connection details.

            Run 'kubectl get nodes' on the control-plane to see this node join the cluster.


            Checking nodes

            NAME            STATUS     ROLES    AGE   VERSION
            ecs-1f5b-0001   NotReady   <none>   12s   v1.18.8
            ecs-1f5b-0002   NotReady   <none>   1s    v1.18.8
            master          Ready      master   33s   v1.18.4

            ```
            - green and blue not Ready
                ```
                [root@master kubernetes_f30_demo]# kubectl get nodes
                NAME            STATUS     ROLES    AGE     VERSION
                ecs-1f5b-0001   NotReady   <none>   7m53s   v1.18.8
                ecs-1f5b-0002   NotReady   <none>   7m42s   v1.18.8
                master          Ready      master   8m14s   v1.18.4
                ```
                - fix in node
                    - install kubernetes-cni
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
                    - restart docker
                        ```
                        systemctl daemon-reload
                        systemctl restart docker.service
                        ```
                    - get info
                        ```
                        [root@master kubernetes_f30_demo]# kubectl get nodes
                        NAME            STATUS     ROLES    AGE     VERSION
                        ecs-1f5b-0001   NotReady   <none>   8m16s   v1.18.8
                        ecs-1f5b-0002   Ready      <none>   8m5s    v1.18.8
                        master          Ready      master   8m37s   v1.18.4
                        ```
                        Repeat the above solution
                        ```
                        [root@master ~]# kubectl get nodes
                        NAME            STATUS   ROLES    AGE   VERSION
                        ecs-1f5b-0001   Ready    <none>   13m   v1.18.8
                        ecs-1f5b-0002   Ready    <none>   13m   v1.18.8
                        master          Ready    master   14m   v1.18.4
                        ```
            -  coredns-66bff467f8-8jx6x--0/1--ContainerCreating
                - kubectl get pod --all-namespaces
                    ```
                    [root@master ~]# kubectl get pod --all-namespaces
                    NAMESPACE              NAME                                         READY   STATUS              RESTARTS   AGE
                    kube-system            coredns-66bff467f8-8jx6x                     0/1     ContainerCreating   0          147m
                    kube-system            coredns-66bff467f8-rbsf6                     0/1     ContainerCreating   0          147m
                    kube-system            etcd-master                                  1/1     Running             0          147m
                    kube-system            kube-apiserver-master                        1/1     Running             0          147m
                    kube-system            kube-controller-manager-master               1/1     Running             0          147m
                    kube-system            kube-proxy-jdcsd                             1/1     Running             2          147m
                    kube-system            kube-proxy-tqbxm                             1/1     Running             0          147m
                    kube-system            kube-proxy-txl5p                             1/1     Running             1          147m
                    kube-system            kube-scheduler-master                        1/1     Running             0          147m
                    kube-system            weave-net-4jgcg                              2/2     Running             4          147m
                    kube-system            weave-net-85kh2                              2/2     Running             3          147m
                    kube-system            weave-net-mbwkd                              2/2     Running             0          147m
                    kubernetes-dashboard   dashboard-metrics-scraper-66b49655d4-nw4bd   0/1     CrashLoopBackOff    29         127m
                    kubernetes-dashboard   kubernetes-dashboard-74b4487bfc-8sn78        1/1     Running             0          127m
                    ```
                - kubectl describe po coredns-66bff467f8-8jx6x -n kube-system
                    ```
                    [root@master ~]# kubectl describe po coredns-66bff467f8-8jx6x -n kube-system
                    Name:                 coredns-66bff467f8-8jx6x
                    Namespace:            kube-system
                    Priority:             2000000000
                    Priority Class Name:  system-cluster-critical
                    Node:                 master/192.168.0.112
                    Start Time:           Mon, 24 Aug 2020 00:58:56 +0800
                    Labels:               k8s-app=kube-dns
                                        pod-template-hash=66bff467f8
                    Annotations:          <none>
                    Status:               Pending
                    IP:
                    IPs:                  <none>
                    Controlled By:        ReplicaSet/coredns-66bff467f8
                    Containers:
                    coredns:
                        Container ID:
                        Image:         k8s.gcr.io/coredns:1.6.7
                        Image ID:
                        Ports:         53/UDP, 53/TCP, 9153/TCP
                        Host Ports:    0/UDP, 0/TCP, 0/TCP
                        Args:
                        -conf
                        /etc/coredns/Corefile
                        State:          Waiting
                        Reason:       ContainerCreating
                        Ready:          False
                        Restart Count:  0
                        Limits:
                        memory:  170Mi
                        Requests:
                        cpu:        100m
                        memory:     70Mi
                        Liveness:     http-get http://:8080/health delay=60s timeout=5s period=10s #success=1 #failure=5
                        Readiness:    http-get http://:8181/ready delay=0s timeout=1s period=10s #success=1 #failure=3
                        Environment:  <none>
                        Mounts:
                        /etc/coredns from config-volume (ro)
                        /var/run/secrets/kubernetes.io/serviceaccount from coredns-token-vdr2h (ro)
                    Conditions:
                    Type              Status
                    Initialized       True
                    Ready             False
                    ContainersReady   False
                    PodScheduled      True
                    Volumes:
                    config-volume:
                        Type:      ConfigMap (a volume populated by a ConfigMap)
                        Name:      coredns
                        Optional:  false
                    coredns-token-vdr2h:
                        Type:        Secret (a volume populated by a Secret)
                        SecretName:  coredns-token-vdr2h
                        Optional:    false
                    QoS Class:       Burstable
                    Node-Selectors:  kubernetes.io/os=linux
                    Tolerations:     CriticalAddonsOnly
                                    node-role.kubernetes.io/master:NoSchedule
                                    node.kubernetes.io/not-ready:NoExecute for 300s
                                    node.kubernetes.io/unreachable:NoExecute for 300s
                    Events:
                    Type     Reason                  Age                      From             Message
                    ----     ------                  ----                     ----             -------
                    Normal   SandboxChanged          12m (x7071 over 147m)    kubelet, master  Pod sandbox changed, it will b                                                                                                    e killed and re-created.
                    Warning  FailedCreatePodSandBox  2m27s (x7585 over 147m)  kubelet, master  (combined from similar events)                                                                                                    : Failed to create pod sandbox: rpc error: code = Unknown desc = failed to set up sandbox container "a86aa2                                                                                                    126e5e196093c77097197b5ae5775907605e51ab8f8ffdab2232402476" network for pod "coredns-66bff467f8-8jx6x": net                                                                                                    workPlugin cni failed to set up pod "coredns-66bff467f8-8jx6x_kube-system" network: open /run/flannel/subne                                                                                                    t.env: no such file or directory

                    ```
                - fix  missing file /run/flannel/subnet.env
                    ```
                    echo"FLANNEL_NETWORK=10.244.0.0/16
                    FLANNEL_SUBNET=10.224.0.1/24
                    FLANNEL_MTU=1450
                    FLANNEL_IPMASQ=true">/run/flannel/subnet.env
                    ```
                - kubectl get pod --all-namespaces
                    ```
                    [root@master ~]# kubectl get pod --all-namespaces
                    NAMESPACE              NAME                                         READY   STATUS             RESTARTS   AGE
                    kube-system            coredns-66bff467f8-8jx6x                     0/1     Running            0          150m
                    kube-system            coredns-66bff467f8-rbsf6                     0/1     Running            0          150m
                    kube-system            etcd-master                                  1/1     Running            0          150m
                    kube-system            kube-apiserver-master                        1/1     Running            0          150m
                    kube-system            kube-controller-manager-master               1/1     Running            0          150m
                    kube-system            kube-proxy-jdcsd                             1/1     Running            2          150m
                    kube-system            kube-proxy-tqbxm                             1/1     Running            0          150m
                    kube-system            kube-proxy-txl5p                             1/1     Running            1          150m
                    kube-system            kube-scheduler-master                        1/1     Running            0          150m
                    kube-system            weave-net-4jgcg                              2/2     Running            4          150m
                    kube-system            weave-net-85kh2                              2/2     Running            3          150m
                    kube-system            weave-net-mbwkd                              2/2     Running            0          150m
                    kubernetes-dashboard   dashboard-metrics-scraper-66b49655d4-nw4bd   0/1     CrashLoopBackOff   30         130m
                    kubernetes-dashboard   kubernetes-dashboard-74b4487bfc-8sn78        1/1     Running            0          130m
                    ```
                - kubectl describe po coredns-66bff467f8-8jx6x -n kube-system
                    ```
                    [root@master ~]# kubectl describe po coredns-66bff467f8-8jx6x -n kube-system
                    Name:                 coredns-66bff467f8-8jx6x
                    Namespace:            kube-system
                    Priority:             2000000000
                    Priority Class Name:  system-cluster-critical
                    Node:                 master/192.168.0.112
                    Start Time:           Mon, 24 Aug 2020 00:58:56 +0800
                    Labels:               k8s-app=kube-dns
                                        pod-template-hash=66bff467f8
                    Annotations:          <none>
                    Status:               Running
                    IP:                   10.224.0.2
                    IPs:
                    IP:           10.224.0.2
                    Controlled By:  ReplicaSet/coredns-66bff467f8
                    Containers:
                    coredns:
                        Container ID:  docker://a342db1ad5e7f2f45200cbc3bbf6d8109482e50e9d2cc80d771269d54ad026c1
                        Image:         k8s.gcr.io/coredns:1.6.7
                        Image ID:      docker-pullable://k8s.gcr.io/coredns@sha256:2c8d61c46f484d881db43b34d13ca47a269336e576c81cf007ca740fa9ec0800
                        Ports:         53/UDP, 53/TCP, 9153/TCP
                        Host Ports:    0/UDP, 0/TCP, 0/TCP
                        Args:
                        -conf
                        /etc/coredns/Corefile
                        State:          Running
                        Started:      Mon, 24 Aug 2020 03:29:26 +0800
                        Ready:          False
                        Restart Count:  0
                        Limits:
                        memory:  170Mi
                        Requests:
                        cpu:        100m
                        memory:     70Mi
                        Liveness:     http-get http://:8080/health delay=60s timeout=5s period=10s #success=1 #failure=5
                        Readiness:    http-get http://:8181/ready delay=0s timeout=1s period=10s #success=1 #failure=3
                        Environment:  <none>
                        Mounts:
                        /etc/coredns from config-volume (ro)
                        /var/run/secrets/kubernetes.io/serviceaccount from coredns-token-vdr2h (ro)
                    Conditions:
                    Type              Status
                    Initialized       True
                    Ready             False
                    ContainersReady   False
                    PodScheduled      True
                    Volumes:
                    config-volume:
                        Type:      ConfigMap (a volume populated by a ConfigMap)
                        Name:      coredns
                        Optional:  false
                    coredns-token-vdr2h:
                        Type:        Secret (a volume populated by a Secret)
                        SecretName:  coredns-token-vdr2h
                        Optional:    false
                    QoS Class:       Burstable
                    Node-Selectors:  kubernetes.io/os=linux
                    Tolerations:     CriticalAddonsOnly
                                    node-role.kubernetes.io/master:NoSchedule
                                    node.kubernetes.io/not-ready:NoExecute for 300s
                                    node.kubernetes.io/unreachable:NoExecute for 300s
                    Events:
                    Type     Reason                  Age                      From             Message
                    ----     ------                  ----                     ----             -------
                    Normal   SandboxChanged          20m (x7071 over 155m)    kubelet, master  Pod sandbox changed, it will be killed and re-created.
                    Warning  FailedCreatePodSandBox  5m10s (x7841 over 154m)  kubelet, master  (combined from similar events): Failed to create pod sandbox: rpc error: code = Unknown desc = failed to set up sandbox container "54714b63e853684353864cfcdd451e39acc925518a6088cc5d7d506a30594e9f" network for pod "coredns-66bff467f8-8jx6x": networkPlugin cni failed to set up pod "coredns-66bff467f8-8jx6x_kube-system" network: open /run/flannel/subnet.env: no such file or directory
                    Warning  Unhealthy               1s (x29 over 4m41s)      kubelet, master  Readiness probe failed: HTTP probe failed with statuscode: 503
                    ```
                - search coredns logs 
                    ```
                    for p in $(kubectl get pods --namespace=kube-system -l k8s-app=kube-dns -o name); do kubectl logs --namespace=kube-system $p; done
                    ```
                    the same error as [coredns/coredns/issues/How to resolve that issue ? Readiness probe failed: HTTP probe failed with statuscode: 503 #3411](https://github.com/coredns/coredns/issues/3411)
                    - remove wrong dash-board
                        ```
                        kubernetes-dashboard   dashboard-metrics-scraper-66b49655d4-nw4bd   0/1     CrashLoopBackOff   30         130m
                        kubernetes-dashboard   kubernetes-dashboard-74b4487bfc-8sn78        1/1     Running            0          130m
                        ```
                        - `kubectl delete deployment  dashboard-metrics-scraper  -n kubernetes-dashboard`
                        - `kubectl delete deployment  kubernetes-dashboard  -n kubernetes-dashboard`
                        ```
                        [root@master ~]# kubectl get pod -n kubernetes-dashboard
                        NAME                                         READY   STATUS             RESTARTS   AGE
                        dashboard-metrics-scraper-66b49655d4-nw4bd   0/1     CrashLoopBackOff   40         3h5m
                        kubernetes-dashboard-74b4487bfc-8sn78        1/1     Running            0          3h5m
                        [root@master ~]# kubectl delete pod dashboard-metrics-scraper-66b49655d4-nw4bd -n kubernetes-dashboard
                        pod "dashboard-metrics-scraper-66b49655d4-nw4bd" deleted
                        [root@master ~]# kubectl delete pod kubernetes-dashboard-74b4487bfc-8sn78  -n kubernetes-dashboard
                        pod "kubernetes-dashboard-74b4487bfc-8sn78" deleted
                        [root@master ~]# kubectl get pod -n kubernetes-dashboard
                        NAME                                         READY   STATUS              RESTARTS   AGE
                        dashboard-metrics-scraper-66b49655d4-jc2hd   0/1     CrashLoopBackOff    1          24s
                        kubernetes-dashboard-74b4487bfc-r2x4b        0/1     ContainerCreating   0          5s
                        [root@master ~]# kubectl get deployment -n kubernetes-dashboard
                        NAME                        READY   UP-TO-DATE   AVAILABLE   AGE
                        dashboard-metrics-scraper   0/1     1            0           3h6m
                        kubernetes-dashboard        1/1     1            1           3h6m
                        [root@master ~]# kubectl delete deployment  dashboard-metrics-scraper  -n kubernetes-dashboard
                        deployment.apps "dashboard-metrics-scraper" deleted
                        [root@master ~]# kubectl delete deployment  kubernetes-dashboard  -n kubernetes-dashboard
                        deployment.apps "kubernetes-dashboard" deleted
                        [root@master ~]# kubectl get deployment -n kubernetes-dashboard
                        No resources found in kubernetes-dashboard namespace.
                        [root@master ~]# kubectl get pod -n kubernetes-dashboard
                        No resources found in kubernetes-dashboard namespace.
                        [root@master ~]# kubectl get pod -n --all-namespaces
                        No resources found in --all-namespaces namespace.
                        [root@master ~]# kubectl get pod --all-namespaces
                        NAMESPACE     NAME                                   READY   STATUS             RESTARTS   AGE
                        kube-system   coredns-66bff467f8-8jx6x               1/1     Running            0          3h28m
                        kube-system   coredns-66bff467f8-rbsf6               1/1     Running            0          3h28m
                        kube-system   etcd-master                            1/1     Running            0          3h28m
                        kube-system   kube-apiserver-master                  1/1     Running            0          3h28m
                        kube-system   kube-controller-manager-master         1/1     Running            0          3h28m
                        kube-system   kube-proxy-jdcsd                       1/1     Running            2          3h28m
                        kube-system   kube-proxy-tqbxm                       1/1     Running            0          3h28m
                        kube-system   kube-proxy-txl5p                       1/1     Running            1          3h27m
                        kube-system   kube-scheduler-master                  1/1     Running            0          3h28m
                        kube-system   kubernetes-dashboard-9bd985584-lzw95   0/1     CrashLoopBackOff   6          7m17s
                        kube-system   weave-net-4jgcg                        2/2     Running            4          3h28m
                        kube-system   weave-net-85kh2                        2/2     Running            3          3h27m
                        kube-system   weave-net-mbwkd                        2/2     Running            0          3h28m
                        ```
                        - the coredns Status is Running but Still not healthy
                        ```
                        
                        [root@master ~]# kubectl describe po coredns-66bff467f8-8jx6x -n kube-system
                        Name:                 coredns-66bff467f8-8jx6x
                        Namespace:            kube-system
                        Priority:             2000000000
                        Priority Class Name:  system-cluster-critical
                        Node:                 master/192.168.0.112
                        Start Time:           Mon, 24 Aug 2020 00:58:56 +0800
                        Labels:               k8s-app=kube-dns
                                            pod-template-hash=66bff467f8
                        Annotations:          <none>
                        Status:               Running
                        IP:                   10.224.0.2
                        IPs:
                        IP:           10.224.0.2
                        Controlled By:  ReplicaSet/coredns-66bff467f8
                        Containers:
                        coredns:
                            Container ID:  docker://a342db1ad5e7f2f45200cbc3bbf6d8109482e50e9d2cc80d771269d54ad026c1
                            Image:         k8s.gcr.io/coredns:1.6.7
                            Image ID:      docker-pullable://k8s.gcr.io/coredns@sha256:2c8d61c46f484d881db43b34d13ca47a269336e576c81cf007ca740fa9ec0800
                            Ports:         53/UDP, 53/TCP, 9153/TCP
                            Host Ports:    0/UDP, 0/TCP, 0/TCP
                            Args:
                            -conf
                            /etc/coredns/Corefile
                            State:          Running
                            Started:      Mon, 24 Aug 2020 03:29:26 +0800
                            Ready:          True
                            Restart Count:  0
                            Limits:
                            memory:  170Mi
                            Requests:
                            cpu:        100m
                            memory:     70Mi
                            Liveness:     http-get http://:8080/health delay=60s timeout=5s period=10s #success=1 #failure=5
                            Readiness:    http-get http://:8181/ready delay=0s timeout=1s period=10s #success=1 #failure=3
                            Environment:  <none>
                            Mounts:
                            /etc/coredns from config-volume (ro)
                            /var/run/secrets/kubernetes.io/serviceaccount from coredns-token-vdr2h (ro)
                        Conditions:
                        Type              Status
                        Initialized       True
                        Ready             True
                        ContainersReady   True
                        PodScheduled      True
                        Volumes:
                        config-volume:
                            Type:      ConfigMap (a volume populated by a ConfigMap)
                            Name:      coredns
                            Optional:  false
                        coredns-token-vdr2h:
                            Type:        Secret (a volume populated by a Secret)
                            SecretName:  coredns-token-vdr2h
                            Optional:    false
                        QoS Class:       Burstable
                        Node-Selectors:  kubernetes.io/os=linux
                        Tolerations:     CriticalAddonsOnly
                                        node-role.kubernetes.io/master:NoSchedule
                                        node.kubernetes.io/not-ready:NoExecute for 300s
                                        node.kubernetes.io/unreachable:NoExecute for 300s
                        Events:
                        Type     Reason     Age                  From             Message
                        ----     ------     ----                 ----             -------
                        Warning  Unhealthy  20m (x239 over 60m)  kubelet, master  Readiness probe failed: HTTP probe failed with statuscode: 503

                        ```
                        
