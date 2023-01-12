local Job = require("plenary").job
local Path = require("plenary").path

local cmake_buffer = -1
ctest_lists = {}
ctest_lists_cleaned = false


local function create_local_buffer() 
    if cmake_buffer == -1 then
        cmake_buffer = vim.api.nvim_create_buf(false, true)
    else
        vim.api.nvim_buf_call(cmake_buffer, function()
            vim.cmd("normal gg")
            vim.cmd("normal dG")
        end)
    end
end

-- Configure the build directory
function generate()
    create_local_buffer()

    function callback(_, data)
        vim.api.nvim_buf_set_lines(cmake_buffer, -1, -1, true, { data })
    end
    local args = {'-B' .. vim.g["cmake_build"], "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON", vim.g["cmake_dir"]}

    if vim.g["cmake_configure_arguments"] ~= "" then
        args = {'-B' .. vim.g["cmake_build"], "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON", vim.g["cmake_configure_arguments"] , vim.g["cmake_dir"]}
    end


    vim.g["cmake_running"] = "Configuring"
    Job:new({command="cmake", args=args,
    on_stdout = vim.schedule_wrap(callback),
    on_stderr = vim.schedule_wrap(callback),
    on_exit = function(j, return_val)
        if return_val == 0 then
            vim.g["cmake_configured"] = true
            vim.g["cmake_running"] = "Success"
            ctest_get_available_tests()
        else
            vim.g["cmake_configured"] = false
            vim.g["cmake_running"] = "Failed"
        end
    end, }):start()
end

-- Build target
function build()

    if vim.g["cmake_configured"] == false then
        vim.notify("Please run CMakeGenerate before building", vim.log.levels.WARN, { title="CMake"})
        return
    end

    create_local_buffer()

    function callback(_, data)
        vim.api.nvim_buf_set_lines(cmake_buffer, -1, -1, true, { data })
    end

    vim.g["cmake_running"] = "Building"
    Job:new({command="cmake", args={'--build', vim.g["cmake_build"]},
    on_stdout = vim.schedule_wrap(callback),
    on_stderr = vim.schedule_wrap(callback),
    on_exit = function(j, return_val)
        if return_val == 0 then
            vim.g["cmake_running"] = "Success"
        else
            vim.g["cmake_running"] = "Failed"
        end
    end, }):start()
end

function ctest_get_available_tests()

    function callback(_, data)
        table.insert(ctest_lists, data)
    end
    Job:new({command="ctest",args={"--test-dir", vim.g["cmake_build"].."/test", "-N"},
    on_stdout = vim.schedule_wrap(callback),
    on_stderr = vim.schedule_wrap(callback),
    on_exit = function(j, return_val)
        if return_val == 0 then
            ctest_lists_cleaned = false
        else 
            ctest_lists = {}
        end
    end, }):sync()

end

function test(reg)

    if vim.g["cmake_configured"] == false then
        vim.notify("Please run CMakeGenerate before building", vim.log.levels.WARN, { title="CMake"})
        return
    end

    create_local_buffer()

    function callback(_, data)
        vim.api.nvim_buf_set_lines(cmake_buffer, -1, -1, true, { data })
    end

    local filter = ""
    if reg ~= "" then
        filter = "-R " .. reg
    end

    vim.g["cmake_running"] = "Testing"
    Job:new({command="ctest", args={"--test-dir", vim.g["cmake_build"].."/test", '--output-on-failure', filter, '.'},
    on_stdout = vim.schedule_wrap(callback),
    on_stderr = vim.schedule_wrap(callback),
    on_exit = function(j, return_val)
        if return_val == 0 then
            vim.g["cmake_running"] = "Success"
        else
            vim.g["cmake_running"] = "Failed"
        end
    end, }):start()
end
function test_completion(A, L, P)
    if ctest_lists_cleaned == false then
        ctest_lists_cleaned = true
    end
    return ctest_lists
end

vim.g["cmake_build"] = "build"
vim.g["cmake_dir"] = "."
vim.g["cmake_configure_arguments"] = ""

if Path:new("build"):is_dir() then
    vim.g["cmake_configured"] = true
    ctest_get_available_tests()
else
    vim.g["cmake_configured"] = false
end

if Path:new("./CMakeLists.txt"):exists() then
    vim.g["cmake_available"] = true
else
    vim.g["cmake_available"] = false
end

if vim.g["cmake_available"] then
    vim.api.nvim_create_user_command("CMakeGenerate", function()
        generate()
    end, {})
    vim.api.nvim_create_user_command("CMakeBuild", function()
        build()
    end, {})
    vim.api.nvim_create_user_command("CTest", function(args)
        local filter = args["args"]

        if filter == "CTest" then
            filter = ""
        end

        test(filter)
    end, { nargs = "?", complete=test_completion})
    vim.api.nvim_create_user_command("CMakeResults", function()
        if (cmake_buffer ~= -1) then
            vim.cmd('split')
            vim.cmd('buffer ' .. cmake_buffer)
        end
    end, {})
end
