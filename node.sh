#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/bin:/sbin
export PATH

which yum >/dev/null 2>/dev/null
if [ $? -ne 0 ]; then
    Main=apt-get
else
    Main=yum
fi

function ssr(){
    echo -e "\033[42;37m 正在检测docker运行状态 \033[0m"
    docker version > /dev/null || curl -fsSL get.docker.com | bash
    service docker restart

    echo -e "\033[42;37m 选择SSR安装版本 \033[0m"
    echo -e "\033[37m [1] docker版SSR普通版 \033[0m"
    echo -e "\033[37m [2] docker版SSR后端端口偏移版 \033[0m"
    echo -e "\033[41;33m 输入1或2进行选择: \033[0m"
    opt=0
    read opt
    echo " "
    echo "---------------------------------------------------------------------------"


    if [ "$opt"x = "1"x ]; then

        echo " "
        echo -e "\033[42;37m 请输入docker容器名 \033[0m 参考格式 ssrmu"
        read name
        echo " "

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
        echo -e "\033[41;33m docker容器名 \033[0m $name"
        echo -e "\033[42;37m 对接域名 \033[0m $host_1"
        echo -e "\033[42;37m muKey \033[0m $muKey_1"
        echo -e "\033[42;37m 节点ID \033[0m $nodeid_1"
        echo " "
        echo -e "\033[41;33m 回车以继续，ctrl+C退出 \033[0m"
        echo " "
        echo "---------------------------------------------------------------------------"


        docker run -d --name=ssrmu -e NODE_ID=$nodeid_1 -e API_INTERFACE=modwebapi -e WEBAPI_URL=$host_1 -e WEBAPI_TOKEN=nodeid_1 --network=host --log-opt max-size=50m --log-opt max-file=3 --restart=always fanvinga/docker-ssrmu

        echo -e "\033[42;37m 安装完成 \033[0m"


    elif [ "$opt"x = "2"x ]; then

        echo " "
        echo -e "\033[42;37m 请输入docker容器名 \033[0m 参考格式 ssrmu"
        read name
        echo " "

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
        echo -e "\033[41;33m docker容器名 \033[0m $name"
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

function v2ray_opt(){
    echo -e "\033[42;37m 选择v2ray安装版本 \033[0m"
    echo -e "\033[37m [1] bash版v2ray \033[0m"
    echo -e "\033[37m [2] rico授权版v2ray \033[0m"
    echo -e "\033[41;33m 输入1或2进行选择: \033[0m"

    read opt
    echo " "
    echo "---------------------------------------------------------------------------"

    if [ "$opt"x = "1"x ]; then
    v2ray

    elif [ "$opt"x = "2"x ]; then
    v2rico

    else
        echo -e "\033[41;33m 输入错误 \033[0m"
        bash ./node.sh
    fi
}

function v2ray(){
    echo "###   v2ray后端一键对接脚本v1.0   ###"
    echo "###     By Linux_Terminal       ###"
    echo "###     Update: 2020-03-16      ###"

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
    bash <(curl -L -s  https://raw.githubusercontent.com/linux-terminal/v2ray-sspanel-v3-mod_Uim-plugin-1/master/install-release.sh) \
    --panelurl $host --panelkey $muKey --nodeid $nodeid \
    --downwithpanel 1 --speedtestrate 6 --paneltype 0 --usemysql 0
    systemctl start v2ray.service
    echo " "
    echo " "
    echo -e "\033[42;37m 安装完成 \033[0m"
}

function v2rico(){
    echo -e "\033[42;37m 正在检测docker运行状态 \033[0m"
    docker version > /dev/null || curl -fsSL get.docker.com | bash
    service docker restart

    echo "###   v2ray rico授权版一键安装   ###"
    echo "###     By Linux_Terminal       ###"
    echo "###     Update: 2020-04-01      ###"
    echo " "
    echo -e "\033[41;33m 请先获取rico授权 \033[0m"
    echo -e "\033[41;33m 授权链接\033[0m https://t.me/Rico_V2_bot"
    echo " "
    echo "---------------------------------------------------------------------------"
    echo " "

    echo " "
    echo -e "\033[42;37m 请输入docker容器名 \033[0m 参考格式 v2ray"
    read name
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
    echo -e "\033[41;33m 请确认下列信息无误 \033[0m"
    echo -e "\033[41;33m docker容器名 \033[0m $name"
    echo -e "\033[42;37m 对接域名 \033[0m $host"
    echo -e "\033[42;37m muKey \033[0m $muKey"
    echo -e "\033[42;37m 节点ID \033[0m $nodeid"
    echo " "
    echo -e "\033[41;33m 回车以继续，ctrl+C退出 \033[0m"
    echo " "
    echo "---------------------------------------------------------------------------"

    read -n 1
        docker run -d --name=$name \
    -e speedtest=0  -e api_port=2333 -e usemysql=0 -e downWithPanel=0 \
    -e node_id=$nodeid -e sspanel_url=$host -e key=$muKey \
    --log-opt max-size=10m --log-opt max-file=5 \
    --network=host --restart=always \
    a3v8meq8wcqn2twa/a3v8meq:4.22.1.8

    echo " "
    echo " "
    echo -e "\033[42;37m 安装完成 \033[0m"

}

function bbr(){
    wget -N --no-check-certificate "https://github.com/ylx2016/Linux-NetSpeed/releases/download/sh/tcp.sh" && chmod +x tcp.sh && ./tcp.sh
}

function brook(){
    wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubiBackup/doubi/master/brook-pf.sh && chmod +x brook-pf.sh && bash brook-pf.sh
}

function dd(){
    echo -e "\033[41;33m 请选择需要安装的操作系统 \033[0m"
    echo -e "\033[42;37m [1] \033[0m Debian"
    echo -e "\033[42;37m [2] \033[0m Ubuntu"
    echo -e "\033[42;37m [3] \033[0m Cent OS"
    echo -e "\033[37m 请选择 \033[0m"
    os=null
    read opt
    if [ "$opt"x = "1"x ]; then
        os=d
    
    elif [ "$opt"x = "2"x ]; then
        os=u
    
    elif [ "$opt"x = "3"x ]; then
        os=c
    
     else
        echo -e "\033[41;33m 输入错误 \033[0m"
        bash ./node.sh

    fi
    echo " "

    echo " "
    echo -e "\033[41;33m 输入发行版本 \033[0m"
    echo -e "\033[37m 例如：Debian [9] Cent OS [7] \033[0m"
    read v
    echo " "

    echo " "
    echo -e "\033[41;33m 镜像类型 \033[0m"
    echo -e "\033[42;37m [1] \033[0m 32位"
    echo -e "\033[42;37m [2] \033[0m 64位"
    opt=0
    read opt
    if [ "$opt"x = "1"x ]; then
        type=32
    
    elif [ "$opt"x = "2"x ]; then
        type=64
    else
        echo -e "\033[41;33m 输入错误 \033[0m"
        bash ./node.sh
    fi
    echo " "

    echo " "
    echo -e "\033[41;33m 请输入root密码 \033[0m"
    read password
    echo " "

    echo " "
    echo "---------------------------------------------------------------------------"
    echo -e "\033[41;33m 请确认下列信息无误，任何失误需要重置操作系统！\033[0m"
    echo -e "\033[42;37m 操作系统 \033[0m $os"
    echo -e "\033[42;37m 发行版本 \033[0m $v"
    echo -e "\033[42;37m 镜像类型 \033[0m $type 位"
    echo -e "\033[42;37m root密码 \033[0m $password"
    echo " "
    echo -e "\033[41;33m 回车以继续，ctrl+C退出 \033[0m"
    echo " "
    echo "---------------------------------------------------------------------------"
    read -n 1
    echo " "
    echo  -e "\033[37m 开始安装，请静候10min！ \033[0m"

    bash <(wget --no-check-certificate -qO- 'https://moeclub.org/attachment/LinuxShell/InstallNET.sh') -$os $v -v $type -a -p $password
}

function dns(){
    echo -e "\033[41;33m 请选择需要安装的内容 \033[0m"
    echo -e "\033[42;37m [1] \033[0m 配置Dnsmasq"
    echo -e "\033[42;37m [2] \033[0m 配置DNS"
    echo -e "\033[37m 请选择 \033[0m"
    echo " "
    read opt

    if [ "$opt"x = "1"x ]; then
    echo "\033[42;37m [1] \033[0m 安装Dnsmasq"
    echo "\033[42;37m [2] \033[0m 卸载Dnsmasq"
    read opt

        if [ "$opt"x = "1"x ]; then
            wget --no-check-certificate -O dnsmasq_sniproxy.sh https://github.com/myxuchangbin/dnsmasq_sniproxy_install/raw/master/dnsmasq_sniproxy.sh && bash dnsmasq_sniproxy.sh -i
        elif [ "$opt"x = "2"x ]; then
            wget --no-check-certificate -O dnsmasq_sniproxy.sh https://github.com/myxuchangbin/dnsmasq_sniproxy_install/raw/master/dnsmasq_sniproxy.sh && bash dnsmasq_sniproxy.sh -u
        else
            echo -e "\033[41;33m 输入错误 \033[0m"
            bash ./node.sh
        fi
    elif [ "$opt"x = "2"x ]; then
        echo -e "\033[41;33m 输入DNS服务器IP \033[0m"
        read unlock_ip
        chattr -i /etc/resolv.conf && echo -e "nameserver $unlock_ip" > /etc/resolv.conf && chattr +i /etc/resolv.conf && systemd-resolve --flush-caches
        echo "---------------------------------------------------------------------------"
        echo -e "\033[41;33m 请确认下列信息无误，任何失误需要重置操作系统！\033[0m"
        echo " "
        echo -e "\033[42;37m DNS服务器IP \033[0m $unlock_ip"
        echo -e "\033[41;33m 回车以继续，ctrl+C退出 \033[0m"
        echo " "
        echo "---------------------------------------------------------------------------"
        
        echo " "
        read -n 1

        echo " "
        echo -e "\033[41;33m 配置成功，需要重启服务器，是否继续？(Y/n) \033[0m"
        read opt
            if [ "$opt"x = "Y"x ]; then
                reboot
            else
                bash ./node.sh
            fi
    fi
}

function donate (){
    $Main install qrencode -y
    echo -e "\033[42;37m [1] \033[0m 支付宝"
    echo -e "\033[42;37m [2] \033[0m 微信"
    echo " "
    read opt
    
    if [ "$opt"x = "1"x ]; then
        qrencode -l M -t UTF8 -k https://qr.alipay.com/fkx15280wdabfli9wnmdp1c

    elif [ "$opt"x = "2"x ]; then
        qrencode -l M -t UTF8 -k wxp://f2f1VUKyDPTr-BCsZHsqHsSBlbxI32o1zway
    
    else
        echo -e "\033[41;33m 输入错误 \033[0m"
        bash ./node.sh
    fi

    echo -e "\033[41;33m 感谢您的支持 \033[0m"
}

function swap(){
    wget https://www.moerats.com/usr/shell/swap.sh && bash swap.sh
}

function menu(){
    echo "###       node tool v3.0       ###"
    echo "###  By Twitter@Linux_Terminal ###"
    echo "###    Update: 2020-04-01      ###"
    echo ""
    echo -e "\033[41;33m 适用环境 Debian/Ubuntu/Cent OS \033[0m"
    echo "---------------------------------------------------------------------------"

    echo -e "\033[42;37m [1] \033[0m 安装docker版SSR后端"
    echo -e "\033[42;37m [2] \033[0m 安装v2ray后端"
    echo -e "\033[42;37m [3] \033[0m 安装brook中转后端"
    echo -e "\033[42;37m [4] \033[0m 安装bbr加速"
    echo -e "\033[42;37m [5] \033[0m 一键重装纯净系统"
    echo -e "\033[42;37m [6] \033[0m 一键配置DNS解锁"
    echo -e "\033[42;37m [7] \033[0m 一键设置swap"
    echo -e "\033[42;37m [0] \033[0m 捐赠开发者"
    echo -e "\033[41;33m 请输入选项以继续，ctrl+C退出 \033[0m"

    opt=0
    read opt
    if [ "$opt"x = "1"x ]; then
        ssr

    elif [ "$opt"x = "2"x ]; then
        v2ray_opt

    elif [ "$opt"x = "3"x ]; then
        brook
    
    elif [ "$opt"x = "4"x ]; then
        bbr
    
    elif [ "$opt"x = "5"x ]; then
        dd

    elif [ "$opt"x = "6"x ]; then
        dns

    elif [ "$opt"x = "7"x ]; then
        swap
        
    elif [ "$opt"x = "0"x ]; then
        donate
    
    else
        echo -e "\033[41;33m 输入错误 \033[0m"
        bash ./node.sh
    fi
}

menu
