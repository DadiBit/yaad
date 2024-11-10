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

Push both `core.sh` and `tasks.sh` to your device:

```bash
adb push core.sh /data/local/tmp/yaad/core.sh
adb push tasks.sh /data/local/tmp/yaad/tasks.sh
```

Run the `core.sh` script, with the `tasks.sh` as argument:

```bash
adb shell sh /data/local/tmp/yaad/core.sh /data/local/tmp/yaad/tasks.sh
```

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
