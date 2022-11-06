local opt = vim.opt ;
local cmd = vim.cmd ;

opt.number      = true  ;
opt.wrap        = false ;
opt.cursorline  = true  ;
opt.tabstop     = 4     ;
opt.softtabstop = 4     ;
opt.shiftwidth  = 4     ;
opt.expandtab   = true  ;
opt.incsearch   = true  ;
opt.hlsearch    = true  ;

cmd [[ colorscheme gruvbox ]]

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

    use 'gruvbox-community/gruvbox'

    if packer_bootstrap then
        require('packer').sync()
    end
end)
