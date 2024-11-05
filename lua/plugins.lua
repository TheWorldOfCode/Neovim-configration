local M = {}

-- List of plugins to configure
-- Vimwiki

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
            packer_bootstrap = fn.system { "git",
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

        -- Colorschemes
        use {
            "sainnhe/everforest",
            config = function()
                vim.g.everforest_better_performance = 1
                vim.cmd.colorscheme [[everforest]]
            end,
            disable = false,
        }

        -- Which key (Menu for keybinding)
        use {
            "folke/which-key.nvim",
            event = "VimEnter",
            module = {"which-key"},
            config = function()
                vim.o.timeout = true
                vim.o.timeoutlen = 100
                require("config.whichkey").setup()
            end,
        }

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
            end,
            requires = {
                "MunifTanjim/nui.nvim"
            },
        }

        -- Search projects
        use {
            'nvim-telescope/telescope.nvim', tag = '0.1.6',
            requires = {
                {'nvim-lua/plenary.nvim'},
                {'BurntSushi/ripgrep'},
                {'sharkdp/fd'},
                {'nvim-telescope/telescope-project.nvim'},
                {'cljoly/telescope-repo.nvim'},
                {'nvim-telescope/telescope-file-browser.nvim'},
            },
            config = function() 
                require("config.telescope").setup()
            end
        }

        -- Better syntax
        use {
            'nvim-treesitter/nvim-treesitter',
            config = function()
                require("config.treesitter").setup()
            end
        }

        -- lspsaga.nvim
        use {
            "glepnir/lspsaga.nvim",
            cmd = { "Lspsaga" },
            config = function()
                require("config.lspsaga").setup()
            end,
        }

        -- renamer.nvim
        use {
            "filipdutescu/renamer.nvim",
            module = { "renamer" },
            config = function()
                require("renamer").setup {}
            end,
        }

        -- Refactoring
        use {
            "ThePrimeagen/refactoring.nvim", 
            module = { "refactoring", "telescope"},
            keys = { [[<leader>r]]},
            config = function()
                require("config.refactoring").setup()
            end,
        }

        -- Easy setup of LSP
        use {
            'neovim/nvim-lspconfig',
            config = function()
                require("config.lsp").setup()
            end,
            requires = {
                "williamboman/mason.nvim",
                "williamboman/mason-lspconfig.nvim",
                "WhoIsSethDaniel/mason-tool-installer.nvim",
                { "jayp0521/mason-null-ls.nvim" },
                "folke/neodev.nvim",
                "RRethy/vim-illuminate",
                "jose-elias-alvarez/null-ls.nvim",
                {
                    "j-hui/fidget.nvim",
                    config = function()
                        require("fidget").setup {}
                    end,
                },
                { "b0o/schemastore.nvim", module = { "schemastore" } },
                { "jose-elias-alvarez/typescript.nvim", module = { "typescript" } },
                {
                    "SmiteshP/nvim-navic",
                    config = function()
                        require("nvim-navic").setup {}
                    end,
                    module = { "nvim-navic" },
                },
                {
                    "simrat39/inlay-hints.nvim",
                    config = function()
                        require("inlay-hints").setup()
                    end,
                },
            },
        }

        -- trouble.nvim
        use {
            "folke/trouble.nvim",
            cmd = { "TroubleToggle", "Trouble" },
            module = { "trouble.providers.telescope" },
            config = function()
                require("trouble").setup {
                    use_diagnostic_signs = true,
                }
            end,
        }

        -- Debugging
        use {
            "mfussenegger/nvim-dap",
            module = { "dap" },
            opt = true,
            requires = {
                {"theHamsta/nvim-dap-virtual-text", module = { "nvim-dap-virtual-text" } },
                {"rcarriga/nvim-dap-ui", module = { "dapui" } },
                "nvim-telescope/telescope-dap.nvim",

                {"mfussenegger/nvim-dap-python", module = { 'dap-python'}},


            },
            config = function()
                require("config.dap").setup()
            end,
        }

        -- Testing
        use {
            "nvim-neotest/neotest",
            requires = {
                {
                    "vim-test/vim-test",
                    event = { "BufReadPre" },
                    config = function()
                        require("config.test").setup()
                    end
                },
                "alfaix/neotest-gtest",
                "nvim-neotest/nvim-nio",
                "nvim-lua/plenary.nvim",
                "nvim-neotest/neotest-vim-test",
                "nvim-treesitter/nvim-treesitter",
                { "nvim-neotest/neotest-python", module = {"neotest-python"}},
            },
            module = { "neotest", "neotest.async" },
            config = function()
                require("config.neotest").setup()
            end,
        }

        -- Auto pairs
        use {
            "windwp/nvim-autopairs",
            opt = true,
            event = "InsertEnter",
            module = { "nvim-autopairs.completion.cmp", "nvim-autopairs" },
            config = function()
                require("config.autopairs").setup()
            end
        }

        -- Task runner
        use {
            "stevearc/overseer.nvim",
            opt = true,
            module = { "neotest.consumers.overseer" },
            cmd = {
                "OverseerToggle",
                "OverseerOpen",
                "OverseerRun",
                "OverseerBuild",
                "OverseerClose",
                "OverseerLoadBundle",
                "OverseerSaveBundle",
                "OverseerDeleteBundle",
                "OverseerRunCmd",
                "OverseerQuickAction",
                "OverseerTaskAction",
            },
            config = function()
                require("overseer").setup()
            end,
        }

        -- Code documentation
        use {
            "danymat/neogen", 
            config = function()
                require("config.neogen").setup()
            end,
            cmd = { "Neogen" }, 
            module = "neogen",
        }

        -- Autocompletion 
        use {
            'hrsh7th/nvim-cmp',
            event = "InsertEnter",
            opt = true,
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


        -- git
        use {
            "TimUntersberger/neogit",
            cmd = "Neogit",
            module = {"neogit"},
            config = function()
                require("config.neogit").setup()
            end
        }

        use {
            "lewis6991/gitsigns.nvim",
            event = "BufReadPre",
            requires = { "nvim-lua/plenary.nvim" },
            config = function()
                require("config.gitsigns").setup()
            end,
        }

        use {
            "akinsho/git-conflict.nvim",
            cmd = {
                "GitConflictChooseTheirs",
                "GitConflictChooseOurs",
                "GitConflictChooseBoth",
                "GitConflictChooseNone",
                "GitConflictNextConflict",
                "GitConflictPrevConflict",
                "GitConflictListQf",
            },
            config = function()
                require("git-conflict").setup()
            end,
        }

        -- Fancy sidebar
        use {
            "sidebar-nvim/sidebar.nvim",
            cmd = { "SidebarNvimToggle" },
            config = function()
                require("sidebar-nvim").setup { open = false }
            end,
        }

        -- R
        use { "jalvesaq/Nvim-R" }

        -- Neovim in browser
        use { 
            'glacambre/firenvim',
            lazy = not vim.g.started_by_firenvim,
            build = function()
                vim.fn["firenvim#install"](0)
            end
        }

        use {
            "aklt/plantuml-syntax"
        }

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
