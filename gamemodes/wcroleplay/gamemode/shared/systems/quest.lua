
fsrp = fsrp or {}

QUEST_TABLE = QUEST_TABLE or {}

function SetupQuest( QuestTable )
	if !QuestTable.Condition then
		
		Error( "No Condition found with Quest ID:" .. QuestTable.ID .. " Name:" .. QuestTable.Name )
		return
	end
	
	QUEST_TABLE[QuestTable.ID] = QuestTable;
	
end

local _pMeta = FindMetaTable("Player")

function _pMeta:FinishedQuestLine( tbl )

	local _QuestCache = {};
	
	for k , v in pairs( tbl ) do
	
		_QuestCache[k] = self:FinishedQuest( v );
		
	end
	
	for k , v in pairs( _QuestCache ) do
	
		if v == false then
		
			return false, tbl[k];
			
		end
	
	end
	
	
	return true, nil;
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

function _pMeta:SetQuestStep( id, step )

	local _ActiveQuests = self:getFlag("questTable", nil )
	
	if !_ActiveQuests[id] then return end
	_ActiveQuests[id].Step = step;
	if SERVER then
		self:Notify(QUEST_TABLE[id].Desc[step])
		saveQuests( self )
		networkClientQuests( _ActiveQuests, self:SteamID() )
		
	end
	
end

function _pMeta:StartQuest( id )
		
	if QUEST_TABLE[id].canStart( self ) then

		local _ActiveQuests = self:getFlag("questTable", nil )
		
		if !_ActiveQuests then
		
			_ActiveQuests = {}
			
		end
		
		--if _ActiveQuests[id] then 
		
			--return
		
		--end
		
		_ActiveQuests[id] = {}
		_ActiveQuests[id].Step = 1;
		
		self:Notify( "You have started: " .. QUEST_TABLE[id].Name );
		self:Notify( QUEST_TABLE[id].Desc[1] );
	
		self:setFlag("questTable", _ActiveQuests );
		if SERVER then
			
			saveQuests( self )
			networkClientQuests( _ActiveQuests, self:SteamID() )
			
		end

	end
	
end

if CLIENT then

	net.Receive("NetworkQuestsToClient", function( len , _p )
		
		local sID = net.ReadString()
		local tb = net.ReadTable()
		
		for k , v in pairs( player.GetAll() ) do
		
			if v:SteamID() == sID then
			
				v:setFlag("questTable", tb )
				
			end
			
		end
	
	
	end )

else

	util.AddNetworkString("NetworkQuestsToClient")
	
	function networkClientQuests( tb, id )
		//if !tb then return PrintTable( tb ) end
		net.Start("NetworkQuestsToClient")
			net.WriteString( id  )
			net.WriteTable(tb)

		if #player.GetAll() > 0 then
			net.Broadcast()
		end
		
	end
	
end


function _pMeta:AdvanceQuestStep( id , bool)

	if QUEST_TABLE[id] then

		local _ActiveQuests = self:getFlag("questTable", nil )
		
		if _ActiveQuests[id] && !_ActiveQuests[id].Completed then
			
			if ( _ActiveQuests[id].Step < #QUEST_TABLE[id].Desc ) && QUEST_TABLE[id].Condition  && !QUEST_TABLE[id].Condition(self) then
			
				_ActiveQuests[id].Step = _ActiveQuests[id].Step + 1 
				self:Notify( QUEST_TABLE[id].Desc[_ActiveQuests[id].Step] )
			
			elseif QUEST_TABLE[id].Condition && QUEST_TABLE[id].Condition(self) then
		
				self:RewardQuest( id )
				return
				
		
			end
			
			QUEST_TABLE[id].OnQuestStep( _ActiveQuests[id].Step, self );
				
			
			self:setFlag( "questTable", _ActiveQuests )
			
			if SERVER then
					
				saveQuests( self )

				networkClientQuests( _ActiveQuests, self:SteamID() )
			
			end
			
		end

	end
	
end

function _pMeta:FinishedQuest( id )
	
	
	local _ActiveQuests = self:getFlag("questTable", nil )

	if _ActiveQuests && _ActiveQuests[id] && _ActiveQuests[id].Completed and _ActiveQuests[id].LastCompletion and self:getFlag("SVTimeLastPayday",0) <_ActiveQuests[id].LastCompletion+QUEST_TABLE[7].Cooldown then
		if _ActiveQuests[id].LastCompletion != nil then
			//print(self:getFlag("SVTimeLastPayday",0) .. " " .._ActiveQuests[id].LastCompletion+QUEST_TABLE[7].Cooldown)
			return true, _ActiveQuests[id].LastCompletion
		end
	end
	
	return false,0

end

function _pMeta:IsOnQuest( id )

	return self:FinishedQuest( id )

end

function _pMeta:RewardQuest( id, _ActiveQuests )
	if !_ActiveQuests then _ActiveQuests = self:getFlag("questTable", nil ) end
	
	if _ActiveQuests && _ActiveQuests[id] then
		local _rewardTable = QUEST_TABLE[id].RewardTable;
					
		self:Notify( "You have finished: " .. QUEST_TABLE[id].Name )
		if _rewardTable.money then
					
			self:addMoney( _rewardTable.money )
			self:Notify( "You have received $" .. _rewardTable.money .. " from the quest." )
			
		end
		if _rewardTable.xp then
					
			self:AddRotoXP(_rewardTable.xp.id,_rewardTable.xp.xp)
			
		end	
		if _rewardTable.rank then
			local _curRank = self:GetUserGroupRank()
			local _targetRank = _rewardTable.rank;	
			if _curRank > _targetRank then
				self:SetRank(_targetRank)	
				self:Notify( "Your user group has been set to " .. fsrp.GetUserGroupName(_targetRank) );
			else
				self:Notify("We can not upgrade your rank to " .. fsrp.GetUserGroupName(_targetRank) .. " because you already have a higher one.")
			end
			
		end	
		_ActiveQuests[id].Step = #QUEST_TABLE[id].Desc
		_ActiveQuests[id].LastCompletion = os.time(); -- sys 
		_ActiveQuests[id].Completed = true; 
			
		if QUEST_TABLE[id].onComplete then
		
			QUEST_TABLE[id].onComplete( self )
			
		end
		
		self:setFlag("questTable", _ActiveQuests );
		
		if SERVER then
		
			saveQuests( self )

			networkClientQuests( _ActiveQuests, self:SteamID() )
				
		end
	end
	
end
			
if SERVER then
	fsrp.config.catlocs = {
		{ Vector(-1343.245 , 11207.907 , 125.553 );Angle(.009 , -0.154 , 0.02 );"Urban Outfitters"};

	}
	hook.Add("PaydayDistribution","randomizeCat",function()
		for k , v in pairs(ents.FindByClass("wcrp_questprop") ) do
			if v:getFlag("quest",0) == 7 then
				local _new = fsrp.config.catlocs[math.random(#fsrp.config.catlocs)];
				v:SetPos(_new[1])
				v:SetAngles(_new[2])
				if fsrp.config.showCatDebug == true then
					print("Moved the cat to the " .. _new[3])
				end
				
				break;
			else
			end
		end
	end)

	local _questitemspawns = {
		[7] = {
			spawns = {
				[1] = {
					Vector(-1343.245 , 11207.907 , 125.553 );
					Angle(45.88 , -85.093 , 0 );
					"models/feline.mdl";
					true;
				};
			}
		}
	}
	function fsrp.SpawnQuestProps()
		for k , v in pairs(ents.FindByClass("wcrp_questprop")) do v:Remove( ) end
		
		for k, v in pairs( _questitemspawns ) do
			
			for i,x in pairs( v.spawns ) do 
				local _qent = ents.Create("wcrp_questprop")
				_qent:setFlag("quest" , k)
				_qent:SetPos(x[1])
				_qent:SetAngles(x[2])
				_qent:SetModel(x[3])
				if x[4] and x[4] == true then
					_qent:setFlag("rotate",true);
				end
				_qent:Spawn()
				print("Spawned Quest Entity for Q#" .. k )
			end
			
		end
	end
	hook.Add("InitPostEntity", "SpawnQuestItems",function()
		fsrp.SpawnQuestProps()
	end)
	function saveQuests( _p )
		if !_p:getFlag("questTable", nil ) then return end;
		local _folder = initQuestFolder(  );
		local _pTable = _p:getFlag("questTable", {} );
		
		file.Write( _folder .. string.safe( _p:SteamID( ) ) .. ".txt", util.TableToJSON(_pTable), "DATA" );
		
		_p:setFlag("questTable",  _pTable  )
		
			
		networkClientQuests( _pTable, _p:SteamID() )
			
		
		loadQuests( _p )
	end

	function loadQuests( _p )
	
		if !IsValid( _p ) then return end;
		
			
		local _folder = initQuestFolder(  );
		local _tbl = file.Read( _folder .. string.safe( _p:SteamID( ) ) .. ".txt" );
		
	
		if _tbl then
			//print( util.JSONToTable( _tbl ) )
			_p:setFlag("questTable", util.JSONToTable( _tbl ) );
			
			
			networkClientQuests( util.JSONToTable(_tbl), _p:SteamID() )
			
			
		else
			_p:setFlag( "questTable", {} )
				
			networkClientQuests( {}, _p:SteamID() )
			
			
		end
		
	end
	
end