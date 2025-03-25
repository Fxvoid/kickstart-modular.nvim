return {
  '0x00-ketsu/autosave.nvim',
  -- lazy-loading on events
  event = { 'InsertLeave', 'TextChanged' },
  config = function()
    require('autosave').setup {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      prompt = {
        enable = true,
        style = 'stdout',
        message = function()
          return 'Autosave: saved at ' .. vim.fn.strftime '%H:%M:%S'
        end,
      },
    }
  end,
}
