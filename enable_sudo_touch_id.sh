#!/usr/bin/env bash

if [[ ! -e /etc/pam.d/sudo_local ]]; then
  echo "Copy sudo_local.template to sudo_local"
  cp /etc/pam.d/sudo_local.template /etc/pam.d/sudo_local
fi

if grep -E '^#auth.+pam_tid.so' /etc/pam.d/sudo_local >/dev/null; then
  echo "Uncommenting line in sudo_local"
  sed -i.bak -r 's/^#(auth\s+sufficient\s+pam_tid.so)/\1/' /etc/pam.d/sudo_local
fi
