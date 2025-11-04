return {
  "sainnhe/gruvbox-material",
  priority = 1000,
  config = function()
    vim.opt.termguicolors = true

    -- Choose your contrast level:
    -- "hard", "medium", "soft"
    vim.g.gruvbox_material_background = "medium"

    -- Optional: Enable true gruvbox colors
    vim.g.gruvbox_material_enable_italic = true
    vim.g.gruvbox_material_enable_bold = true
    vim.g.gruvbox_material_foreground = "material" -- or "original"

    vim.cmd("colorscheme gruvbox-material")
  end,
}

