
-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
vim.keymap.set('n', '<Leader>trn', ":TestNearest<CR>")
vim.keymap.set('n', '<Leader>trf', ":TestFile<CR>")
vim.keymap.set('n', '<Leader>tl', function() require('dap').continue() end, {desc = "Debug: Listen/Next Breakpoint"})
vim.keymap.set('n', '<Leader>to', function() require('dap').step_over() end, {desc = "Debug: Step Over"})
vim.keymap.set('n', '<Leader>ti', function() require('dap').step_into() end, {desc = "Debug: Step Into"})
vim.keymap.set('n', '<Leader>te', function() require('dap').step_out() end, {desc = "Debug: Step Out"})
vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end, {desc = 'Toggle Breakpoint'})
vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end, {desc = 'Set Breakpoint'})
vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end)

vim.keymap.set('n', '<C-b>', ':make<CR>',{desc = 'Build project'})
vim.keymap.set('n', '<C-u>', ':make upload<CR>', {desc = 'Upload project'})
vim.keymap.set('n', ']p', 'o<Esc>p==', {desc = 'Paste on new line after'})
vim.keymap.set('n', '[p', 'O<Esc>p==', {desc = 'Paste on new line before'})

local fixerGroup = vim.api.nvim_create_augroup("PhpCsFixer", {clear = true})
vim.api.nvim_create_autocmd("BufWritePost", {
  group = fixerGroup,
  pattern = "*/src/*.php",
  callback = function ()
    vim.fn.jobstart({'./vendor/bin/php-cs-fixer', 'fix', 'src', '-v'},
      {
        env = { PHP_CS_FIXER_IGNORE_ENV = 1},
        on_exit = function ()
          key = vim.api.nvim_replace_termcodes(':e!<CR>', true, false, true)
          vim.api.nvim_feedkeys(key, 'n', false)
        end
      })
  end
})

vim.api.nvim_create_autocmd("BufWritePost", {
  group = fixerGroup,
  pattern = "*/tests/*.php",
  callback = function ()
    vim.fn.jobstart({'./vendor/bin/php-cs-fixer', 'fix', 'tests', '-v'},
      {
        env = { PHP_CS_FIXER_IGNORE_ENV = 1},
        on_exit = function ()
          key = vim.api.nvim_replace_termcodes(':e!<CR>', true, false, true)
          vim.api.nvim_feedkeys(key, 'n', false)
        end
      })
  end
})
-- The line beneath this is called `modeline`. See `:help modeline`

