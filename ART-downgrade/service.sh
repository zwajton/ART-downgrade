#!/system/bin/sh

MODDIR=${0%/*}

# Wait for full Android boot
while [ "$(getprop sys.boot_completed)" != "1" ]; do
  sleep 2
done

sleep 10

update_description() {

  check_apex() {
    PKG="$1"
    RESULT=$(pm path "$PKG" 2>/dev/null)

    if [ -z "$RESULT" ]; then
      echo "not present"
    elif echo "$RESULT" | grep -qi "/data/apex/active/"; then
      echo "installed"
    elif echo "$RESULT" | grep -qi "/data/apex/decompressed/"; then
      echo "uninstalled"
    else
      echo "unknown"
    fi
  }

  ART_STATUS=$(check_apex com.android.art)
  GART_STATUS=$(check_apex com.google.android.art)

  DESC="Action button will trigger the uninstalling of ART. Auto-reboot if succesful. [ com.android.art $ART_STATUS ] [ com.google.android.art $GART_STATUS ]"

  sed -i "s|^description=.*|description=$DESC|" "$MODDIR/module.prop"
}

# Run once
update_description

# Loop hourly
while true; do
  sleep 3600
  update_description
done