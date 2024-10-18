local M = {}

local function get_cursor_position()
  local _, row, col = unpack(vim.fn.getcursorcharpos())
  return row, col
end

local function do_or_do_not(cmd, revert_cmd)
  local row_original, col_original = get_cursor_position()
  vim.cmd(cmd)
  local row_after_cmd, col_after_cmd = get_cursor_position()
  if row_original == row_after_cmd and col_original == col_after_cmd then
    return
  end
  vim.cmd(revert_cmd)
  local row_after_revert, col_after_revert = get_cursor_position()
  if row_original == row_after_revert and col_original == col_after_revert then
    vim.cmd(cmd)
  else
    print('gradual-undo: Jumped to last ' .. cmd .. ' location')
  end
end

function M.undo()
  do_or_do_not('undo', 'redo')
end

function M.redo()
  do_or_do_not('redo', 'undo')
end

return M
