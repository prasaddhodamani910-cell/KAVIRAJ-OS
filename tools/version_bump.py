#!/usr/bin/env python3
import json, sys, os, re
from datetime import datetime

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
PROJECT_DIR = os.path.dirname(SCRIPT_DIR)
VERSION_FILE = os.path.join(PROJECT_DIR, "VERSION.json")
KERNEL_FILE = os.path.join(PROJECT_DIR, "src", "kernel.c")

UPDATE_TYPES = {
    "mega-update":   {"bump": "major", "label": "Mega Update"},
    "small-update":  {"bump": "minor", "label": "Small Update"},
    "few-update":    {"bump": "patch", "label": "Few Update"},
    "fix-patch":     {"bump": "patch", "label": "Fix Patch"},
    "mega-fix-pack": {"bump": "minor", "label": "Mega Fix Pack"},
    "quick-fix":     {"bump": "patch", "label": "Quick Fix"},
}

def load_version():
    with open(VERSION_FILE, "r") as f: return json.load(f)

def save_version(data):
    with open(VERSION_FILE, "w") as f:
        json.dump(data, f, indent=2)
        f.write("\n")

def main():
    if len(sys.argv) < 2:
        print("Usage: python3 tools/version_bump.py <type> [description]")
        sys.exit(1)
    
    utype = sys.argv[1].lower()
    if utype not in UPDATE_TYPES:
        sys.exit(1)
    info = UPDATE_TYPES[utype]
    desc = sys.argv[2] if len(sys.argv)>2 else ""
    changes = [c.strip() for c in desc.split(",") if c.strip()] or ["UI upgrades and fixes"]

    data = load_version()
    if info["bump"] == "major":
        data["major"] += 1; data["minor"] = 0; data["patch"] = 0
    elif info["bump"] == "minor":
        data["minor"] += 1; data["patch"] = 0
    else:
        data["patch"] += 1
    
    new_ver = f"v{data['major']}.{data['minor']}.{data['patch']}"
    data["label"] = info["label"]
    
    data["history"].insert(0, {
        "version": new_ver, "type": info["label"],
        "date": datetime.now().strftime("%Y-%m-%d"), "changes": changes
    })
    save_version(data)
    
    # Update kernel.c definition
    with open(KERNEL_FILE, "r") as f: content = f.read()
    content = re.sub(r'#define OS_VERSION\s+".*"', f'#define OS_VERSION  "{new_ver} ({info["label"]})"', content)
    with open(KERNEL_FILE, "w") as f: f.write(content)
    
    print(f"Bumped to {new_ver} ({info['label']})")

if __name__ == "__main__": main()
