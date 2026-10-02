# macOS Terminal Development Setup

A reproducible setup for a Mac with Apple Silicon (M1/M2/M3/M4), using:

- **Alacritty** — terminal emulator
- **Rosé Pine Moon** — terminal/editor theme
- **JetBrains Mono** — programming font
- **Neovim** — editor
- **Lazy.nvim** — Neovim plugin manager
- **Telescope** — fuzzy finder
- **Treesitter** — syntax highlighting / parsing
- **Mason** — external development-tool installer
- **LSP** — Go, Swift, TypeScript/JavaScript, Lua
- **tmux** — terminal multiplexer
- **Zsh** — shell

The setup uses 4 spaces for indentation.

---

### Table of Contents

- [1. Homebrew](#1-homebrew)
- [2. Alacritty](#2-alacritty)
- [3. Alacritty configuration](#3-alacritty-configuration)
- [4. JetBrains Mono](#4-jetbrains-mono)
- [5. Rose Pine Moon for Alacritty](#5-rose-pine-moon-for-alacritty)
- [6. Zsh](#6-zsh)
- [7. Git](#7-git)
- [8. Neovim](#8-neovim)
- [9. Neovim configuration directory](#9-neovim-configuration-directory)
- [10. Lazy.nvim](#10-lazynvim)
- [11. Neovim configuration](#11-neovim-configuration)
- [12. Start Neovim](#12-start-neovim)
- [13. Neovim plugins](#13-neovim-plugins)
- [14. Telescope dependencies](#14-telescope-dependencies)
- [15. Treesitter](#15-treesitter)
- [16. LSP](#16-lsp)
- [17. LSP shortcuts](#17-lsp-shortcuts)
- [18. tmux](#18-tmux)
- [19. tmux configuration](#19-tmux-configuration)
- [20. Recommended tmux workflow](#20-recommended-tmux-workflow)
- [21. Suggested project workflow](#21-suggested-project-workflow)
- [22. Health checks](#22-health-checks)
- [23. Complete installation checklist](#23-complete-installation-checklist)
- [24. Configuration locations](#24-configuration-locations)
- [25. Backup / migrate to another Mac](#25-backup--migrate-to-another-mac)
- [26. Quick reference](#26-quick-reference)
- [27. Result](#27-result)

# 1. Homebrew

Homebrew is used to install command-line tools.

If Homebrew is not installed:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Verify:

```bash
brew --version
```

On Apple Silicon Macs, Homebrew normally lives under:

```text
/opt/homebrew
```

Make sure `/opt/homebrew/bin` is in your PATH if the installer asks you to configure it.

---

# 2. Alacritty

Download the latest macOS `.dmg` from the official releases:

https://github.com/alacritty/alacritty/releases

For Apple Silicon, use:

```text
Alacritty-vX.Y.Z.dmg
```

Open the DMG and drag `Alacritty.app` to `/Applications`.

If macOS blocks it with Gatekeeper, use:

**System Settings → Privacy & Security → Open Anyway**

Verify:

```bash
/Applications/Alacritty.app/Contents/MacOS/alacritty --version
```

Optional shell command:

```bash
sudo ln -s /Applications/Alacritty.app/Contents/MacOS/alacritty /usr/local/bin/alacritty
```

Do not disable Gatekeeper globally.

# 3. Alacritty configuration

Create the configuration directory:

```bash
mkdir -p ~/.config/alacritty
```

Create:

```text
~/.config/alacritty/alacritty.toml
```

Use:

```toml
[window]
opacity = 0.92
padding = { x = 12, y = 10 }
decorations = "Buttonless"

[font]
normal = { family = "JetBrains Mono", style = "Regular" }
bold = { family = "JetBrains Mono", style = "Bold" }
italic = { family = "JetBrains Mono", style = "Italic" }
size = 14.0

[selection]
save_to_clipboard = true

[scrolling]
history = 10000

[general]
import = [
    "~/.config/alacritty/rose-pine-moon.toml"
]
```

If you want more transparency:

```toml
opacity = 0.88
```

---

# 4. JetBrains Mono

Install:

```bash
brew install --cask font-jetbrains-mono
```

Verify that the font is available in:

**Font Book → JetBrains Mono**

Alacritty will use it through:

```toml
[font]
normal = { family = "JetBrains Mono", style = "Regular" }
bold = { family = "JetBrains Mono", style = "Bold" }
italic = { family = "JetBrains Mono", style = "Italic" }
size = 14.0
```

---

# 5. Rose Pine Moon for Alacritty

Create:

```text
~/.config/alacritty/rose-pine-moon.toml
```

Use:

```toml
[colors.primary]
background = "#232136"
foreground = "#e0def4"

[colors.cursor]
text = "#232136"
cursor = "#e0def4"

[colors.selection]
text = "#e0def4"
background = "#44415a"

[colors.normal]
black = "#393552"
red = "#eb6f92"
green = "#a3be8c"
yellow = "#f6c177"
blue = "#569fba"
magenta = "#c4a7e7"
cyan = "#9ccfd8"
white = "#e0def4"

[colors.bright]
black = "#6e6a86"
red = "#eb6f92"
green = "#a3be8c"
yellow = "#f6c177"
blue = "#569fba"
magenta = "#c4a7e7"
cyan = "#9ccfd8"
white = "#e0def4"
```

Restart Alacritty.

---

# 6. Zsh

macOS uses Zsh by default.

Check:

```bash
echo $SHELL
```

Expected:

```text
/bin/zsh
```

Your main Zsh configuration is:

```text
~/.zshrc
```

Useful aliases:

```bash
alias vi="nvim"
alias vim="nvim"
```

After changing `.zshrc`:

```bash
source ~/.zshrc
```

---

# 7. Git

Git is useful for both Neovim plugins and development.

Verify:

```bash
git --version
```

If GitHub plugin downloads frequently fail with:

```text
unexpected disconnect while reading sideband packet
fatal: early EOF
```

try forcing Git to use HTTP/1.1:

```bash
git config --global http.version HTTP/1.1
```

Test GitHub connectivity:

```bash
git clone --depth 1 https://github.com/neovim/nvim-lspconfig.git /tmp/nvim-lspconfig
```

Clean up:

```bash
rm -rf /tmp/nvim-lspconfig
```

---

# 8. Neovim

Install:

```bash
brew install neovim
```

Verify:

```bash
nvim --version
```

This configuration expects a current Neovim release with the modern LSP API.

Check the executable:

```bash
which nvim
```

Usually on Apple Silicon Homebrew:

```text
/opt/homebrew/bin/nvim
```

---

# 9. Neovim configuration directory

Create:

```bash
mkdir -p ~/.config/nvim
```

Main configuration:

```text
~/.config/nvim/init.lua
```

---

# 10. Lazy.nvim

Install Lazy.nvim:

```bash
git clone --filter=blob:none https://github.com/folke/lazy.nvim.git \
  ~/.local/share/nvim/lazy/lazy.nvim
```

Lazy.nvim will then be added to Neovim's runtime path by `init.lua`.

---

# 11. Neovim configuration

Replace:

```text
~/.config/nvim/init.lua
```

with:

```lua
-- ============================================
-- Options
-- ============================================

vim.opt.number = true
vim.opt.relativenumber = true

-- 4 spaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.cursorline = true
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.g.mapleader = " "
vim.g.maplocalleader = " "


-- ============================================
-- Lazy.nvim
-- ============================================

vim.opt.rtp:prepend(
    vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
)


-- ============================================
-- Plugins
-- ============================================

require("lazy").setup({

    -- ========================================
    -- Rosé Pine Moon
    -- ========================================

    {
        "rose-pine/neovim",
        name = "rose-pine",
        priority = 1000,

        config = function()
            require("rose-pine").setup({
                variant = "moon",

                styles = {
                    transparency = true,
                },
            })

            vim.cmd("colorscheme rose-pine")
        end,
    },


    -- ========================================
    -- Telescope
    -- ========================================

    {
        "nvim-telescope/telescope.nvim",
        version = "*",

        dependencies = {
            "nvim-lua/plenary.nvim",

            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },

            "nvim-tree/nvim-web-devicons",
        },

        config = function()
            local telescope = require("telescope")

            telescope.setup({
                defaults = {
                    layout_config = {
                        horizontal = {
                            preview_width = 0.5,
                        },
                    },
                },
            })

            telescope.load_extension("fzf")
        end,
    },


    -- ========================================
    -- Treesitter
    -- ========================================

    {
        "nvim-treesitter/nvim-treesitter",

        lazy = false,

        build = ":TSUpdate",

        config = function()

            require("nvim-treesitter").setup({
                install_dir = vim.fn.stdpath("data") .. "/site",
            })

            require("nvim-treesitter").install({
                "go",
                "gomod",
                "gosum",
                "gowork",

                "swift",

                "typescript",
                "javascript",
                "tsx",

                "lua",

                "bash",
                "json",
                "yaml",
                "toml",

                "markdown",
                "markdown_inline",
            })

            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "go",
                    "gomod",
                    "gosum",
                    "gowork",

                    "swift",

                    "typescript",
                    "javascript",
                    "typescriptreact",
                    "javascriptreact",

                    "lua",

                    "bash",
                    "json",
                    "yaml",
                    "toml",

                    "markdown",
                },

                callback = function()
                    vim.treesitter.start()

                    vim.wo.foldexpr =
                        "v:lua.vim.treesitter.foldexpr()"

                    vim.wo.foldmethod = "expr"
                end,
            })
        end,
    },


    -- ========================================
    -- Mason
    -- ========================================

    {
        "mason-org/mason.nvim",
        opts = {},
    },


    -- ========================================
    -- Mason LSP integration
    -- ========================================

    {
        "mason-org/mason-lspconfig.nvim",

        opts = {
            ensure_installed = {
                "gopls",
                "lua_ls",
                "ts_ls",
            },

            automatic_enable = true,
        },

        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
        },
    },


    -- ========================================
    -- LSP
    -- ========================================

    {
        "neovim/nvim-lspconfig",

        config = function()

            -- Lua
            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        runtime = {
                            version = "LuaJIT",
                        },

                        diagnostics = {
                            globals = {
                                "vim",
                            },
                        },

                        workspace = {
                            checkThirdParty = false,
                        },
                    },
                },
            })

            -- Go
            vim.lsp.config("gopls", {
                settings = {
                    gopls = {
                        gofumpt = true,
                        staticcheck = true,
                        usePlaceholders = true,
                    },
                },
            })

            -- TypeScript / JavaScript
            vim.lsp.config("ts_ls", {})

            -- Swift
            -- SourceKit-LSP comes with Xcode / Swift.
            vim.lsp.config("sourcekit", {})
            vim.lsp.enable("sourcekit")
        end,
    },
})


-- ============================================
-- Telescope keybindings
-- ============================================

local builtin = require("telescope.builtin")

vim.keymap.set(
    "n",
    "<leader>ff",
    builtin.find_files,
    { desc = "Find files" }
)

vim.keymap.set(
    "n",
    "<leader>fg",
    builtin.live_grep,
    { desc = "Live grep" }
)

vim.keymap.set(
    "n",
    "<leader>fb",
    builtin.buffers,
    { desc = "Buffers" }
)

vim.keymap.set(
    "n",
    "<leader>fh",
    builtin.help_tags,
    { desc = "Help" }
)


-- ============================================
-- LSP keybindings
-- ============================================

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)

        local opts = {
            buffer = event.buf,
        }

        vim.keymap.set(
            "n",
            "gd",
            vim.lsp.buf.definition,
            opts
        )

        vim.keymap.set(
            "n",
            "gD",
            vim.lsp.buf.declaration,
            opts
        )

        vim.keymap.set(
            "n",
            "gi",
            vim.lsp.buf.implementation,
            opts
        )

        vim.keymap.set(
            "n",
            "gr",
            vim.lsp.buf.references,
            opts
        )

        vim.keymap.set(
            "n",
            "K",
            vim.lsp.buf.hover,
            opts
        )

        vim.keymap.set(
            "n",
            "<leader>rn",
            vim.lsp.buf.rename,
            opts
        )

        vim.keymap.set(
            "n",
            "<leader>ca",
            vim.lsp.buf.code_action,
            opts
        )

        vim.keymap.set(
            "n",
            "<leader>d",
            vim.diagnostic.open_float,
            opts
        )

    end,
})
```

---

# 12. Start Neovim

```bash
nvim
```

Lazy.nvim should install the plugins.

You can also manually synchronize:

```text
:Lazy sync
```

Open Lazy's UI:

```text
:Lazy
```

---

# 13. Neovim plugins

The setup contains:

### Rosé Pine

```text
rose-pine/neovim
```

Theme:

```text
Rosé Pine Moon
```

### Telescope

```text
nvim-telescope/telescope.nvim
nvim-telescope/telescope-fzf-native.nvim
nvim-lua/plenary.nvim
nvim-tree/nvim-web-devicons
```

### Treesitter

```text
nvim-treesitter/nvim-treesitter
```

### LSP

```text
neovim/nvim-lspconfig
mason-org/mason.nvim
mason-org/mason-lspconfig.nvim
```

---

# 14. Telescope dependencies

Install:

```bash
brew install ripgrep fd
```

Telescope uses these for fast file and text searching.

Useful commands:

```text
Space ff
```

Find files.

```text
Space fg
```

Search text across the project.

```text
Space fb
```

List buffers.

```text
Space fh
```

Search Neovim help.

The leader key is:

```text
Space
```

---

# 15. Treesitter

Treesitter provides syntax parsing/highlighting for:

- Go
- Swift
- TypeScript
- JavaScript
- TSX
- Lua
- Bash
- JSON
- YAML
- TOML
- Markdown

Treesitter parsers are installed automatically by the configuration.

Check Treesitter:

```text
:checkhealth nvim-treesitter
```

---

# 16. LSP

The configuration supports:

| Language | LSP |
|---|---|
| Go | `gopls` |
| Swift | `sourcekit` |
| TypeScript | `ts_ls` |
| JavaScript | `ts_ls` |
| Lua | `lua_ls` |

Open Mason:

```text
:Mason
```

The following are installed through Mason:

```text
gopls
lua-language-server
typescript-language-server
```

Swift's SourceKit-LSP is supplied by the Swift/Xcode toolchain rather than Mason.

Check LSP health:

```text
:checkhealth vim.lsp
```

---

# 17. LSP shortcuts

When an LSP is attached:

| Shortcut | Action |
|---|---|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gi` | Go to implementation |
| `gr` | Find references |
| `K` | Documentation / hover |
| `Space rn` | Rename |
| `Space ca` | Code action |
| `Space d` | Diagnostics |

---

# 18. tmux

tmux allows terminal sessions to continue running independently of the terminal window.

Install:

```bash
brew install tmux
```

Verify:

```bash
tmux -V
```

Start a session:

```bash
tmux
```

Create a named session:

```bash
tmux new -s work
```

Detach:

```text
Ctrl-b d
```

List sessions:

```bash
tmux ls
```

Reattach:

```bash
tmux attach -t work
```

---

# 19. tmux configuration

Create:

```text
~/.tmux.conf
```

Use:

```tmux
# ============================================
# General
# ============================================

set -g default-terminal "tmux-256color"

set -g history-limit 10000

set -g mouse on

set -g escape-time 0

set -g focus-events on

set -g renumber-windows on


# ============================================
# Prefix
# ============================================

# Keep the default Ctrl-b prefix.
set -g prefix C-b


# ============================================
# Indexing
# ============================================

set -g base-index 1
setw -g pane-base-index 1


# ============================================
# Splitting
# ============================================

# Split horizontally
bind | split-window -h

# Split vertically
bind - split-window -v

unbind '"'
unbind %


# ============================================
# Pane navigation
# ============================================

bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R


# ============================================
# Pane resizing
# ============================================

bind -r H resize-pane -L 5
bind -r J resize-pane -D 5
bind -r K resize-pane -U 5
bind -r L resize-pane -R 5


# ============================================
# Reload
# ============================================

bind r source-file ~/.tmux.conf \; display-message "tmux config reloaded"


# ============================================
# Status bar
# ============================================

set -g status-position bottom
set -g status-interval 5

set -g status-left-length 40
set -g status-right-length 80

set -g status-left " #S "

set -g status-right " %Y-%m-%d  %H:%M "

setw -g window-status-format " #I:#W "
setw -g window-status-current-format " #I:#W "

set -g status-style "bg=#232136,fg=#e0def4"
setw -g window-status-style "bg=#232136,fg=#6e6a86"
setw -g window-status-current-style "bg=#44415a,fg=#e0def4,bold"


# ============================================
# Pane borders
# ============================================

set -g pane-border-style "fg=#393552"
set -g pane-active-border-style "fg=#c4a7e7"
```

Reload it from inside tmux:

```text
Ctrl-b r
```

---

# 20. Recommended tmux workflow

A simple development setup:

```text
tmux
```

Then create panes:

```text
Ctrl-b |
```

Split left/right.

```text
Ctrl-b -
```

Split top/bottom.

Move between panes:

```text
Ctrl-b h
Ctrl-b j
Ctrl-b k
Ctrl-b l
```

Resize:

```text
Ctrl-b H
Ctrl-b J
Ctrl-b K
Ctrl-b L
```

Detach:

```text
Ctrl-b d
```

Return later:

```bash
tmux attach
```

---

# 21. Suggested project workflow

Launch Alacritty.

Start tmux:

```bash
tmux new -s work
```

Go to your project:

```bash
cd ~/path/to/project
```

Start Neovim:

```bash
nvim
```

A typical tmux layout can then be:

```text
┌──────────────────────────────┬───────────────────┐
│                              │                   │
│          Neovim              │      shell        │
│                              │                   │
│                              │                   │
├──────────────────────────────┤                   │
│                              │                   │
│       running command        │                   │
│                              │                   │
└──────────────────────────────┴───────────────────┘
```

This keeps the editor and development processes inside a persistent tmux session.

---

# 22. Health checks

After installation, run:

```bash
nvim
```

Inside Neovim:

```text
:checkhealth
```

Then specifically:

```text
:checkhealth vim.lsp
:checkhealth telescope
:checkhealth nvim-treesitter
```

Check Mason:

```text
:Mason
```

Check plugins:

```text
:Lazy
```

---

# 23. Complete installation checklist

On a new Mac:

```bash
# Homebrew
brew --version

# Terminal tools
brew install ripgrep fd tmux neovim

# Font
brew install --cask font-jetbrains-mono

# Git
git --version

# Optional GitHub clone stability
git config --global http.version HTTP/1.1
```

Install Alacritty from the official release:

```text
https://github.com/alacritty/alacritty/releases
```

Then create:

```text
~/.config/alacritty/
~/.config/nvim/
```

Install Lazy.nvim:

```bash
git clone --filter=blob:none https://github.com/folke/lazy.nvim.git \
  ~/.local/share/nvim/lazy/lazy.nvim
```

Copy the following configuration files:

```text
~/.config/alacritty/alacritty.toml
~/.config/alacritty/rose-pine-moon.toml
~/.config/nvim/init.lua
~/.tmux.conf
~/.zshrc
```

Start:

```bash
alacritty
```

Then:

```bash
tmux new -s work
```

Then:

```bash
nvim
```

Run:

```text
:Lazy sync
```

and:

```text
:Mason
```

Verify LSP and Treesitter:

```text
:checkhealth vim.lsp
:checkhealth nvim-treesitter
```

---

# 24. Configuration locations

| Component | Configuration |
|---|---|
| Alacritty | `~/.config/alacritty/alacritty.toml` |
| Alacritty theme | `~/.config/alacritty/rose-pine-moon.toml` |
| Neovim | `~/.config/nvim/init.lua` |
| Lazy.nvim | `~/.local/share/nvim/lazy/` |
| tmux | `~/.tmux.conf` |
| Zsh | `~/.zshrc` |

---

# 25. Backup / migrate to another Mac

The most important files to keep are:

```text
~/.config/alacritty/
~/.config/nvim/
~/.tmux.conf
~/.zshrc
```

Do **not** copy the Lazy.nvim plugin directory between Macs unless you have a specific reason.

Instead, install Lazy.nvim again and let it restore the plugins:

```bash
git clone --filter=blob:none https://github.com/folke/lazy.nvim.git \
  ~/.local/share/nvim/lazy/lazy.nvim
```

Then launch:

```bash
nvim
```

and run:

```text
:Lazy sync
```

Mason-managed tools should likewise be installed on the new machine rather than copied from the old one.

---

# 26. Quick reference

## Terminal

```bash
alacritty
```

## tmux

```bash
tmux new -s work
tmux ls
tmux attach -t work
```

## Neovim

```bash
nvim
```

## Neovim plugin manager

```text
:Lazy
:Lazy sync
```

## LSP manager

```text
:Mason
```

## Health

```text
:checkhealth
:checkhealth vim.lsp
:checkhealth telescope
:checkhealth nvim-treesitter
```

## Telescope

```text
Space ff    Find files
Space fg    Search text
Space fb    Buffers
Space fh    Help
```

## LSP

```text
gd          Definition
gD          Declaration
gi          Implementation
gr          References
K           Hover/documentation
Space rn    Rename
Space ca    Code action
Space d     Diagnostics
```

## tmux

```text
Ctrl-b |    Horizontal split
Ctrl-b -    Vertical split
Ctrl-b h    Left pane
Ctrl-b j    Down pane
Ctrl-b k    Up pane
Ctrl-b l    Right pane
Ctrl-b d    Detach
Ctrl-b r    Reload config
```

---

# 27. Result

The final stack is:

```text
macOS
│
├── Alacritty
│   ├── JetBrains Mono
│   └── Rosé Pine Moon
│
├── Zsh
│
├── tmux
│
└── Neovim
    ├── Lazy.nvim
    ├── Rosé Pine Moon
    ├── Telescope
    ├── Treesitter
    ├── Mason
    ├── Mason-LSPconfig
    ├── nvim-lspconfig
    │
    ├── Go → gopls
    ├── Swift → SourceKit-LSP
    ├── TypeScript/JavaScript → ts_ls
    └── Lua → lua_ls
```

This README intentionally keeps the configuration files explicit so the setup can be reproduced on another Mac without relying on remembered commands or plugin UI state.
