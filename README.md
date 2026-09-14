# Seedbox

Infrastructure for my local storage server.

## Start

docker compose up -d

## Stop

docker compose down

## Logs

docker compose logs -f

## Update

docker compose pull
docker compose up -d

Media Location

E:\Media

## qBittorrent WebUI fix

`qbittorrent/custom-cont-init.d/` is mounted into the qBittorrent container and
executed on every start (LinuxServer custom init hook). The script sets
`WebUI\CSRFProtection=false` in `/config/qBittorrent/qBittorrent.conf`.

Without it, opening the WebUI from a link on another site (e.g. the Cloudflare
dashboard) sends a `Referer` header that qBittorrent rejects, and the browser
shows "Unauthorized" instead of the login page.

The script re-applies the value on every start, so enabling CSRF protection in
the WebUI options will be overridden on the next restart. Delete the script to
opt out.