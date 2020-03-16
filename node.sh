#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/bin:/sbin
export PATH


function ssr(){
    echo -e "\033[42;37m 正在检测docker运行状态 \033[0m"
    docker version > /dev/null || curl -fsSL get.docker.com | bash
    service docker restart

    echo -e "\033[42;37m 选择SSR安装版本 \033[0m"
    echo "[1] docker版SSR普通版"
    echo "[2]docker版SSR后端端口偏移版"
    echo -e "\033[41;33m 输入1或2进行选择:"
    read opt
    echo " "
    echo "---------------------------------------------------------------------------"


    if [$opt==1]
    then
        
        echo " "
        echo -e "\033[42;37m 请输入对接域名 \033[0m 参考格式 http://sspanel.com"
        read host_1
        echo " "

        echo " "
        echo -e "\033[42;37m 请输入muKey \033[0m 参考格式 sspanel"
        read muKey_1
        echo " "

        echo " "
        echo -e "\033[42;37m 请输入节点ID \033[0m 参考格式 42"
        read nodeid_1
        echo " "

        echo " "
        echo "---------------------------------------------------------------------------"
        echo -e "\033[41;33m 请确认下列信息无误 \033[0m"
        echo -e "\033[41;33m docker容器名 \033[0m ssrmu"
        echo -e "\033[42;37m 对接域名 \033[0m $host_1"
        echo -e "\033[42;37m muKey \033[0m $muKey_1"
        echo -e "\033[42;37m 节点ID \033[0m $nodeid_1"
        echo " "
        echo -e "\033[41;33m 回车以继续，ctrl+C退出 \033[0m"
        echo " "
        echo "---------------------------------------------------------------------------"


        docker run -d --name=ssrmu -e NODE_ID=$nodeid_1 -e API_INTERFACE=modwebapi -e WEBAPI_URL=$host_1 -e WEBAPI_TOKEN=nodeid_1 --network=host --log-opt max-size=50m --log-opt max-file=3 --restart=always fanvinga/docker-ssrmu

        echo -e "\033[42;37m 安装完成 \033[0m"


    elif [$opt==2]
    then
        echo " "
        echo -e "\033[42;37m 请输入对接域名 \033[0m 参考格式 http://sspanel.com"
        read host_2
        echo " "

        echo " "
        echo -e "\033[42;37m 请输入muKey \033[0m 参考格式 sspanel"
        read muKey_2
        echo " "

        echo " "
        echo -e "\033[42;37m 请输入节点ID \033[0m 参考格式 42"
        read nodeid_2
        echo " "

        echo " "
        echo -e "\033[42;37m 请输入原端口 \033[0m"
        read port_1
        echo " "

        echo " "
        echo -e "\033[42;37m 请输入偏移后端口 \033[0m"
        read port_2
        echo " "

        echo " "
        echo "---------------------------------------------------------------------------"
        echo -e "\033[41;33m 请确认下列信息无误 \033[0m"
        echo -e "\033[41;33m docker容器名 \033[0m ssrmuv2"
        echo -e "\033[42;37m 对接域名 \033[0m $host_2"
        echo -e "\033[42;37m muKey \033[0m $muKey_2"
        echo -e "\033[42;37m 节点ID \033[0m $nodeid_2"
        echo -e "\033[42;37m 原端口 \033[0m $port_1"
        echo -e "\033[42;37m 偏转后端口 \033[0m $port_2"
        echo " "
        echo -e "\033[41;33m 回车以继续，ctrl+C退出 \033[0m"
        echo " "
        echo "---------------------------------------------------------------------------"

        docker run -d --name=ssrmuv2 -e NODE_ID=$nodeid_2 -e API_INTERFACE=modwebapi -e WEBAPI_URL=$host_2  -e SPEEDTEST=0 -e WEBAPI_TOKEN=$muKey_2 --log-opt max-size=50m --log-opt max-file=3 -p $port_2:$port_1/tcp -p $port_2:$port_1/udp  --restart=always stone0906/ssrmuv2

        echo -e "\033[42;37m 安装完成 \033[0m"

        else
        echo -e "\033[42;37m 输入错误 \033[0m"
        echo " "
        bash ./node.sh

        fi
}

function v2ray(){
    echo "###   v2ray后端一键对接脚本v1.0   ###"
    echo "###     By Linux_Terminal       ###"
    echo "###   Update: 2020-03-16      ###"

    echo " "
    echo -e "\033[41;33m 本功能仅支持Debian 9，请勿在其他系统中运行 \033[0m"
    echo " "
    echo "---------------------------------------------------------------------------"
    echo " "

    echo " "
    echo -e "\033[42;37m 请输入对接域名 \033[0m 参考格式 http://sspanel.com"
    read host
    echo " "

    echo " "
    echo -e "\033[42;37m 请输入muKey \033[0m 参考格式 sspanel"
    read muKey
    echo " "

    echo " "
    echo -e "\033[42;37m 请输入节点ID \033[0m 参考格式 42"
    read nodeid
    echo " "

    echo " "
    echo "---------------------------------------------------------------------------"
    echo -e "\033[41;33m 请确认下列信息无误，任何失误需要重置操作系统！\033[0m"
    echo -e "\033[42;37m 对接域名 \033[0m $host"
    echo -e "\033[42;37m muKey \033[0m $muKey"
    echo -e "\033[42;37m 节点ID \033[0m $nodeid"
    echo " "
    echo -e "\033[41;33m 回车以继续，ctrl+C退出 \033[0m"
    echo " "
    echo "---------------------------------------------------------------------------"

    read -n 1
    apt-get update -y
    apt-get install curl -y
    bash <(curl -L -s  https://raw.githubusercontent.com/linux-terminal/v2ray-sspanel-v3-mod_Uim-plugin/master/install-release.sh) \
    --panelurl $host --panelkey $muKey --nodeid $nodeid \
    --downwithpanel 1 --speedtestrate 6 --paneltype 0 --usemysql 0
    systemctl start v2ray.service
    echo " "
    echo " "
    echo -e "\033[42;37m 安装完成 \033[0m"
}

function bbr(){
    wget --no-check-certificate -O tcp.sh https://github.com/cx9208/Linux-NetSpeed/raw/master/tcp.sh && chmod +x tcp.sh && ./tcp.sh
}

function brook(){
    wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubiBackup/doubi/master/brook-pf.sh && chmod +x brook-pf.sh && bash brook-pf.sh
}

function menu(){
    echo "###       node toolv1.0      ###"
    echo "###  By Twitter@Linux_Terminal ###"
    echo "###   Update: 2020-03-16      ###"
    echo ""

    echo "---------------------------------------------------------------------------"

    echo -e "\033[42;37m [1] \033[0m 安装docker版SSR后端"
    echo -e "\033[42;37m [2] \033[0m 安装v2ray后端"
    echo -e "\033[42;37m [3] \033[0m 安装brook中转后端"
    echo -e "\033[42;37m [3] \033[0m 安装bbr加速"
    echo -e "\033[41;33m 请输入选项以继续，ctrl+C退出 \033[0m"

    read opt
    if [$opt==1]
    then
        ssr

    elif [$opt==2]
    then
        v2ray

    elif [$opt==3]
    then
        brook
    
    else
        echo -e "\033[41;33m 输入错误 \033[0m"
        bash ./node.sh
    fi
}

menu
