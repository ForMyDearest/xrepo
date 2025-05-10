package("u8lib")
do
    set_homepage("https://github.com/ForMyDearest/u8lib")
    set_description("Unicode library for C++")
    set_license("MIT")

    add_urls("https://github.com/ForMyDearest/u8lib.git")

    add_deps("yyjson")
    add_deps("mimalloc", { configs = { shared = true } })

    on_load(function(package)
        if package:is_targetos("windows") then
            package:add("syslinks", "Ole32")
        end
        if package:is_targetos("macosx") then
            package:add("frameworks", "CoreFoundation")
        end
    end)

    on_install(function(package)
        io.writefile("xmake.lua", [[
            includes("pack.lua")
        ]])
        import("package.tools.xmake").install(package)
    end)

    on_test(function(package)
        assert(package:check_cxxsnippets({ test = [[
            #include <u8lib/format.hpp>
            #include <cassert>

            void test() {
                using namespace u8lib;
                u8string_view s = "hello world:114514";
                assert(format(u8"{1} world:{0}", 114514, "hello") == s);
            }
        ]] }, { configs = { languages = "c++23" } })
        )
    end)

    package_end()
end