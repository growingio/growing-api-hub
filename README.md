# Growing HUB

Growing HUB 为 SDK 采集的数据提供一个中转的功能，即数据先经过您的服务再发送到 api.growingio.com 上。

# 使用

- 首先从 GitHub 上 `clone` 到本地
```
git clone https://github.com/growingio/growing-api-hub.git
```
- 在您的服务器上需要安装 [OpenResty](https://openresty.org/en/)，具体的安装方法请参考[官方文档](https://openresty.org/en/installation.html)
- 把 `conf` 目录下的 `*.conf.def` 重命名成 `*.conf`
- 在 https.conf 文件中配置您的 SSL 证书
```
ssl_certificate        /etc/ssl/certs/server.crt;
ssl_certificate_key    /etc/ssl/certs/server.key;

```
- 在 growing-hub 目录中执行启动命令
```
sudo bin/hub.sh
```

# 命令

- 重启
```
sudo bin/hub.sh -s reload
```

- 停止程序
```
sudo bin/hub.sh -s stop
```
