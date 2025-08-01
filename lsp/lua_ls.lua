-- Lua lsp

local lua_ls = {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { '.git', 'stylua.toml', '.luarc.json' },
    on_init = function(client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
            ---@diagnostic disable: undefined-field
            if path ~= vim.fn.stdpath 'config' and (vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc')) then
                return
            end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME,
                    -- Depending on the usage, you might want to add additional paths here.
                    -- "${3rd}/luv/library"
                    -- "${3rd}/busted/library",
                },
                -- or pull in all of 'runtimepath'.
                -- NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
                -- library = vim.api.nvim_get_runtime_file("", true)
            },
        })
    end,
    on_attach = function(client)
        if vim.fn.expand '%:t' == 'xmake.lua' then
            vim.lsp.stop_client(client.id)
            return
        end
    end,
    settings = {
        Lua = {},
    },
}

return lua_ls
