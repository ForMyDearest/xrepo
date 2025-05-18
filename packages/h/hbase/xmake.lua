package("HBase")
do
    set_homepage("https://github.com/ForMyDearest/HBase")
    set_description("Basement for hana")
    set_license("MIT")

    add_urls("https://github.com/ForMyDearest/HBase.git")

    add_deps("xxhash", { configs = { shared = true } })
    add_deps("yyjson", { configs = { shared = true } })

    on_install(function(package)
        io.writefile("xmake.lua", [[
            includes("pack.lua")
        ]])
        import("package.tools.xmake").install(package)
    end)

    on_test(function(package)
        assert(package:check_cxxsnippets({ test = [[
            #include <HBase/json.hpp>

            void test() {
                using namespace HBase;
                json::JsonWriter writer(5);
                json::write(writer, u8"int", 5);
            }
        ]] }, { configs = { languages = "c++20" } })
        )
    end)

    package_end()
end