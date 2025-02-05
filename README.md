# gradual-undo.nvim

Fork of [EtiamNullam/gradual-undo.nvim](https://github.com/EtiamNullam/gradual-undo.nvim)

## Installation

### lazy.nvim

```lua
{
  "maksz42/gradual-undo.nvim",
  keys = {
    { "u", function() require("gradual-undo").undo() end },
    { "<C-r>", function() require("gradual-undo").redo() end },
  },
}
```

## Manual usage

```lua
local gradual_undo = require("gradual-undo")

gradual_undo.undo()
gradual_undo.redo()
```
