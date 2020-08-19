# k3s install step
## experimental environment 
- 2vCPUs 
- 4GB
- Fedora 29 64bit with ARM
## step
- SSH access
    - `ssh-keygen -t rsa -C "address@youremail.com`
    - `ssh-copy-id root@serverIP`
    - `ssh-copy-id root@agentIP`
- install docker
    - `curl -fsSL https://get.docker.com | bash -s docker`
- install k3sup
    - `curl -sLS https://get.k3sup.dev | sh`
- install k3s server
    - `export SERVER_IP=192.168.0.100`
    - `export USER=root`
    - `k3sup install --ip $SERVER_IP --user $USER`
- install k3s agent
    - `export SERVER_IP=192.168.0.100`
    - `export AGENT_IP=192.168.0.101`
    - `export USER=root`
    - `k3sup join --ip $AGENT_IP --server-ip $SERVER_IP --user $USER`