
include("sh_init.lua");
include("shared/buisiness.lua");
include("shared/doors.lua");
include("shared/quest.lua");

local gamemodeFolderName = GM.FolderName //Automagically retrieve gamemode name
// Include the shared file to our clientlocal gamemodeFolderName = GM.FolderName //Automagically retrieve gamemode name

local clientFiles, clientDirectories = file.Find(gamemodeFolderName .. "/gamemode/client/*", "LUA")
local sharedFiles, sharedDirectories = file.Find(gamemodeFolderName .. "/gamemode/shared/*", "LUA")
local autoFiles, autoDirectories = file.Find(gamemodeFolderName .. "/gamemode/auto/*", "LUA")

// Functions
local function includeFolder(side, folder)
	if side == "client" then
		for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/client/" .. folder .. "/*.lua", "LUA")) do
			include("client/" .. folder .. "/" .. v)
			if doConsoleMessages then
				print("Including 'client/" .. folder.. "/" .. v .. "' in cl_init.lua")
			end
		end
	elseif side == "shared" then
		for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/shared/" .. folder .. "/*.lua", "LUA")) do
			include("shared/" .. folder .. "/" .. v)
			if doConsoleMessages then
				print("Including 'shared/" .. folder.. "/" .. v .. "' in cl_init.lua")
			end
		end
	elseif side == "auto" then
		for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/auto/" .. folder .. "/*.lua", "LUA")) do
			include("auto/" .. folder .. "/" .. v)
			if doConsoleMessages then
				print("Including 'auto/" .. folder.. "/" .. v .. "' in cl_init.lua")
			end
		end
		for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/auto/" .. folder .. "/*.lua", "LUA")) do
			include("auto/" .. folder .. "/" .. v)
			if doConsoleMessages then
				print("Including 'auto/" .. folder.. "/" .. v .. "' in cl_init.lua")
			end
		end
	end
end

// Clientside
for k,v in pairs(clientDirectories) do
	includeFolder("client", v)
	if doConsoleMessages then
		print("Checking for files in auto directory 'client/" .. v .. "' in cl_init.lua")
	end
end

for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/client/*.lua", "LUA")) do
	include("client/" .. v)
	if doConsoleMessages then
		print("Including 'client/" .. v .. "' in cl_init.lua")
	end
end

// Shared
for k,v in pairs(sharedDirectories) do
	includeFolder("shared", v)
	if doConsoleMessages then
		print("Checking for files in shared directory 'shared/" .. v .. "' in cl_init.lua")
	end
end

for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/shared/*.lua", "LUA")) do
	include("shared/" .. v)
	if doConsoleMessages then
		print("Including 'shared/" .. v .. "' in cl_init.lua")
	end
end

// Auto Folder
for k,v in pairs(autoDirectories) do
	includeFolder("auto", v)
	if doConsoleMessages then
		print("Checking for files in auto directory 'auto/" .. v .. "' in cl_init.lua")
	end
end

for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/auto/*.lua", "LUA")) do
	include("auto/" .. v)
	if doConsoleMessages then
		print("Including 'auto/" .. v .. "' in cl_init.lua")
	end
end

for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/auto/*.lua", "LUA")) do
	include("auto/" .. v)
	if doConsoleMessages then
		print("Including 'auto/" .. v .. "' in cl_init.lua")
	end
end

fsrp.devprint("[560Roleplay] - Fetching Clientside Files" )


surface.CreateFont("fsrp.vgui_createplayer_name", {
	font = "Trebuchet MS",
	size = 35,
	weight = 800,
	antialias = true
})

surface.CreateFont("fsrp.vgui_createplayer", {
	font = "Trebuchet MS",
	size = 18,
	weight = 800,
	antialias = true
})

function GM:InitPostEntity( )
	self.Initialized = true;
	fsrp.hud = vgui.Create("fsrphud");
	
end

fsrp.devprint("[560Roleplay] - Initialized Clientside" )
