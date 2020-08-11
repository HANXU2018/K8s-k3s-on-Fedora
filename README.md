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
                - 

