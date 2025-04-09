return {
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      display = {
        action_palette = {
          provider = 'telescope',
        },
      },
      adapters = {
        -- gemini = function()
        --   return require('codecompanion.adapters').extend('gemini', {
        --     schema = {
        --       model = {
        --         default = 'gemini-2.5-pro-exp-03-25',
        --       },
        --     },
        --   })
        -- end,
      },
      strategies = {
        chat = {
          slash_commands = {
            ['file'] = {
              -- Location to the slash command in CodeCompanion
              callback = 'strategies.chat.slash_commands.file',
              description = 'Select a file using Telescope',
              opts = {
                provider = 'telescope', -- Other options include 'default', 'mini_pick', 'fzf_lua', snacks
                contains_code = true,
              },
            },
          },
          adapter = 'gemini',
        },
        inline = {
          adapter = 'gemini',
        },
      },
    },
  },
}
