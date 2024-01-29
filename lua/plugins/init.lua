return {
	'vim-test/vim-test',
	'normen/vim-pio',
	'coddingtonbear/neomake-platformio',
	'm-pilia/vim-ccls',
	{
		-- Theme inspired by Atom
		'navarasu/onedark.nvim',
		priority = 1000,
		config = function()
			vim.cmd.colorscheme 'onedark'
		end,
	},
	{
		-- "gc" to comment visual regions/lines
		'numToStr/Comment.nvim',
		opts = {
			-- add any options here
		},
		lazy = false,
	},
	'tpope/vim-sleuth',
	{
		-- Add indentation guides even on blank lines
		'lukas-reineke/indent-blankline.nvim',
		-- Enable `lukas-reineke/indent-blankline.nvim`
		-- See `:help ibl`
		main = 'ibl',
		opts = {},
	},

	{
		-- Set lualine as statusline
		'nvim-lualine/lualine.nvim',
		-- See `:help lualine.txt`
		opts = {
			options = {
				icons_enabled = false,
				theme = 'onedark',
				component_separators = '|',
				section_separators = '',
			},
		},
	},

	-- Useful plugin to show you pending keybinds.
	{
		'folke/which-key.nvim',
		config = function()
			-- document existing key chains
			require('which-key').register {
				['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
				['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
				['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
				['<leader>h'] = { name = 'Git [H]unk', _ = 'which_key_ignore' },
				['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
				['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
				['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
				['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
			}

			-- register which-key VISUAL mode
			-- required for visual <leader>hs (hunk stage) to work
			require('which-key').register({
				['<leader>'] = { name = 'VISUAL <leader>' },
				['<leader>h'] = { 'Git [H]unk' },
			}, { mode = 'v' })
		end,
		opts = {}
	},
}
