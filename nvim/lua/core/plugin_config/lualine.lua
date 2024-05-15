require('lualine').setup {
	optios = {
		icons_enabled = true,
		theme = 'gruvbox',
	},
	sections = {
		lualine_a = {
			{
				'filename',
				path = 1,
			}
		}
	}
}
