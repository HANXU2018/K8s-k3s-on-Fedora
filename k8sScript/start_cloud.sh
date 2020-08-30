export MASTER_IP=192.168.0.212
export BLUE_IP=192.168.0.225
export GREEN_IP=192.168.0.189

ping -c 1 -w 10 green
if [ $? -ne 0 ]; then
  echo "$BLUE_IP green">>/etc/hosts
  ping -c 1 -w 10 green
  if [ $? -ne 0 ]; then
    echo "Node: green not up, please check..."
    exit 1
  fi
  exit 1
fi

ping -c 1 -w 10 blue
if [ $? -ne 0 ]; then
  echo "$BLUE_IP blue">>/etc/hosts
  ping -c 1 -w 10 blue
  if [ $? -ne 0 ]; then
    echo "Node: blue not up, please check..."
    exit 1
  fi
  exit 1
fi

ping -c 1 -w 10 master
if [ $? -ne 0 ]; then
  echo "$MASTER_IP master">>/etc/hosts
  ping -c 1 -w 10 master
  if [ $? -ne 0 ]; then
    echo "Node: master (self) not up, please check..."
    exit 1
  fi
  exit 1
fi

echo -e "\n\n\n"|ssh-keygen -t rsa -C "startk3s@tests.com"

ssh master 
if [ $? -ne 0 ]; then
  echo yes|ssh-copy-id root@master
  exit 1
fi

ssh blue 
if [ $? -ne 0 ]; then
  echo yes|ssh-copy-id root@blue
  exit 1
fi

ssh green 
if [ $? -ne 0 ]; then
  echo yes|ssh-copy-id root@green
  exit 1
fi

ssh master if [ $(hostname) != "master" ]; then hostnamectl set-hostname master  ;fi

#install docker
ssh master curl -fsSL https://get.docker.com | bash -s docker
# As a container, Docker is installed on all servers using installation scripts

#start docker
ssh master systemctl daemon-reload
ssh master systemctl restart docker.service

#install k3sup
ssh master curl -sLS https://get.k3sup.dev | sh
#k3sup is a tool for installing K3S
#install k3s server
echo "master install"

ssh master k3sup install --ip $MASTER_IP --user root

#Install K3S remotely using k3sup
ssh blue hostnamectl set-hostname blue
#install docker
ssh blue curl -fsSL https://get.docker.com | bash -s docker
# As a container, Docker is installed on all servers using installation scripts

#start docker
ssh blue systemctl daemon-reload
ssh blue systemctl restart docker.service
echo "blue install"
#install k3sup
ssh blue curl -sLS https://get.k3sup.dev | sh
# install k3s agent blue

k3sup join --ip $BLUE_IP --server-ip $MASTER_IP --user root
# Install K3S remotely using k3sup
echo "green install"
#Install K3S remotely using k3sup
ssh green hostnamectl set-hostname green
#install docker
ssh green curl -fsSL https://get.docker.com | bash -s docker
# As a container, Docker is installed on all servers using installation scripts

#start docker
ssh green systemctl daemon-reload
ssh green systemctl restart docker.service

#install k3sup
ssh green curl -sLS https://get.k3sup.dev | sh
# install k3s agent blue
k3sup join --ip $GREEN_IP --server-ip $MASTER_IP --user root
# Install K3S remotely using k3sup

echo ""
echo "Checking nodes"
echo ""
kubectl get nodes
