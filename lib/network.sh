internet_up() {

    ping -c 1 8.8.8.8 >/dev/null 2>&1

}

get_wan_ip() {

    fetch -qo - https://api.ipify.org

}

interface_up() {

    ifconfig "$1" | grep -q "status: active"

}