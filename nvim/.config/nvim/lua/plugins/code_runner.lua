return {
    "CRAG666/code_runner.nvim",
    cmd = { "RunCode", "RunFile", "RunProject", "RunClose" },
    keys = {
        { "<leader>rc", "<cmd>RunCode<cr>", desc = "Run Code" },
        { "<leader>rf", "<cmd>RunFile<cr>", desc = "Run File" },
        { "<leader>rp", "<cmd>RunProject<cr>", desc = "Run Project" },
    },
    opts = {
        mode = "term",
        focus = true,
        startinsert = false,
        filetype = {
            python = "python3 -u",
            typescript = "deno run",
            javascript = "node",
            lua = "lua",
            go = "go run",
            rust = {
                "cd $dir &&",
                "rustc $fileName &&",
                "$dir/$fileNameWithoutExt",
            },
            c = "cd $dir && gcc $fileName -o /tmp/$fileNameWithoutExt && /tmp/$fileNameWithoutExt",
            cpp = "cd $dir && g++ $fileName -o /tmp/$fileNameWithoutExt && /tmp/$fileNameWithoutExt",
            java = {
                "cd $dir &&",
                "javac $fileName &&",
                "java $fileNameWithoutExt",
            },
            sh = "bash",
        },
    },
}
