# Pork Life
> 2025 Hit Game Developed @ NegroTech Incorporated Headquarters

A thrilling game about the escaping of John Pork's villa.

## Requirements

- Windows, MacOs or Linux
- For source: Foreman Package Manager

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
