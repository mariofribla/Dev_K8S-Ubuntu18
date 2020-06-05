#!/bin/sh

clear
echo "#####################################################################"
echo "###   Install Kubernetes (k8S) con Docker version 18.x a 19.03.x  ###"
echo "#####################################################################"

echo "### Valida Soporte Virtual ###"
grep -q ^flags.*\ hypervisor /proc/cpuinfo && echo "This machine is a VM"

echo "### Instalando Pre-Requisitos. ###"
sudo apt-get -y install curl
sudo apt-get -y install conntrack
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
