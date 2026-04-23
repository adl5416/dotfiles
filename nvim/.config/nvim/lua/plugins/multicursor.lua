return {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    config = function()
        local mc = require("multicursor-nvim")
        mc.setup()

        local set = vim.keymap.set

        -- Add or skip cursor above/below the main cursor.
        set({"n", "x"}, "<up>", function() mc.lineAddCursor(-1) end, { desc = "Add cursor above" })
        set({"n", "x"}, "<down>", function() mc.lineAddCursor(1) end, { desc = "Add cursor below" })
        set({"n", "x"}, "<C-up>", function() mc.lineSkipCursor(-1) end, { desc = "Skip cursor above" })
        set({"n", "x"}, "<C-down>", function() mc.lineSkipCursor(1) end, { desc = "Skip cursor below" })

        -- Add or skip adding a new cursor by matching word/selection
        set({"n", "x"}, "<leader>ca", function() mc.matchAddCursor(1) end, { desc = "Add cursor at next match" })
        set({"n", "x"}, "<leader>cs", function() mc.matchSkipCursor(1) end, { desc = "Skip next match" })
        set({"n", "x"}, "<leader>cA", function() mc.matchAddCursor(-1) end, { desc = "Add cursor at prev match" })
        set({"n", "x"}, "<leader>cS", function() mc.matchSkipCursor(-1) end, { desc = "Skip prev match" })

        -- Add a cursor for all matches of cursor word/selection in the document.
        set({"n", "x"}, "<leader>cl", mc.matchAllAddCursors, { desc = "Add cursors to all matches" })

        -- Mappings defined in a keymap layer only apply when there are
        -- multiple cursors. This lets you have overlapping mappings.
        mc.addKeymapLayer(function(layerSet)

            -- Delete the main cursor.
            layerSet({"n", "x"}, "<leader>cd", mc.deleteCursor, { desc = "Delete cursor" })

            -- Enable and clear cursors using escape.
            layerSet("n", "<esc>", function()
                if not mc.cursorsEnabled() then
                    mc.enableCursors()
                else
                    mc.clearCursors()
                end
            end)
        end)

        -- Customize how cursors look.
        local hl = vim.api.nvim_set_hl
        hl(0, "MultiCursorCursor", { reverse = true })
        hl(0, "MultiCursorVisual", { link = "Visual" })
        hl(0, "MultiCursorSign", { link = "SignColumn"})
        hl(0, "MultiCursorMatchPreview", { link = "Search" })
        hl(0, "MultiCursorDisabledCursor", { reverse = true })
        hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
        hl(0, "MultiCursorDisabledSign", { link = "SignColumn"})
    end
}
