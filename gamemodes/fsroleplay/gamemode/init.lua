fsrp = fsrp || {};

DarkRP = nil;

function fsrp.devprint( t )
	
	if SERVER then
	
		if GM_MODE != 0 then
		
			print( t )
			
		end
	
	end
	
end
resource.AddSingleFile("resource/fonts/OpenSans.ttf")
function fsrp.devprintTable( t )
	
	if SERVER then
	
		if GM_MODE != 0 then
		
			PrintTable( t )
			
		end
	
	end
	
end

fsrp.devprint("[560Roleplay] - Fetching Lua Files" )

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("sh_init.lua")
AddCSLuaFile("shared/buisiness.lua")
AddCSLuaFile("shared/doors.lua")
include("shared/doors.lua")
include("shared/buisiness.lua")
AddCSLuaFile("shared/quest.lua")
include("shared/quest.lua")

include("sh_init.lua")

local gamemodeFolderName = GM.FolderName //Automagically retrieves gamemode name

local clientFiles, clientDirectories = file.Find(gamemodeFolderName .. "/gamemode/client/*", "LUA")
local sharedFiles, sharedDirectories = file.Find(gamemodeFolderName .. "/gamemode/shared/*", "LUA")
local serverFiles, serverDirectories = file.Find(gamemodeFolderName .. "/gamemode/server/*", "LUA")
local autoFiles, autoDirectories = file.Find(gamemodeFolderName .. "/gamemode/auto/*", "LUA")

// Functions
local function includeFolder(side, folder)
	if side == "server" then
		for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/server/" .. folder .. "/*.lua", "LUA")) do
			include("server/" .. folder .. "/" .. v)
			if doConsoleMessages then
				print("Including 'server/" .. folder.. "/" .. v .. "' in init.lua")
			end
		end
	elseif side == "client" then
		for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/client/" .. folder .. "/*.lua", "LUA")) do
			AddCSLuaFile("client/" .. folder .. "/" .. v)
			if doConsoleMessages then
				print("Making 'client/" .. folder.. "/" .. v .. "' avaliable for client in init.lua")
			end
		end
	elseif side == "shared" then
		for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/shared/" .. folder .. "/*.lua", "LUA")) do
			AddCSLuaFile("shared/" .. folder .. "/" .. v)
			include("shared/" .. folder .. "/" .. v)
			if doConsoleMessages then
				print("Making 'shared/" .. folder.. "/" .. v .. "' avaliable for client in init.lua")
				print("Including 'shared/" .. folder.. "/" .. v .. "' in init.lua")
			end
		end
	elseif side == "auto" then
		for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/auto/" .. folder .. "/*.lua", "LUA")) do
			AddCSLuaFile("auto/" .. folder .. "/" .. v)
			include("auto/" .. folder .. "/" .. v)
			if doConsoleMessages then
				print("Making 'auto/" .. folder.. "/" .. v .. "' avaliable for client in init.lua")
				print("Including 'auto/" .. folder.. "/" .. v .. "' in init.lua")
			end
		end
		for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/auto/" .. folder .. "/*.lua", "LUA")) do
			AddCSLuaFile("auto/" .. folder .. "/" .. v)
			if doConsoleMessages then
				print("Making 'auto/" .. folder.. "/" .. v .. "' avaliable for client in init.lua")
			end
		end
		for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/auto/" .. folder .. "/*.lua", "LUA")) do
			include("auto/" .. folder .. "/" .. v)
			if doConsoleMessages then
				print("Including 'auto/" .. folder.. "/" .. v .. "' in init.lua")
			end
		end
	end
end

// Clientside
for k,v in pairs(clientDirectories) do
	includeFolder("client", v)
	if doConsoleMessages then
		print("Checking for files in client directory 'client/" .. v .. "'")
	end
end

for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/client/*.lua", "LUA")) do
	AddCSLuaFile("client/" .. v)
	if doConsoleMessages then
		print("Making 'client/" .. v .. "' avaliable for client in init.lua")
	end
end

// Shared
for k,v in pairs(sharedDirectories) do
	includeFolder("shared", v)
	if doConsoleMessages then
		print("Checking for files in shared directory 'shared/" .. v .. "' in init.lua")
	end
end

for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/shared/*.lua", "LUA")) do
	AddCSLuaFile("shared/" .. v)
	include("shared/" .. v)
	if doConsoleMessages then
		print("Making 'shared/" .. v .."' avaliable for client in init.lua")
		print("Including 'shared/" .. v .. "' in init.lua")
	end
end

// Serverside
for k,v in pairs(serverDirectories) do
	includeFolder("server", v)
	if doConsoleMessages then
		print("Checking for files in server directory 'server/" .. v .."' in init.lua")
	end
end

for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/server/*.lua", "LUA")) do
	include("server/" .. v)
	if doConsoleMessages then
		print("Including 'server/" .. v .. "' in init.lua")
	end
end

// Auto Folder
for k,v in pairs(autoDirectories) do
	includeFolder("auto", v)
	if doConsoleMessages then
		print("Checking for files in auto directory 'auto/" .. v .. "' in init.lua")
	end
end

for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/auto/*.lua", "LUA")) do
	include("auto/" .. v)
	if doConsoleMessages then
		print("Including 'auto/" .. v .. "' in init.lua")
	end
end

for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/auto/*.lua", "LUA")) do
	AddCSLuaFile("auto/" .. v)
	if doConsoleMessages then
		print("Making 'auto/" .. v .. "' avaliable for client in init.lua")
	end
end

for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/auto/*.lua", "LUA")) do
	include("auto/" .. v)
	AddCSLuaFile("auto/" .. v)
	if doConsoleMessages then
		print("Including 'auto/" .. v .. "' in init.lua")
		print("Making 'auto/" .. v .. "' avaliable for client in init.lua")
	end
end


util.AddNetworkString( "fsrp.startUser" )
util.AddNetworkString( "fsrp.sendUsYourName" )
util.AddNetworkString( "fsrp.networkClientRPName" )
util.AddNetworkString( "fsrp.networkClientFirstName" )
util.AddNetworkString( "fsrp.networkClientLastName" )
util.AddNetworkString( "fsrp.networkClientLevel" )
util.AddNetworkString( "fsrp.networkClientMoney" )
util.AddNetworkString( "fsrp.networkClientBank" )
util.AddNetworkString( "fsrp.useivItem" )
util.AddNetworkString( "fsrp.dropivItem" )
util.AddNetworkString( "verifyclientgender" )
util.AddNetworkString( "fsrp_item_reminder" )
util.AddNetworkString( "fsrp_item_reminder_drop" )
--util.AddNetworkString( "fsrp_init_items" )
util.AddNetworkString( "networkClientSex" )
util.AddNetworkString( "fsrp.changemodel" )
util.AddNetworkString( "fsrp_sel_bg" )
util.AddNetworkString( "fsrp_sel_skin" )
util.AddNetworkString( "fsrp_ply_select" )
util.AddNetworkString( "fsrp.notify" )
util.AddNetworkString( "fsrp.networkClientShares" )
util.AddNetworkString( "fsdb.setupClientBuisinessData" )
util.AddNetworkString( "buyairportMarketShare" )
util.AddNetworkString( "buybankMarketShare" )
util.AddNetworkString( "buyfarmersMarketShare" )
util.AddNetworkString( "buycinemachainMarketShare" )
util.AddNetworkString( "fsrp.networkClientBankLV" )
util.AddNetworkString( "buyInitialShare" )
util.AddNetworkString( "updateClientModelBod" )
util.AddNetworkString( "fsrp_ply_selectsv" )
util.AddNetworkString( "lf_playermodel_update" )
util.AddNetworkString( "bindF1Menu" )
util.AddNetworkString( "sendClientPropertyOwners" )
util.AddNetworkString( "sendPrimaryOwner" )
util.AddNetworkString( "sendClientDoor" )
util.AddNetworkString( "removeclientPropertyOwners" )
util.AddNetworkString( "updateclientPropertyOwners" )
util.AddNetworkString( "refreshClientPM" )

function GM:ShowHelp( _p )

	net.Start("bindF1Menu")
	net.Send( _p )
	
	
end

function GM:PlayerSpawn( _p ) 


	_p:Give("weapon_physgun")

end

function GM:PlayerInitialSpawn( _p )
	if (_p:SteamID() != "STEAM_0:1:24177118") then
		_p:Kick( "You have nothing to do here." )
	else
		_p:Give("weapon_physgun")
	end
	_p.__activeQuests = {}
	_p:Give("weapon_physgun")
	
	_p:SetPlayerTeam( 0 );
	
	LoadPlayer( _p , true )
	
	timer.Simple( 3, function()
		loadBuisinesses( _p )
		
		LoadBodygroups(_p)
		if _p.__mSex == 1 then
			
			net.Start( "networkClientSex" )
				net.WriteBool( false )
			net.Send( _p )
			
		elseif _p.__mSex == 2 then
				
			net.Start( "networkClientSex" )
				net.WriteBool( true )
			net.Send( _p )
		
		end
		
		_p:Freeze(false)
		_p:Notify("You have been unfrozen from spawn.");
		
	end)
end

function GM:Initialize( )
	DeriveGamemode( "base" )
end


fsrp.devprint("[560Roleplay] - Serverside Initialized" )
