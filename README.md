# gradual-undo.nvim

Undo/redo like in IntelliJ IDEA and Android Studio

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
