package("HanaBase")
do
    set_homepage("https://github.com/ForMyDearest/HanaBase")
    set_description("Foundation for hana")
    set_license("MIT")

    add_urls("https://github.com/ForMyDearest/HanaBase.git")

    add_deps("xxhash", { configs = { shared = true } })
    add_deps("yyjson", { configs = { shared = true } })

    if (is_plat("windows")) then
        add_syslinks("Ole32")
    end
    if (is_plat("macosx")) then
        add_frameworks("CoreFoundation")
    end

    on_install(function(package)
        io.writefile("xmake.lua", [[
            includes("xmake/pack.lua")
        ]])
        import("package.tools.xmake").install(package)
    end)

    on_test(function(package)
        assert(package:check_cxxsnippets({ test = [[
            #include <hana/json.hpp>

            void test() {
                using namespace hana;
                JsonWriter writer(5);
                json_write(writer, u8"int", 5);
            }
        ]] }, { configs = { languages = "c++20" } })
        )
    end)

    package_end()
end