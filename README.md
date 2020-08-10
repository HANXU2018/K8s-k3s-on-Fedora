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

              


