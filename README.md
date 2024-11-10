# Yet Another Android Debloater

Yet Another Android Debloater (YAAD) is a tool to debloat Android devices.

> [!CAUTION]
> Early stage of development.

Advantages of YAAD over other tools:

1. Simple:
    - No python/java/js dependency
    - No dex binary compilation
    - Client shell `sh` script
    - Standard POSIX shell language
2. Lightweight:
    - Limited `adb` calls (push & run script, pull history)
    - Server needs only `adb push/pull` and `adb shell` commands
3. No root required
4. Flexible:
    - Can run anything (eg: your own binaries)
    - Supports complex logic (eg: if-else, loops, etc.)

## Usage

Push `core.sh`, `tasks.sh` and the `packages` directory (only needed for `install` task) to your device:

```bash
adb push core.sh /data/local/tmp/yaad/core.sh
adb push tasks.sh /data/local/tmp/yaad/tasks.sh
adb push packages /data/local/tmp/yaad/packages
```

Run the `core.sh` script:

```bash
adb shell sh /data/local/tmp/yaad/core.sh
```

### Environment variables

- `PM_USER_ID`: User ID to use for `cmd package`/`pm` commands (default: `0`)
- `YAAD_DIR`: Directory where YAAD files are located (default: same directory as `core.sh`)
- `TASKS_FILE`: Tasks file to use (default: `$YAAD_DIR/tasks.sh`)
- `PACKAGES_DIR`: Directory where packages apk are located (default: `$YAAD_DIR/packages`)

## TODO

- [ ] `cmd` -> `pm` fallback
- [ ] [uad-ng](https://github.com/Universal-Debloater-Alliance/universal-android-debloater-next-generation) integration
- [ ] device picking
- [ ] root support
- [ ] aggressive uninstall (don't keep data)
- [ ] testing on real-world devices
    - [ ] Huawei P20 Lite (ANE-L21)
        - [ ] EMUI 8.0.0.180(C432) - Android 8.0.0
        - [ ] EMUI 9.1.0.401(C432) - Android 9.1.0
    - [ ] Huawei Ascend Y330 (Y330-U01)
        - [ ] EmotionUI 2.0 - Android 4.2.2
    - [ ] Xiaomi Redmi Note 12
        - [ ] Xiaomi HyperOS 1.0.11.0.UMGEUXM - Android 14 UKQ1.230917.001

## License

[MIT](LICENSE)
