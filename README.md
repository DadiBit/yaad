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

## Is it safe?

**DO YOUR OWN RESEARCH**

_Usually_, it is safe, since android protects you from breaking your device.

- If you disable a crucial package you might softbrick your device.
- You can always factory reset your device, but that means you'll lose all your data.

- Also, disabling a package might severely degrade your device performance/battery life:
    1. Some apps are actually designed to balance performance and battery life.
    2. If an activity crashes since its package is disabled and gets called continuously from another package, it will drain your battery and maybe cause your device to bootloop.

- A good idea is to remove Google and OEM bloatware, and then very varefully picking more obscure apps.
    - Search online for the package name to find if there's a good reason to keep it.

- Sidenote: if you start with 200 packages, don't try to go below 100: it's silly and you'll break a bunch of stuff (NFC, WiFi, Bluetooth, battery, etc.)[^1].

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

## Resources

- [uad-ng](https://github.com/Universal-Debloater-Alliance/universal-android-debloater-next-generation)
- [milaq](https://milaq.net/android-bloatware/)

## License

[MIT](LICENSE)

[^1]: I personally did it the first time, and the phone was unusable (it booted, but I couldn't call or run some apps) until I factory reset it. I reccommend removing all the Google non-essential apps in addition to OEM bloatware.
