local M = {}

local function get_cursor_position()
  local _, row, col = unpack(vim.fn.getcursorcharpos())
  return row, col
end

local function set_cursor_position(row, col)
  vim.fn.setcursorcharpos(row, col)
end

local function is_cursor_at_eol()
  return vim.fn.col('.') >= vim.fn.col('$') - 1
end

local function do_or_do_not(cmd, revert_cmd)
  local row_before, col_before = get_cursor_position()
  local eol = is_cursor_at_eol()
  vim.cmd(cmd)
  local row_after, col_after = get_cursor_position()
  eol = eol or is_cursor_at_eol()
  if (row_before ~= row_after or col_before ~= col_after) and not eol then
    vim.cmd(revert_cmd)
    set_cursor_position(row_after, col_after)
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
