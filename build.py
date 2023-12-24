from pathlib import Path
from typing import Union


# Some Utils here
def system(command: str):
    from os import system as _system

    print(f"Run {command}")
    _system(command)


def check(value: Union[str, None]) -> bool:
    if isinstance(value, str):
        return len(value) != 0
    return False


root = str(Path(__file__).parent)

try:
    from yaml import load, Loader
except ModuleNotFoundError:
    system("python -m pip install pyyaml")
    from yaml import load, Loader

# Build Web Application
config = load(
    open(f"{root}/resource/config.yaml", "r", encoding="utf-8"),
    Loader=Loader,
)["build"]

if check(config["base-href"]):
    system(f"flutter build web --base-href {config['base-href']}")
else:
    system("flutter build web")

# Patch Proxy
mainJS = Path(f"{root}/build/web/main.dart.js")
if not mainJS.exists():
    exit(1)

with open(mainJS, "r", encoding="utf-8") as f:
    source = f.read()

proxy = config["google-proxy"]
if check(proxy["www"]):
    print("Patch www.gstatic.com")
    source = source.replace("www.gstatic.com", proxy["www"])

if check(proxy["fonts"]):
    print("Patch fonts.gstatic.com")
    source = source.replace("fonts.gstatic.com", proxy["fonts"])

with open(mainJS, "w", encoding="utf-8") as f:
    f.write(source)
