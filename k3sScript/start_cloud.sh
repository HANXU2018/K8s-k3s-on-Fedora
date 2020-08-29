ping -c 1 -w 10 green
if [ $? -ne 0 ]; then
  echo "Node: green not up, please check..."
  exit 1
fi
ping -c 1 -w 10 blue
if [ $? -ne 0 ]; then
  echo "Node: blue not up, please check..."
  exit 1
fi
ping -c 1 -w 10 master
if [ $? -ne 0 ]; then
  echo "Node: master (self) not up, please check..."
  exit 1
fi

#install docker
ssh master curl -fsSL https://get.docker.com | bash -s docker
# As a container, Docker is installed on all servers using installation scripts

#start docker
ssh master systemctl daemon-reload
ssh master systemctl restart docker.service

#install k3sup
ssh master curl -sLS https://get.k3sup.dev | sh
k3sup is a tool for installing K3S
# install k3s server
ssh master export SERVER_IP=master
ssh master export USER=root
ssh master k3sup install --ip $SERVER_IP --user $USER

#Install K3S remotely using k3sup
#install docker
ssh blue curl -fsSL https://get.docker.com | bash -s docker
# As a container, Docker is installed on all servers using installation scripts

#start docker
ssh blue systemctl daemon-reload
ssh blue systemctl restart docker.service

#install k3sup
ssh blue curl -sLS https://get.k3sup.dev | sh
k3sup is a tool for installing K3S
# install k3s agent blue
ssh blue export SERVER_IP=master
ssh blue export AGENT_IP=blue
ssh blue export USER=root
k3sup join --ip $AGENT_IP --server-ip $SERVER_IP --user $USER
# Install K3S remotely using k3sup

#Install K3S remotely using k3sup
#install docker
ssh green curl -fsSL https://get.docker.com | bash -s docker
# As a container, Docker is installed on all servers using installation scripts

#start docker
ssh green systemctl daemon-reload
ssh green systemctl restart docker.service

#install k3sup
ssh green curl -sLS https://get.k3sup.dev | sh
k3sup is a tool for installing K3S
# install k3s agent blue
ssh green export SERVER_IP=master
ssh green export AGENT_IP=blue
ssh green export USER=root
k3sup join --ip $AGENT_IP --server-ip $SERVER_IP --user $USER
# Install K3S remotely using k3sup