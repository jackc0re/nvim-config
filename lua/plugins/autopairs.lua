-- nvim-autopairs — auto-close brackets/quotes
return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	opts = {
		check_ts = true, -- use treesitter to ignore brackets in strings/comments
	},
}
