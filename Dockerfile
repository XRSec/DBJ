FROM ubuntu:18.04

LABEL Auther="xrsec"
LABEL Mail="troy@zygd.site"
LABEL Github="https://github.com/XRSec/DBJ"

COPY . /DBJ

RUN apt-get update -y && apt-get upgrade -y \
    && apt-get -o Acquire::BrokenProxy="true" -o Acquire::http::No-Cache="true" -o Acquire::http::Pipeline-Depth="0" -y install python3 python3-pip mongodb redis-server \
    && pip3 install -r /DBJ/requirements.txt -i https://mirrors.aliyun.com/pypi/simple/ \
    && mkdir -p /root/.config \
    && cp -r /DBJ/data/.config/nuclei /root/.config/nuclei \
    && chmod +x /DBJ/data/nuclei \
    && chmod +x /DBJ/start.sh \
    && ln -s /DBJ/data/nuclei /usr/bin/nuclei

WORKDIR /DBJ/
ENV LC_ALL=de_DE.utf-8
ENV LANG=de_DE.utf-8
EXPOSE 5000

CMD ["/DBJ/start.sh"]