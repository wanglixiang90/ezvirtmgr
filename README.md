
## ezvirtmgr

1. Install [Docker](https://www.docker.com/).
```
$ yum install docker
```

2. Build the image from Dockerfile

```
$ docker build -t webkvm .
```

### Usage

```
$ docker run --name webkvm-init -v you_data_dir:/data webkvm /webvirtmgr/bootstrap.sh
$ Ctrl + C
$ docker start webkvm
$ docke run -itd -v you_data_dir:/data -p 80:80 -p 6080:6080 webkvm
$ ssh-keygen
$ ssh-copy-id username@hostip(like root@172.17.0.1)
$ Ctrl + P + Q
```
### Test

```
$ docker run --name web -p 80:80 -p -it 6080:6080 webkvm /bin/bash

```

### Install libvirt and KVM
```
$ sudo sh libvirt-bootstrap.sh
```

### Open Browser
1. Url is Host:80
2. User admin, pwd admin
3. Then add Connection by TCP or SSH(Host kvm libvirtd can config use TCP OR SSH)
4. Use it as you wish

### Reference resources
1. ianblenke/kvm
2. primiano/docker-webvirtmgr