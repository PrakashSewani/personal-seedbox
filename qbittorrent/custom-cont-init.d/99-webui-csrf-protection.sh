#!/bin/bash

CONF="/config/qBittorrent/qBittorrent.conf"

# The image's init script copies the default conf on a fresh install and may
# run concurrently with this one, so wait briefly for it to appear.
for _ in $(seq 1 15); do
    [ -f "${CONF}" ] && break
    sleep 1
done

if [ ! -f "${CONF}" ]; then
    echo "[custom-init] webui-csrf-protection: ${CONF} not found, skipping"
    exit 0
fi

if grep -qF 'WebUI\CSRFProtection=' "${CONF}"; then
    sed -i 's|^WebUI\\CSRFProtection=.*|WebUI\\CSRFProtection=false|' "${CONF}"
else
    sed -i '/^\[Preferences\]/a WebUI\\CSRFProtection=false' "${CONF}"
fi

chown abc:abc "${CONF}"

echo "[custom-init] webui-csrf-protection: WebUI\\CSRFProtection=false ensured in ${CONF}"
