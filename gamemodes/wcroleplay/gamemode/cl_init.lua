
include("sh_init.lua");
include("shared/ext/acecoolsharednetworking.lua")
include("shared/config.lua")

include("shared/ext/jobmodellib.lua")
include("shared/systems/inventory.lua")
include("shared/systems/vehicles.lua")
include("shared/systems/chatlogic.lua")
include("shared/systems/store.lua")
include("shared/systems/doors.lua")
include("shared/systems/perklevel.lua")
//include("shared/systems/businessv2.lua")
// rip include("shared/systems/mayoralvoting.lua")
include("client/vgui/warehouse.lua")
include("client/vgui/hud.lua")
include("client/vgui/police_pda.lua")
 
local function IncludeProperties()

	include("wcroleplay/gamemode/shared/properties/id_1.lua")
	include("wcroleplay/gamemode/shared/properties/rp_evo.lua")

end

hook.Add("InitPostEntity","CreateEmitters",function()
	if SERVER then return end
	GLOBAL_EMITTER = ParticleEmitter(Vector(0, 0, -5000));
	GLOBAL_EMITTER:SetNearClip(50, 200);
	SMOKE_EMITTER = ParticleEmitter(Vector(0, 0, -5000));
	SMOKE_EMITTER:SetNearClip(50, 200);
end)
		IncludeProperties()
local _pMeta = FindMetaTable('Player');
local gamemodeFolderName = GM.FolderName //Automagically retrieve gamemode name
// Include the shared file to our clientlocal gamemodeFolderName = GM.FolderName //Automagically retrieve gamemode name

GM.Options_SaveBuddies = CreateClientConVar("fsrpsavebuddies", "0", true, false);
local clientFiles, clientDirectories = file.Find(gamemodeFolderName .. "/gamemode/client/*", "LUA")
local sharedFiles, sharedDirectories = file.Find(gamemodeFolderName .. "/gamemode/shared/*", "LUA")
local autoFiles, autoDirectories = file.Find(gamemodeFolderName .. "/gamemode/auto/*", "LUA")

net.Receive( "sendClientProperty" , function ( len , _p ) 

	local prop = net.ReadInt( 8 )
	PropertyInfoPanel( prop )
	if !LocalPlayer():getFlag("InMenu", false ) then 
		LocalPlayer():setFlag("InMenu", true )
	end
end )
net.Receive( "sendClientGenderInformation" , function ( len , _p ) 

	LocalPlayer().__mSex = net.ReadInt( 3)


end ) 


net.Receive( "SendClientInventoryRefresh", function( len, _p ) 
		local str = net.ReadTable();
		LocalPlayer().__Inventory = str;
		
end)


for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/shared/ext/*.lua", "LUA")) do
	include("shared/ext/" .. v)
	if doConsoleMessages then
		print("Including 'shared/ext/" .. v .. "' in cl_init.lua")
	end
end


for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/shared/*.lua", "LUA")) do
	include("shared/" .. v)
	if doConsoleMessages then
		print("Including 'shared/" .. v .. "' in cl_init.lua")
	end
end
for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/shared/systems/*.lua", "LUA")) do
	include("shared/systems/" .. v)
	if doConsoleMessages then
		print("Including 'shared/systems/" .. v .. "' in cl_init.lua")
	end
end

for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/shared/quests/*.lua", "LUA")) do
	include("shared/quests/" .. v)
	if doConsoleMessages then
		print("Including 'shared/quests/" .. v .. "' in cl_init.lua")
	end
end
for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/shared/shops/*.lua", "LUA")) do
	include("shared/shops/" .. v)
	if doConsoleMessages then
		print("Including 'shared/shops/" .. v .. "' in cl_init.lua")
	end
end

for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/client/*.lua", "LUA")) do
	include("client/" .. v)
	if doConsoleMessages then
		print("Including 'client/" .. v .. "' in cl_init.lua")
	end
end

for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/shared/meta/*.lua", "LUA")) do
	include("shared/meta/" .. v)
	if doConsoleMessages then
		print("Including 'shared/meta/" .. v .. "' in cl_init.lua")
	end
end
for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/client/vgui/*.lua", "LUA")) do
	include("client/vgui/" .. v)
	if doConsoleMessages then
		print("Including 'client/vgui/" .. v .. "' in cl_init.lua")
	end
end



for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/shared/items/crafting/*.lua", "LUA")) do
	include("shared/items/crafting/" .. v)
	if doConsoleMessages then
		print("Making 'shared/items/crafting/" .. v .."' avaliable for client in init.lua")
		print("Including 'shared/items/crafting/" .. v .. "' in init.lua")
	end
end

for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/shared/items/rewards/*.lua", "LUA")) do
	include("shared/items/rewards/" .. v)
	if doConsoleMessages then
		print("Making 'shared/items/rewards/" .. v .."' avaliable for client in init.lua")
		print("Including 'shared/items/rewards/" .. v .. "' in init.lua")
	end
end

for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/shared/items/weapons/*.lua", "LUA")) do
	include("shared/items/weapons/" .. v)
	if doConsoleMessages then
		print("Making 'shared/items/weapons/" .. v .."' avaliable for client in init.lua")
		print("Including 'shared/items/weapons/" .. v .. "' in init.lua")
	end
end

for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/shared/items/misc/*.lua", "LUA")) do
	include("shared/items/misc/" .. v)
	if doConsoleMessages then
		print("Making 'shared/items/misc/" .. v .."' avaliable for client in init.lua")
		print("Including 'shared/items/misc/" .. v .. "' in init.lua")
	end
end

for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/shared/items/furniture/*.lua", "LUA")) do
	include("shared/items/furniture/" .. v)
	if doConsoleMessages then
		print("Making 'shared/items/furniture/" .. v .."' avaliable for client in init.lua")
		print("Including 'shared/items/furniture/" .. v .. "' in init.lua")
	end
end

for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/shared/business/*.lua", "LUA")) do
	include("shared/business/" .. v)
	if doConsoleMessages then
		print("Making 'shared/business/" .. v .."' avaliable for client in init.lua")
		print("Including 'shared/business/" .. v .. "' in init.lua")
	end
end 

for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/shared/properties/*.lua", "LUA")) do
	include("shared/properties/" .. v)
	if doConsoleMessages then
		print("Including 'shared/properties/" .. v .. "' in cl_init.lua")
	end
end
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
for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/shared/recipes/*.lua", "LUA")) do
	include("shared/recipes/" .. v)
	if doConsoleMessages then
		print("Including 'shared/recipes/" .. v .. "' in cl_init.lua")
	end
end

net.Receive("showBuddyMenu", function( len , _p )

	if GAMEMODE.BuddyPanel then
				
		GAMEMODE.BuddyPanel:Remove()
		GAMEMODE.BuddyPanel = nil
	
	else
		
		GAMEMODE.BuddyPanel = vgui.Create("buddypanel");

	end
	
end )

function LoadBuddiesClientside()

	if (file.Exists("buddylist.txt", "DATA")) then
		
		local loadBuddies = file.Read("buddylist.txt");
		
		local explodedBuddies = string.Explode(",", loadBuddies);

		LocalPlayer().__Buddies = {};
		for k, v in pairs(explodedBuddies) do
			local miniSplit = string.Explode(";", v);
			
			if (#miniSplit == 3) then
				if (tostring(tonumber(miniSplit[2])) == tostring(miniSplit[2])) then
					table.insert(LocalPlayer().__Buddies, {miniSplit[1], miniSplit[2], miniSplit[3]});
					
				end
			end
		end
		
					net.Start( "clientBuddyTable" )
						net.WriteTable( LocalPlayer().__Buddies )
					net.SendToServer()
					
	end
end

function GM:InitPostEntity( )
	self.Initialized = true;

	//fsrp.hud = vgui.Create("fsrphud");
		// buddies

		timer.Simple(1,function()RunConsoleCommand("stopsound") end)
	LocalPlayer().__Buddies = {};
	
	LocalPlayer()._invButtons = {};
	for k , v in pairs( fsrp.PropertyTable ) do

		SetupProperty( v )
		
	end
		
					net.Start( "clientBuddyTable" )
						net.WriteTable( 	LocalPlayer().__Buddies )
					net.SendToServer()
end
net.Receive( "InitializeClientInventory", function( len, _p ) 

	LocalPlayer().__Inventory = net.ReadTable()
end )

hook.Add("PlayerFullyConnected", "propertyInit", function(_p, client )
	
	if client then
		timer.Simple( 3, function()
			LoadBuddiesClientside()
		end )
	end
	
end) 
