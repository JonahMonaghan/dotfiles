vim.g.mapleader = " "
vim.g.maplocalleader = ","

require("config.lazy")

require("config.theme")

vim.opt.number = true

vim.filetype.add({
	extension = {
		v = "verilog",
		vh = "verilog",
		p8 = "pico8",
	},
})
