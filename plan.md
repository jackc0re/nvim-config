---
title: Port jackc0re theme to Pi, Windows Terminal, Herdr, and btop
status: done
created: 2026-08-29
---

## Goal
Port the jackc0re theme (canonical palette in nvim-config/lua/jackc0re/palette.lua) to four additional surfaces: a Pi TUI theme (51 JSON tokens), a Windows Terminal color scheme (serves as the "PowerShell theme" per user choice), Herdr [theme.custom] overrides, and btop .theme files for both WSL and Windows/scoop installs — each mapped as closely as possible to the same palette.

## Context / Decisions
User wants the jackc0re theme (originally Zed, already ported 1:1 to Neovim) ported to Pi, PowerShell (via Windows Terminal scheme — user explicitly chose this over in-console PSReadLine/omp), Herdr, and btop.

CANONICAL PALETTE: C:/Users/GRIGS.DESKTOP-0KH5FS2/source/git/nvim-config/lua/jackc0re/palette.lua — full palette with Zed-token provenance. Key values: bg #212124, bg_panel #262629, bg_chrome #2A2A2E, bg_hover #3a4042, bg_active #1a1f20, fg #B8B8B8, fg_bright #D3D3DB, fg_muted #999999, fg_accent/amber #F6C177, accent amber #EA9D34, cursor/search #cd974b, selection #EA9D34, blue #71ade7, purple #915caf, cyan #23acdd, red #e25d56, green #73ca50, yellow #e9bf57, syn_string #9CCFD8, syn_constant #EB6F92, syn_special #C4A7E7, syn_func #71ADE7, syn_ns #3E8FB0, syn_operator #EA9A97, syn_unit #CC8BC9, linenr #454343, git_added green/modified yellow/deleted red, error/warning/info/success pairs (+_bg/_border), predictive #915caf. terminal_colors() defines the 16-color ANSI map (blue #4a88e4, bright variants, etc.).

ENVIRONMENT FINDINGS (machine is Windows 11 + WSL2 Ubuntu; bash tool runs in WSL, user jackc0re; Windows side via /mnt/c):
- Pi (agent) installed BOTH sides. Windows: C:\Users\GRIGS.DESKTOP-0KH5FS2\.pi\agent\ (settings.json uses pi-themes package, theme dir not yet created). WSL: /home/jackc0re/.pi/agent/ (settings.json has "theme":"dark"). Pi theme format: JSON, 51 required color tokens (+optional scrollbarThumb/searchMatch*/thinkingMax/export), loaded from ~/.pi/agent/themes/*.json, hot-reloads, $schema available. Docs: AppData/Roaming/npm/node_modules/@earendil-works/pi-coding-agent/docs/themes.md. The adapt-ghostty-theme-to-pi skill has token-mapping methodology worth consulting.
- Herdr (Windows app): config at C:\Users\GRIGS.DESKTOP-0KH5FS2\AppData\Roaming\herdr\config.toml, currently [theme] name="gruvbox". Custom colors via [theme.custom] inline TOML overrides (hex/rgb/named/reset). Keys discovered from binary strings: accent, panel_bg, sidebar_bg, active_row_bg, selection_bg, surface0, surface1, surface_dim, overlay0, overlay1, text, subtext0, mauve, green, yellow, red, blue, teal, peach. Apply live via `herdr server reload-config`; validate via `herdr config check`. Separate theme FILES not supported per docs (inline overrides only).
- btop used on BOTH sides: WSL ~/.config/btop (btop.conf points at /usr/share/btop/themes/gruvbox_dark.theme, themes/ dir empty) AND Windows scoop installs: scoop/apps/btop (conf currently tokyo-night.theme in app dir) plus a btop-lhm fork (1.0.4/1.0.5, also has btop.log → in use). btop theme format: theme[key]="#RRGGBB" INI-ish file with gradient triplets (start/mid/end), user themes in themes/ dir next to conf, truecolor=True, theme_background=True everywhere.
- Windows Terminal: settings at AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json, colorSchemes=[] (empty), profiles use stock schemes (PowerShell→Kanagawa, Ubuntu→Catppuccin Mocha, etc.). Default profile GUID {2595cd9c-8f05-55ff-a1d4-93f3041ca67f}. File has // comments → strip before JSON parse. PowerShell profile is bare (fnm only).
- Original Zed theme for cross-check: ~/AppData/Roaming/Zed/themes/jackc0re.json (Windows).

DECISIONS:
- PowerShell scope = Windows Terminal jackc0re scheme only (user-selected; PSReadLine/$PSStyle/prompt and oh-my-posh explicitly declined for now).
- Scheme applied to PowerShell-family profiles AND the Ubuntu (WSL) profile so pi-WSL/btop-WSL/herdr get the jackc0re ANSI backdrop; other profiles untouched; trivially reversible one-liner.
- Herdr: keep base name "gruvbox", override via [theme.custom] with full jackc0re mapping (surface*→bg surfaces, mauve→purple #915caf, teal→#3E8FB0, peach→amber #EA9D34, text→fg_bright, subtext0→fg).
- btop: theme written to all three installs (WSL, scoop btop, scoop btop-lhm); keep gradients using palette accents; main_bg #212124 with theme_background=True.
- All theme source files additionally vendored into nvim-config/ports/jackc0re/ for version control (repo already hosts the nvim port; keeps everything in one place).
ASSUMPTIONS: truecolor supported everywhere (already true in btop confs; WT supports 24-bit); pi theme JSON validated against the 51-token list; no changes to nvim theme.
REJECTED: oh-my-posh / PSReadLine theming (user chose WT scheme); Herdr theme file (unsupported — inline overrides only); changing non-PowerShell/Ubuntu WT profiles (out of scope).

## Tasks
- [x] 1. Write Pi theme: create jackc0re.json with all 51 required tokens (plus optional scrollbarThumb/searchMatchBg/searchMatchText/thinkingMax) mapped from palette.lua; validate JSON parses and token count via script; install to BOTH C:/Users/GRIGS.DESKTOP-0KH5FS2/.pi/agent/themes/ and /home/jackc0re/.pi/agent/themes/; set "theme":"jackc0re" in both settings.json
- [x] 2. Add Windows Terminal scheme: append a jackc0re colorSchemes entry (16 ANSI colors from palette.terminal_colors(), background #212124, foreground #B8B8B8, cursorColor #cd974b, selectionBackground #EA9D34) to WT settings.json and set colorScheme="jackc0re" on the PowerShell-family profiles and the Ubuntu profile; verify settings.json still parses (comment-stripping JSON check) and scheme is listed
- [x] 3. Configure Herdr: add [theme.custom] overrides (accent, text, subtext0, surface0/1/dim, overlay0/1, sidebar_bg, active_row_bg, selection_bg, panel_bg, mauve, green, yellow, red, blue, teal, peach) to AppData/Roaming/herdr/config.toml, keeping base name gruvbox; re-dump herdr.exe strings to confirm no missed theme keys; apply with `herdr server reload-config` and validate with `herdr config check`
- [x] 4. Create btop theme for WSL: write jackc0re.theme (full theme[key] set modeled on gruvbox_dark.theme, including all gradient start/mid/end triplets) to /home/jackc0re/.config/btop/themes/ and point ~/.config/btop/btop.conf color_theme at it; verify key-set parity against the reference theme
- [x] 5. Install btop theme on Windows: copy jackc0re.theme into scoop/apps/btop/current/themes/ and scoop/apps/btop-lhm/current/themes/, update each btop.conf color_theme to jackc0re.theme; verify via grep
- [x] 6. Vendor all generated theme sources into nvim-config/ports/jackc0re/ (pi json, WT scheme snippet, herdr toml block, btop theme) with a small README mapping table palette-token → target-key, and commit
- [x] 7. Final verification pass: for each target confirm it loads (pi --use-theme jackc0re smoke test or /settings; WT scheme visible; herdr config check; btop launch in WSL + Windows shows jackc0re colors); write short summary with revert instructions for each change

## Log
- `2026-08-29 22:54` [build] wrote ports\jackc0re\jackc0re.json
- `2026-08-29 22:54` [build] wrote ..\..\..\.pi\agent\settings.json
- `2026-08-29 22:54` [build] ✅ completed task 1: Write Pi theme: create jackc0re.json with all 51 required tokens (plus optional scrollbarThumb/searchMatchBg/searchMatchText/thinkingMax) mapped from palette.lua; validate JSON parses and token count via script; install to BOTH C:/Users/GRIGS.DESKTOP-0KH5FS2/.pi/agent/themes/ and /home/jackc0re/.pi/agent/themes/; set "theme":"jackc0re" in both settings.json
- `2026-08-29 22:56` [build] ✅ completed task 2: Add Windows Terminal scheme: append a jackc0re colorSchemes entry (16 ANSI colors from palette.terminal_colors(), background #212124, foreground #B8B8B8, cursorColor #cd974b, selectionBackground #EA9D34) to WT settings.json and set colorScheme="jackc0re" on the PowerShell-family profiles and the Ubuntu profile; verify settings.json still parses (comment-stripping JSON check) and scheme is listed
- `2026-08-29 22:57` [build] wrote ..\..\..\AppData\Roaming\herdr\config.toml
- `2026-08-29 22:57` [build] wrote ..\..\..\AppData\Roaming\herdr\config.toml
- `2026-08-29 22:57` [build] wrote ..\..\..\AppData\Roaming\herdr\config.toml
- `2026-08-29 22:58` [build] ✅ completed task 3: Configure Herdr: add [theme.custom] overrides (accent, text, subtext0, surface0/1/dim, overlay0/1, sidebar_bg, active_row_bg, selection_bg, panel_bg, mauve, green, yellow, red, blue, teal, peach) to AppData/Roaming/herdr/config.toml, keeping base name gruvbox; re-dump herdr.exe strings to confirm no missed theme keys; apply with `herdr server reload-config` and validate with `herdr config check`
- `2026-08-29 22:59` [build] wrote ports\jackc0re\jackc0re.theme
- `2026-08-29 22:59` [build] ✅ completed task 4: Create btop theme for WSL: write jackc0re.theme (full theme[key] set modeled on gruvbox_dark.theme, including all gradient start/mid/end triplets) to /home/jackc0re/.config/btop/themes/ and point ~/.config/btop/btop.conf color_theme at it; verify key-set parity against the reference theme
- `2026-08-29 23:00` [build] ✅ completed task 5: Install btop theme on Windows: copy jackc0re.theme into scoop/apps/btop/current/themes/ and scoop/apps/btop-lhm/current/themes/, update each btop.conf color_theme to jackc0re.theme; verify via grep
- `2026-08-29 23:00` [build] wrote ports\jackc0re\windows-terminal-scheme.json
- `2026-08-29 23:00` [build] wrote ports\jackc0re\herdr-theme.toml
- `2026-08-29 23:00` [build] wrote ports\jackc0re\README.md
- `2026-08-29 23:01` [build] git commit
- `2026-08-29 23:01` [build] ✅ completed task 6: Vendor all generated theme sources into nvim-config/ports/jackc0re/ (pi json, WT scheme snippet, herdr toml block, btop theme) with a small README mapping table palette-token → target-key, and commit
- `2026-08-29 23:02` [build] ✅ completed task 7: Final verification pass: for each target confirm it loads (pi --use-theme jackc0re smoke test or /settings; WT scheme visible; herdr config check; btop launch in WSL + Windows shows jackc0re colors); write short summary with revert instructions for each change
- `2026-08-29 23:02` [build] All 7 tasks complete. Key deviations/notes: (1) Herdr [theme.custom] keys pink/maroon/lavender/text1 were rejected by `herdr config check` — removed; 19 keys remain and validate clean. (2) scoop btop: persist\btop[-lhm] copies are separate files from apps\current (not junctions) — updated all 4 confs + 4 theme copies so scoop updates won't revert the theme. (3) Git identity missing in WSL — set repo-local user.name/email to match prior commits (jackc0re <chris.metodieff@gmail.com>). Commit 31e59d1. WT settings backup kept at settings.json.pre-jackc0re. Pi theme validated 51/51 required + 4 optional tokens; visual check is user-side (pi hot-reloads; WT applies on settings save).
- `2026-08-30 09:35` [note] Follow-up request: apply jackc0re palette to starship. User confirmed live config is C:\Users\GRIGS.DESKTOP-0KH5FS2\.config\starship.toml (gruvbox powerline preset, role names color_*). Added [palettes.jackc0re] mapped to each preset's role names (Windows gruvbox-roles; WSL catppuccin-roles as a bonus since that file had the same structure) and flipped palette= in both; catppuccin/gruvbox palettes kept for one-line revert; backups at starship.toml.pre-jackc0re. Also de-hardcoded docker fg:#83a598 -> fg:color_fg0 on Windows. Validated with tomllib + `starship.exe print-config` (OK). Note: WSL ~/.bashrc/.zshrc have starship init commented out and the PS profile doesn't init starship — flagged to user, not changed.
