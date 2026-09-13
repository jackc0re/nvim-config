# nvim-config

Personal Neovim config, rewritten for **Neovim 0.12+** with a focus on
startup time and editing performance. Primary machine is **Arch Linux**;
Windows keeps working — every OS-specific bit is guarded with
`vim.fn.has("win32")`.

Plugin manager: [lazy.nvim](https://github.com/folke/lazy.nvim) ·
Theme: **jackc0re** (custom colorscheme, `colors/jackc0re.lua`) ·
Picker: [fzf-lua](https://github.com/ibhagwan/fzf-lua)

## Theme: jackc0re

Custom colorscheme ported from my Zed theme:

- `colors/jackc0re.lua` — `:colorscheme jackc0re` entry
- `lua/jackc0re/palette.lua` — the canonical palette (single source of truth)
- `lua/jackc0re/init.lua` / `theme.lua` — loader + highlight groups
  (`transparent = true` via `setup{}` strips editor chrome backgrounds)
- `lua/lualine/themes/jackc0re.lua` — matching lualine theme
- `ports/jackc0re/` — the same palette ported to other apps (foot, btop,
  starship, Pi, Windows Terminal, herdr). See `ports/jackc0re/README.md`.

gruvbox.nvim (motaz-shokry) is kept in `lua/plugins/gruvbox.lua` but
`enabled = false` as a fallback — flip the flag and remove the
`colorscheme("jackc0re")` call in `init.lua` to go back.

## Requirements

- **Neovim 0.12+** (treesitter highlighting is built-in since 0.11)
- **A Nerd Font** (icons in bufferline/lualine/snacks)
- **fzf** + **ripgrep** — for the picker:
  Arch: `sudo pacman -S fzf ripgrep` · Windows: `scoop install fzf ripgrep`
- **A clipboard bridge** — Arch: `wl-clipboard` (Wayland) or `xclip`/`xsel`
  (X11); Windows: **win32yank**. Without win32yank Neovim spawns
  powershell.exe for *every* yank/paste (300ms–2s each!):
  `scoop install win32yank`
  (config warns at startup on Windows if it is missing)
- **tree-sitter CLI + a C compiler** — the rewritten `nvim-treesitter` (main
  branch) compiles parsers locally: `npm i -g tree-sitter-cli` plus a C
  compiler (Arch: `gcc` · Windows: MSVC `cl.exe` from VS Build Tools, or
  `scoop install zig`)
- **lazygit** (optional, `<leader>gg`)

**Windows Defender tip (Windows only):** add exclusions for `nvim.exe` and
`%LOCALAPPDATA%\nvim-data` — Defender real-time scanning is the single
biggest cause of slow process spawning (git/node/cargo) on Windows.

## Structure

```
init.lua                    -- entry: leader keys + requires
lua/config/options.lua      -- all settings (clipboard handling incl.)
lua/config/keymaps.lua      -- general keymaps
lua/config/autocmds.lua     -- yank highlight, cursor restore, ...
lua/plugins/*.lua           -- one file per plugin (lazy.nvim import)
colors/jackc0re.lua         -- :colorscheme jackc0re entry
lua/jackc0re/               -- custom colorscheme (palette + loader + lualine theme)
ports/jackc0re/             -- palette ports for non-nvim apps (see its README)
```

## Plugin set

| Purpose        | Plugin |
|----------------|--------|
| Theme          | **jackc0re** (custom, local) — gruvbox.nvim kept disabled as fallback |
| Statusline     | lualine.nvim (native theme support) |
| Tabline        | bufferline.nvim (tabs mode) |
| Picker         | fzf-lua |
| UI utilities   | snacks.nvim (explorer, dashboard, notifier, input, indent, statuscolumn) |
| Completion     | blink.cmp (+ emoji & sql sources) |
| LSP            | nvim-lspconfig via `vim.lsp.config`/`vim.lsp.enable` + mason + fidget |
| Python         | pyright (types/completions) + ruff server (lint/format/code actions; hover deferred to pyright) |
| Rust           | rustaceanvim (rust-analyzer) |
| Notes          | obsidian.nvim (fzf-lua finder, vault path is per-OS) |
| Treesitter     | nvim-treesitter (main branch, parser manager only) + textobjects |
| Formatting     | conform.nvim (format on save) |
| Misc           | which-key, nvim-autopairs, render-markdown.nvim |

Mason auto-installs on first run: `bash-language-server`, `clangd`, `gopls`,
`lua-language-server`, `marksman`, `pyright`, `ruff`, `stylua`, `prettierd`.
C# uses the official Roslyn LSP — not a Mason package, install manually:
`dotnet tool install -g roslyn-language-server --prerelease`.

Removed for speed/simplicity: oil (snacks.explorer kept), snacks.picker
(fzf-lua kept), dressing, mini.statusline, vim-sleuth, supermaven,
rustowl, tiny-glimmer, showkeys, tmux-navigator, auto-session,
gruvbox-material, mason-lspconfig.

## Keymaps (essentials)

| Keys | Action |
|------|--------|
| `<leader>ff / fg / fb / <leader><leader>` | files / live grep / builtin / buffers |
| `<leader>/` | grep current buffer |
| `<leader>e / E` | snacks explorer toggle / reveal current file |
| `<leader>gg` | lazygit |
| `gd / gr / gI / gy` | LSP definitions / references / implementations / types |
| `<leader>ds / ws` | document / workspace symbols |
| `<leader>ca / cr` | code action / rename |
| `<leader>cf` | format file (conform) |
| `<leader>th` | toggle inlay hints |
| `af / if / ac / ic / ao` | treesitter textobjects |
| `<leader>a / A` | swap next / previous parameter |
| `]m / [m` | next / previous function |
| `<leader>oo / on / os` | obsidian: quick switch / new note / search |
| `<leader>ot / od` | obsidian: today's daily / recent dailies |
| `<leader>ob / oc / ol` | obsidian: backlinks / toggle checkbox / links |

## Setup on a new machine

Arch (`~/.config/nvim`) or Windows (`%LOCALAPPDATA%\nvim`):

1. Clone/sync this repo to the path above
2. Open nvim — lazy.nvim installs everything fresh
3. `:checkhealth` — confirm fzf/rg/clipboard/tree-sitter are found
4. If treesitter parsers fail to install (leftovers from the frozen `master`
   branch era), wipe them once and restart:
   `rm -rf ~/.local/share/nvim/site/parser` (Arch) ·
   `Remove-Item -Recurse %LOCALAPPDATA%\nvim-data\site\parser` (Windows)
5. Mason auto-installs LSP servers + formatters on first run

## Why it's faster than before

- one picker (fzf-lua) instead of two, no duplicate/overlapping plugins
- no animation timers (tiny-glimmer ran at 125 FPS; snacks scroll/indent
  animations disabled)
- lazy loading: autopairs, conform, lualine, bufferline, which-key all load
  on events instead of at startup
- no update checks over the network at startup (`:Lazy update` is manual)
- treesitter on the maintained `main` branch (parsers built-in to Neovim)
- modern `vim.lsp.enable()` instead of the deprecated lspconfig framework
