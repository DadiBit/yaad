#!/system/bin/env sh


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

# generic uninstall function
# uses cmd if available (faster), otherwise pm
__uninstall() {
    if [ $cmd_package_service_exists -eq 0 ]; then
        cmd package uninstall "$@" >/dev/null
    else
        test "$(pm uninstall "$@" 2>/dev/null)" = "Success"
    fi
}

remove() {
    package="$1"
    printf "....... remove  %s" "$package"
    if __uninstall -k "$package"; then
        printf "\rsuccess\n"
    elif __uninstall -k --user 0 "$package"; then
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
