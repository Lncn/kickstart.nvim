--[[
-- MY NEOVIM CONFIG
--
-- This is a fork of the "kickstart" configuration from https://github.com/nvim-lua/kickstart.nvim
--
-- It uses the lazy.nvim plugin manager which is pretty much magic, but I've made an effort to keep
-- this configuration as simple as possible. The main thing I wanted was to switch from VSCode and
-- use an LSP with Vim again after starting to read/edit larger Python projects and needing a better
-- language server than raw tags. (Previously, I had only use ctags with vanilla Vim) I miss Vim.
--
-- I'VE ATTEMPTED TO MAKE THIS CLEANER BY MOVING PLUGINS WITH OPTIONS TO IT'S OWN
-- LUA FILE UNDER lua/plugins/ USING THE `return {}` SYNTAX THERE TO BE IMPORTED BELOW
--]]

-- This is basic Vim configuration and keymappings the Neovim way (using Lua)
-- Go to lua/base/config.lua --> 'base.config'
require 'base.config'

-- [[ INSTALL `lazy.nvim` PLUGIN MANAGER ]]

-- Using lazy.nvim plugin manager. This is where most of the magic happens..
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins for Lazy ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.

require('lazy').setup {
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).

  'tpope/vim-sleuth', -- Detects tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- **** IMPORTANT TO KNOW ****
  -- Use `opts = {}` to force a plugin to be loaded.
  -- ***************************
  --
  --  This is equivalent to the normal neovim lua:
  --    require('Comment').setup({})

  { 'numToStr/Comment.nvim', opts = {} },

  -- Pull in a simple plugin via require `return {}` in a lua/plugins/*.lua file
  --
  -- NOTE: You should also be able to do "{ import = 'plugins' }" to import all
  --       lua files in the plugins dir, but I use require here because I don't
  --       want that.

  require 'plugins.gitsigns',

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `config` key, the configuration only runs
  -- after the plugin has been loaded:
  --  config = function() ... end

  require 'plugins.autoformat',
  require 'plugins.autocomplete',
  require 'plugins.colorscheme',
  --require 'plugins.debug',
  require 'plugins.fuzzyfind', -- Supercharged Fuzzyfinder
  --require 'plugins.indent_line',
  require 'plugins.line', -- Status line config
  --require 'plugins.lint',
  require 'plugins.lsp', -- Language Server (GoTo Definition!)
  require 'plugins.treesitter', -- Syntax tree generator (Code parser for better highlighting)
  require 'plugins.which-key', -- Convenient key bind displayer
}
