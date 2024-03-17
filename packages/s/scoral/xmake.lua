package("scoral")
    set_homepage("https://github.com/SnowLeopardEngine/SCoral")
    set_description("SCoral is a customized Coral with xmake configurations.")

    add_urls("https://github.com/SnowLeopardEngine/SCoral.git")

	add_includedirs("include")
    add_linkdirs("lib")
	
    add_links("CoralNative")

    on_install(function (package)
        -- install
        import("package.tools.xmake").install(package, configs)
    end)
