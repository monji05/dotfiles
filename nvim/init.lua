require("config.lazy")
if jit.os:find("Windows") then
	require("config.windows")
else
	require("config.macos")
end
