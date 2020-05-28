# Instalar Kubernetes (K8S-Minikube) con Docker versión 18.

Este GitHub describe la Shell que esta desarrolla para la instalación de Minikube(K8S) con Docker v.18 Localmente.

## Requisitos
* Ubuntu 18.04.4 LTS.
* Docker versión 18.* (la versión 19 no es soportada aun).

## DESCRIPCIÓN SHELL
### Validación para Soporte Virtual
```sh
$ grep -q ^flags.*\ hypervisor /proc/cpuinfo && echo "This machine is a VM"
```
## DOCKER
### Stop Docker si Existe.
```sh
$ sudo systemctl stop docker
```
### Instalando Pre-Requisitos.
```sh
$ sudo apt-get -y install curl
$ sudo apt-get -y install conntrack
```
### Creando APT REPO para Docker.
```sh
$ curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
$ sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable"
$ sudo apt-get update
```
### Remueve Docker si Existe.
```sh
$ sudo apt-get purge docker-engine
$ sudo apt-get autoremove --purge docker-engine
$ sudo dpkg -l | grep -i docker
$ sudo apt-get purge -y docker-engine docker docker.io docker-ce  
$ sudo apt-get autoremove -y --purge docker-engine docker docker.io docker-ce  
$ sudo rm -rf /var/lib/docker /etc/docker
$ sudo rm /etc/apparmor.d/docker
$ sudo groupdel docker
$ sudo rm -rf /var/run/docker.sock /usr/local/bin/docker-compose
$ sudo apt-get purge -y docker-engine docker docker.io docker-ce docker-ce-cli
$ sudo dpkg-query -S $(sudo find / -name '*docker*' -print 2>/dev/null)
```
### Instalar Docker 18.03.1 compatible Minikube desde REPO.
```sh
$ sudo apt-get -y install docker-ce=18.03*
```
### Configura usuarios.
```sh
$ sudo usermod -aG docker $USER
```
### Instalar Docker Service.
```sh
$ sudo systemctl start docker
$ sudo systemctl enable docker
$ sudo systemctl status docker
```
### Docker Versión.
```sh
$ sudo docker version
```
## INSTALAR KUBECTL.
### Descarga de kubectl.
```sh
$ curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
```
### Asigna Permiso de ejecucion.
```sh
$ chmod +x ./kubectl
```
### Mueve kubectl a /usr/bin.
```sh
$ if [ -f /usr/bin/kubectl ]
  then
    echo "### Existe kubectl, se elimina en /usr/bin. ###"
    sudo rm -rf /usr/bin/kubectl
  fi
$ sudo mv ./kubectl /usr/bin/kubectl
```
### Valida kubectl en /usr/bin.
```sh
$ ls -l /usr/bin/kubectl
```
### Versión kubectl.
```sh
$ sudo kubectl version --client
```
## INSTALAR MINIKUBE.
### Descarga minikube.
```sh
$ curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
```
### Asigna Permiso de ejecucion.
```sh
$ chmod +x minikube
```
### Mueve minikube a /usr/bin.
```sh
$ if [ -f /usr/bin/minikube ]
$ then
    echo "### Existe minikube, se elimina en /usr/bin. ###"
    sudo rm -rf /usr/bin/minikube
  fi
$ sudo mv minikube /usr/bin
```
### Valida minikube en /usr/bin.
```sh
$ ls -l /usr/bin/minikube
```
### Versión kubectl.
```sh
$ sudo minikube start --kubernetes-version=''
```
### Status minikube.
```sh
$ sudo minikube status
```

SACACIngeniería
### SACACI Chile

