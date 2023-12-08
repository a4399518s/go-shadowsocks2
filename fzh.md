# 安装
```
export GO111MODULE=on
go install -u github.com/shadowsocks/go-shadowsocks2@latest
```
# 启动命令
```shell
go run . -s "ss://AEAD_CHACHA20_POLY1305:11111111@:10099" -verbose  -rh 10.20.10.21 -id 1 -e 1709768600
```

# 编译命令
```shell
make linux-amd64
```

wget https://oss-mobile-control.chattmi.com/app/server/agent/install.sh
sh install.sh