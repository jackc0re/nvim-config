# nvim-config

Personal Neovim config, rewritten for **Neovim 0.12+** with a focus on
startup time and editing performance on Windows.

Plugin manager: [lazy.nvim](https://github.com/folke/lazy.nvim) ·
Theme: [gruvbox.nvim (motaz-shokry)](https://gitlab.com/motaz-shokry/gruvbox.nvim) ·
Picker: [fzf-lua](https://github.com/ibhagwan/fzf-lua)

## Requirements

- **Neovim 0.12+** (treesitter highlighting is built-in since 0.11)
- **A Nerd Font** (icons in bufferline/lualine/snacks)
- **fzf** + **ripgrep** — for the picker:
  `scoop install fzf ripgrep`
- **win32yank** — fast system clipboard on Windows. Without it Neovim spawns
  powershell.exe for *every* yank/paste (300ms–2s each!):
  `scoop install win32yank`
  (config warns at startup if it is missing)
- **tree-sitter CLI + a C compiler** — the rewritten `nvim-treesitter` (main
  branch) compiles parsers locally:
  `npm i -g tree-sitter-cli` and either MSVC (`cl.exe`, from VS Build Tools)
  or `scoop install zig`
- **lazygit** (optional, `<leader>gg`)

**Windows Defender tip:** add exclusions for `nvim.exe` and
`%LOCALAPPDATA%\nvim-data` — Defender real-time scanning is the single
biggest cause of slow process spawning (git/node/cargo) on Windows.

## Structure

```
init.lua                    -- entry: leader keys + requires
lua/config/options.lua      -- all settings (clipboard handling incl.)
lua/config/keymaps.lua      -- general keymaps
lua/config/autocmds.lua     -- yank highlight, cursor restore, ...
lua/plugins/*.lua           -- one file per plugin (lazy.nvim import)
```

## Plugin set (after the rewrite)

| Purpose        | Plugin |
|----------------|--------|
| Theme          | gruvbox.nvim (motaz-shokry) |
| Statusline     | lualine.nvim (native theme support) |
| Tabline        | bufferline.nvim (tabs mode) |
| Picker         | fzf-lua |
| UI utilities   | snacks.nvim (explorer, dashboard, notifier, input, indent, statuscolumn) |
| Completion     | blink.cmp (+ emoji & sql sources) |
| LSP            | nvim-lspconfig via `vim.lsp.config`/`vim.lsp.enable` + mason + fidget |
| Rust           | rustaceanvim (rust-analyzer) |
| Treesitter     | nvim-treesitter (main branch, parser manager only) + textobjects |
| Formatting     | conform.nvim (format on save) |
| Misc           | which-key, nvim-autopairs |

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
| `af / if / ac / ic / ao` | treesitter textobjects |
| `<leader>a / A` | swap next / previous parameter |
| `]m / [m` | next / previous function |

## Migrating from the old config (Windows)

1. `git pull` / sync this repo to `%LOCALAPPDATA%\nvim`
2. Open nvim — lazy.nvim installs everything fresh (the old `lazy-lock.json`
   was intentionally removed)
3. `:checkhealth` — confirm fzf/rg/win32yank/tree-sitter are found
4. If treesitter parsers fail to install (leftovers from the frozen `master`
   branch era), wipe them once:
   `Remove-Item -Recurse %LOCALAPPDATA%\nvim-data\site\parser`
   then restart nvim and run `:checkhealth nvim-treesitter`
5. Mason will auto-install LSP servers + stylua + prettierd on first run

## Why it's faster than before

- one picker (fzf-lua) instead of two, no duplicate/overlapping plugins
- no animation timers (tiny-glimmer ran at 125 FPS; snacks scroll/indent
  animations disabled)
- lazy loading: autopairs, conform, lualine, bufferline, which-key all load
  on events instead of at startup
- no update checks over the network at startup (`:Lazy update` is manual)
- treesitter on the maintained `main` branch (parsers built-in to Neovim)
- modern `vim.lsp.enable()` instead of the deprecated lspconfig framework
