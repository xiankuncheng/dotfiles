local execute = vim.api.nvim_command
local fn = vim.fn

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require("packer").startup(
  function(use)
    if packer_bootstrap then
      require('packer').sync()
    end

    use 'folke/tokyonight.nvim'

    use {
      'kyazdani42/nvim-tree.lua',
      requires = {
        'kyazdani42/nvim-web-devicons',
      },
      config = function() require'nvim-tree'.setup {} end
    }

    use {
      "folke/which-key.nvim",
      config = function()
        require("which-key").setup {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
                                   }
      end
    }

    use {
      'nvim-treesitter/nvim-treesitter',
      requires = {
        {'sheerun/vim-polyglot'},
        -- doesnt work with which key https://github.com/romgrk/nvim-treesitter-context/issues/40
        -- {'romgrk/nvim-treesitter-context'}
      },
      run = ':TSUpdate'
    }

    use 'glepnir/galaxyline.nvim'

    use {
      'nvim-telescope/telescope.nvim',
      requires = {
        {'nvim-lua/popup.nvim'},
        {'nvim-lua/plenary.nvim'},
        {'nvim-telescope/telescope-media-files.nvim'},
        {'nvim-telescope/telescope-github.nvim'},
        {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
        {'fannheyward/telescope-coc.nvim'}
      }
    }
    use {
      'junegunn/fzf.vim',
      requires = {{'junegunn/fzf'}},
      run = 'call fzf#install'
    
  end
)
