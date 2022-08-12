return require'packer'.startup(function()
    use 'wbthomason/packer.nvim'
    -- Color schemes
    use 'EdenEast/nightfox.nvim'
    -- file icons
    use 'kyazdani42/nvim-web-devicons'     
    -- nvim-tree, file explorer
    use 'kyazdani42/nvim-tree.lua'
    -- Notification manager config
    use 'rcarriga/nvim-notify'
    -- LuaLine plugin
    use 'nvim-lualine/lualine.nvim'
    -- Barbar plugin
    use 'romgrk/barbar.nvim'
    -- Treesitter plugin
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    --use { 'nvim-treesitter/nvim-treesitter',
    --    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    --}
    -- nvim-treesitter extra plugin
    use 'nvim-treesitter/nvim-treesitter-refactor'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = { {'nvim-lua/plenary.nvim'} }
    }


    -- Nvim LSP plugin and utility plugins 
    use 'williamboman/nvim-lsp-installer'   
    use 'neovim/nvim-lspconfig' 
    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
    use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
    use 'L3MON4D3/LuaSnip' -- Snippets plugin
    use 'onsails/lspkind.nvim' --adds vscode-like pictograms to neovim built-in lsp

end)
