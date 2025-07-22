#!/bin/bash

# 初始化 chihaya
bash chihaya.bash

# 克隆 metadata-service 仓库并初始化
git clone https://github.com/MirrorCask/metadata-service
cd metadata-service
bash init.bash

# 克隆 bt-agent 仓库并初始化
git clone https://github.com/MirrorCask/bt-agent
cd bt-agent
bash init.bash