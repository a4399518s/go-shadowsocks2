#!/bin/bash
pip=$(curl ifconfig.me)
echo $pip
id=$(hostname)
region=$(echo $id | cut -d'-' -f1)

curl --location '35.240.135.67:8080/server/add.php' \
--header 'Content-Type: application/json' \
--data "{
    \"id\": \"$id\",
    \"ip\": \"$pip\",
    \"region\": \"$region\",
    \"redisHost\": \"127.0.0.1\"
}"



# read -p "请输入服务器名称：" serverId; 
# echo "服务器ID：$serverId"

# export SERVER_ID=$serverId
# echo "export SERVER_ID=$serverId" >> /etc/profile

mkdir -p /data/redis
cd /data/redis
wget https://oss-mobile-control.chattmi.com/app/r/redis-server
chmod u+x redis-server
nohup /data/redis/redis-server 1>/data/redis/redis-server.out 2>/data/redis/redis-server.err & echo $! > /data/redis/redis-server.pid

mkdir -p /data/java/jdk
cd /data/java/jdk
wget https://download.oracle.com/graalvm/21/latest/graalvm-jdk-21_linux-x64_bin.tar.gz
tar -xzvf graalvm-jdk-21_linux-x64_bin.tar.gz
export JAVA_HOME=/data/java/jdk/graalvm-jdk-21.0.1+12.1
export PATH=$JAVA_HOME/bin:$PATH
echo 'export JAVA_HOME=/data/java/jdk/graalvm-jdk-21.0.1+12.1' >> /etc/profile
echo 'export PATH=$JAVA_HOME/bin:$PATH' >> /etc/profile

mkdir /data/frp/
cd /data/frp/
wget https://oss-mobile-control.chattmi.com/app/f/frp_0.52.3_linux_amd64.tar.gz
tar -xzvf frp_0.52.3_linux_amd64.tar.gz
rm -rf frp_0.52.3_linux_amd64.tar.gz
wget https://oss-mobile-control.chattmi.com/app/f/config/1/$(hostname)/frpc.toml

nohup /data/frp/frp_0.52.3_linux_amd64/frpc -c /data/frp/frpc.toml 1>/data/frp/frpc.out 2>/data/frp/frpc.err & echo $! > /data/frp/frpc.pid

mkdir /data/java/server-agent
cd /data/java/server-agent
wget https://oss-mobile-control.chattmi.com/app/server/agent/8/frp-server-agent-0.0.1-SNAPSHOT.jar

export BASE_URL=http://35.240.135.67:8080
export SERVER_ID=$(hostname)
export SERVER_PASSWORD=cH1HnevnFGw3O8B5

echo 'export BASE_URL=http://35.240.135.67:8080' >> /etc/profile
echo "export SERVER_ID=$(hostname)" >> /etc/profile
echo "export SERVER_PASSWORD=cH1HnevnFGw3O8B5" >> /etc/profile

source /etc/profile
nohup java -jar /data/java/server-agent/frp-server-agent-0.0.1-SNAPSHOT.jar 1>/data/java/server-agent/frp-server-agent.out 2>/data/java/server-agent/frp-server-agent.err & echo $! > /data/java/server-agent/frp-server-agent.pid

mkdir /data/go-shadowsocks2
mkdir /data/go-shadowsocks2/log
mkdir /data/go-shadowsocks2/pid
cd /data/go-shadowsocks2
wget https://oss-mobile-control.chattmi.com/app/s/1/shadowsocks2-linux-amd64
chmod u+x shadowsocks2-linux-amd64
wget https://oss-mobile-control.chattmi.com/app/s/1/start.sh
# ```
# #!/bin/bash
# echo "0:"$0
# echo "1:"$1
# echo "2:"$2
# echo "3:"$3
# echo "4:"$4
# echo "5:"$5
# echo "6:"$6
# echo "7:"$7

# nohup /data/go-shadowsocks2/shadowsocks2-linux-amd64 \
#  -s "ss://$1:$2@:$3" \
#  -verbose  -rh "$4" -rp $5 -id "$6" -e $7 \
#  1>/data/go-shadowsocks2/log/shadowsocks2-$3.out \
#  2>/data/go-shadowsocks2/log/shadowsocks2-$3.err \
#  & echo $! >  /data/go-shadowsocks2/pid/shadowsocks2-$3.pid
# ```
chmod u+x start.sh