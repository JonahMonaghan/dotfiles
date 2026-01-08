return {
  "Bakudankun/PICO-8.vim",
  lazy = false, -- Important: Load immediately to handle filetype detection
  config = function()
    -- Optional: This plugin adds a "Pico8Run" command. 
    -- You can point it to your pico8 binary if it's not in your PATH
    vim.g.pico8_config = {
      pico8_path = "~/Applications/pico-8/pico8_dyn", -- Change if needed
      t_pack = true, -- optimize packing
    }
  end
}
