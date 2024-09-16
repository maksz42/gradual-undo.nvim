# gradual-undo.nvim

Based on an idea posted on reddit by [Flaky_Candy_6232](https://www.reddit.com/user/Flaky_Candy_6232):

https://www.reddit.com/r/neovim/comments/xij4yn/how_to_configure_undo_the_way_android_studios

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

Map to your own keys of choice or invoke manually by:

```lua
local gradual_undo = require('gradual-undo')

gradual_undo.jump_to_last_undo_position_or_undo()
gradual_undo.jump_to_last_redo_position_or_redo()
```
