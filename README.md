# standup.nvim

My personal Neovim plugin for taking daily notes. Use at your own risk.

## Installation

With [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
    "brattonross/standup.nvim",
    opts = {},
    keys = {
        {
            "<leader>sc",
            "<cmd>lua require(\"standup\").current()<CR>",
            desc = "[S]tandup [C]urrent",
        },
        {
            "<leader>sn",
            "<cmd>lua require(\"standup\").next()<CR>",
            desc = "[S]tandup [N]ext",
        },
        {
            "<leader>sp",
            "<cmd>lua require(\"standup\").previous()<CR>",
            desc = "[S]tandup [P]revious",
        },
    },
},
```
