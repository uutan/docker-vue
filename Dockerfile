## 选node作为基础镜像
FROM node:latest

# system local config
RUN true \
  # debian china mirrors
  && sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list \
  && sed -i 's/security.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list \
  # timezone to china
  && ln -sf /usr/share/zoneinfo/PRC /etc/localtime 

RUN apt-get update \
  && apt-get install -y \
  # node-sass 等编译依赖
  make gcc g++ python \
  # 命令行工具
  zsh curl wget vim git

# RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
RUN sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

RUN true \
  && npm config set registry https://registry.npm.taobao.org \
  && npm install webpack -g \  
  && npm install -g @vue/cli

RUN mkdir /workspace

WORKDIR /workspace

# 给这个目录执行权限，x是执行权限
RUN chmod +x /workspace

VOLUME /workspace

EXPOSE 8080

CMD ["zsh"]
