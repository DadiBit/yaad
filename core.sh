#!/system/bin/env sh

# Default environment variables
: "${PM_USER_ID:=0}"
: "${YAAD_DIR:="$(dirname "$0")"}"
: "${TASKS_FILE:="$YAAD_DIR/tasks.sh"}"

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

# try to run cmd if available, if not, use pm
__pm() {
    ([ $cmd_package_service_exists -eq 0 ] && cmd package "$@" >/dev/null 2>&1) \
    || if [ "$1" = "uninstall" ]; then
        # uninstall always returns 0 (even if it fails)
        [ "$(pm "$@" 2>/dev/null)" = "Success" ]
    else
        pm "$@" >/dev/null 2>&1
    fi
}

# Disable a package
disable() {
    package="$1"
    printf "....... disable %s" "$package"
    if __pm disable "$package"; then
        printf "\rsuccess\n"
    elif __pm disable --user "$PM_USER_ID" "$package"; then
        printf "\rpartial\n"
    elif __pm disable-user "$package"; then
        printf "\rpartial\n"
    elif __pm disable-user --user "$PM_USER_ID" "$package"; then
        printf "\rpartial\n"
    else
        printf "\rfailure\n"
    fi
}

# Remove a package
remove() {
    package="$1"
    printf "....... remove  %s" "$package"
    if __pm uninstall -k "$package"; then
        printf "\rsuccess\n"
    elif __pm uninstall -k --user "$PM_USER_ID" "$package"; then
        printf "\rpartial\n"
        disable "$package"
    else
        printf "\rfailure\n"
    fi
}

install() {
    package="$1"
    printf "....... install %s" "$package"
# Source tasks file instead of creating new shell via `sh` -> share functions
# shellcheck disable=SC1090
. "$TASKS_FILE"
