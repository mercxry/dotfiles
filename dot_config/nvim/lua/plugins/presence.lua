require("presence"):setup({
    main_image = 'file',
    buttons = false,
    editing_text = function(filename) -- filename arg doesn't need to be used here
        -- Determine type of file using vim's &filetype variable
        local filetype = vim.bo.filetype:gsub('^%l', string.upper)
        return string.format("Editing a %s file", filetype)
    end,
    reading_text = 'Reading file',
    workspace_text = 'Working on a project'
})
