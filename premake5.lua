project "imgui"
	kind "StaticLib"
	language "C++"
	cppdialect "C++17"
    staticruntime "on"

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
		"%{IncludeDir.Vulkan}",
	}

	filter "system:windows"
		systemversion "latest"

		postbuildcommands {
	
			-- copy premake exe
			"{MKDIR} %{wks.location}/bin/" .. outputs .. "/vendor/%{prj.name}",
			'{COPYDIR} "%{cfg.buildtarget.directory}" "../../../bin/' .. outputs .. '/vendor/%{prj.name}"',
	
			-- Copy ImGui source files
			'{COPY} "*.h" "../../../bin/' .. outputs .. '/vendor/%{prj.name}"',
			'{COPY} "*.cpp" "../../../bin/' .. outputs .. '/vendor/%{prj.name}"',
			'{COPY} "LICENSE.txt" "../../../bin/' .. outputs .. '/vendor/%{prj.name}"',
			
			'{COPYDIR} "backends" "../../../bin/' .. outputs .. '/vendor/%{prj.name}/backends"',
			'{COPYDIR} "misc" "../../../bin/' .. outputs .. '/vendor/%{prj.name}/misc"',
		}

	filter "system:linux"
		pic "On"
		systemversion "latest"

		postbuildcommands {
			"{MKDIR} %{wks.location}/bin/" .. outputs .. "/vendor/%{prj.name}",
			'{COPYDIR} "%{cfg.buildtarget.directory}" "../../../bin/' .. outputs .. '/vendor"',
			'{COPY} "LICENSE.txt" "%{wks.location}/bin/' .. outputs .. '/vendor/%{prj.name}"',
			'{COPYDIR} "backends" "%{wks.location}/bin/' .. outputs .. '/vendor/%{prj.name}"',
			'{COPYDIR} "misc" "%{wks.location}/bin/' .. outputs .. '/vendor/%{prj.name}"',

			'{COPY} "imconfig.h" "%{wks.location}/bin/' .. outputs .. '/vendor/%{prj.name}"',
			'{COPY} "imgui.cpp" "%{wks.location}/bin/' .. outputs .. '/vendor/%{prj.name}"',
			'{COPY} "imgui_demo.cpp" "%{wks.location}/bin/' .. outputs .. '/vendor/%{prj.name}"',
			'{COPY} "imgui_draw.cpp" "%{wks.location}/bin/' .. outputs .. '/vendor/%{prj.name}"',
			'{COPY} "imgui.h" "%{wks.location}/bin/' .. outputs .. '/vendor/%{prj.name}"',
			'{COPY} "imgui_impl_glfw.cpp" "%{wks.location}/bin/' .. outputs .. '/vendor/%{prj.name}"',
			'{COPY} "imgui_impl_glfw.h" "%{wks.location}/bin/' .. outputs .. '/vendor/%{prj.name}"',
			'{COPY} "imgui_impl_vulkan.cpp" "%{wks.location}/bin/' .. outputs .. '/vendor/%{prj.name}"',
			'{COPY} "imgui_impl_vulkan.h" "%{wks.location}/bin/' .. outputs .. '/vendor/%{prj.name}"',
			'{COPY} "imgui_internal.h" "%{wks.location}/bin/' .. outputs .. '/vendor/%{prj.name}"',
			'{COPY} "imgui_tables.cpp" "%{wks.location}/bin/' .. outputs .. '/vendor/%{prj.name}"',
			'{COPY} "imgui_widgets.cpp" "%{wks.location}/bin/' .. outputs .. '/vendor/%{prj.name}"',
			'{COPY} "imstb_rectpack.h" "%{wks.location}/bin/' .. outputs .. '/vendor/%{prj.name}"',
			'{COPY} "imstb_textedit.h" "%{wks.location}/bin/' .. outputs .. '/vendor/%{prj.name}"',
			'{COPY} "imstb_truetype.h" "%{wks.location}/bin/' .. outputs .. '/vendor/%{prj.name}"',
		}

	filter "configurations:Debug"
		runtime "Debug"
		symbols "on"
		
	filter "configurations:RelWithDebInfo"
		runtime "Release"
		symbols "on"
		optimize "on"

	filter "configurations:Release"
		runtime "Release"
		optimize "on"
