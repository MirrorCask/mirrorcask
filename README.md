# mirrorcask

Mirrorcask 是一套在 k8s 内部建立的 bt 网络，使得节点在拉取远端镜像时能从网络中进行 p2p 下载，有效利用集群内已有资源

## Quick start

```bash
git clone mirrorcask
cd mirrorcask
bash init.bash
```

在这之后，在每个希望使用 p2p 下载的节点添加镜像代理：

如在 ·/etc/containerd/config.toml· 中添加

```toml
   [plugins."io.containerd.grpc.v1.cri".registry.mirrors."docker.io"]
     endpoint = ["http://127.0.0.1:8080"]
```