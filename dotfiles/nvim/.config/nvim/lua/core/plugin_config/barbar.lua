vim.g.barbar_auto_setup = false -- disable auto-setup

require('barbar').setup{
    animation = true,
    auto_hide = false,
    tabpages = true,
    clickable = true,
    filetype = {
      custom_colors = false,
      enabled = true,
    },
    separator = {left = '', right = ''},
    sidebar_filetypes = {
        NvimTree = true, -- default event and text
        ['neo-tree'] = {event = 'BufWipeout', text = 'neo-tree'}, -- custom event and text
  },
}
