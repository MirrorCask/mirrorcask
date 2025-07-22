# mirrorcask

Mirrorcask 是一套在 k8s 内部建立的 bt 网络，使得节点在拉取远端镜像时能从网络中进行 p2p 下载，有效利用集群内已有资源

## 原理

`mirrorcask` 在本地部署了一个 `http` 服务 `bt-agent`，并将其伪装成。`bt-agent` 能够劫持并响应 `Layer` 的下载请求，并根据集群内状况进行 `bt` 或直接下载并返回，并将其他其余请求原样发送给 `docker` 仓库。同时，`mirrorcask` 在启动时还会自动扫描 `containerd` 已有的 `layer` 并开始做种。

`mirrorcask` 还会部署若干 `metadata service` 服务，提供 `digest - infohash` 查询。

## 部署

```bash
git clone mirrorcask
cd mirrorcask
bash init.bash
```

在这之后，在每个希望使用 p2p 下载的节点添加镜像代理：

如在 `/etc/containerd/config.toml` 中添加

```toml
[plugins."io.containerd.grpc.v1.cri".registry.mirrors]
  [plugins."io.containerd.grpc.v1.cri".registry.mirrors."docker.io"]
    endpoint = ["http://127.0.0.1:2030"]
```

`bt-agent` 仓库中存在 `init-helper`，可以辅助添加代理：

```bash
kubectl apply -f init-helperyaml
kubectl cp ./config.toml default/<init-helper-pod-name>:/host/etc/containerd/config.toml
```

之后重启 `containerd`，`bt-agent` 仓库中同样存在 `restart.yaml` 能够重启全部节点的 `containerd`