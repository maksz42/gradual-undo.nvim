local M = {}

local function get_cursor_position()
  return unpack(vim.api.nvim_win_get_cursor(0));
end

local function is_cursor_at_eol()
  return vim.fn.col('.') >= vim.fn.col('$') - 1
end

local function undo_and_check_eol()
  local cmd = 'undo'
  vim.cmd(cmd)
  return cmd, is_cursor_at_eol()
end

local function check_eol_and_redo()
  local cmd = 'redo'
  local eol = is_cursor_at_eol()
  vim.cmd(cmd)
  return cmd, eol
end

local function do_or_do_not(todo, revert_cmd)
  local row_before, col_before = get_cursor_position()
  local cmd, eol = todo()
  local row_after, col_after = get_cursor_position()
  if row_before ~= row_after or (col_before ~= col_after and not eol) then
    vim.cmd(revert_cmd)
    print('gradual-undo: Jumped to last ' .. cmd .. ' location')
  end
end

function M.undo()
  do_or_do_not(undo_and_check_eol, 'redo')
end

function M.redo()
  do_or_do_not(check_eol_and_redo, 'undo')
end

function M.setup(opts)
  opts = opts or {}

  if opts.map_default_keys == true or opts.map_default_keys == nil then
    vim.keymap.set('n', 'u', M.undo)
    vim.keymap.set('n', '<c-r>', M.redo)
  end
end

return M
