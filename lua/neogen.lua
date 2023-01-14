local M = {}

function M.setup() 
    require('neogen').setup {
        snippet_engine = "luasnip",
        enabled = true,
        lanuages = {
            python = {
                template = {
                    annotation_convention = "doxygen"
                }
            },

            c  = {
                template = {
                    annotation_convention = "doxygen"
                }
            },
            cpp  = {
                template = {
                    annotation_convention = "doxygen"
                }
            }
        }
    }
end

return M
