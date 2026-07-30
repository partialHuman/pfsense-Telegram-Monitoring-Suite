get_state() {

    FILE="$1"

    [ -f "$FILE" ] && cat "$FILE"

}

save_state() {

    FILE="$1"

    VALUE="$2"

    echo "$VALUE" > "$FILE"

}