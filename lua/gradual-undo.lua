local M = {}

local function get_cursor_position()
  return vim.fn.getcharpos('.')
end

local function do_or_do_not(cmd, revert_cmd)
  local pos_original = get_cursor_position()
  vim.cmd(cmd)
  local pos_after_cmd = get_cursor_position()
  if vim.deep_equal(pos_original, pos_after_cmd) then
    return
  end
  vim.cmd(revert_cmd)
  local pos_after_revert = get_cursor_position()
  if vim.deep_equal(pos_original, pos_after_revert) then
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
