local gitsigns = require('gitsigns')

gitsigns.setup{
    current_line_blame = true,
    current_line_blame_formatter_opts = {
      relative_time = true
    },
    current_line_blame_opts = {
        delay = 400
    },
}
