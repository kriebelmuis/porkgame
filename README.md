# Pork Life
> 2025 Hit Game Developed @ NegroTech Incorporated Headquarters

A thrilling game about the escaping of John Pork's villa.

## Trello

> [Link](https://trello.com/invite/b/677d5887acb9b24593a295e4/ATTIacf3a19417d6ac0ad8eea63a69d83390ADBDE206/jp-game)

## Requirements

- Windows, MacOs or Linux
- For source: Lune Standable Lua U Compiler

# Running game

### From Release

1. Download the latest release from the [releases page](https://github.com/kriebelmuis/porkgame/releases/latest)

### From Source (Compile binaries)

1. Clone repository:
    ```bash
    git clone https://github.com/kriebelmuis/porkgame.git
    ```
2. Navigate to project:
    ```bash
    cd porkgame
    ```
3. Process source code:
    ```bash
    darklua process main.luau main.bundled.luau
    ```
3. Run processed:
    ```bash
    lune build main.bundled.luau
    ```
