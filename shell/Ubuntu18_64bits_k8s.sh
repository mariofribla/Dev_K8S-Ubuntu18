#!/bin/sh

clear
echo "#################################################################"
echo "###   Install Kubernetes (k8S) con Docker version 18.         ###"
echo "#################################################################"

echo "### Valida Soporte Virtual ###"
grep -q ^flags.*\ hypervisor /proc/cpuinfo && echo "This machine is a VM"

echo "### DOCKER ###"
echo "### Stop Docker si Existe. ###"
sudo systemctl stop docker

echo "### Creando APT REPO para Docker. ###"
#
echo "### Instalando Pre-Requisitos. ###"
sudo apt-get -y install curl
sudo apt-get -y install conntrack
#
echo "### Creando APT REPO para Docker. ###"
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable"
sudo apt-get update
#
echo "### Remueve Docker si Existe. ###"
sudo apt-get purge docker-engine
sudo apt-get autoremove --purge docker-engine
sudo dpkg -l | grep -i docker
sudo apt-get purge -y docker-engine docker docker.io docker-ce  
sudo apt-get autoremove -y --purge docker-engine docker docker.io docker-ce  
sudo rm -rf /var/lib/docker /etc/docker
sudo rm /etc/apparmor.d/docker
sudo groupdel docker
sudo rm -rf /var/run/docker.sock /usr/local/bin/docker-compose
sudo apt-get purge -y docker-engine docker docker.io docker-ce docker-ce-cli
sudo dpkg-query -S $(sudo find / -name '*docker*' -print 2>/dev/null)

#
echo "### Instala Docker 18.03.1 compatible Minikube desde REPO. ###"
sudo apt-get -y install docker-ce=18.03*
#
echo "### Configura usuarios"
sudo usermod -aG docker $USER
#
echo "### Install Docker Service. ###"
sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl status docker
echo "### Docker Version. ###"
sudo docker version
#
echo "### FIN DOCKER. ##"
#
echo "### INSTALAR KUBECTL ###"
#
echo "### Descarga de KUBECTL. ###"
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
#
echo "### Asigna Permiso de ejecucion. ###"
chmod +x ./kubectl
#
if [ -f /usr/bin/kubectl ]
then
  echo "### Existe kubectl, se elimina en /usr/bin. ###"
  sudo rm -rf /usr/bin/kubectl
fi
#
echo "### Mueve kubectl a /usr/bin. ###"
sudo mv ./kubectl /usr/bin/kubectl
#
echo "### Valida kubectl a /usr/bin. ###"
ls -l /usr/bin/kubectl
#
echo "### Version kubectl. ###"
sudo kubectl version --client
#
echo "### INSTALAR MINIKUBE ###"
#
echo "### Descarga de MINIKUBE. ###"
#
echo "### Descarga MINIKUBE. ###"
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 
#
echo "### Asigna Permiso de ejecucion. ###"
chmod +x minikube
#
if [ -f /usr/bin/minikube ]
then
  echo "### Existe minikube, se elimina en /usr/bin. ###"
  sudo rm -rf /usr/bin/minikube
fi
#
echo "### Mueve minikube a /usr/bin. ###"
sudo mv minikube /usr/bin 
#
echo "### Valida minikube a /usr/bin. ###"
ls -l /usr/bin/minikube
#
echo "### Version kubectl. ###"
sudo minikube start --kubernetes-version=''
#
echo "### Status MINIKUBE. ###"
sudo minikube status
#
echo "### FIN KUBERNETES. ##"
#
exit 0
