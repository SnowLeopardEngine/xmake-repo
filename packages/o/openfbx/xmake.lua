package("openfbx")
    set_homepage("https://github.com/nem0/OpenFBX")
    set_description("Lightweight open source FBX importer")

    add_urls("https://github.com/nem0/OpenFBX/archive/refs/tags/$(version).tar.gz",
             "https://github.com/nem0/OpenFBX.git")

    on_install(function (package)
         io.writefile("xmake.lua", [[
            add_rules("mode.debug", "mode.release")
            set_languages("c++17")
            target("openfbx")
                set_kind("$(kind)")
                add_files("src/**.c")
                add_files("src/**.cpp")
                add_headerfiles("src/**.h")
        ]])
        import("package.tools.xmake").install(package)
    end)