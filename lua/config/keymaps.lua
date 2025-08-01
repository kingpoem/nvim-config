-- This file contains keymaps, which is executed after lazy initialization

local KeyMaps = {}

function KeyMaps.apply()
    -- resize window
    vim.keymap.set('n', '<C-Left>', ':SmartResizeLeft<Enter>', { noremap = true, silent = true })
    vim.keymap.set('n', '<C-Right>', ':SmartResizeRight<Enter>', { noremap = true, silent = true })
    vim.keymap.set('n', '<C-Up>', ':SmartResizeUp<Enter>', { noremap = true, silent = true })
    vim.keymap.set('n', '<C-Down>', ':SmartResizeDown<Enter>', { noremap = true, silent = true })

    -- buffer swich
    vim.keymap.set('n', '<C-h>', ':SmartCursorMoveLeft<Enter>', { desc = 'Move to left window', noremap = true, silent = true })
    vim.keymap.set('n', '<C-j>', ':SmartCursorMoveDown<Enter>', { desc = 'Move to below window', noremap = true, silent = true })
    vim.keymap.set('n', '<C-k>', ':SmartCursorMoveUp<Enter>', { desc = 'Move to above window', noremap = true, silent = true })
    vim.keymap.set('n', '<C-l>', ':SmartCursorMoveRight<Enter>', { desc = 'Move to right window', noremap = true, silent = true })
    vim.keymap.set('n', 'H', ':bp<Enter>', { noremap = true, silent = true })
    vim.keymap.set('n', 'L', ':bn<Enter>', { noremap = true, silent = true })

    -- telescope related, prefix is leader-t
    vim.keymap.set('n', '<Leader>ff', ':Telescope find_files<Enter>', { desc = 'Telescope Find Files', noremap = true, silent = true })
    vim.keymap.set('n', '<Leader>fo', ':Telescope oldfiles<Enter>', { desc = 'Telescope Find Recent Files', noremap = true, silent = true })
    vim.keymap.set('n', '<Leader>fw', ':Telescope live_grep<Enter>', { desc = 'Telescope Find Word', noremap = true, silent = true })
    vim.keymap.set('n', '<Leader>fb', ':Telescope buffers<Enter>', { desc = 'Telescope Find Buffer', noremap = true, silent = true })
    vim.keymap.set('n', '<Leader>fd', ':Telescope diagnostics<Enter>', { desc = 'Telescope Find Diagnostics', noremap = true, silent = true })
    vim.keymap.set('n', '<Leader>fg', ':Telescope git_status<Enter>', { desc = 'Telescope Find Git Diff', noremap = true, silent = true })
    vim.keymap.set('n', '<Leader>fm', ':Noice telescope<Enter>', { desc = 'Telescope Filter Noice Msg', noremap = true, silent = true })
    vim.keymap.set('n', '<Leader>ft', ':TodoTelescope<Enter>', { desc = 'Telescope Filter Todo Items', noremap = true, silent = true })

    -- buffer releated, prefix is leader-b
    vim.keymap.set('n', '<Leader>bc', ':bp | bd #<Enter>', { desc = 'Buffer close current', noremap = true, silent = true })
    vim.keymap.set('n', '<Leader>bl', ':Telescope buffers<Enter>', { desc = 'Buffer list', noremap = true, silent = true })

    vim.keymap.set('n', '<Leader>h', ':Alpha<Enter>', { desc = 'Open Home Page', noremap = true, silent = true })
    vim.keymap.set('n', '<Leader>lg', ':Telescope git_commits<Enter>', { desc = 'Search Git Commits', noremap = true, silent = true })
    vim.keymap.set('n', '<Leader>lD', ':Telescope diagnostics<Enter>', { desc = 'Search diagnostics', noremap = true, silent = true })

    vim.keymap.set('n', '<Leader>w', function()
        local bufnr = vim.api.nvim_get_current_buf()
        local filepath = vim.api.nvim_buf_get_name(bufnr)

        local function write_to(path)
            local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
            local file, err = io.open(path, 'w')
            if not file then
                vim.notify('Cannot open file: ' .. err, vim.log.levels.ERROR)
                return
            end
            for _, line in ipairs(lines) do
                file:write(line, '\n')
            end
            file:close()
            vim.api.nvim_buf_set_name(bufnr, path)
            vim.bo[bufnr].modified = false
            vim.notify('Saved to ' .. path, vim.log.levels.INFO)
        end

        if filepath == '' then
            vim.ui.input({ prompt = 'Save as: ', completion = 'file' }, function(input)
                if input and input ~= '' then
                    write_to(input)
                else
                    vim.notify('Save cancelled', vim.log.levels.WARN)
                end
            end)
        else
            write_to(filepath)
        end
    end, { desc = 'Save current buffer', noremap = true, silent = true })
end

return KeyMaps
