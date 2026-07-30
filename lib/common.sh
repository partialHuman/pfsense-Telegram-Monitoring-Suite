#!/bin/sh

timestamp() {
    date "+%Y-%m-%d %H:%M:%S"
}

log_info() {
    echo "[INFO] $(timestamp) $1"
}

log_warning() {
    echo "[WARNING] $(timestamp) $1"
}

log_error() {
    echo "[ERROR] $(timestamp) $1"
}

separator() {
    echo "------------------------------------------------"
}