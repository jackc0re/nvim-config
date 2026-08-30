# jackc0re palette

> Canonical color reference extracted from [`lua/jackc0re/palette.lua`](../../lua/jackc0re/palette.lua) (originally `~/AppData/Roaming/Zed/themes/jackc0re.json`).
> Machine-readable copies: [`palette.json`](palette.json), starship-ready [`palette.toml`](palette.toml).

## ANSI / terminal (16)

| slot | name | hex | swatch |
|---|---|---|---|
| 0 | black | `#000000` | ████ |
| 1 | red | `#e25d56` | ████ |
| 2 | green | `#73ca50` | ████ |
| 3 | yellow | `#e9bf57` | ████ |
| 4 | blue | `#4a88e4` | ████ |
| 5 | magenta | `#915caf` | ████ |
| 6 | cyan | `#23acdd` | ████ |
| 7 | white | `#cecece` | ████ |
| 8 | bright_black | `#777777` | ████ |
| 9 | bright_red | `#f36868` | ████ |
| 10 | bright_green | `#88db3f` | ████ |
| 11 | bright_yellow | `#f0bf7a` | ████ |
| 12 | bright_blue | `#6f8fdb` | ████ |
| 13 | bright_magenta | `#e987e9` | ████ |
| 14 | bright_cyan | `#4ac9e2` | ████ |
| 15 | bright_white | `#ffffff` | ████ |

## UI / theme colors

### Editor surfaces

| key | hex | swatch | Zed token |
|---|---|---|---|
| `bg` | `#212124` | ████ | editor.background |
| `bg_panel` | `#262629` | ████ | panel.background / tab_bar.background / surface.background |
| `bg_chrome` | `#2A2A2E` | ████ | background / border (window chrome) |
| `bg_hover` | `#3a4042` | ████ | element.hover / element.selected |
| `bg_active` | `#1a1f20` | ████ | editor.active_line.background |
| `bg_disabled` | `#282c2d` | ████ | element.disabled / hidden.background |

### Text

| key | hex | swatch | Zed token |
|---|---|---|---|
| `fg` | `#B8B8B8` | ████ | editor.foreground |
| `fg_bright` | `#D3D3DB` | ████ | text / icon |
| `fg_muted` | `#999999` | ████ | text.muted |
| `fg_placeholder` | `#8A8A8A` | ████ | text.placeholder |
| `fg_disabled` | `#666666` | ████ | text.disabled |
| `fg_accent` | `#F6C177` | ████ | text.accent |
| `fg_hidden` | `#708b8d` | ████ | hidden / ignored |

### Accents (theme "accents" list)

| key | hex | swatch | Zed token |
|---|---|---|---|
| `amber` | `#EA9D34` | ████ | — |
| `cursor` | `#cd974b` | ████ | players[1].cursor (settings.json override) |
| `blue` | `#71ade7` | ████ | — |
| `purple` | `#915caf` | ████ | — |
| `cyan` | `#23acdd` | ████ | — |
| `red` | `#e25d56` | ████ | — |
| `green` | `#73ca50` | ████ | — |
| `yellow` | `#e9bf57` | ████ | — |

### Syntax (Zed syntax.*)

| key | hex | swatch | Zed token |
|---|---|---|---|
| `syn_comment` | `#F6C177` | ████ | comment / comment.doc / title / emphasis |
| `syn_string` | `#9CCFD8` | ████ | string / punctuation / type |
| `syn_string_doc` | `#DFDF8E` | ████ | string.doc |
| `syn_constant` | `#EB6F92` | ████ | number / boolean / constant / selector / string.escape / link_uri |
| `syn_special` | `#C4A7E7` | ████ | string.special / link_text / emphasis.strong |
| `syn_func` | `#71ADE7` | ████ | function.definition / type.class.definition |
| `syn_ns` | `#3E8FB0` | ████ | namespace / tag |
| `syn_operator` | `#EA9A97` | ████ | operator |
| `syn_unit` | `#CC8BC9` | ████ | type.unit |

### Gutter

| key | hex | swatch | Zed token |
|---|---|---|---|
| `linenr` | `#454343` | ████ | editor.line_number |
| `linenr_active` | `#cecece` | ████ | editor.active_line_number |
| `linenr_hover` | `#999999` | ████ | editor.hover_line_number |
| `invisible` | `#444444` | ████ | editor.invisible |

### Diagnostics / status chips

| key | hex | swatch | Zed token |
|---|---|---|---|
| `error` | `#e25d56` | ████ | — |
| `error_bg` | `#3a2729` | ████ | — |
| `error_border` | `#4c3335` | ████ | — |
| `warning` | `#e9bf57` | ████ | — |
| `warning_bg` | `#3d3a2f` | ████ | — |
| `warning_border` | `#4f4b3f` | ████ | — |
| `info` | `#71ade7` | ████ | — |
| `info_bg` | `#1f2b3d` | ████ | — |
| `info_border` | `#293b5b` | ████ | — |
| `success` | `#73ca50` | ████ | — |
| `success_bg` | `#273229` | ████ | — |
| `success_border` | `#334335` | ████ | — |

### Git (version_control.*)

| key | hex | swatch | Zed token |
|---|---|---|---|
| `git_added` | `#73ca50` | ████ | — |
| `git_modified` | `#e9bf57` | ████ | — |
| `git_deleted` | `#e25d56` | ████ | — |
| `git_renamed` | `#71ade7` | ████ | — |
| `git_ignored` | `#708b8d` | ████ | — |

### Search / selection

| key | hex | swatch | Zed token |
|---|---|---|---|
| `search` | `#cd974b` | ████ | search.match_background |
| `selection` | `#EA9D34` | ████ | players[1].background (theme_overrides in Zed settings.json) |

### Misc chrome

| key | hex | swatch | Zed token |
|---|---|---|---|
| `scrollbar` | `#7A7A7A` | ████ | scrollbar.thumb.background |
| `predictive` | `#915caf` | ████ | predictive (ghost text) |

## Using it elsewhere

**starship** supports named palettes natively:

```toml
# ~/.config/starship.toml
palette = "jackc0re"

[palettes.jackc0re]  # paste from ports/jackc0re/palette.toml
amber = "#EA9D34"
blue = "#71ade7"

[directory]
style = "fg:blue"
[git_branch]
style = "fg:amber"
```

**Anything else** — read `palette.json` (`jq .colors.bg.hex ports/jackc0re/palette.json`) or copy hexes from the tables above.
