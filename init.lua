local opt = vim.opt ;
local cmd = vim.cmd ;

opt.number        = true  ;
opt.wrap          = false ;
opt.cursorline    = true  ;
opt.tabstop       = 4     ;
opt.softtabstop   = 4     ;
opt.shiftwidth    = 4     ;
opt.expandtab     = true  ;
opt.incsearch     = true  ;
opt.hlsearch      = true  ;
opt.termguicolors = true  ;

require('nvim-treesitter.configs').setup {
    ensure_installed = { "lua", "haskell", "python" },
    sync_install = false,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
    },
    indent = { enable = true }
}

require('onedarkpro').setup {
    styles = { -- Choose from "bold,italic,underline"
        types        = "bold", -- Style that is applied to types
        numbers      = "NONE", -- Style that is applied to numbers
        strings      = "NONE", -- Style that is applied to strings
        comments     = "NONE", -- Style that is applied to comments
        keywords     = "NONE", -- Style that is applied to keywords
        constants    = "NONE", -- Style that is applied to constants
        functions    = "NONE", -- Style that is applied to functions
        operators    = "NONE", -- Style that is applied to operators
        variables    = "NONE", -- Style that is applied to variables
        conditionals = "NONE", -- Style that is applied to conditionals
        virtual_text = "NONE", -- Style that is applied to virtual text
    },
    plugins = {
        treesitter = true
    },
    options = {
        italic = false,
        cursorline = true
    }
}

cmd [[ colorscheme onedarkpro ]]

-- [[ Ensure packer ]]

local function ensure_packer()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        cmd [[ packadd packer.nvim ]]

        return true
    end

    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    use 'olimorris/onedarkpro.nvim'
    use 'gruvbox-community/gruvbox'

    if packer_bootstrap then
        require('packer').sync()
    end
end)
