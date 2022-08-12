local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP  = fn.system {
	  'git', 
	  'clone', 
	  '--depth', 
	  '1', 
	  'https://github.com/wbthomason/packer.nvim', 
	  install_path
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Install your plugins here
return require('packer').startup(function(use)
	use {'wbthomason/packer.nvim', opt = true}
	
	-- File Explorer
	use {
  		'kyazdani42/nvim-tree.lua',
  		requires = {
    			'kyazdani42/nvim-web-devicons', -- optional, for file icons
  		},
  		tag = 'nightly' -- optional, updated every week. (see issue #1193)
	}


  -- My plugins here
  -- use 'foo1/bar1.nvim'
  -- use 'foo2/bar2.nvim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP  then
    require('packer').sync()
  end
end)


