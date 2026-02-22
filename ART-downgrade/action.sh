#!/system/bin/sh

SUCCESS=0

print_line() {
  echo ""
  echo "================================="
  echo "$1"
  echo "================================="
}

run_uninstall() {
  PKG="$1"

  print_line "Running pm uninstall for $PKG"

  RESULT=$(pm uninstall "$PKG" 2>&1)

  echo ""
  echo "$RESULT"
  echo ""

  if echo "$RESULT" | grep -q "Success"; then
    print_line "Successfully uninstalled $PKG"
    SUCCESS=1
  elif echo "$RESULT" | grep -q "Unknown package"; then
    print_line "Couldn't find $PKG"
  else
    print_line "$RESULT"
  fi
}

print_line "Starting ART Uninstall Process"

run_uninstall "com.android.art"
run_uninstall "com.google.android.art"

# Only reboot if something was actually uninstalled
if [ "$SUCCESS" -eq 1 ]; then
  print_line "Reboot required to complete the uninstallation"
  echo ""
  echo "Rebooting in 10 seconds..."
  sleep 10
  reboot
else
  print_line "Nothing was uninstalled. Exiting..."
  sleep 3
fi