project "imgui"
	kind "StaticLib"
	language "C++"
    staticruntime "off"

	targetdir ("bin/" .. outputs .. "/%{prj.name}")
	objdir ("bin-int/" .. outputs .. "/%{prj.name}")

	files
	{
		"imconfig.h",
		"imgui.h",
		"imgui.cpp",
		"imgui_draw.cpp",
		"imgui_internal.h",
		"imgui_tables.cpp",
		"imgui_widgets.cpp",
		"imstb_rectpack.h",
		"imstb_textedit.h",
		"imstb_truetype.h",
		"imgui_demo.cpp",
		"imgui_impl_glfw.h",
		"imgui_impl_glfw.cpp",
		"imgui_impl_vulkan.h",
		"imgui_impl_vulkan.cpp",
	}

	includedirs
	{
		"%{prj.name}",
		"backends",
		"%{IncludeDir.glfw}/include",
		"%{IncludeDir.VulkanSDK}",
	}

	postbuildcommands {
	
		-- copy premake exe
		"{MKDIR} %{wks.location}/bin/" .. outputs .. "/vendor",
		'{COPYDIR} "%{cfg.buildtarget.directory}" "../../../bin/' .. outputs .. '/vendor/%{prj.name}"'
	}

	filter "system:windows"
		systemversion "latest"
		cppdialect "C++17"

	filter "system:linux"
		pic "On"
		systemversion "latest"
		cppdialect "C++17"

	filter "configurations:Debug"
		buildoptions "/MDd"
		runtime "Debug"
		symbols "on"
		
	filter "configurations:RelWithDebInfo"
		buildoptions "/MD"
		runtime "Release"
		symbols "on"
		optimize "On"

	filter "configurations:Release"
		buildoptions "/MD"
		runtime "Release"
		symbols "off"
		optimize "Full"
		