FROM ubuntu:24.04

ENV TZ=Asia/Shanghai

RUN touch /etc/apt/sources.list || true
RUN echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm main contrib non-free non-free-firmware" > /etc/apt/sources.list \
    && echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-updates main contrib non-free non-free-firmware" >> /etc/apt/sources.list \
    && echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-backports main contrib non-free non-free-firmware" >> /etc/apt/sources.list \
    && echo "deb https://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware" >> /etc/apt/sources.list 
# RUN npm config set registry https://registry.npmmirror.com    

RUN apt-get update -y
RUN apt-get install -y git net-tools build-essential
RUN apt-get install -y pkg-config
RUN apt-get install -y libssl-dev
RUN apt-get install -y libsqlite3-0
RUN apt-get install -y libsqlite3-dev
RUN apt-get install -y libevent-dev
RUN apt-get install -y libpq-dev
RUN apt-get install -y mysql-client
RUN apt-get install -y libmysqlclient-dev
RUN apt-get install -y libhiredis-dev

WORKDIR /coturn

COPY CMakeLists.txt .
COPY configure .
COPY Makefile.in .
COPY src src
COPY turndb turndb

RUN ./configure
RUN make

CMD ["/coturn/bin/turnserver", "-c","turnserver.conf"]
