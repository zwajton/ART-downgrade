# ART Uninstall (Magisk Module)

A Magisk module that allows you to uninstall the Android Runtime (ART) APEX package directly from the Magisk app (or other root app that supports this) using an Action button.

⚠ **Warning:** This module modifies a core system component. There is a real risk of bootloop after reboot.

---

## Features

* Action button inside Magisk
* Attempts to uninstall:

  * `com.android.art`
  * `com.google.android.art`
* Automatically reboots **only if uninstall was successful**
* Exits safely if package is not present
* Live status shown in module description:

  * `installed`
  * `uninstalled`
  * `not present`

* Visual example
<img width="1080" height="452" alt="image0" src="https://github.com/user-attachments/assets/7ba67c31-d7c5-42f5-ad22-2f7f4d10ec85" />

---

## How It Works
### Action Button

When pressed:

1. Runs:
   ```
   pm uninstall com.android.art
   pm uninstall com.google.android.art
   ```
2. If uninstall succeeds → device reboots after 10 seconds.
3. If not found or failed → exits without reboot.

---

### Background Service

A `service.sh` script:

* Waits for full Android boot
* Checks ART APEX state hourly using:
  ```
  pm path <package>
  ```
* Updates `module.prop` description with current status

APEX detection logic:

* `/data/apex/active/` → **installed**
* `/data/apex/decompressed/` → **uninstalled**
* No output → **not present**

* Visual example
<img width="1080" height="452" alt="image0" src="https://github.com/user-attachments/assets/7ba67c31-d7c5-42f5-ad22-2f7f4d10ec85" />

---

## Requirements

This module requires that your phone is rooted. Root handler programs that this module is working on:

- Magisk 29+
- Kitsune
- Apatch
- KSU
- KSUWebUIStandaloneApp

---

## ⚠ Important Warning

Uninstalling ART may:

* Cause bootloop
* Break system runtime
* Prevent apps from launching
* Require full firmware restore

Use at your own risk.

---

## Installation

1. Download the latest release ZIP.
2. Flash via Root handler → Modules → Install from storage.
3. Reboot the phone.
4. Open your Root handler (or KSUWebUIStandaloneApp)
5. Navigate to Modules
6. Press the **Action** button for _ART Uninstall_.

---

## Disclaimer

This module is intended for advanced users only.

The author is not responsible for:

* Bootloops
* Data loss
* Device damage
