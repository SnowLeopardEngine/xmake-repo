package("scoral")
    set_homepage("https://github.com/SnowLeopardEngine/SCoral")
    set_description("SCoral is a customized Coral with xmake configurations.")

    add_urls("https://github.com/SnowLeopardEngine/SCoral.git")

	add_includedirs("include")
    add_linkdirs("lib")

    if is_plat("windows") then
        add_syslinks("Shell32", "Ole32")
    end
	
    add_links("CoralNative")

    on_install(function (package)
        -- The .NET installer keeps only the newest hostfxr (e.g. host/fxr/9.0.6), and hostfxr can run older runtimes.
        -- Coral only accepted a folder whose path contains the character '8', so it found nothing on such machines.
        -- Accept any hostfxr whose major version is at least the target one.
        local hostinstance = "Coral.Native/Source/Coral/HostInstance.cpp"
        io.replace(hostinstance, '#include "HostInstance.hpp"', '#include "HostInstance.hpp"\n#include <cstdlib>', {plain = true})
        io.replace(hostinstance,
            "if (dirPath.find(CORAL_DOTNET_TARGET_VERSION_MAJOR_STR) == std::string::npos)",
            "if (std::atoi(dir.path().filename().string().c_str()) < CORAL_DOTNET_TARGET_VERSION_MAJOR)",
            {plain = true})

        -- install
        import("package.tools.xmake").install(package, configs)
    end)
