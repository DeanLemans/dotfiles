from promnesia.common import Source
from promnesia.sources import auto, browser

SOURCES = [
    Source(browser.index, name="floorp"),
    Source(
        auto.index,
        "/home/void/repositories/deanlemans.github.io/content/",
        name="pkm",
        ignored=["*/.obsidian/*", "*.trash/*"],
    ),
    Source(
        auto.index,
        "/home/void/Downloads",
        name="fuck ass downloads folder",
        ignored=["*/.tagstudio/*", "*.iso", "*.zip", "*.tar*", "*.AppImage", "*.pkg.tar*", "*.mp4", "*.mkv", "*.json", "*.jsond", "*.import", "*.py", "*.tmp", "*.ts", "*.css", "*.js", "*.lmu", "*.tsx", "*.mjs", "*.xyz", "*.ttf", "*.TTF", "*.ttc", "*.otf", "*.win"],
    ),
    Source(
        auto.index,
        "/home/void/repositories/nexus",
        name="shared projects folder",
        ignored=["*/.obsidian/*", "*.trash/*", "*/node_modules/*", "*.ts", "*.tsx", "*.js", "*.mjs"],
    ),
]
HOST = "127.0.0.1"
PORT = 13131
