return {
	"ibhagwan/fzf-lua",
	dependencies = {"nvim-mini/mini.icons"},
	
	keys = {
		{"<Leader>pf", "<cmd>FzfLua files<cr>", desc = "Project Files"},
		{"<Leader>ps", "<cmd>FzfLua live_grep<cr>", desc = "Project Search (Text)"},
		{"<Leader><bo>", "<cmd>FzfLua buffers<cr>", desc = "Switch Open Buffers"},
		{"<Leader>ph", "<cmd>FzfLua help_tags<cr>", desc = "Project Help"},
	},

	opts = {
	}
}
