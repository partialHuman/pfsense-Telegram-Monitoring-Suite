check_command() {

    command -v "$1" >/dev/null

}

check_file() {

    [ -f "$1" ]

}

