#!/bin/sh
set -e
sudo install -Dm644 /dev/stdin /etc/floorp/policies/policies.json <<'EOF'
{
  "policies": {
    "DisableAppUpdate": true,
    "ExtensionSettings": {
      "{b9edf38a-e293-4606-a088-e63cd4e56d2d}": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/%7Bb9edf38a-e293-4606-a088-e63cd4e56d2d%7D/latest.xpi"
      },
      "{07c6b8e1-94f7-4bbf-8e91-26c0a8992ab5}": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/%7B07c6b8e1-94f7-4bbf-8e91-26c0a8992ab5%7D/latest.xpi"
      },
      "pinboard-webextension@helloworld.ro": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/pinboard-webextension@helloworld.ro/latest.xpi"
      },
      "Tab-Session-Manager@sienori": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/Tab-Session-Manager@sienori/latest.xpi"
      },
      "sponsorBlocker@ajay.app": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/sponsorBlocker@ajay.app/latest.xpi"
      },
      "deArrow@ajay.app": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/deArrow@ajay.app/latest.xpi"
      },
      "clipper@obsidian.md": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/clipper@obsidian.md/latest.xpi"
      },
      "leechblockng@proginosko.com": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/leechblockng@proginosko.com/latest.xpi"
      },
      "{cb31ec5d-c49a-4e5a-b240-16c767444f62}": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/%7Bcb31ec5d-c49a-4e5a-b240-16c767444f62%7D/latest.xpi"
      },
      "{3c078156-979c-498b-8990-85f7987dd929}": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/%7B3c078156-979c-498b-8990-85f7987dd929%7D/latest.xpi"
      },
      "{aecec67f-0d10-4fa7-b7c7-609a2db280cf}": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/%7Baecec67f-0d10-4fa7-b7c7-609a2db280cf%7D/latest.xpi"
      },
      "benwinding@gmail.com": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/benwinding@gmail.com/latest.xpi"
      },
      "{446900e4-71c2-419f-a6a7-df9c091e268b}": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/%7B446900e4-71c2-419f-a6a7-df9c091e268b%7D/latest.xpi"
      },
      "7esoorv3@alefvanoon.anonaddy.me": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/7esoorv3@alefvanoon.anonaddy.me/latest.xpi"
      },
      "jid1-xUfzOsOFlzSOXg@jetpack": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/jid1-xUfzOsOFlzSOXg@jetpack/latest.xpi"
      },
      "addon@darkreader.org": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/addon@darkreader.org/latest.xpi"
      },
      "{762f9885-5a13-4abd-9c77-433dcd38b8fd}": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/%7B762f9885-5a13-4abd-9c77-433dcd38b8fd%7D/latest.xpi"
      },
      "{799c0914-748b-41df-a25c-22d008f9e83f}": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/%7B799c0914-748b-41df-a25c-22d008f9e83f%7D/latest.xpi"
      },
      "uBlock0@raymondhill.net": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/uBlock0@raymondhill.net/latest.xpi"
      },
      "real-time-stable@reveddit.com": {
        "installation_mode": "normal_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/real-time-stable@reveddit.com/latest.xpi"
      }
    }
  }
}
EOF
