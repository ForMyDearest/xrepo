package("HanaBase")
do
    set_homepage("https://github.com/ForMyDearest/HanaBase")
    set_description("Foundation for hana")
    set_license("MIT")

    add_urls("https://github.com/ForMyDearest/HanaBase.git")

    add_configs("shared", { default = true, type = "boolean", readonly = true })

    on_load(function(package)
        package:add("defines", "HANA_BASE_API=HANA_IMPORTS")
    end)

    on_install(function(package)
        io.writefile("xmake.lua", [[
            includes("xmake/pack.lua")
        ]])
        import("package.tools.xmake").install(package)
    end)

    on_test(function(package)
        assert(package:check_cxxsnippets({ test = [[
            #include <hana/archive/json.hpp>

            void test() {
                using namespace hana;
                auto writer = JsonWriter::create(5);
                json_write(writer, u8"int", 5);
            }
        ]] }, { configs = { languages = "c++20" } })
        )
    end)

    package_end()
end