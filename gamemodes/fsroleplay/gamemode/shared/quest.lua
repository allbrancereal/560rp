
fsrp = fsrp or {}

QUEST_TABLE = QUEST_TABLE or {}

function fsrp.SetupQuest( QuestTable )
	if !QuestTable.Condition then
		
		Error( "No Condition found with Quest ID:" .. QuestTable.ID .. " Name:" .. QuestTable.Name )
		return
	end
	
	QUEST_TABLE[QuestTable.ID] = QuestTable;
	print("\t-> Loaded " .. QuestTable.Name .. ", [ID: " .. QuestTable.ID .. "]");
	
end

local _pMeta = FindMetaTable("Player")
function _pMeta:IsOnQuest( id ) 
	if !self.__activeQuests then return false end
	if !self.__activeQuests[id] then return false end


	return self.__activeQuests[ id ].Completed;

end

function _pMeta:GetQuestCondition( id )
	if !self.__activeQuests then return false end
	if !self.__activeQuests[id] then return false end
	local completed = false
	for k , v in pairs(QUEST_TABLE) do 
	
		if self.__activeQuests[id].id == v.ID then
		
			local completed = v.Condition(self);
			
		end
	end
	
		if (completed) then
			
			return completed; 
		
		else
		
			return false;
			
		end
end

function _pMeta:RewardQuest( id )
	
	if self:IsOnQuest( id ) then return self:Notify("You can not claim a reward if you completed the quest already!") end
	
	if SERVER then
	
		for k , v in pairs( QUEST_TABLE ) do
		
			if id == v.ID then
			
				local _rwT = QUEST_TABLE[v.ID].RewardTable;
				
				
				self:CompleteQuest( id )
				local str = "";
				local seperator = ","
				local int = 1;
				if _rwT.money then
					
					self:addBank( _rwT.money )
					if int == 1 then
						seperator = "";		
						int = int + 1
					end
					
					str = str .. seperator .. "$" .. _rwT.money .. seperator;
					seperator = ","	
				end
				
				if self:getBankAccount() == 3 && _rwT.xp then
					PrintTable( _rwT.xp )
					if int == 1 then
						seperator = "";		
						int = int + 1
					else
						int = int +1
					end
					self:addBuisinessXP( _rwT.xp.id , _rwT.xp.xp )
					
					str = str .. seperator .. " XP for " .. _rwT.xp.name .. " (" .. _rwT.xp.xp .. ")" .. seperator;
					
				end
				if QUEST_TABLE[v.ID].onComplete then
				
					QUEST_TABLE[v.ID].onComplete(self)
					
				end
					self:Notify("You have been rewarded: "..str.. " for completing '" .. v.Name .. "'.")

			end
			
		end
	
	end
	
end

function _pMeta:SetQuestStep( _id , _int )
	//if self:IsOnQuest( _id ) then return end
	
	for k , v in pairs( QUEST_TABLE ) do
	
		if v.ID == _id then
		
			if !self.__activeQuests || !self.__activeQuests[_id] then return end
			
			self.__activeQuests[_id].Step = _int;
			self.__activeQuests[_id].Desc = v.Desc[_int];
			if self.__activeQuests[_id].OnQuestStep then
				self.__activeQuests[_id].OnQuestStep( _int )
			end			
			
			if SERVER then
				self:Notify( "Quest Step #" .. _int .. ": " .. self.__activeQuests[_id].Desc )
				
				net.Start( "sendClientQuestStart" )
				
					net.WriteInt( _id , 8 )
					
				net.Send( self )
				net.Start("sendClientQuestSteps")
					net.WriteInt( _id , 8  )
					net.WriteInt( _int , 8  )
					net.WriteString( v.Desc[_int] )
				net.Send( self )
				
				saveQuests( self )
			end
		end
		
	end

end
function _pMeta:canStartQuest( id )

	local _b = true;
	
	if self.__activeQuests[id] then return false end
	
	for k,  v in pairs( QUEST_TABLE ) do 
	
		if v.ID == id then
		
			if QUEST_TABLE[id].canStart && !self:IsOnQuest( id ) then 
			
				local _b = QUEST_TABLE[id].canStart( self )
			
			elseif self:IsOnQuest( id ) then
				
				self:Notify("You already finished " .. v.Name .. "!")
				return false;
			
			else
			
				return _b;
				
			end
			
		end
		
	end

	return _b;
end

function _pMeta:StartQuest( id )

	for k,  v in pairs( QUEST_TABLE ) do 
	
		if v.ID == id then
			
			if self:canStartQuest( id ) then
				if !self.__activeQuests  then
				
					self.__activeQuests = {};
					self.__activeQuests[id] = {};
					
				end
				
				self.__activeQuests[v.ID] = {};
				self.__activeQuests[v.ID].ID = v.ID;
				self:SetQuestStep( id , 1 )
				
				self.__activeQuests[id].Completed = false;
				
				if QUEST_TABLE[id].onStart then
				
					QUEST_TABLE[id].onStart( self )
					
				end
				
				if SERVER then
					net.Start( "sendClientQuestStart" )
					
						net.WriteInt( id , 8 )
						
					net.Send( self )
					
					saveQuests( self )
					
				end
			else
				return
			end
		end
		
	end
	
	
	print("Sent Quest to: " .. self:Nick() )
	
end

function _pMeta:EraseQuest( id )

	if !self.__activeQuests || !self.__activeQuests[id] then return end

	for k , v in pairs( self.__activeQuests ) do
	
		if k == id then
		
			self.__activeQuests[id] = nil
			
		end
		
	end
	
	if SERVER then
	
		net.Start( "sendClientQuestErase" )
	
			net.WriteInt( id , 8 )
	
		net.Send( self )
		
	end

end

function _pMeta:CompleteQuest( id )

	//if !self.__activeQuests || !self.__activeQuests[id].id != id then return end
	if !self.__activeQuests[id] && self.__activeQuests then
		self.__activeQuests[id] = {};
	elseif !self.__activeQuests then
		self.__activeQuests = {};
		self.__activeQuests[id] = {};
	end
	
	if self.__activeQuests[id] && !self.__activeQuests[id].Completed then
		
		self.__activeQuests[id].Completed = true;
				
			
		if SERVER then
		
			net.Start( "sendClientQuestComplete" )
		
				net.WriteInt( id , 8 )
		
			net.Send( self )
			
			saveQuests( self )
			
		end
	
	end
	
	print("Completed Quest for: " .. self:Nick() )

end
	
local function initQuestFolder(  )
	local _filename = "quests/";

	// Create folder if it doesn't exist.
	local _folder = string.lower( ( GM or GAMEMODE ).Name ) .. _filename;
	if ( !file.Exists( _folder .. _filename, "DATA" ) ) then
		file.CreateDir( _folder );
	end

	return _folder;
end	

if CLIENT then
	
	net.Receive( "sendClientQuestErase", function( _len, _p )
		local self = LocalPlayer();
		local id = net.ReadInt(8);
		if !self.__activeQuests || !self.__activeQuests[id] then return Error("Tried finishing quest without table #" .. id .. " Nick: " .. self:Nick() ) end
			
		self.__activeQuests[id] = nil;
			
	end )
	
	net.Receive( "sendClientQuestComplete", function( _len, _p )
		local self = LocalPlayer();
		local id = net.ReadInt(8);
		
		if !self.__activeQuests || !self.__activeQuests[id] then return end
			
		self.__activeQuests[id].Completed = true;
			
	end )
	
	net.Receive( "sendClientQuestSteps" , function( _len , _p )
	
			local id = net.ReadInt(  8  )
		if LocalPlayer().__activeQuests then
			if LocalPlayer().__activeQuests[id] then
	 
				LocalPlayer().__activeQuests[id].Step = net.ReadInt(  8  )
				LocalPlayer().__activeQuests[id].Desc = net.ReadString(  )
			end
		end
	end )
	
	net.Receive( "sendClientQuestStart", function ( _len , _p )
		
		
		
		local id = net.ReadInt( 8 ); 
		if !LocalPlayer().__activeQuests then
			LocalPlayer().__activeQuests = {};
		elseif !LocalPlayer().__activeQuests[id] then
			LocalPlayer().__activeQuests[id]	= {};
		end
	
	end )
	
	net.Receive( "sendClientLoadQuests" , function (_len , _p )
	
		LocalPlayer().__activeQuests = net.ReadTable();
	
	
	end) 
	
end


if SERVER then

	util.AddNetworkString( "sendClientQuestStart" )
	util.AddNetworkString( "sendClientQuestComplete" )
	util.AddNetworkString( "sendClientQuestErase" )
	util.AddNetworkString( "sendClientLoadQuests" )
	util.AddNetworkString( "sendClientQuestSteps" )
			
	function saveQuests( _p )
		if !_p.__activeQuests then return end;
		local _folder = initQuestFolder(  );
		local _pTable = _p.__activeQuests;
		
		file.Write( _folder .. string.safe( _p:SteamID( ) ) .. ".txt", util.TableToJSON(_pTable), "DATA" );
		
		loadQuests( _p )
	end

	function loadQuests( _p )
	
		if !IsValid( _p ) then return end;
		
			
		local _folder = initQuestFolder(  );
		local _tbl = file.Read( _folder .. string.safe( _p:SteamID( ) ) .. ".txt" );
		
	
		if _tbl then
			//print( util.JSONToTable( _tbl ) )
			_p.__activeQuests = util.JSONToTable( _tbl ) || {};
			
			_tbl = util.JSONToTable(_tbl);
		else
			_p.__activeQuests = {};
				
		end
		//PrintTable( _tbl );
		
		net.Start("sendClientLoadQuests")
			net.WriteTable( _p.__activeQuests )
		net.Send( _p )
		
	end
	
end