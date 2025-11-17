vim.pack.add{
    -- :Gen Chat
    -- :Gen ..
    "https://github.com/David-Kunz/gen.nvim",

    -- :LLMSessionToggle and alike..
    -- export LLM_KEY=<Your API_KEY>
    -- export ACCOUNT=<Your ACCOUNT> # just for cloudflare
    "https://github.com/MunifTanjim/nui.nvim",
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/Kurama622/llm.nvim",

    -- Have these in PATH
    -- * gemini-cli
    -- * qwen-code
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/gutsavgupta/nvim-gemini-companion",
}

-- :Gemini
require("gemini").setup({
    cmds = { "gemini", "qwen" },  -- Use both
})
