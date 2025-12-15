vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.lazy")

vim.cmd.colorscheme("habamax")

vim.filetype.add({
	extension = {
		v = "verilog",
		vh = "verilog",
	},
})
