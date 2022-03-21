-- Location with current line and column, and total lines in file
local function improved_location()
    local r, c = unpack(vim.api.nvim_win_get_cursor(0))
    return string.format("%d:%d | %d", r, c, vim.fn.line('$'))
end

require('lualine').setup({
  options = {
      theme = 'tokyonight',
      globalstatus = true,
  },
  sections = {
      lualine_c = {
        { 'filename', file_status = false, path = 1, icons_enabled = true },
      },
      lualine_z = { improved_location },
  }
})

