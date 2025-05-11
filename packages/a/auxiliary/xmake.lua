package("auxiliary")
do
    set_homepage("https://github.com/ForMyDearest/auxiliary")
    set_description("Tools for C++")
    set_license("MIT")

    add_urls("https://github.com/ForMyDearest/auxiliary.git")

    add_deps("u8lib")
    add_deps("xxhash")
    add_deps("yyjson")

    on_install(function(package)
        io.writefile("xmake.lua", [[
            includes("pack.lua")
        ]])
        import("package.tools.xmake").install(package)
    end)

    on_test(function(package)
        assert(package:check_cxxsnippets({ test = [[
            #include <auxiliary/json.hpp>

            void test() {
                using namespace auxiliary;
                JsonWriter writer(5);
                writer.write(u8"int", 5);
            }
        ]] }, { configs = { languages = "c++23" } })
        )
    end)

    package_end()
end