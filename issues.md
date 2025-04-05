### attmep to call method 'range'
see https://github.com/kevinhwang91/nvim-ufo/issues/254

Line: 177 Update to

```~/.local/share/nvim/lazy/nvim-ufo/lua/ufo/provider/treesitter.lua
for _, node in ipairs(matches) do
    if node.range then
        local start, _, stop, stop_col = node:range()
        if stop_col == 0 then
            stop = stop - 1
        end
        if stop > start then
            table.insert(ranges, foldingrange.new(start, stop))
        end
    end
end
```

### tbl_islist is deprecated

Append

```init.lua
vim.tbl_islist = vim.islist
```
