package("fastnoise2")

    set_homepage("https://github.com/Auburn/FastNoise2/")
    set_description("Modular node graph based noise generation library using SIMD, C++17 and templates.")
    set_license("MIT")

    add_urls("https://github.com/Auburn/FastNoise2/archive/refs/tags/$(version).tar.gz",
             "https://github.com/Auburn/FastNoise2.git")

    add_deps("cmake")
    add_includedirs("include")

    on_install(function (package)
         local configs = {}
        table.insert(configs, "-DCMAKE_BUILD_TYPE=" .. (package:is_debug() and "Debug" or "Release"))
        table.insert(configs, "-DBUILD_SHARED_LIBS=" .. (package:config("shared") and "ON" or "OFF"))
        import("package.tools.cmake").install(package, configs)
    end)
