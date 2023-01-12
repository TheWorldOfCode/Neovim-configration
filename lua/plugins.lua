local M = {}

-- List of plugins to configure
-- dap
-- lspconfig
-- neogen
-- neotest
-- Vimwiki
-- git plugin
-- nvim-navic
-- cmp

function M.setup()

    -- Install plugins if packer is not installed.
    local packer_bootstrap = false

    -- Packer configuration
    local conf =  {
        display = {
            open_fn = function()
                return require("packer.util").float { border = "rounded" }
            end
        }
    }

    -- Setup packer if it doesn't is installed already.
    local function init()
        local fn = vim.fn
        local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
        if (fn.empty(fn.glob(install_path)) > 0) then
            packer_bootstrap = fn.system {
                "git",
                "clone",
                "--depth",
                "1",
                "https://github.com/wbthomason/packer.nvim",
                install_path,
            }
            vim.cmd [[packadd packer.nvim]]
        end
        vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
    end

    local function plugins(use)
        -- Packer manager
        use 'wbthomason/packer.nvim'

        -- Statusline
        use {
            'nvim-lualine/lualine.nvim',
            requires = {
                {
                    'kyazdani42/nvim-web-devicons',
                    config = function()
                        require("nvim-web-devicons").setup { default = true}
                    end
                }
        },
            config = function()
                require("config.lualine").setup()
            end
        }

        -- UI
        use {
            "rcarriga/nvim-notify",
            event = "BufReadPre",
            config = function()
                require("config.notify").setup()
            end,
        }

        use {
            'folke/noice.nvim',
            event = "VimEnter",
            config = function()
                require("config.noice").setup()
            end
        }

        -- Search projects
        use {
            'nvim-telescope/telescope.nvim', tag = '0.1.0',
            requires = {
                {'nvim-lua/plenary.nvim'},
                {'BurntSushi/ripgrep'},
                {'sharkdp/fd'},
                {'nvim-telescope/telescope-project.nvim'},
                {'cljoly/telescope-repo.nvim'}
            },
            config = function() 
                require("config.telescope").setup()
            end
        }

        -- Which key (Menu for keybinding)
        use {
            "folke/which-key.nvim",
            event = "VimEnter",
            config = function()
                vim.o.timeout = true
                vim.o.timeoutlen = 300
                require("config.whichkey").setup()
            end,
        }
        -- Better syntax
        use {
            'nvim-treesitter/nvim-treesitter',
            config = function()
                require("config.treesitter").setup()
            end
        }

        -- Easy setup of LSP
        use 'neovim/nvim-lspconfig'

        -- Code location
        use {
            "SmiteshP/nvim-navic",
            requires = "neovim/nvim-lspconfig"
        }

        use {
            "mfussenegger/nvim-dap",
            event = "BufReadPre",
            module = { "dap" },
            wants = { "nvim-dap-virtual-text", "nvim-dap-ui", "which-key.nvim" },
            requires = {
                "theHamsta/nvim-dap-virtual-text",
                "rcarriga/nvim-dap-ui",
                "nvim-telescope/telescope-dap.nvim",
            },
            config = function()
                require("config.dap").setup()
            end,
        }

        -- Autocompletion 
        use {
            'hrsh7th/nvim-cmp',
            --       event = "InsertEnter",
            config = function()
                require("config.cmp").setup()
            end,
            requires = {
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-nvim-lua",
                "ray-x/cmp-treesitter",
                "hrsh7th/cmp-cmdline",
                "saadparwaiz1/cmp_luasnip",
                { "hrsh7th/cmp-nvim-lsp", module = { "cmp_nvim_lsp" } },
                "hrsh7th/cmp-nvim-lsp-signature-help",
                "lukas-reineke/cmp-rg",
                "davidsierradz/cmp-conventionalcommits",
                { "onsails/lspkind-nvim", module = { "lspkind" } },
                {
                    "L3MON4D3/LuaSnip",
                    config = function()
                        require("config.snip").setup()
                    end,
                    module = { "luasnip" },
                },
            }
        }


        -- For ultisnips users.
        --    use 'SirVer/ultisnips'
        --    use 'quangnguyen30192/cmp-nvim-ultisnips'
        --    vim.g["g:UltiSnipsSnippetDirectories"] = {"snippets"}


        -- Install plugins in fresh installment.
        if packer_bootstrap then
            print "Restart Neovim required after installation!"
            require("packer").sync()
        end

    end

    init()
    local packer = require "packer"
    packer.init(conf)
    packer.startup(plugins)
end

return M
