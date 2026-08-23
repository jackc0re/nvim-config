-- jackc0re — highlight groups
-- Mapping of Zed theme tokens -> Neovim highlights (standard, Treesitter,
-- LSP, diagnostics and the plugins this config uses).
local M = {}

function M.groups(p)
	local g = {}
	local function add(name, opts)
		g[name] = opts
	end

	--------------------------------------------------------------------
	-- Core editor (editor.*, element.*, border.*, panel.*)
	--------------------------------------------------------------------
	add("Normal", { fg = p.fg, bg = p.bg })
	add("NormalNC", { fg = p.fg, bg = p.bg })
	add("NormalFloat", { fg = p.fg_bright, bg = p.bg_panel })
	add("FloatBorder", { fg = p.bg_chrome, bg = p.bg_panel })
	add("FloatTitle", { fg = p.fg_accent, bg = p.bg_panel, bold = true })
	add("Cursor", { fg = p.bg, bg = p.cursor })
	add("TermCursor", { fg = p.bg, bg = p.cursor })
	add("TermCursorNC", { fg = p.bg, bg = p.fg_hidden })
	add("CursorLine", { bg = p.bg_active })
	add("CursorColumn", { bg = p.bg_active })
	add("ColorColumn", { bg = p.bg_panel })
	add("LineNr", { fg = p.linenr, bg = p.bg })
	add("CursorLineNr", { fg = p.linenr_active, bg = p.bg_active, bold = true })
	add("SignColumn", { fg = p.linenr, bg = p.bg })
	add("FoldColumn", { fg = p.fg_hidden, bg = p.bg })
	add("Folded", { fg = p.fg_muted, bg = p.bg_panel })
	add("WinSeparator", { fg = p.bg_chrome, bg = p.bg })
	add("VertSplit", { fg = p.bg_chrome, bg = p.bg })
	add("WinBar", { fg = p.fg_bright, bg = p.bg, bold = true })
	add("WinBarNC", { fg = p.fg_muted, bg = p.bg })
	add("EndOfBuffer", { fg = p.bg_chrome })
	add("NonText", { fg = p.invisible })
	add("SpecialKey", { fg = p.invisible })
	add("Whitespace", { fg = p.invisible })
	add("Conceal", { fg = p.fg_muted })
	add("MsgArea", { fg = p.fg })
	add("ModeMsg", { fg = p.fg_muted })
	add("MoreMsg", { fg = p.info })
	add("Question", { fg = p.info })
	add("WarningMsg", { fg = p.warning })
	add("ErrorMsg", { fg = p.error, bold = true })
	add("Directory", { fg = p.blue })
	add("Title", { fg = p.fg_accent })
	add("QuickFixLine", { bg = p.warning_bg })

	-- players[1].background override: solid amber selection (matches Zed).
	-- fg is set so syntax colors yield to dark text inside the selection
	-- (otherwise yellow-ish syntax on amber is unreadable).
	add("Visual", { fg = p.bg, bg = p.selection })
	add("VisualNOS", { fg = p.bg, bg = p.selection })
	add("Search", { fg = p.bg, bg = p.search, bold = true })
	add("CurSearch", { fg = p.bg, bg = p.amber, bold = true })
	add("IncSearch", { fg = p.bg, bg = p.amber, bold = true })
	add("Substitute", { fg = p.bg, bg = p.red })
	add("MatchParen", { fg = p.linenr_active, bg = p.bg_hover, bold = true })

	-- Popups (blink.cmp & friends render on Pmenu)
	add("Pmenu", { fg = p.fg_bright, bg = p.bg_panel })
	add("PmenuSel", { fg = p.fg_bright, bg = p.bg_hover, bold = true })
	add("PmenuSbar", { bg = p.bg_chrome })
	add("PmenuThumb", { bg = p.scrollbar })
	add("PmenuMatch", { fg = p.amber, bg = p.bg_panel, bold = true })
	add("PmenuMatchSel", { fg = p.amber, bg = p.bg_hover, bold = true })
	add("WildMenu", { fg = p.bg, bg = p.search, bold = true })

	-- Statusline / tabline (fallbacks; lualine & bufferline cover the rest)
	add("StatusLine", { fg = p.fg_bright, bg = p.bg_panel, bold = true })
	add("StatusLineNC", { fg = p.fg_muted, bg = p.bg })
	add("TabLine", { fg = p.fg_muted, bg = p.bg_panel })
	add("TabLineFill", { fg = p.fg_muted, bg = p.bg_panel })
	add("TabLineSel", { fg = p.fg_bright, bg = p.bg, bold = true })

	-- editor.document_highlight.read/write_background (#293334 ~50% over bg)
	add("LspReferenceText", { bg = "#252A2C" })
	add("LspReferenceRead", { bg = "#252A2C" })
	add("LspReferenceWrite", { bg = "#252A2C" })
	add("IlluminatedWordText", { bg = "#252A2C" })
	add("IlluminatedWordRead", { bg = "#252A2C" })
	add("IlluminatedWordWrite", { bg = "#252A2C" })

	add("SpellBad", { sp = p.red, undercurl = true })
	add("SpellCap", { sp = p.info, undercurl = true })
	add("SpellRare", { sp = p.purple, undercurl = true })
	add("SpellLocal", { sp = p.yellow, undercurl = true })

	--------------------------------------------------------------------
	-- Base syntax groups (non-Treesitter contexts: vim files, help, etc.)
	--------------------------------------------------------------------
	add("Comment", { fg = p.syn_comment }) -- comment
	add("Constant", { fg = p.syn_constant }) -- constant
	add("String", { fg = p.syn_string }) -- string
	add("Character", { fg = p.syn_string })
	add("Number", { fg = p.syn_constant }) -- number
	add("Boolean", { fg = p.syn_constant }) -- boolean
	add("Float", { fg = p.syn_constant })
	add("Identifier", { fg = p.fg }) -- (unthemed in Zed -> editor fg)
	add("Function", { fg = p.syn_func }) -- function.definition
	add("Statement", { fg = p.fg, bold = true }) -- keyword (alabaster: plain, bold)
	add("Conditional", { fg = p.fg, bold = true })
	add("Repeat", { fg = p.fg, bold = true })
	add("Label", { fg = p.syn_unit })
	add("Operator", { fg = p.syn_operator }) -- operator
	add("Keyword", { fg = p.fg, bold = true })
	add("Exception", { fg = p.fg, bold = true })
	add("Include", { fg = p.fg, bold = true })
	add("Define", { fg = p.fg, bold = true })
	add("Macro", { fg = p.syn_func })
	add("PreCondit", { fg = p.fg, bold = true })
	add("PreProc", { fg = p.syn_comment })
	add("Type", { fg = p.syn_string }) -- type
	add("StorageClass", { fg = p.fg, bold = true })
	add("Structure", { fg = p.syn_string })
	add("Typedef", { fg = p.syn_string })
	add("Special", { fg = p.syn_special }) -- string.special
	add("SpecialChar", { fg = p.syn_constant }) -- string.escape
	add("Tag", { fg = p.syn_ns }) -- tag
	add("Delimiter", { fg = p.syn_string }) -- punctuation
	add("SpecialComment", { fg = p.syn_comment })
	add("Debug", { fg = p.fg_muted })
	add("Underlined", { fg = p.syn_special, underline = true }) -- link_text
	add("Ignore", { fg = p.fg_disabled })
	add("Todo", { fg = p.fg_accent, bold = true })
	add("Error", { fg = p.error })

	--------------------------------------------------------------------
	-- Treesitter captures (mirror of the Zed syntax.* block)
	--------------------------------------------------------------------
	add("@comment", { fg = p.syn_comment })
	add("@comment.documentation", { fg = p.syn_comment })
	add("@comment.error", { fg = p.error, bold = true })
	add("@comment.warning", { fg = p.warning, bold = true })
	add("@comment.todo", { fg = p.fg_accent, bold = true })
	add("@comment.note", { fg = p.info, bold = true })

	add("@constant", { fg = p.syn_constant })
	add("@constant.builtin", { fg = p.syn_constant })
	add("@constant.macro", { fg = p.syn_constant })
	add("@module", { fg = p.syn_ns }) -- namespace
	add("@module.builtin", { fg = p.syn_ns })
	add("@namespace", { fg = p.syn_ns }) -- legacy alias
	add("@variable", { fg = p.fg })
	add("@variable.builtin", { fg = p.fg_bright, italic = true })
	add("@variable.member", { fg = p.fg }) -- properties stay plain (alabaster)
	add("@variable.parameter", { fg = p.fg })
	add("@variable.parameter.builtin", { fg = p.fg })

	add("@string", { fg = p.syn_string })
	add("@string.documentation", { fg = p.syn_string_doc }) -- string.doc
	add("@string.special", { fg = p.syn_special })
	add("@string.escape", { fg = p.syn_constant })
	add("@string.regexp", { fg = p.syn_string })
	add("@character", { fg = p.syn_string })
	add("@character.special", { fg = p.syn_special })
	add("@number", { fg = p.syn_constant })
	add("@number.float", { fg = p.syn_constant })
	add("@boolean", { fg = p.syn_constant })

	add("@function", { fg = p.syn_func })
	add("@function.call", { fg = p.syn_func })
	add("@function.builtin", { fg = p.syn_func })
	add("@function.definition", { fg = p.syn_func }) -- function.definition
	add("@function.macro", { fg = p.syn_func })
	add("@method", { fg = p.syn_func })
	add("@method.call", { fg = p.syn_func })
	add("@method.definition", { fg = p.syn_func })
	add("@constructor", { fg = p.syn_string }) -- punctuation
	add("@parameter", { fg = p.fg })
	add("@keyword", { fg = p.fg, bold = true }) -- not colored in Zed; bold like alabaster
	add("@keyword.function", { fg = p.fg, bold = true })
	add("@keyword.operator", { fg = p.syn_operator })
	add("@keyword.import", { fg = p.fg, bold = true })
	add("@keyword.storage", { fg = p.fg, bold = true })
	add("@keyword.repeat", { fg = p.fg, bold = true })
	add("@keyword.conditional", { fg = p.fg, bold = true })
	add("@keyword.debug", { fg = p.fg, bold = true })
	add("@keyword.exception", { fg = p.fg, bold = true })
	add("@keyword.directive", { fg = p.fg, bold = true })
	add("@keyword.directive.define", { fg = p.fg, bold = true })
	add("@label", { fg = p.syn_unit }) -- type.unit
	add("@operator", { fg = p.syn_operator }) -- operator
	add("@punctuation.delimiter", { fg = p.syn_string }) -- punctuation
	add("@punctuation.bracket", { fg = p.syn_string })
	add("@punctuation.special", { fg = p.syn_string })

	add("@type", { fg = p.syn_string }) -- type
	add("@type.builtin", { fg = p.syn_string })
	add("@type.definition", { fg = p.syn_func }) -- type.class.definition
	add("@type.qualifier", { fg = p.fg, bold = true })
	add("@attribute", { fg = p.syn_unit })
	add("@property", { fg = p.fg })
	add("@field", { fg = p.fg })
	add("@enum", { fg = p.syn_string })
	add("@variant", { fg = p.syn_string })

	add("@tag", { fg = p.syn_ns }) -- tag
	add("@tag.attribute", { fg = p.syn_constant }) -- selector.pseudo
	add("@tag.delimiter", { fg = p.syn_string })

	-- Markup (markdown / inline docs): title / emphasis / link_*
	add("@markup.heading", { fg = p.fg_accent, bold = true }) -- title
	add("@markup.heading.1", { fg = p.fg_accent, bold = true })
	add("@markup.heading.2", { fg = p.fg_accent, bold = true })
	add("@markup.heading.3", { fg = p.fg_accent, bold = true })
	add("@markup.heading.4", { fg = p.fg_accent, bold = true })
	add("@markup.heading.5", { fg = p.fg_accent, bold = true })
	add("@markup.heading.6", { fg = p.fg_accent, bold = true })
	add("@markup.italic", { fg = p.fg_accent, italic = true }) -- emphasis
	add("@markup.strong", { fg = p.syn_special, bold = true }) -- emphasis.strong
	add("@markup.strikethrough", { fg = p.fg_disabled, strikethrough = true })
	add("@markup.underline", { underline = true })
	add("@markup.link", { fg = p.syn_special }) -- link_text
	add("@markup.link.label", { fg = p.syn_special })
	add("@markup.link.url", { fg = p.syn_constant, underline = true }) -- link_uri
	add("@markup.list", { fg = p.syn_string })
	add("@markup.list.checked", { fg = p.green })
	add("@markup.list.unchecked", { fg = p.fg_muted })
	add("@markup.quote", { fg = p.fg_muted, italic = true })
	add("@markup.raw", { fg = p.fg }) -- text.literal: unthemed in Zed
	add("@markup.math", { fg = p.syn_special })
	add("@diff.plus", { fg = p.git_added })
	add("@diff.minus", { fg = p.git_deleted })
	add("@diff.delta", { fg = p.git_modified })
	add("@none", {})

	-- Help filetype
	add("helpCommand", { fg = p.syn_string })
	add("helpExample", { fg = p.fg_muted })
	add("helpHeader", { fg = p.fg_accent, bold = true })
	add("helpHyperTextEntry", { fg = p.fg_accent })
	add("helpHyperTextJump", { fg = p.syn_special })
	add("helpSpecial", { fg = p.syn_unit })

	--------------------------------------------------------------------
	-- Diagnostics (error / warning / hint / info)
	--------------------------------------------------------------------
	local severity = { Error = p.error, Warn = p.warning, Info = p.info, Hint = p.info }
	for name, color in pairs(severity) do
		add("Diagnostic" .. name, { fg = color })
		add("DiagnosticSign" .. name, { fg = color })
		add("DiagnosticVirtualText" .. name, { fg = color, italic = true })
		add("DiagnosticFloating" .. name, { fg = color, bg = p.bg_panel })
		add(
			"DiagnosticUnderline" .. name,
			{ sp = color, undercurl = true }
		)
	end
	add("DiagnosticOk", { fg = p.success })
	add("DiagnosticUnnecessary", { fg = p.fg_muted })
	add("DiagnosticDeprecated", { fg = p.fg_disabled, strikethrough = true })

	-- LSP chrome (hidden / predictive from Zed)
	add("LspInlayHint", { fg = p.fg_hidden, italic = true })
	add("LspCodeLens", { fg = p.fg_hidden })
	add("LspCodeLensSeparator", { fg = p.fg_hidden })
	add("LspSignatureActiveParameter", { fg = p.amber, bold = true })
	add("LspActiveParameter", { fg = p.amber, bold = true })

	--------------------------------------------------------------------
	-- Git (version_control.* / created / deleted / modified)
	--------------------------------------------------------------------
	add("DiffAdd", { fg = p.git_added, bg = p.success_bg }) -- created
	add("DiffChange", { fg = p.git_modified, bg = p.warning_bg }) -- modified
	add("DiffDelete", { fg = p.git_deleted, bg = p.error_bg }) -- deleted
	add("DiffText", { fg = p.git_modified, bg = p.warning_border, bold = true })
	add("Added", { fg = p.git_added })
	add("Changed", { fg = p.git_modified })
	add("Removed", { fg = p.git_deleted })

	-- Quickfix / loclist
	add("qfFileName", { fg = p.syn_string })
	add("qfLineNr", { fg = p.linenr })
	add("qfSeparator", { fg = p.fg_hidden })
	add("qfError", { fg = p.error })

	--------------------------------------------------------------------
	-- blink.cmp / nvim-cmp
	--------------------------------------------------------------------
	add("BlinkCmpGhostText", { fg = p.predictive, italic = true }) -- predictive
	add("BlinkCmpLabelMatch", { fg = p.amber, bold = true })
	add("BlinkCmpMenu", { link = "Pmenu" })
	add("BlinkCmpMenuSelection", { link = "PmenuSel" })
	add("BlinkCmpDoc", { link = "NormalFloat" })
	add("BlinkCmpDocBorder", { link = "FloatBorder" })
	add("BlinkCmpDocSeparator", { fg = p.bg_chrome })
	add("CmpItemAbbr", { fg = p.fg_bright })
	add("CmpItemAbbrMatch", { fg = p.amber, bold = true })
	add("CmpItemKind", { fg = p.fg_muted })
	for kind, color in pairs({
		Function = p.syn_func,
		Method = p.syn_func,
		Constructor = p.syn_func,
		Variable = p.fg_bright,
		Property = p.fg,
		Field = p.fg,
		Unit = p.syn_unit,
		Value = p.syn_constant,
		Enum = p.syn_unit,
		EnumMember = p.syn_constant,
		Constant = p.syn_constant,
		Keyword = p.fg_accent,
		Snippet = p.syn_special,
		Color = p.cyan,
		File = p.syn_string,
		Reference = p.syn_ns,
		Folder = p.syn_ns,
		Struct = p.syn_string,
		Event = p.yellow,
		Operator = p.syn_operator,
		TypeParameter = p.syn_string,
		Text = p.fg_bright,
	}) do
		add("CmpItemKind" .. kind, { fg = color })
	end

	--------------------------------------------------------------------
	-- bufferline (mode = "tabs", slant separators)
	--------------------------------------------------------------------
	add("BufferLineFill", { bg = p.bg_panel }) -- tab_bar.background
	add("BufferLineTab", { fg = p.fg_muted, bg = p.bg_panel }) -- tab.inactive
	add("BufferLineTabSelected", { fg = p.fg_bright, bg = p.bg, bold = true }) -- tab.active
	add("BufferLineTabClose", { fg = p.fg_muted, bg = p.bg_panel })
	add("BufferLineModified", { fg = p.git_modified, bg = p.bg_panel })
	add("BufferLineModifiedSelected", { fg = p.git_modified, bg = p.bg })
	add("BufferLineSeparator", { fg = p.bg_panel, bg = p.bg_panel })
	add("BufferLineSeparatorSelected", { fg = p.bg, bg = p.bg_panel })
	add("BufferLineIndicatorSelected", { fg = p.green, bg = p.bg })
	add("BufferLineCloseButton", { fg = p.fg_muted, bg = p.bg_panel })
	add("BufferLineCloseButtonSelected", { fg = p.fg_muted, bg = p.bg })
	add("BufferLineError", { fg = p.error, bg = p.bg_panel })
	add("BufferLineErrorSelected", { fg = p.error, bg = p.bg })

	--------------------------------------------------------------------
	-- fzf-lua
	--------------------------------------------------------------------
	add("FzfLuaNormal", { fg = p.fg_bright, bg = p.bg_panel })
	add("FzfLuaBorder", { fg = p.bg_chrome, bg = p.bg_panel })
	add("FzfLuaTitle", { fg = p.fg_accent, bg = p.bg_panel, bold = true })
	add("FzfLuaBackdrop", { bg = p.bg_chrome })
	add("FzfLuaPreviewNormal", { fg = p.fg, bg = p.bg })
	add("FzfLuaPreviewBorder", { fg = p.bg_chrome, bg = p.bg })
	add("FzfLuaPreviewTitle", { fg = p.fg_muted, bg = p.bg_panel })
	add("FzfLuaCursorLine", { fg = p.fg_bright, bg = p.bg_active })
	add("FzfLuaCursorLineNr", { fg = p.linenr_active, bg = p.bg_active })
	add("FzfLuaSearch", { fg = p.amber })
	add("FzfLuaHeaderText", { fg = p.fg_accent })
	add("FzfLuaPath", { fg = p.fg_muted })
	add("FzfLuaPathColNr", { fg = p.syn_string })
	add("FzfLuaBufName", { fg = p.syn_ns })

	--------------------------------------------------------------------
	-- which-key
	--------------------------------------------------------------------
	add("WhichKey", { fg = p.cursor })
	add("WhichKeyGroup", { fg = p.blue })
	add("WhichKeyDesc", { fg = p.fg_bright })
	add("WhichKeySeparator", { fg = p.fg_hidden })
	add("WhichKeyValue", { fg = p.fg_muted })
	add("WhichKeyNormal", { fg = p.fg, bg = p.bg_panel })
	add("WhichKeyBorder", { fg = p.bg_chrome, bg = p.bg_panel })
	add("WhichKeyTitle", { fg = p.fg_accent, bg = p.bg_panel, bold = true })

	--------------------------------------------------------------------
	-- snacks.nvim (dashboard / indent / notifier / input)
	--------------------------------------------------------------------
	add("SnacksDashboardHeader", { fg = p.fg_accent })
	add("SnacksDashboardIcon", { fg = p.syn_ns })
	add("SnacksDashboardKey", { fg = p.fg_bright, bold = true })
	add("SnacksDashboardDesc", { fg = p.fg_muted })
	add("SnacksDashboardFooter", { fg = p.fg_hidden })
	add("SnacksDashboardSpecial", { fg = p.amber })
	add("SnacksIndent", { fg = p.linenr })
	add("SnacksIndentBlank", { fg = p.bg })
	add("SnacksIndentScope", { fg = p.cursor })
	add("SnacksNotifierBorder", { fg = p.bg_chrome, bg = p.bg_panel })
	add("SnacksNotifierTitle", { fg = p.fg_accent, bg = p.bg_panel, bold = true })
	add("SnacksNotifierIconInfo", { fg = p.info })
	add("SnacksNotifierIconWarn", { fg = p.warning })
	add("SnacksNotifierIconError", { fg = p.error })
	add("SnacksNormal", { fg = p.fg_bright, bg = p.bg_panel })
	add("SnacksBorder", { fg = p.bg_chrome, bg = p.bg_panel })
	add("SnacksTitle", { fg = p.fg_accent, bg = p.bg_panel, bold = true })
	add("SnacksInputIcon", { fg = p.amber })

	--------------------------------------------------------------------
	-- snacks picker / explorer (`<leader>e`)
	-- Window chrome mirrors panel.*; content colors mirror Zed's
	-- project panel (hidden/ignored -> #708b8d, NOT editor.invisible).
	--------------------------------------------------------------------
	-- Window chrome
	add("SnacksPicker", { fg = p.fg_bright, bg = p.bg_panel })
	add("SnacksPickerNormal", { fg = p.fg_bright, bg = p.bg_panel })
	add("SnacksPickerNormalFloat", { fg = p.fg_bright, bg = p.bg_panel })
	add("SnacksPickerBorder", { fg = p.bg_chrome, bg = p.bg_panel })
	add("SnacksPickerTitledBorder", { fg = p.bg_chrome, bg = p.bg_panel })
	add("SnacksPickerTitle", { fg = p.fg_accent, bg = p.bg_panel, bold = true })
	add("SnacksPickerFooter", { fg = p.fg_muted, bg = p.bg_panel })
	add("SnacksPickerBackdrop", { bg = p.bg_chrome })
	add("SnacksPickerList", { fg = p.fg_bright, bg = p.bg_panel })
	add("SnacksPickerListBorder", { fg = p.bg_chrome, bg = p.bg_panel })
	add("SnacksPickerListTitle", { fg = p.fg_accent, bg = p.bg_panel, bold = true })
	add("SnacksPickerListCursorLine", { fg = p.fg_bright, bg = p.bg_active, bold = true })
	add("SnacksPickerInput", { fg = p.fg_bright, bg = p.bg_panel })
	add("SnacksPickerInputBorder", { fg = p.bg_chrome, bg = p.bg_panel })
	add("SnacksPickerInputTitle", { fg = p.fg_muted, bg = p.bg_panel })
	add("SnacksPickerPreview", { fg = p.fg, bg = p.bg })
	add("SnacksPickerPreviewBorder", { fg = p.bg_chrome, bg = p.bg })
	add("SnacksPickerPreviewTitle", { fg = p.fg_muted, bg = p.bg_panel })
	add("SnacksPickerPreviewCursorLine", { bg = p.bg_active })

	-- Explorer tree + content
	add("SnacksPickerTree", { fg = p.fg_hidden }) -- tree guides │├└ (Zed hidden)
	add("SnacksPickerFile", { fg = p.fg_bright }) -- file names: explicitly bright
	add("SnacksPickerDirectory", { fg = p.blue, bold = true }) -- directories
	add("SnacksPickerDir", { fg = p.fg_muted }) -- dirname part of paths
	add("SnacksPickerPathHidden", { fg = p.fg_hidden }) -- dotfiles (Zed hidden)
	add("SnacksPickerPathIgnored", { fg = p.fg_hidden }) -- gitignored (Zed ignored)
	add("SnacksPickerDimmed", { fg = p.fg_muted })
	add("SnacksPickerUnselected", { fg = p.fg_hidden })
	add("SnacksPickerSelected", { fg = p.syn_special, bold = true })
	add("SnacksPickerMatch", { fg = p.amber, bold = true })
	add("SnacksPickerSearch", { fg = p.amber })
	add("SnacksPickerPrompt", { fg = p.fg_accent })
	add("SnacksPickerSpecial", { fg = p.syn_special })
	add("SnacksPickerTotals", { fg = p.fg_muted })
	add("SnacksPickerToggle", { fg = p.info })
	add("SnacksPickerRow", { fg = p.syn_string })
	add("SnacksPickerCol", { fg = p.linenr })

	-- Git status column
	add("SnacksPickerGitStatusAdded", { fg = p.git_added })
	add("SnacksPickerGitStatusModified", { fg = p.git_modified })
	add("SnacksPickerGitStatusDeleted", { fg = p.git_deleted })
	add("SnacksPickerGitStatusUntracked", { fg = p.git_renamed })
	add("SnacksPickerGitStatusIgnored", { fg = p.git_ignored })

	--------------------------------------------------------------------
	-- Misc plugins / UI
	--------------------------------------------------------------------
	add("TreesitterContext", { fg = p.fg, bg = p.bg_active })
	add("TreesitterContextLineNumber", { fg = p.linenr })
	add("healthError", { fg = p.error })
	add("healthWarning", { fg = p.warning })
	add("healthSuccess", { fg = p.success })
	add("healthInfo", { fg = p.info })
	add("NoiceCmdlineIcon", { fg = p.amber })
	add("LazyNormal", { fg = p.fg_bright, bg = p.bg_panel })
	add("LazyButton", { fg = p.fg_muted, bg = p.bg_panel })
	add("LazyButtonActive", { fg = p.fg_bright, bg = p.bg_hover, bold = true })
	add("LazyH1", { fg = p.bg, bg = p.amber, bold = true })
	add("LazyH2", { fg = p.fg_accent, bold = true })
	add("LazySpecial", { fg = p.blue })
	add("fidget_task", { fg = p.fg_muted })
	add("fidget_title", { fg = p.fg_accent })

	return g
end

return M
