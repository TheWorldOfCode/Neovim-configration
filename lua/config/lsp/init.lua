local M = {}

local servers = {
  pyright = {
    settings = {
      python = {
        analysis = {
          typeCheckingMode = "off",
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = "workspace",
        },
      },
    },
  },
  clangd = { },
  yamlls = {
      schemastore = {
          enable = true,
      },
      settings = {
          yaml = {
              hover = true,
              completion = true,
              validate = true,
              schemas = require("schemastore").json.schemas(),
          },
      },
  },
  bashls = {},
  dockerls = {},
  cmake = {},
  r_language_server = {}
}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    local caps = client.server_capabilities

    -- Enable completion triggered by <C-X><C-O>
    -- See `:help omnifunc` and `:help ins-completion` for more information.
    if caps.completionProvider then
        vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
    end


    -- Configure key mappings
    require("config.lsp.keybinding").setup(client, bufnr)

    -- tagfunc
    if caps.definitionProvider then
        vim.bo[bufnr].tagfunc = "v:lua.lsp.tagfunc"
    end

    -- Setup navic (code location)
    if client.server_capabilities.documentSymbolProvider then
        local navic = require 'nvim-navic'
        navic.attach(client, bufnr)
    end

end


local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properies = {
        "documentation",
        "detail",
        "additionalTextEdits",
    }
}

-- Set up lspconfig.
M.capabilities = require('cmp_nvim_lsp').default_capabilities()

local opts = {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
    flags = {
        debounce_text_changes = 150,
    },
}


-- Setup LSP handlers
require("config.lsp.handlers").setup()

function M.setup()
    require("config.lsp.installer").setup(servers, opts)
end


return M
