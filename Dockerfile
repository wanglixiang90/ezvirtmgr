FROM centos:7
MAINTAINER Wanglx <15201376500@163.com>

VOLUME /data

RUN yum -y install epel-release -y && \
    yum -y install git nginx python-pip libvirt-python libxml2-python python-websockify supervisor -y && \
    yum clean all && rm -rf /var/cache/yum/*

RUN git clone https://github.com/retspen/webvirtmgr /webvirtmgr
WORKDIR /webvirtmgr
RUN pip install -i https://pypi.tuna.tsinghua.edu.cn/simple -r requirements.txt && \
    pip install -i https://pypi.tuna.tsinghua.edu.cn/simple numpy && rm -rf ~/.cache/pip 
ADD local_settings.py /webvirtmgr/webvirtmgr/local/local_settings.py 
RUN /usr/bin/python /webvirtmgr/manage.py collectstatic --noinput

ADD supervisor.webvirtmgr.conf /etc/supervisord.d/webvirtmgr.ini
ADD gunicorn.conf.py /webvirtmgr/conf/gunicorn.conf.py
ADD nginx.conf /etc/nginx/nginx.conf
ADD bootstrap.sh /webvirtmgr/bootstrap.sh

RUN /bin/sh /webvirtmgr/bootstrap.sh && \
    chown -R nginx.nginx  /webvirtmgr/static 

EXPOSE 80
EXPOSE 6080
CMD ["supervisord", "-n"]
