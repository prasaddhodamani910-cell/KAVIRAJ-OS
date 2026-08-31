import sys
import json
import time

# Simulated Cloud Registry for Kaviraj OS Packages
REGISTRY = {
    "snake": {
        "version": "1.0",
        "description": "A classic snake game (TUI)",
        "script": "echo Starting Snake...\necho \033[32m  xxxxO\033[0m\necho Just kidding, ANSI snake is coming soon!\n"
    },
    "calc": {
        "version": "1.2",
        "description": "Command line calculator",
        "script": "echo Kaviraj Calculator v1.2\necho Type ai 'calculate 5+5' instead!\n"
    },
    "fetch": {
        "version": "2.0",
        "description": "System information fetcher",
        "script": "echo \033[1;36m  /\\  \033[0m OS: Kaviraj OS\necho \033[1;36m /  \\ \033[0m Host: ARM64 Bare-metal\necho \033[1;36m/____\\\033[0m Kernel: v3.5.0\n"
    }
}

def simulate_network():
    time.sleep(0.5)

if len(sys.argv) < 2:
    print("ERR: No command")
    sys.exit(1)

cmd = sys.argv[1]

if cmd == "list":
    simulate_network()
    for pkg, info in REGISTRY.items():
        print(f"{pkg}|{info['version']}|{info['description']}")
elif cmd == "install":
    if len(sys.argv) < 3:
        print("ERR: No package specified")
        sys.exit(1)
    pkg = sys.argv[2]
    simulate_network()
    if pkg in REGISTRY:
        print("OK")
        print(REGISTRY[pkg]["script"], end="")
    else:
        print("ERR: Package not found")
else:
    print("ERR: Unknown command")
