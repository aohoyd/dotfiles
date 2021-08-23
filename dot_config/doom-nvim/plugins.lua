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
    { 'rodjek/vim-puppet' },
    { 'mg979/vim-visual-multi' },
    {
        'rmagatti/auto-session',
        requires = { 'nvim-lua/telescope.nvim' },
    },
    {
        'nvim-telescope/telescope-project.nvim',
        requires = { 'nvim-lua/telescope.nvim' },
    },
    {
        'rmagatti/session-lens',
        requires = { 'rmagatti/auto-session', 'nvim-lua/telescope.nvim' },
    },
    { 'kevinhwang91/nvim-bqf' },
}
