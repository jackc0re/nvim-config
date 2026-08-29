# jackc0re theme ports

Canonical palette: [`lua/jackc0re/palette.lua`](../../lua/jackc0re/palette.lua)
(originally `~/AppData/Roaming/Zed/themes/jackc0re.json`).

This directory vendors the ports so they live in version control. The live
copies are installed at the paths below — **edit here, then re-copy** (Pi and
Herdr hot-reload; btop and WT need a restart/reopen).

| File | Target | Installed at |
|------|--------|--------------|
| `jackc0re.json` | Pi TUI theme | `%USERPROFILE%\.pi\agent\themes\jackc0re.json` **and** `~/.pi/agent/themes/jackc0re.json` (WSL); selected via `"theme": "jackc0re"` in each `settings.json` |
| `windows-terminal-scheme.json` | "PowerShell theme" | `"schemes"` array in `%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json`; applied to PowerShell-family + Ubuntu profiles |
| `herdr-theme.toml` | Herdr | `[theme.custom]` in `%APPDATA%\herdr\config.toml` (base stays `gruvbox`); apply: `herdr server reload-config`, validate: `herdr config check` |
| `jackc0re.theme` | btop | `~/.config/btop/themes/` (WSL), `scoop\apps\btop\current\themes\` + `scoop\apps\btop-lhm\current\themes\` **and** each `scoop\persist\btop[-lhm]\themes\` copy; `color_theme` set in every `btop.conf` |

## Mapping (palette → targets)

| palette.lua | Zed token | Pi | Windows Terminal | Herdr | btop |
|---|---|---|---|---|---|
| `bg` #212124 | editor.background | — (terminal default) | `background` | `surface_dim` | `main_bg` |
| `bg_panel` #262629 | panel.background | `userMessageBg`, `toolPendingBg`, `customMessageBg` | — | `surface0`, `sidebar_bg`, `panel_bg` | — |
| `bg_hover` #3a4042 | element.hover/selected | `selectedBg` | — | `surface1`, `selection_bg` | `selected_bg` |
| `bg_active` #1a1f20 | editor.active_line | — | — | `active_row_bg` | — |
| `fg` #B8B8B8 | editor.foreground | — | `foreground` | `text1`* | `main_fg`, box outlines |
| `fg_bright` #D3D3DB | text/icon | — | — | `text` | `selected_fg` |
| `fg_muted` #999999 | text.muted | `muted`, `thinkingText`, `mdQuote`, `toolDiffContext` | — | `subtext0`, `overlay1` | — |
| `fg_disabled` #666666 | text.disabled | `dim` | — | — | `graph_text` |
| `fg_accent` #F6C177 | text.accent / title | `toolTitle`, `mdHeading`, `customMessageLabel` | — | `peach` | `title` |
| `amber` #EA9D34 | accents[0] / selection | `accent`, `borderAccent`, `bashMode` | `selectionBackground` | `accent` | — |
| `cursor` #cd974b | players[1].cursor | `searchMatchBg` (+ dark text) | `cursorColor`, (search) | — | `hi_fg` |
| `blue` #71ade7 | — | `syntaxFunction`, `thinkingLow` | `blue`* | `blue`, `lavender`* | — |
| `purple` #915caf | — | `thinkingHigh` | `purple` | `mauve` | `download_start` |
| `cyan` #23acdd | — | `thinkingMedium` | `cyan` | — | `upload_mid` |
| `red` #e25d56 | — | `error`, `toolDiffRemoved` | `red` | `red` | `cpu_end`, `temp_end`, `used_start` |
| `green` #73ca50 | — | `success`, `toolDiffAdded` | `green` | `green` | `cpu_start`, `proc_misc`, `free_end` |
| `yellow` #e9bf57 | — | `warning` | `yellow` | `yellow` | `cpu_mid`, `available_start` |
| `syn_comment` #F6C177 | comment/title | `syntaxComment` | — | — | — |
| `syn_string` #9CCFD8 | string/type/punct | `syntaxString/Type/Punctuation`, `mdListBullet` | — | — | — |
| `syn_constant` #EB6F92 | number/constant | `syntaxNumber`, `mdLinkUrl`, `thinkingXhigh` | — | — | — |
| `syn_func` #71ADE7 | function.definition | `syntaxFunction` | — | — | — |
| `syn_ns` #3E8FB0 | namespace/tag | — | — | `teal` | `upload_start` |
| `syn_operator` #EA9A97 | operator | `syntaxOperator` | — | — | — |
| `linenr` #454343 | editor.line_number | `border`, `thinkingOff`, `mdCodeBlockBorder`, `mdQuoteBorder`, `mdHr` | — | `overlay0` | `div_line`, `inactive_fg` |
| `scrollbar` #7A7A7A | scrollbar.thumb | `scrollbarThumb` | — | — | — |
| terminal ANSI 0-15 | terminal.ansi.* | — | 16 scheme colors | — | — |

`*` = closest available key; Herdr has no per-key bold/italic, so Zed's
plain-bold keywords and alabaster-style plain variables map to default text.

## Reverting

- Pi: `"theme"` back to `gruvbox-material` (Windows) / `dark` (WSL) in the two `settings.json`; delete `themes/jackc0re.json`.
- WT: restore `%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json.pre-jackc0re` backup (or set profiles back to Kanagawa / Catppuccin Mocha / GruvboxMaterialHardDark).
- Herdr: delete the `[theme.custom]` block from `%APPDATA%\herdr\config.toml`, then `herdr server reload-config`.
- btop: point `color_theme` back to gruvbox_dark (WSL), tokyo-night (scoop btop), gruvbox_material_dark (btop-lhm); delete `jackc0re.theme` files.
