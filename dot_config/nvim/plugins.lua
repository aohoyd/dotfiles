-- plugins - Doom nvim custom plugins
--
-- This file contains all the custom plugins that are not in Doom nvim but that
-- the user requires. All the available fields can be found here
-- https://github.com/wbthomason/packer.nvim#specifying-plugins
--
-- By example, for including a plugin with a dependency on telescope:
-- return {
--     {
--         'user/repository',
--         requires = { 'nvim-lua/telescope.nvim' },
--     },
-- }

return {
    { 'hashivim/vim-terraform' },
    { 'rodjek/vim-puppet' },
    { 'mg979/vim-visual-multi' },
    { 
        'kevinhwang91/nvim-bqf',
        requires = { 'junegunn/fzf' },
    },
    -- { 'ms-jpq/coq_nvim', branch = 'coq' },
    -- { 'ms-jpq/coq.artifacts', branch = 'artifacts' },
    { 
        'ibhagwan/fzf-lua',
        requires = { 'vijaymarupudi/nvim-fzf' },
    },
    {
        'phaazon/hop.nvim',
        config = function() require('hop').setup() end,
    },
    {
        'blackCauldron7/surround.nvim',
        config = function() require('surround').setup({}) end,
    },
    { 
        'ahmedkhalf/project.nvim',
        config = function() require('project_nvim').setup({}) end,
    },
    { 'nvim-telescope/telescope-project.nvim' }
}
