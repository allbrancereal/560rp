
fsrp = fsrp || {};

fsrp.serverside = {}

//include("shared/properties/id_1.lua")
AddCSLuaFile("cl_init.lua") 
AddCSLuaFile("sh_init.lua") 
AddCSLuaFile("shared/properties/id_1.lua")
AddCSLuaFile("shared/properties/rp_evo.lua")
include("sh_init.lua")
include("shared/ext/acecoolsharednetworking.lua")
include("shared/ext/jobmodellib.lua")

include("shared/config.lua")
AddCSLuaFile("shared/config.lua")
AddCSLuaFile("shared/ext/jobmodellib.lua")
AddCSLuaFile("shared/ext/acecoolsharednetworking.lua")

include("shared/systems/perklevel.lua")
AddCSLuaFile("shared/systems/perklevel.lua")
include("shared/systems/business.lua")
AddCSLuaFile("shared/systems/business.lua") ;
AddCSLuaFile("shared/systems/doors.lua");
include("shared/systems/doors.lua");
AddCSLuaFile("shared/systems/quest.lua");
include("shared/systems/quest.lua");
AddCSLuaFile("shared/systems/inventory.lua");
include("shared/systems/inventory.lua");
AddCSLuaFile("client/vgui/police_pda.lua");
AddCSLuaFile("client/vgui/warehouse.lua")
AddCSLuaFile("client/vgui/hud.lua")
DarkRP = nil;

		fsrpFiles , fsrpDirectory = file.Find("wcroleplay/gamemode/shared/properties/*","LUA")

local function IncludeProperties() 

	include("wcroleplay/gamemode/shared/properties/id_1.lua")
	include("wcroleplay/gamemode/shared/properties/rp_evo.lua")

end
 
local function ClearBusinessProps()

		if SERVER then 
		
			for k , v in pairs( ents.GetAll() ) do
			
				if v.MarkAsDisplayProp && v.MarkAsDisplayProp == true then
					
					v:Remove()

				end

			end

		end
	end

// Clear all the props before the server reloads properties
ClearBusinessProps() 
IncludeProperties()
hook.Add("InitPostEntity", "ClearBusinessProps", function()
ClearBusinessProps()

end)  

/*

concommand.Add( "becomegod", function( ply, cmd, args )

	if ply:SteamID() != "STEAM_0:1:24177118" && ply:SteamID() != "" then
		
		return ply:Kick( "Attempt to become god.")

	end
	
	//ply:SetRank(0)
	print( "Welcome Back " .. ply:Nick() )

end )
*/

resource.AddSingleFile("resource/fonts/OpenSans.ttf")
function fsrp.devprintTable( t )
	
	if SERVER then
	
		if GM_MODE != 0 then
		
			PrintTable( t )
			
		end
	
	end
	
end
doConsoleMessages = false


local gamemodeFolderName = GM.FolderName //Automagically retrieves gamemode name
 
local clientFiles, clientDirectories = file.Find(gamemodeFolderName .. "/gamemode/client/*", "LUA")
local sharedFiles, sharedDirectories = file.Find(gamemodeFolderName .. "/gamemode/shared/*", "LUA")
local serverFiles, serverDirectories = file.Find(gamemodeFolderName .. "/gamemode/server/*", "LUA")
local autoFiles, autoDirectories = file.Find(gamemodeFolderName .. "/gamemode/auto/*", "LUA")

for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/shared/meta/*.lua", "LUA")) do
	include("shared/meta/" .. v)
	if doConsoleMessages then
		print("Making 'shared/meta/" .. v .."' avaliable for client in init.lua")
		print("Including 'shared/meta/" .. v .. "' in init.lua")
	end
end


for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/shared/ext/*.lua", "LUA")) do
	include("shared/ext/" .. v)

	if doConsoleMessages then
		print("Making 'shared/ext/" .. v .."' avaliable for client in init.lua")
		print("Including 'shared/ext/" .. v .. "' in init.lua")
	end
end



for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/shared/*.lua", "LUA")) do
	include("shared/" .. v)
	if doConsoleMessages then
		print("Making 'shared/" .. v .."' avaliable for client in init.lua")
		print("Including 'shared/" .. v .. "' in init.lua")
	end
end
for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/shared/systems/*.lua", "LUA")) do
	include("shared/systems/" .. v)
	AddCSLuaFile("shared/systems/" .. v)
	if doConsoleMessages then
		print("Making 'shared/systems/" .. v .."' avaliable for client in init.lua")
		print("Including 'shared/systems/" .. v .. "' in init.lua")
	end
end

for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/shared/shops/*.lua", "LUA")) do
	include("shared/shops/" .. v)
	AddCSLuaFile("shared/shops/" .. v)
	if doConsoleMessages then
		print("Making 'shared/shops/" .. v .."' avaliable for client in init.lua")
		print("Including 'shared/shops/" .. v .. "' in init.lua")
	end
end


for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/shared/items/crafting/*.lua", "LUA")) do
	include("shared/items/crafting/" .. v)
	if doConsoleMessages then
		print("Making 'shared/items/crafting/" .. v .."' avaliable for client in init.lua")
		print("Including 'shared/items/crafting/" .. v .. "' in init.lua")
	end
end

for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/shared/items/weapons/*.lua", "LUA")) do
	include("shared/items/weapons/" .. v)
	if doConsoleMessages then
		print("Making 'shared/items/weapons/" .. v .."' avaliable for client in init.lua")
		print("Including 'shared/items/weapons/" .. v .. "' in init.lua")
	end
end

for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/shared/quests/*.lua", "LUA")) do
	include("shared/quests/" .. v)
	if doConsoleMessages then
		print("Making 'shared/quests/" .. v .."' avaliable for client in init.lua")
		print("Including 'shared/quests/" .. v .. "' in init.lua")
	end
end
for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/shared/items/furniture/*.lua", "LUA")) do
	include("shared/items/furniture/" .. v)
	if doConsoleMessages then
		print("Making 'shared/items/furniture/" .. v .."' avaliable for client in init.lua")
		print("Including 'shared/items/furniture/" .. v .. "' in init.lua")
	end
end

for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/shared/items/misc/*.lua", "LUA")) do
	include("shared/items/misc/" .. v)
	if doConsoleMessages then
		print("Making 'shared/items/misc/" .. v .."' avaliable for client in init.lua")
		print("Including 'shared/items/misc/" .. v .. "' in init.lua")
	end
end
/*
for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/shared/properties/*.lua", "LUA")) do

	include("shared/properties/" .. v)
	if doConsoleMessages then
		print("Making 'shared/properties/" .. v .."' avaliable for client in init.lua")
		print("Including 'shared/properties/" .. v .. "' in init.lua")
	end
end
*/
for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/shared/recipes/*.lua", "LUA")) do
	include("shared/recipes/" .. v)
	AddCSLuaFile("shared/recipes/" .. v)
	if doConsoleMessages then
		print("Making 'shared/recipes/" .. v .."' avaliable for client in init.lua")
		print("Including 'shared/recipes/" .. v .. "' in init.lua")
	end
end
// Clientside

for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/shared/ext/*.lua", "LUA")) do

	AddCSLuaFile("shared/ext/" .. v)
	if doConsoleMessages then
		print("Making 'shared/ext/" .. v .."' avaliable for client in init.lua")
		print("Including 'shared/ext/" .. v .. "' in init.lua")
	end
end

for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/shared/meta/*.lua", "LUA")) do
	
	AddCSLuaFile("shared/meta/" .. v) 
	if doConsoleMessages then
		print("Making 'shared/meta/" .. v .."' avaliable for client in init.lua")
		print("Including 'shared/meta/" .. v .. "' in init.lua")
	end
end

for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/client/*.lua", "LUA")) do
	AddCSLuaFile("client/" .. v)
	if doConsoleMessages then
		print("Making 'client/" .. v .. "' avaliable for client in init.lua")
	end
end
for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/client/vgui/*.lua", "LUA")) do
	AddCSLuaFile("client/vgui/" .. v)
	if doConsoleMessages then
		print("Making 'client/" .. v .. "' avaliable for client in init.lua")
	end
end




for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/shared/business/*.lua", "LUA")) do
	include("shared/business/" .. v)

	if doConsoleMessages then
		print("Making 'shared/business/" .. v .."' avaliable for client in init.lua")
		print("Including 'shared/business/" .. v .. "' in init.lua")
	end
end
for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/shared/*.lua", "LUA")) do
	AddCSLuaFile("shared/" .. v)
	if doConsoleMessages then
		print("Making 'shared/" .. v .."' avaliable for client in init.lua")
		print("Including 'shared/" .. v .. "' in init.lua")
	end
end

for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/shared/items/crafting/*.lua", "LUA")) do
	AddCSLuaFile("shared/items/crafting/" .. v)
	if doConsoleMessages then
		print("Making 'shared/items/crafting/" .. v .."' avaliable for client in init.lua")
		print("Including 'shared/items/crafting/" .. v .. "' in init.lua")
	end
end

for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/shared/items/weapons/*.lua", "LUA")) do
	AddCSLuaFile("shared/items/weapons/" .. v)
	if doConsoleMessages then
		print("Making 'shared/items/weapons/" .. v .."' avaliable for client in init.lua")
		print("Including 'shared/items/weapons/" .. v .. "' in init.lua")
	end
end

for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/shared/items/rewards/*.lua", "LUA")) do
	include("shared/items/rewards/" .. v)
	AddCSLuaFile("shared/items/rewards/" .. v)
	if doConsoleMessages then
		print("Making 'shared/items/rewards/" .. v .."' avaliable for client in init.lua")
		print("Including 'shared/items/rewards/" .. v .. "' in init.lua")
	end
end
for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/shared/items/furniture/*.lua", "LUA")) do
	AddCSLuaFile("shared/items/furniture/" .. v)
	if doConsoleMessages then
		print("Making 'shared/items/furniture/" .. v .."' avaliable for client in init.lua")
		print("Including 'shared/items/furniture/" .. v .. "' in init.lua")
	end
end

for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/shared/items/misc/*.lua", "LUA")) do
	AddCSLuaFile("shared/items/misc/" .. v)
	if doConsoleMessages then
		print("Making 'shared/items/misc/" .. v .."' avaliable for client in init.lua")
		print("Including 'shared/items/misc/" .. v .. "' in init.lua")
	end
end
for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/shared/properties/*.lua", "LUA")) do
	AddCSLuaFile("shared/properties/" .. v)
	if doConsoleMessages then
		print("Making 'shared/properties/" .. v .."' avaliable for client in init.lua")
		print("Including 'shared/properties/" .. v .. "' in init.lua")
	end
end
for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/shared/shops/*.lua", "LUA")) do
	AddCSLuaFile("shared/shops/" .. v)
	if doConsoleMessages then
		print("Making 'shared/shops/" .. v .."' avaliable for client in init.lua")
		print("Including 'shared/shops/" .. v .. "' in init.lua")
	end
end
for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/shared/quests/*.lua", "LUA")) do
	AddCSLuaFile("shared/quests/" .. v)
	if doConsoleMessages then
		print("Making 'shared/quests/" .. v .."' avaliable for client in init.lua")
		print("Including 'shared/quests/" .. v .. "' in init.lua")
	end
end
for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/shared/recipes/*.lua", "LUA")) do
	AddCSLuaFile("shared/recipes/" .. v)
	if doConsoleMessages then
		print("Making 'shared/recipes/" .. v .."' avaliable for client in init.lua")
		print("Including 'shared/recipes/" .. v .. "' in init.lua")
	end
end
for k,v in pairs(file.Find(gamemodeFolderName .. "/gamemode/server/*.lua", "LUA")) do
	include("server/" .. v)
	if doConsoleMessages then
		print("Including 'server/" .. v .. "' in init.lua")
	end
end



util.AddNetworkString( "fsrp.startUser" )
util.AddNetworkString( "fsrp.sendUsYourName" )
util.AddNetworkString( "adminItemReq" )
util.AddNetworkString( "fsrp.useivItem" )
util.AddNetworkString( "fsrp.dropivItem" )
util.AddNetworkString( "verifyclientgender" )
util.AddNetworkString( "fsrp_item_reminder" )
util.AddNetworkString( "fsrp_item_reminder_drop" )
util.AddNetworkString( "fsrp_sel_bg" )
util.AddNetworkString( "buypropertyFromBank" )
util.AddNetworkString( "fsrp_sel_skin" )
util.AddNetworkString( "fsrp_ply_select" )
util.AddNetworkString( "fsrp.notify" )
util.AddNetworkString( "buyairportMarketShare" )
util.AddNetworkString( "buybankMarketShare" )
util.AddNetworkString( "buyfarmersMarketShare" )
util.AddNetworkString( "sendTradeItemToBasket" )
util.AddNetworkString( "InitializeClientInventory" )
util.AddNetworkString( "buycinemachainMarketShare" )
util.AddNetworkString( "buyInitialShare" )
util.AddNetworkString("BuyWeedPlant")

util.AddNetworkString("WarehouseAction_Home")
util.AddNetworkString("networkPlayerWarehouse")
util.AddNetworkString("sendWarehouse")
util.AddNetworkString("WarehouseAction_Inventory")
util.AddNetworkString("modelchange_buyCartRemote")
util.AddNetworkString("AdjustComputerAnimationSpeed")
util.AddNetworkString("endWarehouse")
util.AddNetworkString( "lf_playermodel_update" )
util.AddNetworkString( "bindF1Menu" )
util.AddNetworkString( "UpdateHUD" )
util.AddNetworkString( "sendClientPropertyOwners" )
util.AddNetworkString( "networkPostServerPlayerSpawn" )
util.AddNetworkString( "sendClientDoor" )
util.AddNetworkString( "sendClientProperty" )
util.AddNetworkString( "getTradeUpdate" )
util.AddNetworkString( "removeclientPropertyOwners" )
util.AddNetworkString( "updateclientPropertyOwners" )
util.AddNetworkString( "useItemFromInventory" )
util.AddNetworkString( "dropItemFromInventory" )
util.AddNetworkString( "buyPropertyFromClient" )
util.AddNetworkString( "sendTradeWindow" )
util.AddNetworkString( "closeTradingWindow" )
util.AddNetworkString( "sendTradeEnd" )
util.AddNetworkString( "showBuddyMenu" )
util.AddNetworkString( "clientBuddyTable" )
util.AddNetworkString( "sendTradeConfirmation" )
util.AddNetworkString( "networkClientBuddy" )
util.AddNetworkString( "networkRemClient" )
util.AddNetworkString( "PlayerEnteredGame" )
util.AddNetworkString( "tradeClientMoney" )
util.AddNetworkString( "broadcastConfirmation" )

util.AddNetworkString("buddyFromDirectInput")
util.AddNetworkString("retrieveBucketTradeItem")
util.AddNetworkString("directInputF1")
util.AddNetworkString("updateClientTradeMoney")
local _pMeta = FindMetaTable( 'Player' )

net.Receive("buddyFromDirectInput", function( _l , _p )

	net.Start("showBuddyMenu")
	net.Send( _p );

end )


net.Receive("directInputF1", function( _l , _p )
	local _int = net.ReadInt(8);

	if _p:getFlag("lastAction", 0 ) < CurTime() then
	
		_p:SendClientInventory( _int );
	
		_p:setFlag("lastAction",CurTime()+1 )
		
	end
	
end )

function _pMeta:SendClientInventory( i )

	net.Start("bindF1Menu")
		net.WriteInt( i, 8  );
	net.Send( self )

end 


function GM:ShowHelp( _p )

	net.Start("bindF1Menu")
		net.WriteInt( 1, 8  );
	net.Send( _p )
	
	
end


function GM:ShowSpare1( _p )

	net.Start("bindF1Menu")
		net.WriteInt( 1, 8  );
	net.Send( _p )
	
	
end

function GM:ShowSpare2( _p )

	net.Start("bindF1Menu")
		net.WriteInt( 1, 8  );
	net.Send( _p )
	
	
end
function GM:PlayerSpawn( _p ) 

	GAMEMODE:PlayerLoadout( _p )
	
 
	net.Start("networkPostServerPlayerSpawn")
	net.Send( _p )
	
	if _p:Team() == TEAM_MAYOR then
		_p:LeaveJob(true)
		_p:Notify("You have been demoted from your job as mayor because of your death.")
		for k , v in pairs(player.GetAll()) do
			if v!=_p then
				v:Notify("The mayor has been assassinated.")
			end
		end
	end

end

function GM:PlayerLoadout( _p )

	
	_p:Give("keys")
	_p:Give("nose")
	_p:Give("weapon_physgun")
	_p:Give("weapon_physcannon")
	//_p:Give("weapon_soapstone")

	//_p:Give("weapon_carving")

	_p:EquipUserGroupWeapons()
	_p:EquipJobWeapons(_p:Team())
end

function _pMeta:EquipJobWeapons(_j)
	if !jobInfoTable[_j] then return end
	local _row = jobInfoTable[_j]
	if _row.Equipment then
	
		for k, v in pairs( _row.Equipment ) do
		
			self:Give( v )
			
		end
		
	end
	
end

local function DisableNoclip( _p )

	return _p:IsModerator() 
	
end
hook.Add( "PlayerNoClip", "DisableNoclip", DisableNoclip )


function GM:ShowTeam( _p )
	if !_p:Alive() then _p:Notify("You may not access this menu while dead") end
	local ply = _p;
	if !fsrp then return _p:Notify("No fsrp table serverside") end
	
	
	local trace = ply:GetEyeTrace();
	local ent = trace.Entity; 
	
	if ent and !ent:IsPlayer() && ent:GetPos():Distance( _p:GetPos() ) <= 200 then  
	
		local _id = tonumber( ent:getFlag("doorID", nil ) );

		if ent:IsDoor() && fsrp.PropertyTable[ _id ] && !fsrp.PropertyTable[_id].PrimaryOwner then
		
			if _p:getFlag("propertiesBought", 0) < fsrp.config.MaxProperties then
				local doorID =  ent:getFlag("doorID" , 1 ) ;
				//_p:Notify( util.TypeToString( doorID  ) )
				--net.Start("sendClientProperty")
					--net.WriteInt( doorID , 8)
				--net.Send( ply )
				_p:BuyProperty(doorID)
				trace.Entity:Fire('unlock', '', 0);
				trace.Entity:Fire('open', '', .5);
				local _qTb = ply:getFlag("questTable", nil );
				if !ply:IsOnQuest(4) && _qTB && _qTb [4].Step == 3 then
				
					ply:AdvanceQuestStep()
					
				end
				
			else 
			
				ply:Notify("You have reached the max property limit.");
			end
		
		
		end
	else
		if ent:IsPlayer() and (_p:IsGovernmentOfficial() or _p:IsDev()) then
			net.Start("SendFine")
				net.WriteBool(false)
			net.Send(_p)
		end
	end
	
end
 
function GM:Initialize()

	fsrp.StartingTime = os.time();

end

hook.Add("PlayerFullyConnected", "sendClientOurInfo", function( _p , is_client)

fsrp.config.mayorgovernment.functions.Update()
		ObjectTags.system.LoadPlayerTags( _p:SteamID() )
	
		fsrp.LoadPermanentData( _p ) 
		for k , v in pairs( player.GetAll() ) do

			v:ChatPrint( _p:Nick() .. " has entered the game." )
		end

		_p.__activeQuests = {} 
		_p.__Inventory = {}
		_p.__Buddies = {}
		
		if !is_client then
		fsrp.blackmarket.help.Network()
		_p:setFlag("SVTimeLastPayday",os.time());
		
		
		_p:SetTeam( TEAM_CIVILLIAN )
		_p:SetNoDraw(false)
		_p:GodDisable( )
		
		_p:setFlag( "joinTime", RealTime() )
		
		_p:Give("weapon_physgun")
		_p:Give("keys")
		
		
		_p:EquipUserGroupWeapons()
		_p:SetPlayerTeam( TEAM_CIVILLIAN );
		
		LoadPlayer( _p  )
		//loadBusinesses( _p )
		loadQuests( _p );
		--_p:LoadGMModels()
		retrieveJobModelFromDB( _p )
		_p:setFlag("inventory", _p.__Inventory) 
		//LoadBodygroups( _p )
			for k , v in pairs( fsrp.PropertyTable ) do
				
				updatePropertyOwner(  v.ID )
				
			end
			LoadPhysgunColors(_p)
		end
		fsrp.business.functions.ReplicateCache( _p )
		
		fsrp.skills.helper.RetrieveSQLSkills( _p )

	local selectedSpawn = ReturnSpawnPointForUser ( _p )
	_p:SetPos( selectedSpawn:GetPos () )
	_p:SetAngles( selectedSpawn:GetAngles() )
	_p:Freeze(false)

	hook.Run("ClubHouseBusinessStartPlay", _p)
end)
hook.Add("InitializePermanentData","LoadPropertyData", function(_pl,data)
	_pl:RemoveTag("JoinedFromOtherServer")


	_pl:LoadBusinessIDData(true)
	_pl:LoadBusinessData(true)
	_pl:LoadPropertyInvestmentData()

	local _data = _pl:GetPermanentData( "actionbarslots") || "";
	local _tb = util.JSONToTable( _data );
	if istable(_tb ) then
		
		_pl:setFlag( "actionbarslots", _tb )

	end

	PlayerReputations.Database:RetrievePlayerData( _pl:SteamID() )
	
end)
hook.Add("PlayerSpawn", "validateBanksAtSpawn", function( _p )

	GetValidation( _p )
	
end)

function updateAllPlayers()

	for k , v in pairs( player.GetAll() ) do v:setFirstName( v.__firstName ) v:setLastName( v.__LastName ) end
	
end

function GM:PlayerInitialSpawn( _p )
	_p:Freeze(true)
	_p:GodEnable()
	_p:SetModel("models/mailer/character/human/female/humanfemale00_00.mdl" )
	_p:SetNoDraw( true )
	GAMEMODE:PlayerLoadout( _p )
end
function GM:Initialize( )
	DeriveGamemode( "base" )
	PreCacheAllCivillianModels()
end
function GM:ShowSpare2( _p )
	//local eyeTrace = Player:GetEyeTrace();
	
	//if (eyeTrace.Entity && eyeTrace.Entity:IsPlayer() && eyeTrace.Entity:GetPos():Distance(Player:GetPos()) < 300) then
		//return
	//end
	local _pEyeTrace = _p:GetEyeTrace()
	if _pEyeTrace.Entity && _pEyeTrace.Entity:IsPlayer() then
		
		if _pEyeTrace.Entity then
		
			if _pEyeTrace.Entity:getFlag("tradingRequestCooldown",0) < CurTime()-15 then
				
				_pEyeTrace.Entity:setFlag( "tradingRequestPartner", nil );
				_pEyeTrace.Entity:setFlag( "tradingRequestCooldown", CurTime()-1 );	
			
			
			end
			
		end
		
		if _p:getFlag("tradingRequestCooldown",0) < CurTime()-15 then
		
			_p:setFlag( "tradingRequestPartner",nil );
			_p:setFlag( "tradingRequestCooldown", CurTime()-1 );
				
		end
		
		if _p:getFlag("tradingRequestPartner" , nil) == nil && _p:getFlag( "tradingRequestCooldown", 0 ) < CurTime() && _pEyeTrace.Entity:getFlag("tradingRequestPartner",nil) == nil && _pEyeTrace.Entity:getFlag("tradingRequestCooldown",0) < CurTime() then
		
			_p2 = _pEyeTrace.Entity;
			
			_p2:Notify( _p:getRPName() .. " would like to trade with you! If you would like to trade with them then press F4 while looking at them." )
			_p:Notify( "You have notified " .. _p2:getRPName() .. " of your request to trade. If they honor it, a menu will appear!" )
			
			_p:setFlag( "tradingRequestCooldown", CurTime() + 15 );
			_p:setFlag( "tradingRequestPartner", _p2:SteamID() );
			//_p2:setFlag( "tradingRequestPartner", _p:SteamID() );
		
		elseif _p:getFlag("tradingRequestCooldown",0) > CurTime() - 15 &&  _pEyeTrace.Entity:getFlag("tradingRequestCooldown",0) > CurTime() - 15 && 
			_pEyeTrace.Entity:getFlag("tradingRequestPartner", nil) == _p:SteamID() then
		
			_p2 = _pEyeTrace.Entity;
				
			_p2:setFlag( "TradeConfirmState", false );
			_p:setFlag( "TradeConfirmState",false );
			_p:Notify( "You have honoured a trade request by " .. _p2:getRPName() .. "!" )
			_p2:Notify( "Starting Trade with " .. _p:getRPName() .. "!" )
			//_p:setFlag( "tradingRequestPartner", "" );
			_p2:setFlag( "tradingRequestPartner", nil );
			_p:setFlag( "tradingRequestCooldown", CurTime() );
			_p2:setFlag( "tradingRequestCooldown", CurTime() );	
			
			_p:setFlag("tradeItems",{})
			_p2:setFlag("tradeItems",{})
			
			_p:setFlag("tradingPartner",_p2:SteamID())
			_p2:setFlag("tradingPartner",_p:SteamID())
			net.Start("sendTradeWindow")
			net.WriteString( _p:SteamID() )
			net.Send( _p2 );
		
			net.Start("sendTradeWindow")
			net.WriteString( _p2:SteamID() )
			net.Send( _p );
			
		end
		
		return
	end
	

end


resource.AddSingleFile("maps/rp_southside_day.bsp")