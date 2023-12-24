from os import system
from pathlib import Path

try:
    from yaml import load, Loader
except ModuleNotFoundError:
    system("python -m pip install pyyaml")
    from yaml import load, Loader

config = load(
    open(f"{Path(__file__).parent}/resource/config.yaml", "r", encoding="utf-8"),
    Loader=Loader,
)["build"]

if config["base-href"] is None:
    system("flutter build web")
else:
    system(f"flutter build web --base-href {config['base-href']}")
