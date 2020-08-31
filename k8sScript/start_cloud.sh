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
fi

ping -c 1 -w 10 blue
if [ $? -ne 0 ]; then
  echo "$BLUE_IP blue">>/etc/hosts
  ping -c 1 -w 10 blue
  if [ $? -ne 0 ]; then
    echo "Node: blue not up, please check..."
    exit 1
  fi
fi

ping -c 1 -w 10 master
if [ $? -ne 0 ]; then
  echo "$MASTER_IP master">>/etc/hosts
  ping -c 1 -w 10 master
  if [ $? -ne 0 ]; then
    echo "Node: master (self) not up, please check..."
    exit 1
  fi
fi

echo -e "\n\n\n"|ssh-keygen -t rsa -C "startk3s@tests.com"

echo -e "$MASTER_IP \c" && ssh master -o PreferredAuthentications=publickey -o StrictHostKeyChecking=no “date” > /dev/null 2>&1
if [ $? -eq 0 ]; then echo"we can alredy ssh to the  master nodes" 
else
echo yes|ssh-copy-id root@master
fi

echo -e "$BLUE_IP \c" && ssh blue -o PreferredAuthentications=publickey -o StrictHostKeyChecking=no “date” > /dev/null 2>&1
if [ $? -eq 0 ];then echo"we can alredy ssh to the  blue nodes" 
else
echo yes|ssh-copy-id root@blue
fi

echo -e "$GREEN_IP \c" && ssh green -o PreferredAuthentications=publickey -o StrictHostKeyChecking=no “date” > /dev/null 2>&1
if [ $? -eq 0 ];then echo"we can alredy ssh to the  green nodes" 
else
echo yes|ssh-copy-id root@green
fi


#ssh master if [ $(hostname) != "master" ]; then hostnamectl set-hostname master  ;fi
ssh master hostnamectl set-hostname master
#install docker
ssh master curl -fsSL https://get.docker.com | bash -s docker
# As a container, Docker is installed on all servers using installation scripts

#start docker
ssh master systemctl daemon-reload
ssh master systemctl restart docker.service

ssh master cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
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
ssh master sudo setenforce 0
ssh master sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

ssh master sudo yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes

ssh master sudo systemctl enable --now kubelet
ssh master sudo yum install -y ipvsadm

ssh master cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-aarch64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
ssh master yum clean all
ssh master yum install kubernetes-cni -y

ssh master echo"FLANNEL_NETWORK=10.244.0.0/16
FLANNEL_SUBNET=10.224.0.1/24
FLANNEL_MTU=1450
FLANNEL_IPMASQ=true">/run/flannel/subnet.env

ssh master systemctl daemon-reload
ssh master systemctl restart docker.service
ssh master systemctl enable docker
ssh master systemctl enable kubelet.service
ssh master systemctl start docker
ssh master systemctl start kubelet

# node


#ssh blue if [ $(hostname) != "blue" ]; then hostnamectl set-hostname blue  ;fi
ssh blue hostnamectl set-hostname blue
#install docker
ssh blue curl -fsSL https://get.docker.com | bash -s docker
# As a container, Docker is installed on all servers using installation scripts

#start docker
ssh blue systemctl daemon-reload
ssh blue systemctl restart docker.service

ssh blue cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
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
ssh blue sudo setenforce 0
ssh blue sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

ssh blue sudo yum install -y kubelet kubeadm  --disableexcludes=kubernetes

ssh blue sudo systemctl enable --now kubelet
ssh blue sudo yum install -y ipvsadm

ssh blue cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-aarch64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
ssh blue yum clean all
ssh blue yum install kubernetes-cni -y

ssh blue echo"FLANNEL_NETWORK=10.244.0.0/16
FLANNEL_SUBNET=10.224.0.1/24
FLANNEL_MTU=1450
FLANNEL_IPMASQ=true">/run/flannel/subnet.env

ssh blue systemctl daemon-reload
ssh blue systemctl restart docker.service
ssh blue systemctl enable docker
ssh blue systemctl enable kubelet.service
ssh blue systemctl start docker
ssh blue systemctl start kubelet

#ssh blue if [ $(hostname) != "blue" ]; then hostnamectl set-hostname blue  ;fi
ssh blue hostnamectl set-hostname blue
#install docker
ssh blue curl -fsSL https://get.docker.com | bash -s docker
# As a container, Docker is installed on all servers using installation scripts

#start docker
ssh green systemctl daemon-reload
ssh green systemctl restart docker.service

ssh green cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
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
ssh green sudo setenforce 0
ssh green sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

ssh green sudo yum install -y kubelet kubeadm  --disableexcludes=kubernetes

ssh green sudo systemctl enable --now kubelet
ssh green sudo yum install -y ipvsadm

ssh green cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-aarch64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
ssh green yum clean all
ssh green yum install kubernetes-cni -y

ssh green echo"FLANNEL_NETWORK=10.244.0.0/16
FLANNEL_SUBNET=10.224.0.1/24
FLANNEL_MTU=1450
FLANNEL_IPMASQ=true">/run/flannel/subnet.env

ssh green systemctl daemon-reload
ssh green systemctl restart docker.service
ssh green systemctl enable docker
ssh green systemctl enable kubelet.service
ssh green systemctl start docker
ssh green systemctl start kubelet



ssh master git clone https://github.com/HANXU2018/kubernetes_f30_demo/
ssh master cd kubernetes_f30_demo
ssh master sh start_cloud.sh

echo ""
echo "Checking nodes"
echo ""
kubectl get nodes
