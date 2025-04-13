vim.keymap.set('t', '<esc><esc>', '<c-\\><c-n>')

local state = {}
local current = -1

local function create_floating_window(opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)

  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end

  local win_config = {
    relative = 'editor',
    width = width,
    height = height,
    col = col,
    row = row,
    style = 'minimal',
    border = 'rounded',
  }

  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

local function toggle_terminal(idx)
  if not state[idx] then
    state[idx] = { buf = -1, win = -1 }
  end
  if current ~= -1 and current ~= idx and vim.api.nvim_win_is_valid(state[current].win) then
    vim.api.nvim_win_hide(state[current].win)
  end
  if not vim.api.nvim_win_is_valid(state[idx].win) then
    state[idx] = create_floating_window { buf = state[idx].buf }
    if vim.bo[state[idx].buf].buftype ~= 'terminal' then
      vim.cmd.term()
    end
    current = idx
  else
    vim.api.nvim_win_hide(state[idx].win)
    current = -1
  end
  vim.cmd 'normal i'
end

vim.api.nvim_create_user_command('Floaterm', toggle_terminal, {})
for i = 1, 9, 1 do
  vim.keymap.set({ 'n' }, '<leader>t' .. i, function()
    toggle_terminal(i)
  end, { desc = 'Floating terminal ' .. i })
end

vim.keymap.set('n', '<esc>', function()
  if current ~= -1 then
    toggle_terminal(current)
  end
end)
