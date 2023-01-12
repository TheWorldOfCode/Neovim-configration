local M = {}

-- Check if the file or folder exists
function M.exists(name)
    if type(name) ~= "string" then return false end
    return os.rename(name, name) and true or false
end

function M.IsFile(name)
    if type(name) ~= "string" then return false end
    if not exists(name) then return false end
    local f = io.open(name)

    if f then
        f:close()
        return true
    end
    return false
end

function M.IsDir(name)
    return (exists(name) and not IsFile(name))
end

return M
