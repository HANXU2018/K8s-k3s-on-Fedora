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