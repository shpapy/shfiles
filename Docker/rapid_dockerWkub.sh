curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) \
stable"
sudo apt-get update
sudo apt-get install -y docker-ce=18.06.1~ce~3-0~ubuntu
sudo apt-mark hold docker-ce
You can verify that docker is working by running this command:
sudo docker version
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat << EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update
sudo apt-get install -y kubelet=1.15.7-00 kubeadm=1.15.7-00 kubectl=1.15.7-00
sudo apt-mark hold kubelet kubeadm kubectl
After installing these components, verify that Kubeadm is working by getting the version info.
kubeadm version
sudo kubeadm init --pod-network-cidr=10.244.0.0/16
mkdir -p $HOME/.kube
kubectl get nodes
echo "net.bridge.bridge-nf-call-iptables=1" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

only on the workers
kubeadm token create --print-join-command
kubeadm join 172.31.113.234:6443 --token djb35l.odm7grrh2cj87oxy --discovery-token-ca-cert-hash sha256:b3b0c235749bbb83298173fbdc5bf9c078c99f0270357134450b765600a7a6cf

##//##
setenforce 0
sed -i --follow-symlinks 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
modprobe br_netfilter
echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables
swapoff -a 
nano /etc/fstab
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install -y docker-ce
sed -i '/^ExecStart/ s/$/ --exec-opt native.cgroupdriver=systemd/' /usr/lib/systemd/system/docker.service 
systemctl daemon-reload && systemctl enable docker --now && systemctl status docker
docker info | grep -i cgroup
#Kubernetes deployment
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=0
repo_gpgcheck=0
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
      https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
more /etc/yum.repos.d/kubernetes.repo 
yum install -y kubelet kubeadm kubectl && systemctl enable kubelet

kubeadm init --pod-network-cidr=10.244.0.0/16 #this is for the cluster network setup just on the master

kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml #flannel load-up

 mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubeadm join 172.31.18.50:6443 --token 45csw2.iii52makdvs2jy7w \
	--discovery-token-ca-cert-hash sha256:f7d7e1330d45e3b18c93723904a8b3fe2202a89272d50ddc00a850c444728bfd






 sudo apt dist-upgrade -y && sudo apt update && sudo apt -y install curl apt-transport-https
 curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
 echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
 sudo apt update && sudo apt -y install vim git curl wget kubelet kubeadm kubectl && sudo apt-mark hold kubelet kubeadm kubectl
 sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
 sudo swapoff -a && sudo modprobe overlay && sudo modprobe br_netfilter 
 sudo tee /etc/sysctl.d/kubernetes.conf <<EOF
 {
 net.bridge.bridge-nf-call-ip6tables = 1
 net.bridge.bridge-nf-call-iptables = 1
 net.ipv4.ip_forward = 1
 }
 EOF

sudo sysctl --system
sudo apt install -y curl gnupg2 software-properties-common apt-transport-https ca-certificates
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update && sudo apt install -y containerd.io docker-ce docker-ce-cli
sudo mkdir -p /etc/systemd/system/docker.service.d
sudo tee /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

sudo systemctl daemon-reload && sudo systemctl restart docker && sudo systemctl enable docker && sudo systemctl enable kubelet
sudo kubeadm config images pull
sudo kubeadm init --pod-network-cidr=10.244.0.0/16
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config







  eyJhbGciOiJSUzI1NiIsImtpZCI6IjBldHZ4anlrclF3VUNqZG1EUGVkTFlEOUR5RkY1WF9sY1gxclJRVlU2RUEifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJrdWJlcm5ldGVzLWRhc2hib2FyZCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJhZG1pbi11c2VyLXRva2VuLXByOWRrIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQubmFtZSI6ImFkbWluLXVzZXIiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC51aWQiOiI3MDc5NWE4OS04NDhkLTQ4YWItOGU2My0zNjY3NjEyMDVlM2YiLCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6a3ViZXJuZXRlcy1kYXNoYm9hcmQ6YWRtaW4tdXNlciJ9.VT2JJy1B5qc-dxIsr6gQKTEx4JK6mlspbY1rhG9HBs6nBJ1WBpQ3lfYXf9dqQjgTVD7o-AN65Vulu5naC8ytUyMCYBm4PGmZdjO8WKITE-SqdYWBNW_8dqpYE1Tfj_ggs6AsyWRIGRvXR6obYycRvTeSW0_p-Q8Vy1gPJ0oGBwfQrOuFA0J29A4EUOYEqKP6TWyICVyKR5oNusEg5L9Q1B905nZXzDJtUiFm-sNWCLwI5ExjURqn5WYQOB_gSuky1Tm9BrfD9cO9qHz2bbvU0EfmTsKLfYibY9aHzOwVsVEOx1ag_I5WuKJoHnZ5PrRchKsa1jSnvJ25VIE__memywcloud_user