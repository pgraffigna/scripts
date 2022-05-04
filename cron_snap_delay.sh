# snap holding
sudo snap set system refresh.hold="$(date --iso-8601=seconds -d '+30 days')"

# check snap hold
snap refresh --time | grep ^hold

# crontab
sudo crontab -e
30 12 * * * /usr/bin/snap set system refresh.hold="$(date --iso-8601=seconds -d '+30 days')"

