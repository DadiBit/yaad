#!/system/bin/env sh

: "${PM_USER_ID:=0}"

cmd_package_service_exists=1 #false

# if cmd is available
if command -v cmd >/dev/null 2>&1; then
    # check if "package" service exits
    cmd package >/dev/null 2>&1
    # 255 = exists, 20 = not found
    if [ $? -eq 255 ]; then
        cmd_package_service_exists=0 #true
    fi
# if pm is not available
elif ! command -v pm >/dev/null 2>&1; then
    printf "Neither cmd nor pm are available. Aborting.\n"
    exit 1
fi

# generic pm proxy: tries to run cmd if available, if not, uses pm
__pm() {
    ([ $cmd_package_service_exists -eq 0 ] && cmd package "$@" >/dev/null) \
    || [ "$(pm "$@" 2>/dev/null)" = "Success" ]
}

remove() {
    package="$1"
    printf "....... remove  %s" "$package"
    if __pm uninstall -k "$package"; then
        printf "\rsuccess\n"
    elif __pm uninstall -k --user "$PM_USER_ID" "$package"; then
        printf "\rpartial\n"
    else
        printf "\rfailure\n"
    fi
}

install() {
    package="$1"
    printf "....... install %s" "$package"
    # TODO
    printf "\rskipped\n"
}

# shellcheck disable=SC1090
. "$1"
