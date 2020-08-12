# K8s-k3s-on-Fedora
This is  one or at least start a prototype

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
                    $ sudo dnf install -y grubby
                    $ sudo grubby --update-kernel=ALL --args="systemd.unified_cgroup_hierarchy=0"
                    $ sudo reboot
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