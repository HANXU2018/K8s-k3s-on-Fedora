# k3s install step
## experimental environment 
- 2vCPUs 
- 4GB
- Fedora 29 64bit with ARM
## step
- SSH access
    - `ssh-keygen -t rsa -C "address@youremail.com`
        - k3sUp use SSH connect to server. First generate the SSH secret key
    - `ssh-copy-id root@serverIP`
        - Copy the SSH key remotely to the server
    - `ssh-copy-id root@agentIP`
        - Copy the SSH key remotely to the agent
- install docker
    - `curl -fsSL https://get.docker.com | bash -s docker`
        - As a container, Docker is installed on all servers using installation scripts
    - start docker
        ```
        systemctl daemon-reload
        systemctl restart docker.service
        ```
- install k3sup
    - `curl -sLS https://get.k3sup.dev | sh`
        - k3sup is a tool for installing K3S
- install k3s server
    - `export SERVER_IP=192.168.0.100`
    - `export USER=root`
    - `k3sup install --ip $SERVER_IP --user $USER`
        - Install K3S remotely using k3sup
- install k3s agent
    - `export SERVER_IP=192.168.0.100`
    - `export AGENT_IP=192.168.0.101`
    - `export USER=root`
    - `k3sup join --ip $AGENT_IP --server-ip $SERVER_IP --user $USER`
        - Install K3S remotely using k3sup
## quick start
- I wrote a script to quickly start three nodes I'll call these three nodes master blue and green.You need to make sure that the three nodes are accessible to each other before you run the script.Refer to the tutorial below
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
- You can now run the script directly 
    - `sh start_cloud.sh`