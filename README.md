# K8s-k3s-on-Fedora
This is  one or at least start a prototype
[![Page Views Count](https://badges.toozhao.com/badges/01EHNQCSK83F1NTKRM1JWKAQTW/green.svg)](https://badges.toozhao.com/badges/01EHNQCSK83F1NTKRM1JWKAQTW/green.svg "Get your own page views count badge on badges.toozhao.com")
## One click setup script
- k3s 
    - [`k3sScript\start_cloud.sh`](https://github.com/HANXU2018/K8s-k3s-on-Fedora/tree/master/k3sScript)
    - using step
    ```
        git clone https://github.com/HANXU2018/K8s-k3s-on-Fedora.git
        cd K8s-k3s-on-Fedora/k3sScript
        sh start_cloud.sh
    ```
- k8s
    - [`k8sScript\start_cloud.sh`](https://github.com/HANXU2018/K8s-k3s-on-Fedora/tree/master/k8sScript)
    - using step
    ```
        git clone https://github.com/HANXU2018/K8s-k3s-on-Fedora.git
        cd K8s-k3s-on-Fedora/k8sScript
        sh start_cloud.sh
    ```
## installation steps
- [k3s install in Fedora29](https://github.com/HANXU2018/K8s-k3s-on-Fedora/tree/master/k3sScript)
    - I used a virtual machine locally to simulate the Fedora32 environment for the installation
        - Many problems arose and many attempts failed
        - For specific questions, please refer to Timeline
        - These questions are about the Cgroup of Fedora32 Network problems and so on
    - Finally give up Fedora32 and use huawei cloud server online
        - Fedora 29 64bit with ARM
        - Renting servers outside Of China avoids the problems of network environment
        - Successful deployment of multiple nodes using k3sup installation tool
## Timeline
- 2020-08-03 Plan to write an installation script for the raspberry PI cluster
    - The tutor's personal environment is 2 core 4G RAM Fedora32 ARM64
    - I personally did not learn ARM environment to simulate, but failed
    - Try to simulate using ARM cloud service resources
    - The tutor believes that X86 and ARM do not affect the experimental condition
    - I'm going to do an experimental simulation of reusing an X86 virtual machine

- 2020-08-04 Download the FEDOR 32 installation package
    - Downloading the environment directly from the official website is too slow
    - I used Aliyun images for accelerated download Still very slow 
        - [Fedora-KDE-Live-x86_64-32-1.6.iso](https://mirrors.tuna.tsinghua.edu.cn/fedora/releases/32/Spins/x86_64/iso/Fedora-KDE-Live-x86_64-32-1.6.iso)
            - An installation environment containing the KDE desktop was used.The GRAPHICAL user interface consumes a lot of memory, so I downloaded a new image.
        - [Fedora-Server-dvd-x86_64-32-1.6.iso](https://mirrors.aliyun.com/fedora/releases/32/Server/x86_64/iso/Fedora-Server-dvd-x86_64-32-1.6.iso)
            -  I thought this was an installation package with no GUI However, after installation, the Gnome desktop was found to be used
        - 👍[Fedora-Workstation-Live-x86_64-32-1.6.iso](https://mirrors.aliyun.com/fedora/releases/32/Workstation/x86_64/iso/Fedora-Workstation-Live-x86_64-32-1.6.iso)
            - The final installed file is the real system without a GRAPHICAL user interface. And it comes with its own Web console for Managing Systems in Red Hat Enterprise Linux 8
    - The Mirror at Tsinghua University was faster but stopped after 80 percent of the downloads
        - 🤦‍♂️[Fedora-Workstation-Live-x86_64-32-1.6.iso](https://mirrors.tuna.tsinghua.edu.cn/fedora/releases/32/Workstation/x86_64/iso/Fedora-Workstation-Live-x86_64-32-1.6.iso)

- 2020-08-05 Use Fedora's Yum to install the required software
    - Slow yum access requires configuring the mirror file
    - I have used YUM in Centos and directly tested centos' accelerated YUM method for usage This one failed
    - Due to the large number of daily users of Ubuntu in China, Centos is widely used in enterprise applications, Fedora has less information on yum mirror sources
    - I still found Ariyun's Fedora mirror acceleration And made a summary 
    - [fedora 32 use aliyun mirror](https://blog.csdn.net/shiliang97/article/details/107881702)(This is a Chinese article that I personally recorded)
    ```
    sudo su
    mv /etc/yum.repos.d/fedora.repo fedora.repo.bak
    mv /etc/yum.repos.d/fedora-updates.repo fedora-updates.repo.bak
    wget -O /etc/yum.repos.d/fedora.repo http://mirrors.aliyun.com/repo/fedora.repo
    wget -O /etc/yum.repos.d/fedora-updates.repo http://mirrors.aliyun.com/repo/fedora-updates.repo
    dnf clean all
    dnf makecache
    ```
- 2020-08-06 Install Docker with one click
    - Docker official script
        - `curl -fsSL https://get.docker.com | bash`
        - Join Ali Cloud Mirror `curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun`
        - Not suitable for Frdora 32
        - 

- 2020-08-10 yum Couldn't open file /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
    - Yum, which is using Fedora for the first time, has this problem
    - I have never had this problem with Centos
    - I solved this problem by querying it (Run the following instruction at the terminal)
    - `rpmkeys --import /etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-32-x86_64`
- 2020-08-10 docekr install and config
    - It is suggested to install VMdocker. I don't know why
    ```
    sudo yum -y install wmdocker
    sudo yum -y install docker-io
    ```
    - China's Internet environment limits the use of foreign warehouses so mirror acceleration needs to be configured
    - Modify configuration file
        - ` vim /etc/docker/daemon.json`
    - Add warehouse address

        - ` {"registry-mirrors": ["https://****.mirror.aliyuncs.com"]}`

    - reload docker
        ```
            systemctl daemon-reload
            systemctl restart docker.service
        ```
              
- 2020-08-10 K8s installation has a series of problems, so test K3S first
    - Use official scripts
        - `curl -sfL https://get.k3s.io | sh -`
        - Official mirror image of China
            - `curl -sfL https://docs.rancher.cn/k3s/k3s-install.sh | INSTALL_K3S_MIRROR=cn sh -`

    - [ERROR]  Failed to find the k3s-selinux policy
        - ```
            [ERROR]  Failed to find the k3s-selinux policy, please install:
            yum install -y container-selinux selinux-policy-base
            rpm -i https://rpm.rancher.io/k3s-selinux-0.1.1-rc1.el7.noarch.rpm
            ```
        - According to the error prompt to execute the command
        - `yum install -y container-selinux selinux-policy-base`
        - `rpm -i https://rpm.rancher.io/k3s-selinux-0.1.1-rc1.el7.noarch.rpm`
            - An error has been reported and the second execution has been successful
            - ```
                [root@192 ~]#   rpm -i https://rpm.rancher.io/k3s-selinux-0.1.1-rc1.el7.noarch.rpm
                curl: (52) Empty reply from server
                error: skipping https://rpm.rancher.io/k3s-selinux-0.1.1-rc1.el7.noarch.rpm - transfer failed
                ```
        -  Reexecuting the installation command successfully
            - `curl -sfL https://docs.rancher.cn/k3s/k3s-install.sh | INSTALL_K3S_MIRROR=cn sh -`
            - ```
                [root@192 ~]# curl -sfL https://docs.rancher.cn/k3s/k3s-install.sh | INSTALL_K3S_MIRROR=cn sh -
                [INFO]  Finding release for channel stable
                [INFO]  Using v1.18.6+k3s1 as release
                [INFO]  Downloading hash https://mirror-k3s.rancher.cn/download/v1.18.6-k3s1/sha256sum-amd64.txt
                [INFO]  Skipping binary downloaded, installed k3s matches hash
                [INFO]  Creating /usr/local/bin/kubectl symlink to k3s
                [INFO]  Creating /usr/local/bin/crictl symlink to k3s
                [INFO]  Skipping /usr/local/bin/ctr symlink to k3s, command exists in PATH at /usr/bin/ctr
                [INFO]  Creating killall script /usr/local/bin/k3s-killall.sh
                [INFO]  Creating uninstall script /usr/local/bin/k3s-uninstall.sh
                [INFO]  env: Creating environment file /etc/systemd/system/k3s.service.env
                [INFO]  systemd: Creating service file /etc/systemd/system/k3s.service
                [INFO]  systemd: Enabling k3s unit
                Created symlink /etc/systemd/system/multi-user.target.wants/k3s.service → /etc/systemd/system/k3s.service.
                [INFO]  systemd: Starting k3s

                ```
            - Test K3S use kubectl get  Node
                - ```
                    [root@192 ~]# kubectl get nodes
                    The connection to the server 127.0.0.1:6443 was refused - did you specify the right host or port?
                    ```
                - Check to see if the service is started
                - ❌ Still not solved
- 2020-08-11 failed to get the kubelet's cgroup: mountpoint for cpu not found
    ```
    kubelet
    I0812 00:17:41.633282   52219 server.go:425] Version: v1.15.8-beta.0
    I0812 00:17:41.633525   52219 plugins.go:103] No cloud provider specified.
    W0812 00:17:41.633542   52219 server.go:564] standalone mode, no API client
    W0812 00:17:41.633582   52219 server.go:628] failed to get the kubelet's cgroup: mountpoint for cpu not found.  Kubelet system container metrics may be missing.
    W0812 00:17:41.634172   52219 server.go:635] failed to get the container runtime's cgroup: failed to get container name for docker process: mountpoint for cpu not found. Runtime system container metrics may be missing.
    F0812 00:17:41.634254   52219 server.go:273] failed to run Kubelet: mountpoint for cpu not found
    ```

    - Fedora 31 uses cgroup V2, a version of cgroup that is not compatible with current docker.
    ```
    [root@192 hanxu]# k3s server
    INFO[2020-08-12T23:33:16.943206376+08:00] Starting k3s v1.18.6+k3s1 (6f56fa1d)
    INFO[2020-08-12T23:33:16.944455823+08:00] Cluster bootstrap already complete
    ...
    ...
    INFO[2020-08-12T23:33:20.784434757+08:00] k3s is up and running
    WARN[2020-08-12T23:33:20.784884309+08:00] Failed to find cpuset cgroup, you may need to add "cgroup_enable=cpuset" to your linux cmdline (/boot/cmdline.txt on a Raspberry Pi)
    ERRO[2020-08-12T23:33:20.785091908+08:00] Failed to find memory cgroup, you may need to add "cgroup_memory=1 cgroup_enable=memory" to your linux cmdline (/boot/cmdline.txt on a Raspberry Pi)
    FATA[2020-08-12T23:33:20.785300136+08:00] failed to find memory cgroup, you may need to add "cgroup_memory=1 cgroup_enable=memory" to your linux cmdline (/boot/cmdline.txt on a Raspberry Pi)
    ```
    - After checking, it was found that docker service did not start
        - ```
            systemctl start docker
            systemctl stop docker
            systemctl restart docker
            systemctl status docker.service
            ```
        - ```
                    [root@192 hanxu]# systemctl status docker.service
            ● docker.service - Docker Application Container Engine
                Loaded: loaded (/usr/lib/systemd/system/docker.service; disabled; vendor preset: disabled)
                Active: inactive (dead)
            TriggeredBy: ● docker.socket
                Docs: https://docs.docker.com
            [root@192 hanxu]# systemctl start docker
            [root@192 hanxu]# 停止
            bash: 停止: command not found
            [root@192 hanxu]# systemctl stop docker
            [root@192 hanxu]# 重启
            bash: 重启: command not found
            [root@192 hanxu]# systemctl restart docker
            [root@192 hanxu]# systemctl status docker.service
            ● docker.service - Docker Application Container Engine
                Loaded: loaded (/usr/lib/systemd/system/docker.service; disabled; vendor preset: disabled)
                Active: active (running) since Wed 2020-08-12 23:41:12 CST; 5s ago
            TriggeredBy: ● docker.socket
                Docs: https://docs.docker.com
            Main PID: 3658 (dockerd)
                Tasks: 17 (limit: 4630)
                Memory: 57.6M
                    CPU: 475ms
                CGroup: /system.slice/docker.service
                        ├─3658 /usr/bin/dockerd --host=fd:// --exec-opt native.cgroupdriver=systemd --selinux-enabled --log-driver=journald --storage-driver=overlay2 --live-restore --default-ulimit nofile=1024:1024 -->
                        └─3664 containerd --config /var/run/docker/containerd/containerd.toml --log-level info

            Aug 12 23:41:11 192.168.0.105 dockerd[3658]: time="2020-08-12T23:41:11.948676169+08:00" level=warning msg="Your kernel does not support cgroup rt period"
            Aug 12 23:41:11 192.168.0.105 dockerd[3658]: time="2020-08-12T23:41:11.948679704+08:00" level=warning msg="Your kernel does not support cgroup rt runtime"
            Aug 12 23:41:11 192.168.0.105 dockerd[3658]: time="2020-08-12T23:41:11.948683119+08:00" level=warning msg="Unable to find blkio cgroup in mounts"
            Aug 12 23:41:11 192.168.0.105 dockerd[3658]: time="2020-08-12T23:41:11.948894312+08:00" level=info msg="Loading containers: start."
            Aug 12 23:41:12 192.168.0.105 dockerd[3658]: time="2020-08-12T23:41:12.231207891+08:00" level=info msg="Default bridge (docker0) is assigned with an IP address 172.17.0.0/16. Daemon option --bip can be used>
            Aug 12 23:41:12 192.168.0.105 dockerd[3658]: time="2020-08-12T23:41:12.343556178+08:00" level=info msg="Loading containers: done."
            Aug 12 23:41:12 192.168.0.105 dockerd[3658]: time="2020-08-12T23:41:12.394285391+08:00" level=info msg="Docker daemon" commit=42e35e6 graphdriver(s)=overlay2 version=19.03.11
            Aug 12 23:41:12 192.168.0.105 dockerd[3658]: time="2020-08-12T23:41:12.394337284+08:00" level=info msg="Daemon has completed initialization"
            Aug 12 23:41:12 192.168.0.105 dockerd[3658]: time="2020-08-12T23:41:12.405452293+08:00" level=info msg="API listen on /run/docker.sock"
            Aug 12 23:41:12 192.168.0.105 systemd[1]: Started Docker Application Container Engine.
            ...skipping...
            ● docker.service - Docker Application Container Engine
                Loaded: loaded (/usr/lib/systemd/system/docker.service; disabled; vendor preset: disabled)
                Active: active (running) since Wed 2020-08-12 23:41:12 CST; 5s ago
            TriggeredBy: ● docker.socket
                Docs: https://docs.docker.com
            Main PID: 3658 (dockerd)
                Tasks: 17 (limit: 4630)
                Memory: 57.6M
                    CPU: 475ms
                CGroup: /system.slice/docker.service
                        ├─3658 /usr/bin/dockerd --host=fd:// --exec-opt native.cgroupdriver=systemd --selinux-enabled --log-driver=journald --storage-driver=overlay2 --live-restore --default-ulimit nofile=1024:1024 -->
                        └─3664 containerd --config /var/run/docker/containerd/containerd.toml --log-level info

            Aug 12 23:41:11 192.168.0.105 dockerd[3658]: time="2020-08-12T23:41:11.948676169+08:00" level=warning msg="Your kernel does not support cgroup rt period"
            Aug 12 23:41:11 192.168.0.105 dockerd[3658]: time="2020-08-12T23:41:11.948679704+08:00" level=warning msg="Your kernel does not support cgroup rt runtime"
            Aug 12 23:41:11 192.168.0.105 dockerd[3658]: time="2020-08-12T23:41:11.948683119+08:00" level=warning msg="Unable to find blkio cgroup in mounts"
            Aug 12 23:41:11 192.168.0.105 dockerd[3658]: time="2020-08-12T23:41:11.948894312+08:00" level=info msg="Loading containers: start."
            Aug 12 23:41:12 192.168.0.105 dockerd[3658]: time="2020-08-12T23:41:12.231207891+08:00" level=info msg="Default bridge (docker0) is assigned with an IP address 172.17.0.0/16. Daemon option --bip can be used>
            Aug 12 23:41:12 192.168.0.105 dockerd[3658]: time="2020-08-12T23:41:12.343556178+08:00" level=info msg="Loading containers: done."
            Aug 12 23:41:12 192.168.0.105 dockerd[3658]: time="2020-08-12T23:41:12.394285391+08:00" level=info msg="Docker daemon" commit=42e35e6 graphdriver(s)=overlay2 version=19.03.11
            Aug 12 23:41:12 192.168.0.105 dockerd[3658]: time="2020-08-12T23:41:12.394337284+08:00" level=info msg="Daemon has completed initialization"
            Aug 12 23:41:12 192.168.0.105 dockerd[3658]: time="2020-08-12T23:41:12.405452293+08:00" level=info msg="API listen on /run/docker.sock"
            Aug 12 23:41:12 192.168.0.105 systemd[1]: Started Docker Application Container Engine.
        ```
    - Rerun command `k3s server`
        - ```
            [root@192 hanxu]# k3s server
            INFO[2020-08-12T23:41:29.717676913+08:00] Starting k3s v1.18.6+k3s1 (6f56fa1d)
            INFO[2020-08-12T23:41:29.718239988+08:00] Cluster bootstrap already complete
            FATA[2020-08-12T23:41:29.727177667+08:00] starting kubernetes: preparing server: start cluster and https: listen tcp :6443: bind: address already in use
            ```
        - To find the information
            - [k3s fails and restarts, Fedora 32 #2105](https://github.com/rancher/k3s/issues/2105)
            - [k3s on pi error - cgroup_memory=1 cgroup_enable=memory #2067](https://github.com/rancher/k3s/issues/2067) 
                - The Contributor brandond  say that :The 64bit kernel does appear to resolve the issue, but I have heard anecdotally that performance on older devices can be a bit lacking. You might be better off sticking with an older 32bit OS on your Pi until they fix the cgroups.
                - Execute the following command to solve the problem
                    ```
                    sudo dnf install -y grubby
                    sudo grubby --update-kernel=ALL --args="systemd.unified_cgroup_hierarchy=0"
                    sudo reboot
                    ```
                    -  k3s get nodes can work
                    ```
                        [root@192 hanxu]# k3s server
                        INFO[2020-08-13T01:00:36.371194086+08:00] Starting k3s v1.18.6+k3s1 (6f56fa1d)
                        INFO[2020-08-13T01:00:36.374592225+08:00] Cluster bootstrap already complete
                        FATA[2020-08-13T01:00:36.391363896+08:00] starting kubernetes: preparing server: start cluster and https: listen tcp :6443: bind: address already in use
                        [root@192 hanxu]# kubectl get nodes
                        NAME            STATUS   ROLES    AGE   VERSION
                        192.168.0.105   Ready    master   10m   v1.18.6+k3s1

                    ```
    - install k3s node
        - get K3S tocken
            - `cat /var/lib/rancher/k3s/server/node-token`
        - install example
            - china mirror
                - `curl -sfL https://docs.rancher.cn/k3s/k3s-install.sh | INSTALL_K3S_MIRROR=cn K3S_URL=https://myserver:6443 K3S_TOKEN=XXX sh -`
                - `curl -sfL https://docs.rancher.cn/k3s/k3s-install.sh | INSTALL_K3S_MIRROR=cn K3S_URL=https://192.168.0.100:6443 K3S_TOKEN=K10358d00a5edb8ef9d2721f92475cc843c0817247ac648867c6c1d8a13770161bb::server:a263241abec744609c05130c1f651c11 sh -`
                - the network is worng 
            - `curl -sfL https://get.k3s.io | K3S_URL=https://myserver:6443 K3S_TOKEN=XXX sh -`

    - I tried something else. I tried k3s up.
        - error Failed to connect to raw.githubusercontent.com port 443: Connection refused
            ```
            [root@192 hanxu]# curl -sLS https://get.k3sup.dev | sh
            curl: (7) Failed to connect to raw.githubusercontent.com port 443: Connection refused
            ```
            - China banned the raw.githubusercontent.com parsing
            -   the solution
                - `sudo vim /etc/hosts`
                - `199.232.28.133 raw.githubusercontent.com`
        -  Error: unable to load the ssh key with path "/root/.ssh/id_rsa": unable to read file: /root/.ssh/id_rsa, open /root/.ssh/id_rsa: no such file or directory
            ```
           [root@ecs-50d1 ~]# k3sup install
            Running: k3sup install
            Public IP: 127.0.0.1
            Error: unable to load the ssh key with path "/root/.ssh/id_rsa": unable to read file: /root/.ssh/id_rsa, open /root/.ssh/id_rsa: no such file or directory
            ```
            - the things i did `ssh-keygen -t rsa -C "1076998404@qq.com"`

                -   Error: unable to connect to 127.0.0.1:22 over ssh: ssh: handshake failed: ssh: unable to authenticate, attempted methods [none publickey], no supported methods 
                     ```
                    [root@ecs-50d1 ~]# ssh-keygen -t rsa -C "1076998404@qq.com"
                    Generating public/private rsa key pair.
                    Enter file in which to save the key (/root/.ssh/id_rsa):
                    Enter passphrase (empty for no passphrase):
                    Enter same passphrase again:
                    Your identification has been saved in /root/.ssh/id_rsa.
                    Your public key has been saved in /root/.ssh/id_rsa.pub.
                    The key fingerprint is:
                    SHA256:r0bh9f+/Iv9OGxMe/XoximApJX9CidAAPBBTwZEr+mo 1076998404@qq.com
                    The key's randomart image is:
                    +---[RSA 2048]----+
                    | +*==.o          |
                    |  .= . .         |
                    |    o . . .      |
                    | . .   o.+.     .|
                    |. .    .So..   o.|
                    |.      .oB .. .o+|
                    | .     .o = ...=+|
                    | E.     .. o oo.=|
                    |o.     ..   o.=B=|
                    +----[SHA256]-----+
                    [root@ecs-50d1 ~]#
                    [root@ecs-50d1 ~]# k3sup install
                    Running: k3sup install
                    Public IP: 127.0.0.1
                    Error: unable to connect to 127.0.0.1:22 over ssh: ssh: handshake failed: ssh: unable to authenticate, attempted methods [none publickey], no supported methods remain
                    ```
                - the solution i test `ssh-copy-id root@127.0.0.1`
                    - the k3sup install successful
                        ```
                        [root@ecs-50d1 ~]# export IP=127.0.0.1
                        [root@ecs-50d1 ~]# k3sup install k3sup install --ip $IP --user root
                        Running: k3sup install
                        Public IP: 127.0.0.1
                        [INFO]  Using v1.18.6+k3s1 as release
                        [INFO]  Downloading hash https://github.com/rancher/k3s/releases/download/v1.18.6+k3s1/sha256sum-arm64.txt
                        [INFO]  Downloading binary https://github.com/rancher/k3s/releases/download/v1.18.6+k3s1/k3s-arm64
                        [INFO]  Verifying binary download
                        [INFO]  Installing k3s to /usr/local/bin/k3s
                        [INFO]  Creating /usr/local/bin/kubectl symlink to k3s
                        [INFO]  Creating /usr/local/bin/crictl symlink to k3s
                        [INFO]  Skipping /usr/local/bin/ctr symlink to k3s, command exists in PATH at /usr/bin/ctr
                        [INFO]  Creating killall script /usr/local/bin/k3s-killall.sh
                        [INFO]  Creating uninstall script /usr/local/bin/k3s-uninstall.sh
                        [INFO]  env: Creating environment file /etc/systemd/system/k3s.service.env
                        [INFO]  systemd: Creating service file /etc/systemd/system/k3s.service
                        [INFO]  systemd: Enabling k3s unit
                        Created symlink /etc/systemd/system/multi-user.target.wants/k3s.service → /etc/systemd/system/k3s.service.
                        [INFO]  systemd: Starting k3s
                        Result: [INFO]  Using v1.18.6+k3s1 as release
                        [INFO]  Downloading hash https://github.com/rancher/k3s/releases/download/v1.18.6+k3s1/sha256sum-arm64.txt
                        [INFO]  Downloading binary https://github.com/rancher/k3s/releases/download/v1.18.6+k3s1/k3s-arm64
                        [INFO]  Verifying binary download
                        [INFO]  Installing k3s to /usr/local/bin/k3s
                        [INFO]  Creating /usr/local/bin/kubectl symlink to k3s
                        [INFO]  Creating /usr/local/bin/crictl symlink to k3s
                        [INFO]  Skipping /usr/local/bin/ctr symlink to k3s, command exists in PATH at /usr/bin/ctr
                        [INFO]  Creating killall script /usr/local/bin/k3s-killall.sh
                        [INFO]  Creating uninstall script /usr/local/bin/k3s-uninstall.sh
                        [INFO]  env: Creating environment file /etc/systemd/system/k3s.service.env
                        [INFO]  systemd: Creating service file /etc/systemd/system/k3s.service
                        [INFO]  systemd: Enabling k3s unit
                        [INFO]  systemd: Starting k3s
                        Created symlink /etc/systemd/system/multi-user.target.wants/k3s.service → /etc/systemd/system/k3s.service.

                        apiVersion: v1
                        clusters:
                        - cluster:
                            certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUJXRENCL3FBREFnRUNBZ0VBTUFvR0NDcUdTTTQ5QkFNQ01DTXhJVEFmQmdOVkJBTU1HR3N6Y3kxelpYSjIKWlhJdFkyRkFNVFU1TnpnMU5UWTVOREFlRncweU1EQTRNVGt4TmpRNE1UUmFGdzB6TURBNE1UY3hOalE0TVRSYQpNQ014SVRBZkJnTlZCQU1NR0dzemN5MXpaWEoyWlhJdFkyRkFNVFU1TnpnMU5UWTVOREJaTUJNR0J5cUdTTTQ5CkFnRUdDQ3FHU000OUF3RUhBMElBQlBXN2ZTUW9BRHR0VzZOcXpzYjhmNXdrSmtOeTFEQnlxMk1HTnQvU2V3MTEKd1IvbGRHcEZPMVliK083QVJmVlZaY2JsTlNyU1pNTytzV0o3ZHg4OU56dWpJekFoTUE0R0ExVWREd0VCL3dRRQpBd0lDcERBUEJnTlZIUk1CQWY4RUJUQURBUUgvTUFvR0NDcUdTTTQ5QkFNQ0Ewa0FNRVlDSVFESFpuWis4cFczCmlaNlBGcEFjeDNFVTh5WWtJeS84ZTduUG5DSGRLQ3JZNGdJaEFPWmRacWNsNEkvZEVYQWpRWGU0dUIweDFqaWYKQ1N0L0NWZkpYUnpaWUhuaQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==
                            server: https://127.0.0.1:6443
                        name: default
                        contexts:
                        - context:
                            cluster: default
                            user: default
                        name: default
                        current-context: default
                        kind: Config
                        preferences: {}
                        users:
                        - name: default
                        user:
                            password: 1715c0e322f72792b70ffc8e08b4acf7
                            username: admin
                        Result: apiVersion: v1
                        clusters:
                        - cluster:
                            certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUJXRENCL3FBREFnRUNBZ0VBTUFvR0NDcUdTTTQ5QkFNQ01DTXhJVEFmQmdOVkJBTU1HR3N6Y3kxelpYSjIKWlhJdFkyRkFNVFU1TnpnMU5UWTVOREFlRncweU1EQTRNVGt4TmpRNE1UUmFGdzB6TURBNE1UY3hOalE0TVRSYQpNQ014SVRBZkJnTlZCQU1NR0dzemN5MXpaWEoyWlhJdFkyRkFNVFU1TnpnMU5UWTVOREJaTUJNR0J5cUdTTTQ5CkFnRUdDQ3FHU000OUF3RUhBMElBQlBXN2ZTUW9BRHR0VzZOcXpzYjhmNXdrSmtOeTFEQnlxMk1HTnQvU2V3MTEKd1IvbGRHcEZPMVliK083QVJmVlZaY2JsTlNyU1pNTytzV0o3ZHg4OU56dWpJekFoTUE0R0ExVWREd0VCL3dRRQpBd0lDcERBUEJnTlZIUk1CQWY4RUJUQURBUUgvTUFvR0NDcUdTTTQ5QkFNQ0Ewa0FNRVlDSVFESFpuWis4cFczCmlaNlBGcEFjeDNFVTh5WWtJeS84ZTduUG5DSGRLQ3JZNGdJaEFPWmRacWNsNEkvZEVYQWpRWGU0dUIweDFqaWYKQ1N0L0NWZkpYUnpaWUhuaQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==
                            server: https://127.0.0.1:6443
                        name: default
                        contexts:
                        - context:
                            cluster: default
                            user: default
                        name: default
                        current-context: default
                        kind: Config
                        preferences: {}
                        users:
                        - name: default
                        user:
                            password: 1715c0e322f72792b70ffc8e08b4acf7
                            username: admin

                        Saving file to: /root/kubeconfig

                        # Test your cluster with:
                        export KUBECONFIG=/root/kubeconfig
                        kubectl get node -o wide

                        ```
        - successful init k3s cluster
            - the step
                - add the IP(in the example i use the Fedora29)
                    - `ssh-copy-id root@192.168.0.139`
                    - `yes`
                    - input the agent password
                    - `export AGENT_IP=192.168.0.139`
                    - `export SERVER_IP=192.168.0.153`
                    - `export USER=root`
                    - `k3sup join --ip $AGENT_IP --server-ip $SERVER_IP --user $USER`

            - the worker install log
                ```
                [root@ecs-50d1 ~]# kubectl get node
                NAME       STATUS   ROLES    AGE     VERSION
                ecs-50d1   Ready    master   4m12s   v1.18.6+k3s1
                [root@ecs-50d1 ~]#  export AGENT_IP=192.168.0.139
                [root@ecs-50d1 ~]# export SERVER_IP=192.168.0.153
                [root@ecs-50d1 ~]#
                [root@ecs-50d1 ~]# export USER=root
                [root@ecs-50d1 ~]#
                [root@ecs-50d1 ~]# k3sup join --ip $AGENT_IP --server-ip $SERVER_IP --user $USER
                Running: k3sup join
                Server IP: 192.168.0.153
                K1067e3987c6eb897f03d346922d11b75de3881a103d938c2f12a58e5b43c58504f::server:829e8fce7c095806d444f2a7f2dafe04
                Error: unable to connect to 192.168.0.139:22 over ssh: ssh: handshake failed: ssh: unable to authenticate, attempted methods [none publickey], no supported methods remain
                [root@ecs-50d1 ~]# ssh-copy-id root@192.168.0.139
                /usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/root/.ssh/id_rsa.pub"
                The authenticity of host '192.168.0.139 (192.168.0.139)' can't be established.
                ECDSA key fingerprint is SHA256:1g0gbnMdjsH2XcCK/R2XlkA9bvy6wg3XcsRW4z86okA.
                Are you sure you want to continue connecting (yes/no)? yes
                /usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
                /usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
                root@192.168.0.139's password:
                Permission denied, please try again.
                root@192.168.0.139's password:

                Number of key(s) added: 1

                Now try logging into the machine, with:   "ssh 'root@192.168.0.139'"
                and check to make sure that only the key(s) you wanted were added.

                [root@ecs-50d1 ~]# k3sup join --ip $AGENT_IP --server-ip $SERVER_IP --user $USER
                Running: k3sup join
                Server IP: 192.168.0.153
                K1067e3987c6eb897f03d346922d11b75de3881a103d938c2f12a58e5b43c58504f::server:829e8fce7c095806d444f2a7f2dafe04
                [INFO]  Using v1.18.6+k3s1 as release
                [INFO]  Downloading hash https://github.com/rancher/k3s/releases/download/v1.18.6+k3s1/sha256sum-arm64.txt
                [INFO]  Downloading binary https://github.com/rancher/k3s/releases/download/v1.18.6+k3s1/k3s-arm64
                [INFO]  Verifying binary download
                [INFO]  Installing k3s to /usr/local/bin/k3s
                [INFO]  Creating /usr/local/bin/kubectl symlink to k3s
                [INFO]  Creating /usr/local/bin/crictl symlink to k3s
                [INFO]  Creating /usr/local/bin/ctr symlink to k3s
                [INFO]  Creating killall script /usr/local/bin/k3s-killall.sh
                [INFO]  Creating uninstall script /usr/local/bin/k3s-agent-uninstall.sh
                [INFO]  env: Creating environment file /etc/systemd/system/k3s-agent.service.env
                [INFO]  systemd: Creating service file /etc/systemd/system/k3s-agent.service
                [INFO]  systemd: Enabling k3s-agent unit
                Created symlink /etc/systemd/system/multi-user.target.wants/k3s-agent.service → /etc/systemd/system/k3s-agent.service.
                [INFO]  systemd: Starting k3s-agent
                Logs: Created symlink /etc/systemd/system/multi-user.target.wants/k3s-agent.service → /etc/systemd/system/k3s-agent.service.
                Output: [INFO]  Using v1.18.6+k3s1 as release
                [INFO]  Downloading hash https://github.com/rancher/k3s/releases/download/v1.18.6+k3s1/sha256sum-arm64.txt
                [INFO]  Downloading binary https://github.com/rancher/k3s/releases/download/v1.18.6+k3s1/k3s-arm64
                [INFO]  Verifying binary download
                [INFO]  Installing k3s to /usr/local/bin/k3s
                [INFO]  Creating /usr/local/bin/kubectl symlink to k3s
                [INFO]  Creating /usr/local/bin/crictl symlink to k3s
                [INFO]  Creating /usr/local/bin/ctr symlink to k3s
                [INFO]  Creating killall script /usr/local/bin/k3s-killall.sh
                [INFO]  Creating uninstall script /usr/local/bin/k3s-agent-uninstall.sh
                [INFO]  env: Creating environment file /etc/systemd/system/k3s-agent.service.env
                [INFO]  systemd: Creating service file /etc/systemd/system/k3s-agent.service
                [INFO]  systemd: Enabling k3s-agent unit
                [INFO]  systemd: Starting k3s-agent
                [root@ecs-50d1 ~]# k3s
                NAME:
                k3s - Kubernetes, but small and simple

                USAGE:
                k3s [global options] command [command options] [arguments...]

                VERSION:
                v1.18.6+k3s1 (6f56fa1d)

                COMMANDS:
                server        Run management server
                agent         Run node agent
                kubectl       Run kubectl
                crictl        Run crictl
                ctr           Run ctr
                check-config  Run config check
                help, h       Shows a list of commands or help for one command

                GLOBAL OPTIONS:
                --debug        Turn on debug logs [$K3S_DEBUG]
                --help, -h     show help
                --version, -v  print the version
                [root@ecs-50d1 ~]# k3s kubectl get nodes
                NAME            STATUS     ROLES    AGE   VERSION
                ecs-50d1        Ready      master   11m   v1.18.6+k3s1
                ecs-50d1-9c12   NotReady   <none>   5s    v1.18.6+k3s1
                [root@ecs-50d1 ~]# k3s kubectl get nodes
                NAME            STATUS   ROLES    AGE   VERSION
                ecs-50d1        Ready    master   11m   v1.18.6+k3s1
                ecs-50d1-9c12   Ready    <none>   10s   v1.18.6+k3s1
                [root@ecs-50d1 ~]# kubectl get node
                NAME            STATUS   ROLES    AGE   VERSION
                ecs-50d1        Ready    master   12m   v1.18.6+k3s1
                ecs-50d1-9c12   Ready    <none>   33s   v1.18.6+k3s1

                ```
- install k8s in Fedora29 server
    - Failed to start Kubernetes Kubelet Server.
        ```
        [root@ecs-50d1 ~]# kubectl create -f ./node.json
        The connection to the server localhost:8080 was refused - did you specify the right host or port?
        ```
        ```
        [root@ecs-50d1 ~]# kubectl get nodes
        The connection to the server localhost:8080 was refused - did you specify the right host or port?
        ```
        ```
        [root@ecs-50d1 ~]# systemctl status kubelet -l
        ● kubelet.service - Kubernetes Kubelet Server
        Loaded: loaded (/usr/lib/systemd/system/kubelet.service; disabled; vendor preset: disabled)
        Active: failed (Result: exit-code) since Fri 2020-08-21 00:29:18 CST; 2min 17s ago
            Docs: https://github.com/GoogleCloudPlatform/kubernetes
        Process: 1908 ExecStart=/usr/bin/kubelet $KUBE_LOGTOSTDERR $KUBE_LOG_LEVEL $KUBELET_API_SERVER $KUBELET_ADDRESS $KUBELET_PORT $KUBELET_HOSTNAME $KUBE_ALLOW_PRIV $KUBELET_ARGS (code=exited, status=255)
        Main PID: 1908 (code=exited, status=255)
            CPU: 127ms

        Aug 21 00:29:17 ecs-50d1 systemd[1]: kubelet.service: Consumed 127ms CPU time
        Aug 21 00:29:18 ecs-50d1 systemd[1]: kubelet.service: Service RestartSec=100ms expired, scheduling restart.
        Aug 21 00:29:18 ecs-50d1 systemd[1]: kubelet.service: Scheduled restart job, restart counter is at 5.
        Aug 21 00:29:18 ecs-50d1 systemd[1]: Stopped Kubernetes Kubelet Server.
        Aug 21 00:29:18 ecs-50d1 systemd[1]: kubelet.service: Consumed 127ms CPU time
        Aug 21 00:29:18 ecs-50d1 systemd[1]: kubelet.service: Start request repeated too quickly.
        Aug 21 00:29:18 ecs-50d1 systemd[1]: kubelet.service: Failed with result 'exit-code'.
        Aug 21 00:29:18 ecs-50d1 systemd[1]: Failed to start Kubernetes Kubelet Server.
        ```
        