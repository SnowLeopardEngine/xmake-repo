package("sphysx-cross")
    set_homepage("https://github.com/SnowLeopardEngine/SPhysX-Cross")
    set_description("Cross-Platform PhysX 5 for SnowLeopardEngine")

    add_urls("https://github.com/SnowLeopardEngine/SPhysX-Cross.git")

	add_includedirs("include")
    add_linkdirs("lib")
	
	-- it must follow the order: https://github.com/NVIDIAGameWorks/PhysX/issues/53
    add_links("PhysX_static", "PhysXPvdSDK_static", "PhysXExtensions_static", "PhysXCooking_static", "PhysXCommon_static", "PhysXFoundation_static")
    add_links("PhysXCharacterKinematic_static")
    add_links("PhysXVehicle_static")

    if is_plat("windows") then
        add_links("ucrtd")
    end

    add_deps("cmake")

    on_install(function (package)
        -- download PhysXGpu_*.dll
        if is_plat("windows") then
            os.execv("powershell .\\download_dll.ps1")
        end

        local configs = {"-DBUILD_SHARED_LIBS=OFF"}
        table.insert(configs, "-DCMAKE_BUILD_TYPE=" .. (package:is_debug() and "Debug" or "Release"))
        import("package.tools.cmake").install(package, configs)
        -- copy include
        os.cp("PhysX-CMake/physx/include/*", package:installdir("include"))
        -- copy libraries
        os.cp("lib/bin/*/$(mode)/*", package:installdir("lib"))
        os.cp("*.dll", package:installdir("bin"))
        os.cp("*.so", package:installdir("bin"))
    end)
