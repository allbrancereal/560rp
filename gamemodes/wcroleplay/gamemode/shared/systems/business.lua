
fsrp = fsrp || {}

BUSINESS_TABLE = BUSINESS_TABLE or {}

if SERVER then
		
	//hook.Run("ClubHouseBusinessStartPlay")

		/* { 
			[1] = Time = os.time() , 
			[2] = Property = _PropertyID , 
			[3] = Supplies = 0, Product = 0 ,  
			[4] = FinishedInit = false, 
			[5] = Upgrades = {} , 
			[6] = SupplyMission = nil,
		};*/

		/*
			[6] = SupplyMission = {
				MissionType = "Type";
				IndexStep = "KeyStep";
				PlayerInfo = { Host = InitiatorSteamID", Members = "SteamIDsToConsider" };
				FlagsToSet = { {"Key","Value"}, {"Key", 12} };
				
			}
		*/



	hook.Add("ClubHouseBusinessStartPlay", "SetupMissionInformation", function(_p)

		local _businesses = _p:GetBusiness();
		
		local _isSupplying = _p:GetPermanentData( "SupplyingBusiness" );
		
		if _isSupplying then
			

		end

	end)

	util.AddNetworkString("computerForeclosure")

	net.Receive("computerForeclosure", function(_l,_p)

		local _typeAc = net.ReadInt(16)
		local _pID = net.ReadInt(16)
		local _isEvo = net.ReadBool()
		local _isDowntown = !_isEvo
		local _tbToUse = _typeAc == 1 && fsrp.I_BusinessPropertyTable || fsrp.ClubhousePropertyTable;

		local _foundComp, _foundMonitor = false, false;
		local _Comp,_Mon;
		for k , v in pairs( ents.FindInSphere(_p:GetPos(),250) ) do
			
			if (v) then
				
				if v:GetClass() == "fsrpcomputer" then
					
					_foundComp = true;
					_Comp = v;

				elseif v:GetClass() == "fsrpmonitor" then
					
					_foundMonitor = true;
					_Mon = v;

				end	
			end 
			
		end


		if _foundComp && _foundMonitor && IsValid(_Comp) && IsValid(_Mon) then

			if _typeAc != 1 && _Comp.MarkAsDisplayProp == true then return _p:Notify("You must be near a clubhouse computer to buy a business") end;
			if _typeAc == 2 && _Comp:getFlag("ownedBy", "") != _p:SteamID() then return _p:Notify("You must be near your own computer to buy a foreclosure.") end

			local _TableInQuestion = _typeAc == 1 && _tbToUse[_pID].BusinessInformation ||  _tbToUse[_pID].ClubHouseInformation;

			//print(_p:HasBusinessIDTag( _TableInQuestion.Tag ,true));

			if _p:canAffordBank( _tbToUse[_pID].Cost ) then
				
				if _p:HasBusinessIDTag( _TableInQuestion.Tag ,_isDowntown) then return _p:Notify("You already have this property.") end
				if _typeAc == 1 then
					_p:AddBusinessToData( _tbToUse[_pID].ID, _isDowntown )
				elseif _typeAc == 2 then

					_p:AddBusinessIDToData(_TableInQuestion.Tag,_isDowntown);
						
					
				end
				_p:Notify("You have purchased " ..  _tbToUse[_pID].Name )
				_p:addBank(-_tbToUse[_pID].Cost)

			else
				_p:Notify("You can not afford this property.")
			end
		end

	end)

end

function fsrp.SetupBusiness ( BusinessTable )
	BUSINESS_TABLE[BusinessTable.ID] = BusinessTable;

end

function string.safe( text )
	text = string.gsub( text, "%W", "_" );
	return text;
end

local _pMeta = FindMetaTable( "Player" )
local _ServerPrefix = "DT_";

local function ActAsBusinessServer(IsDowntown)

	if !IsDowntown then
		_ServerPrefix = "DT_"; 
		
		return true;

	end

	if isbool(IsDowntown) then
		_ServerPrefix = IsDowntown == true &&  "DT_" || "EVO_";
		return true;
	elseif isstring(IsDowntown) then
		_ServerPrefix = IsDowntown;
		return true;
	end

	return false;
end

function _pMeta:SaveBusinessIDData(actingServer)
	ActAsBusinessServer(actingServer)
	self:SavePermanentData(util.TableToJSON(self:getFlag(_ServerPrefix.."ID_Business_DATA" , {} )),  _ServerPrefix.."ID_Business_DATA")

	return true;
end

function _pMeta:LoadBusinessIDData(actingServer)
	ActAsBusinessServer(actingServer)
	local _data = self:GetPermanentData( _ServerPrefix.."ID_Business_DATA" ) || "";

	local _tb = util.JSONToTable( _data );

	if istable(_tb ) then
		
		self:setFlag( _ServerPrefix.."ID_Business_DATA", _tb )
		self:FullNWSync();

		return true;
	end

	return false

end

function _pMeta:HasBusinessIDTag(tag,actingServer)
	ActAsBusinessServer(actingServer)

	local _IDData = self:getFlag( _ServerPrefix.."ID_Business_DATA", {} );

	return table.HasValue(_IDData, tag );

end

function _pMeta:AddBusinessIDToData( tag ,actingServer)
	ActAsBusinessServer(actingServer)
		
	local _IDData = self:getFlag( _ServerPrefix.."ID_Business_DATA", {} );

	table.insert(_IDData,tag)
	self:setFlag(_ServerPrefix.."ID_Business_DATA",_IDData);
	self:SaveBusinessIDData(actingServer)
	self:FullNWSync();
	return true;
end

function _pMeta:SaveBusinessData(actingServer)
	ActAsBusinessServer(actingServer)
	self:SavePermanentData(util.TableToJSON(self:getFlag(_ServerPrefix.."BusinessData" , {} )),  _ServerPrefix.."BusinessData")

	return true;
end

function _pMeta:LoadBusinessData(actingServer)
	ActAsBusinessServer(actingServer)
	local _data = self:GetPermanentData( _ServerPrefix.."BusinessData" ) || "";

	local _tb = util.JSONToTable( _data );

	if istable(_tb ) then
		
		self:setFlag( _ServerPrefix.."BusinessData", _tb )

		return true;
	end

	return false

end

function _pMeta:AddBusinessToData( _PropertyID, actingServer )
	local _ServerPrefix = actingServer == true && "DT_" || "EVO_";
	if !fsrp.I_BusinessPropertyTable[_PropertyID] then return end
		
	local _IDData = self:getFlag( _ServerPrefix.."ID_Business_DATA", {} );
	if _IDData[fsrp.I_BusinessPropertyTable[_PropertyID].BusinessInformation.BusinessInitIdentifier] then return end
	local _businessdata = self:getFlag( _ServerPrefix.."BusinessData" , {} );
	if !self:CanBeginSupplyMission(actingServer) then
		return self:Notify("You can not buy a business on a supply/initial mission!");
	end
	if _businessdata then

		if _businessdata[_PropertyID] then return end
		
		/* { 
			[1] = Time = os.time() , 
			[2] = Property = _PropertyID , 
			[3] = Supplies = 0, 
			[4] = Product = 0 , 
			[5] = FinishedInit = false, 
			[6] = Upgrades = {} , 
			[7] = SupplyMission = nil,
		};*/

		table.insert( _businessdata ,{  os.time() , fsrp.I_BusinessPropertyTable[_PropertyID].BusinessInformation.Tag ,  0,  0 , false, {}, nil,nil });
		//PrintTable(_businessdata)

		self:setFlag( _ServerPrefix.."BusinessData" , _businessdata );
		self:BeginInitMission( _PropertyID,fsrp.I_BusinessPropertyTable[_PropertyID].BusinessInformation.BusinessInitIdentifier,joiningPlayers, actingServer)

	end
	self:FullNWSync();
	self:SaveBusinessData(actingServer)
end

function _pMeta:GetBusiness(actingServer)
	ActAsBusinessServer(actingServer)

	local _businessdata = self:getFlag( _ServerPrefix.."BusinessData" , {});
	//local _residingBusiness = self:getFlag("ResidingInControlledProperty", 0);

	return _businessdata;

end
/*
function _pMeta:StartSupplying( _PropertyID ,actingServer)
	ActAsBusinessServer(actingServer)
	if !fsrp.I_BusinessPropertyTable[_PropertyID] then return end

	local _businessdata = self:getFlag( _ServerPrefix.."BusinessData" , nil );
	local _residingBusiness = self:getFlag("ResidingInControlledProperty", 0);

	local _businessIDData = self:getFlag(_ServerPrefix.."ID_Business_DATA" , {} )
	local _identifier = fsrp.I_BusinessPropertyTable[_PropertyID].BusinessInformation.BusinessInitIdentifier;
	//print(_businessdata)
	//print(_businessIDData)

	if _businessdata && _businessIDData then

		if !_businessdata[_residingBusiness] then return print("Couldn't find business in businessdata") end
		
		local _businessInQuestion = _businessdata[_residingBusiness];

		if _businessInQuestion.FinishedInit && _businessIDData[_identifier] then
			
			self:BeginSupplyMission( fsrp.config.SupplyMissions[math.random(#fsrp.config.SupplyMissions)] )

		else

			self:BeginBusinessInit( _PropertyID , "DT_" )


		end

	end
	
end*/
/* { 

			[1] = Time = os.time() , 
			[2] = Property = _PropertyID , 
			[3] = Supplies = 0, 
			[4] = Product = 0 , 
			[5] = FinishedInit = false, 
			[6] = Upgrades = {} , 
			[7] = SupplyMission = nil,
		};*/
		/*
			[7] = SupplyMission = {
				MissionType = "Type";
				IndexStep = "KeyStep";
				PlayerInfo = { Host = InitiatorSteamID", Members = "SteamIDsToConsider" };
				FlagsToSet = { {"Key","Value"}, {"Key", 12} };
				 
			}
		*/
		local _serverMap = "rp_downtown_v4c_v2"
function _pMeta:SetupSupplyMission()
	local _p = self;
	local _map = (game.GetMap() == _serverMap && true || false);
	local _data = _p:GetBusiness(_map)

	for k , v in pairs(fsrp.I_BusinessPropertyTable) do

		for x , y in pairs(_data ) do

			if y[2] == v.BusinessInformation.Tag then

				if y[5] && istable(y[5]) then
				
					if y[5] && y[5][1] then
						fsrp.config.InitMissions[y[5][1]].supplyStep[game.GetMap()].JoinedServer(_p,y)

					end
					
				elseif y[7] && istable(y[7]) and y[7][1] then
				
					if y[7] && y[7][1] then
						fsrp.config.SupplyMissions[y[7][1]].supplyStep[game.GetMap()].JoinedServer(_p,y)
					end
					
				end
				
			end	
		end

	end
end

if SERVER then
	hook.Add("PlayerFullyConnected","InitSupplyMission", function(_p)
		local _p = _p;
		timer.Simple(10, function() 
			if !_p then return end;
			_p:SetupSupplyMission()
		end)
	end)
end

hook.Add("PlayerDisconnected","SaveSupplyMission", function(_p)

	local _map = (game.GetMap() == _serverMap && true || false);
	local _data = _p:GetBusiness(_map)


	for k , v in pairs(fsrp.I_BusinessPropertyTable) do

		for x , y in pairs(_data ) do

			if y[2] == v.BusinessInformation.Tag then

				if y[5] && istable(y[5]) then
					
					if y[5] && y[5][1] then
						fsrp.config.InitMissions[y[5][1]].supplyStep[game.GetMap()].LeftServer(_p, y)

					end
					
				elseif y[7] && istable(y[7]) and y[7][1] then
				
					if y[7] && y[7][1] then
						fsrp.config.SupplyMissions[y[7][1]].supplyStep[game.GetMap()].LeftServer(_p, y)
					end

				end
				
			end	
		end

	end

end)
hook.Add("PaydayDistribution","UpdateBusinessSupply",function()

	for k,v in pairs(player.GetAll()) do
		
		v:UpdateBusinessSupply();

	end

end)
function _pMeta:UpdateBusinessSupply()
	local _luck = math.random(100)

	if _luck >= 50 then
		return //print(self:Nick() .. "["..self:SteamID().."] failed business supply roll.")
	end

	local _data = self:GetBusiness(true)
	for k ,v in pairs(_data) do
		local _supp = tonumber(v[3]);
		if _supp > 0 then
			local _prod = tonumber(v[4]);
			local _build = math.random(_supp);
			_prod = _prod + _build;
			_supp = _supp - _build

			_data[k][4] = math.min(4,_prod)
			_data[k][3] = _supp
		end	
	end
	self:setFlag("DT_BusinessData" , _data )

	local _data = self:GetBusiness(false)
	for k ,v in pairs(_data) do
		local _supp = v[3];
		if _supp > 0 then
			local _prod = tonumber(v[4]);
			local _build = math.random(_supp);
			_prod = _prod + _build;
			_supp = _supp - _build
			_data[k][4] = math.min(4,_prod)
			_data[k][3] = _supp
		end	
	end
		
	self:setFlag("EVO_BusinessData" , _data )
	self:SaveBusinessData(false)
	self:FullNWSync();

end

/*
function _pMeta:FinishedSupplyMission(Business,actingServer)

	local _data = self:GetBusiness((actingServer == true && true || false))

	local _isFinished = _data[Business] &&  _data[Business][7]  &&  _data[Business][7][4] &&  _data[Business][7][4][1] == true && true || false

	return _isFinished;
end

function _pMeta:FinishedInitMission(Business,actingServer)

	local _data = self:GetBusiness((actingServer == true && true || false))

	local _isFinished = _data[Business] &&  _data[Business][5] &&  _data[Business][5] == true && true || false

	return _isFinished;
end
*/

function _pMeta:UpgradeBusiness(Business, upgrade,actingServer)
	//fsrp.I_BusinessPropertyTable.BusinessInformation.Upgrades;
	local _data = self:GetBusiness((actingServer==true && true || false))
	local _index = 0
	local _indexdata = 0;
	for k , v in pairs(fsrp.I_BusinessPropertyTable) do
		
		if v.BusinessInformation.Tag ==  _data[Business][2] then
			_index = k;

			break;
		end
			
	end
	local _property =fsrp.I_BusinessPropertyTable[_index];
	if !_data[Business] then
		return self:Notify("Business not found!")
	end
	if _data[Business][6] && _data[Business][6][upgrade] then
		return self:Notify("You already have this business upgrade!")
	end

	if _property and _property.BusinessInformation.Upgrades[upgrade] then

		local _upgcost = _property.BusinessInformation.Upgrades[upgrade].Cost

		if !self:canAfford(_upgcost) then
			return self:Notify("You do not have enough money on your person for this expense!")
		end
		self:addMoney(_upgcost*-1)
		if !_data[Business][6][upgrade] then
			_data[Business][6][upgrade]=true;
		end
		_data[Business][6][upgrade] = true;

		local _pre = "EVO_"
		if actingServer == true then
			_pre = "DT_";
		end
		local _supp = _pre.."BusinessData";
		self:setFlag( _supp , _data )
		self:SaveBusinessData(actingServer)
		self:Notify("You have bought " .. _property.BusinessInformation.Upgrades[upgrade].Name .. " for $" .. _property.BusinessInformation.Upgrades[upgrade].Cost)
		self:FullNWSync();
		return
	end
	return self:Notify("The Business you are trying to upgrade wasnt found!")
end

function _pMeta:SelloutProduct(Business,actingServer)
	local _data = self:GetBusiness((actingServer && true || false))
	local _isFinished = self:FinishedSupplyMission(Business)
	if _data[Business] && !_data[Business][7] then return self:Notify("You are not on a supply mission.") end
	if _data[Business] && !_data[Business][5] then return self:Notify("You have not finished your business initialization supply drop.") end
	if !_isFinished then return self:Notify("You can not finish this supply mission because you have not met its criteria.") end
	if fsrp.config.SupplyMissions[_data[Business][2]] then
	
		for i=1,(math.min(_prod,4)*100) do
			self:AddItemByID(54)
		end
		_data[Business][3] = 0
		_data[Business][4] = 0

		local _pre = "EVO_"
		if actingServer == true then
			_pre = "DT_";
		end
		local _supp = _pre.."BusinessData";
		self:setFlag( _supp , _data )
		self:SaveBusinessData(actingServer)
		self:FullNWSync();
	/*
	local _upgrades = _data[Business][6] or {};
	local _potential = 1;
	local _increase = 0;
	if #_upgrades > 0 then
		for k , v in pairs(_upgrades) do
			if _property.BusinessInformation and _property.BusinessInformation.Upgrades and _property.BusinessInformation.Upgrades[v] then
				_increase = _increase+_property.BusinessInformation.Upgrades[v].GrowValueIncrease
			end

		end
	end

	_potential = _increase/100+_potential
	*/

	
	
	end
end
function _pMeta:CanBeginSupplyMission(actingServer)

	local _data = self:GetBusiness(actingServer)
	local _count = 0;
	for k , v in pairs( _data ) do
		if v[5] && v[5] != true then
			_count=_count+1
		end
		if v[7] && istable(v[7]) && v[7][1] then
			_count=_count+1
		end
		if v[8] && istable(v[8]) && v[8][1] then
			_count=_count+1
		end
	end	

	if _count > 0 then
		return false
	else
		return true;
	end

	return (_count <= 0)
end

function _pMeta:FinishSupplyMission(Business,actingServer)
	local _data = self:GetBusiness((actingServer && true || false))
	//local _isFinished = self:FinishedSupplyMission(Business)
	if _data[Business] && !_data[Business][7] then return self:Notify("You are not on a supply mission.") end
	if _data[Business] && !_data[Business][7][4][1] then return self:Notify("You have not finished your business supply drop.") end
	//if !_isFinished then return self:Notify("You can not finish this supply mission because you have not met its criteria.") end
	local _residingBusiness = self:getFlag("ResidingInControlledProperty", 0);
	if !fsrp.I_BusinessPropertyTable[_residingBusiness] then
		return self:Notify("You must be in the business to finish a supply mission!")
	end
	local _proptype = fsrp.I_BusinessPropertyTable[_residingBusiness].BusinessInformation.Type;
	local _illegaltype = fsrp.config.IllegalBusinessTypes[_proptype];
	if fsrp.config.SupplyMissions[_data[Business][7][1]] then
		

		local _supp = _data[Business][3] 
		local _extra = math.random(1,fsrp.config.SupplyMissions[_data[Business][7][1]].supplycountmax)

		_data[Business][3] = math.max(fsrp.config.IllegalBusinessTypes[fsrp.I_BusinessPropertyTable[_residingBusiness].BusinessInformation.Type].MaxSupply,_supp + _extra)
		_data[Business][7] = nil;

		local _pre = "EVO_"
		if actingServer == true then
			_pre = "DT_";
		end
		local _supp = _pre.."BusinessData";
		self:setFlag( _supp , _data )
		self:SaveBusinessData(actingServer)
		self:setFlag("supplyFlagTag",nil)
		self:Notify("You have finished the " .. _illegaltype.Name .. " supply mission.")
		self:FullNWSync();
	/*
	local _upgrades = _data[Business][6] or {};
	local _potential = 1;
	local _increase = 0;
	if #_upgrades > 0 then
		for k , v in pairs(_upgrades) do
			if _property.BusinessInformation and _property.BusinessInformation.Upgrades and _property.BusinessInformation.Upgrades[v] then
				_increase = _increase+_property.BusinessInformation.Upgrades[v].GrowValueIncrease
			end

		end
	end

	_potential = _increase/100+_potential
	*/

	
	
	end
end
function _pMeta:BeginInitMission( _PropertyID,_MissionNumber,joiningPlayers, actingServer)
	ActAsBusinessServer(actingServer)
	local _data = self:GetBusiness(actingServer)
	local _addPlayers = joiningPlayers || {};
	local _businessProperty = fsrp.I_BusinessPropertyTable[_PropertyID];

	if !_businessProperty then return self:Notify("Can't start a mission with a property that doesn't exist.") end
	local _activeMission = self:getFlag("supplyFlagTag",nil);
	local _proptype = _businessProperty.BusinessInformation.Type;
	local _illegaltype = fsrp.config.IllegalBusinessTypes[_proptype];

	if _activeMission != nil && _activeMission != "" then
		return self:Notify("You are already on a " .. _illegaltype.Name .. " supply mission!")
	end


	for k , v in pairs( _data ) do
		
		if v[2] == fsrp.I_BusinessPropertyTable[_PropertyID].BusinessInformation.Tag then
			
			local _SupplyMission = {
				_MissionNumber,
				1,
				{self:SteamID(), _addPlayers };
				fsrp.config.InitMissions[_MissionNumber].initFlags;
			};

			fsrp.config.InitMissions[_MissionNumber].supplyStep[game.GetMap()].StartMission(self)
			v[5] = _SupplyMission;

			_data[k] = v;

			break;
		end

	end

	local _pre = "EVO_"
	if actingServer == true then
		_pre = "DT_";
	end
	local _supp = _pre.."BusinessData";
	self:setFlag( _supp , _data )
 	self:Notify("Beginning Initial " .. _illegaltype.Name .. " Supply Mission")
	self:SaveBusinessData(actingServer)
	self:FullNWSync();

end
function _pMeta:FinishInitMission(Business,actingServer)
	local _data = self:GetBusiness((actingServer && true || false))
	//local _isFinished = self:FinishedInitMission(Business)
	if _data[Business] && !_data[Business][5] then return self:Notify("You are not on a supply mission.") end
	if _data[Business] && !_data[Business][5][4][1] then return self:Notify("You have not finished your business initialization supply drop.") end
	//if !_isFinished then return self:Notify("You can not finish this supply mission because you have not met its criteria.") end
	local _residingBusiness = self:getFlag("ResidingInControlledProperty", 0);
	if !fsrp.I_BusinessPropertyTable[_residingBusiness] then
		return self:Notify("You must be in the business to finish a supply mission!")
	end
	local _proptype = fsrp.I_BusinessPropertyTable[_residingBusiness].BusinessInformation.Type;
	local _illegaltype = fsrp.config.IllegalBusinessTypes[_proptype];
	if fsrp.config.InitMissions[_data[Business][5][1]] then
		

		local _supp = _data[Business][3] 
		local _extra = math.random(1,fsrp.config.InitMissions[_data[Business][5][1]].supplycountmax)

		_data[Business][3] = math.max(fsrp.config.IllegalBusinessTypes[fsrp.I_BusinessPropertyTable[_residingBusiness].BusinessInformation.Type].MaxSupply,_supp + _extra)
		_data[Business][5] = true;

		local _pre = "EVO_"
		if actingServer == true then
			_pre = "DT_";
		end
		local _supp = _pre.."BusinessData";
		self:setFlag( _supp , _data )
		self:SaveBusinessData(actingServer)
		self:setFlag("supplyFlagTag",nil)
		self:Notify("You have finished the introductory " .. _illegaltype.Name .. " supply mission.")
		self:FullNWSync();

	end
end
function _pMeta:BeginSupplyMission( _PropertyID,_MissionNumber,joiningPlayers, actingServer)
	ActAsBusinessServer(actingServer)
 
	local _data = self:GetBusiness(actingServer)
	local _addPlayers = joiningPlayers || {};
	local _businessProperty = fsrp.I_BusinessPropertyTable[_PropertyID];
	if !_businessProperty then return self:Notify("Can't start a mission with a property that doesn't exist.") end
	local _proptype = _businessProperty.BusinessInformation.Type;
	local _illegaltype = fsrp.config.IllegalBusinessTypes[_proptype];

	local _activeMission = self:getFlag("supplyFlagTag",nil);
	
	if _activeMission != nil && _activeMission != "" then
		return self:Notify("You are already on a " .. _illegaltype.Name .. " supply mission!")
	end

	local _residingBusiness = self:getFlag("ResidingInControlledProperty", 0);
	if !fsrp.I_BusinessPropertyTable[_residingBusiness] then
		return self:Notify("You must be in the business to begin a " .. _illegaltype.Name .. " supply mission!")
	end
	local _suppabledt, _suppableevo= self:CanBeginSupplyMission(true), self:CanBeginSupplyMission(false)

	if _suppabledt != true || _suppableevo != true then
		return self:Notify("You are already on a " .. _illegaltype.Name .. " supply mission!")
	end
	
	for k , v in pairs( _data ) do
		
		if v[2] == fsrp.I_BusinessPropertyTable[_PropertyID].BusinessInformation.Tag then
			
			local _SupplyMission = {
				_MissionNumber,
				1,
				{self:SteamID(), _addPlayers };
				fsrp.config.SupplyMissions[_MissionNumber].initFlags;
			};

			v[7] = _SupplyMission;
			fsrp.config.SupplyMissions[_MissionNumber].supplyStep[game.GetMap()].StartMission(self)
			_data[k] = v;
		end

	end

	local _pre = "EVO_"
	if actingServer == true then
		_pre = "DT_";
	end
	local _supp = _pre.."BusinessData";
	self:setFlag( _supp , _data )
	self:SaveBusinessData(actingServer)
 	self:Notify("Beginning " .. _illegaltype.Name .. " Supply Mission")
	self:FullNWSync();

end
local function ReinitializeBusinessDropoffs()
	if CLIENT then return end
	for k , v in pairs(ents.FindByClass("wcrp_ibsupply")) do
		if v and IsValid(v) then
			v:Remove();
		end
	end
	local _tbs = {
		[1] = fsrp.config.SupplyMissions;
		[2] = fsrp.config.InitMissions;
		[3] = fsrp.config.DeliveryMissions;
	}

	local _mission = {};
	for k , v in pairs( fsrp.config.BusinessTagsToLoad ) do
		for i=1,#_tbs do
			if _tbs[i][k] then
				_mission[k] = _tbs[i][k];
			end
		end
	end
	for k , v in pairs(_mission) do
		local _pickup = v.pickup[game.GetMap()];

		if _pickup && istable(_pickup) then
			local _ent = ents.Create("wcrp_ibsupply");
			_ent:Spawn()
			_ent:SetPos(_pickup[1])
			_ent:SetAngles(_pickup[2])

			_ent:setFlag("supplyFlagTag", k)
		end

	end
end
fsrp.ReinitBusinessDrops = ReinitializeBusinessDropoffs;
hook.Add("InitPostEntity","SpawnBusinessDrops", function()
	ReinitializeBusinessDropoffs();
end)
if CLIENT then

	net.Receive("ShowPropertyHUD", function(_l,_p)
		local _shouldclose = net.ReadBool();
		if _shouldclose == true then
			LocalPlayer():HidePropertyHUD();
		else
			LocalPlayer():ShowPropertyHUD();
		end	
	end)
	local SCREEN_W, SCREEN_H = 3840, 2160;

	local _w, _h = ScrW( ), ScrH( );
	local _wMod, _hMod = _w / SCREEN_W, _h / SCREEN_H;
	_wMod = _wMod*2;
	_hMod = _hMod*2;
	local gradient = Material( 'vgui/gradient-r' ) -- cache before use!

	function _pMeta:ShowPropertyHUD()
		local _data = self:GetBusiness();
		local targLerp = doClose==true && 0 || 255;
		local hAlpha = 0;
		local _residingBusiness = self:getFlag("ResidingInControlledProperty", 0);
		local _residingBusinessTag = fsrp.I_BusinessPropertyTable[_residingBusiness].BusinessInformation.Tag
		if _data and istable(_data) then
			hook.Add("HUDPaint","PropertyHUD", function()
				//if !_showRobbing then return end
				hAlpha = Lerp(0.05,hAlpha,targLerp);

				//draw.RoundedBoxEx( 0,_wMod * 50, _hMod * 895, _wMod * 300 , _hMod * 60 , Color(25,25,25,255) )
			
			    surface.SetMaterial( gradient )
			    surface.SetDrawColor( 0, 0, 0, hAlpha ) -- solid white, 0,0,0 is black
			    surface.DrawTexturedRect( _wMod*1500, _hMod*970, _wMod*150, _hMod*55 )
				 draw.NoTexture()
			    surface.DrawTexturedRect( _wMod*1650, _hMod*970, _wMod*150, _hMod*55 )
				_data = self:GetBusiness();
			    surface.SetDrawColor( 255, 255, 255, hAlpha ) 
			    for i=1,4 do
			    	surface.DrawRect( _wMod*(1545+i*51), _hMod*(981) , _wMod*46, _hMod*10 )
			    end
			    surface.SetDrawColor( 128, 255, 128, hAlpha ) 
			    for k , v in pairs( _data ) do
			    	if v[2] == _residingBusinessTag then
					    for i=1,v[3] do
					    	surface.DrawRect( _wMod*(1545+i*51), _hMod*(981) , _wMod*46, _hMod*10 )
					    end
				    end
			  	end
			    surface.SetDrawColor( 255, 255, 255, hAlpha ) 
			    for i=1,4 do
			    	surface.DrawRect( _wMod*(1545+i*51), _hMod*(1006) , _wMod*46, _hMod*10 )
			    end
			    surface.SetDrawColor( 128, 255, 128, hAlpha ) 
			    for k , v in pairs( _data ) do
			    	if v[2] == _residingBusinessTag then
					    for i=1,v[4] do
			    			surface.DrawRect( _wMod*(1545+i*51), _hMod*(1006) , _wMod*46, _hMod*10 )
					    end
				    end
			  	end
				
				draw.SimpleText( "Supply" , "RobberyText", _wMod * 1525,_hMod * 972.5, Color(150, 150, 150, hAlpha), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 1, Color(0, 0, 0, 255));
				draw.SimpleText( "Product" , "RobberyText", _wMod * 1525,_hMod * 996.5, Color(150, 150, 150, hAlpha), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 1, Color(0, 0, 0, 255));

			end)
		end
	end

	function _pMeta:HidePropertyHUD()
		hook.Remove("HUDPaint","PropertyHUD")
	end
else
	util.AddNetworkString("ShowPropertyHUD");

	function _pMeta:ShowPropertyHUD(shouldclose)
		net.Start("ShowPropertyHUD")
		net.WriteBool(shouldclose)
		net.Send(self)
	end
	function _pMeta:GetJobTimePlayed(_j)

		return  tonumber(self:getFlag( "jobPlaytimes", {} )[_j].Played);

	end
	function _pMeta:GetJobTimeInfo(_j)

		return  self:getFlag( "jobPlaytimes", {} )[_j];

	end
	function _pMeta:GetTimePlayed()

		return tonumber(self:getFlag("playTime", 0  ))
		
	end
	function _pMeta:TimeSinceJoin()

		return RealTime() - self:getFlag( "joinTime" , 0 );
		
	end
	function _pMeta:GetPlaytimeTitle( )

		local _pTime = self:GetTimePlayed()
		local _gender = self:getGender();
		local _returnTit = "";
		local _found = 1;
		
		for k , v in pairs ( _TitleTable ) do
		
			if _pTime > v.time then
					
				_found = k;
				if _TitleTable[(k+1)] && _pTime < _TitleTable[(k+1)].time then
					
					break;

				end

			end
			
		end
		
		return _TitleTable[_found].title;
	end
end
function _pMeta:BeginBusinessInit( _PropertyID ,actingServer)
	ActAsBusinessServer(actingServer)
	

end
function _pMeta:BeginDeliveryMission( _PropertyID,_MissionNumber,joiningPlayers, actingServer)
	ActAsBusinessServer(actingServer)
 
	local _data = self:GetBusiness(actingServer)
	local _addPlayers = joiningPlayers || {};
	local _businessProperty = fsrp.I_BusinessPropertyTable[_PropertyID];
	if !_businessProperty then return self:Notify("Can't start a mission with a property that doesn't exist.") end
	local _proptype = _businessProperty.BusinessInformation.Type;
	local _illegaltype = fsrp.config.IllegalBusinessTypes[_proptype];

	local _activeMission = self:getFlag("supplyFlagTag",nil);
	
	if _activeMission != nil && _activeMission != "" then
		return self:Notify("You are already on a " .. _illegaltype.Name .. " delivery mission!")
	end

	local _residingBusiness = self:getFlag("ResidingInControlledProperty", 0);
	if !fsrp.I_BusinessPropertyTable[_residingBusiness] then
		return self:Notify("You must be in the business to begin a " .. _illegaltype.Name .. " delivery mission!")
	end
	local _suppabledt, _suppableevo= self:CanBeginSupplyMission(true), self:CanBeginSupplyMission(false)

	if _suppabledt != true || _suppableevo != true then
		return self:Notify("You are already on a " .. _illegaltype.Name .. " delivery mission!")
	end
	local _noproduct = true;

	for k , v in pairs( _data ) do
		
		if v[2] == fsrp.I_BusinessPropertyTable[_PropertyID].BusinessInformation.Tag then
		
			local _SupplyMission = {
				_MissionNumber,
				v[4],
				{self:SteamID(), _addPlayers };
				fsrp.config.DeliveryMissions[_MissionNumber].initFlags;
			};
			v[4] = 0;
			v[8] = _SupplyMission;
			fsrp.config.DeliveryMissions[_MissionNumber].supplyStep[game.GetMap()].StartMission(self)
			_data[k] = v;			
			_noproduct = false;
			
		end

	end

	if _noproduct == true then
		return self:Notify("You may not begin a delivery without sufficient product.")
	end

	local _pre = "EVO_"
	if actingServer == true then
		_pre = "DT_";
	end
	local _supp = _pre.."BusinessData";
	self:setFlag( _supp , _data )

	self:SaveBusinessData(actingServer)
 	self:Notify("Beginning " .. _illegaltype.Name .. " Delivery Mission")
	self:FullNWSync();

end
function _pMeta:FinishDeliveryMission(Business,actingServer)
	local _data = self:GetBusiness((actingServer && true || false))
	//local _isFinished = self:FinishedInitMission(Business)
	if _data[Business] && !_data[Business][8] then return self:Notify("You are not on a delivery mission.") end
	if _data[Business] && !_data[Business][8][4][1] then return self:Notify("You have not finished your business delivery drop.") end
	if _data[Business] && _data[Business][8][4][2] then return self:Notify("You have already brought the drugs to the dealer.") end
	//if !_isFinished then return self:Notify("You can not finish this supply mission because you have not met its criteria.") end
	local _residingBusiness = self:getFlag("ResidingInControlledProperty", 0);
	if !fsrp.I_BusinessPropertyTable[_residingBusiness] then
		return self:Notify("You must be in the business to finish a delivery mission!")
	end
	local _proptype = fsrp.I_BusinessPropertyTable[_residingBusiness].BusinessInformation.Type;
	local _illegaltype = fsrp.config.IllegalBusinessTypes[_proptype];
	if fsrp.config.DeliveryMissions[_data[Business][8][1]] then
		
		//local _supp = _data[Business][3] 
		//local _extra = math.random(1,fsrp.config.DeliveryMissions[_data[Business][8][1]])

		//_data[Business][3] = math.max(fsrp.config.IllegalBusinessTypes[fsrp.I_BusinessPropertyTable[_residingBusiness].BusinessInformation.Type].MaxSupply,_supp + _extra)
		local _canstartLaundering = _data[Business][8][4][1];
		if _canstartLaundering == true then
			local _prod = _data[Business][8][2];
			local _list = _illegaltype.LaunderNPCs;
			local _launderlist = {};
			for i =1,_prod do
				local _randk = math.random(#_list);
				local _randv = _list[_randk];
				table.insert(_launderlist,_randv)

				table.remove(_list,_randk)
			end
			_data[Business][8][4][2] = _launderlist;
			_data[Business][8][4][3] = true;

			local _pre = "EVO_"
			if actingServer == true then
				_pre = "DT_";
			end
			local _supp = _pre.."BusinessData";
			self:setFlag( _supp , _data )
			self:SaveBusinessData(actingServer)
			self:setFlag("supplyFlagTag",nil)
			self:Notify("You have sold the " .. _illegaltype.Name .. " inventory, you must now launder the money by bringing it to businesses. Check your destinations in F1!")
			/*for k , v in pairs(_launderlist) do
				if cnQuests[v] then
					local _name = cnQuests[v].name;
					self:Notify("Deliver to " .._name);
				end
			end*/
			self:FullNWSync();
		else
			self:Notify("You may not start laundering money until you sell your goods to the dealer.")
		end
	end
end
function _pMeta:LaunderBusiness(Business,actingServer)
	local _data = self:GetBusiness((actingServer && true || false))
	//local _isFinished = self:FinishedInitMission(Business)
	if _data[Business] && !_data[Business][8] then return self:Notify("You are not on a delivery mission.") end
	if _data[Business] && !_data[Business][8][4][1] then return self:Notify("You have not finished your business delivery drop.") end
	if _data[Business] && !_data[Business][8][4][2] then return self:Notify("You have not brought your product to the dealer.") end
	//if !_isFinished then return self:Notify("You can not finish this supply mission because you have not met its criteria.") end

	local _property = _data[Business][2];
	local _residingBusiness = 0;
	for k , v in pairs(fsrp.I_BusinessPropertyTable) do
		if v.BusinessInformation and v.BusinessInformation.Tag == _property then
			_residingBusiness = k
		end
	end
	if !fsrp.I_BusinessPropertyTable[_residingBusiness] then return self:Notify("You must be near the target NPC to launder cash.") end;

	local _proptype = fsrp.I_BusinessPropertyTable[_residingBusiness].BusinessInformation.Type;
	local _illegaltype = fsrp.config.IllegalBusinessTypes[_proptype];
	if fsrp.config.DeliveryMissions[_data[Business][8][1]] then
		local _playersID = _data[Business][8][3];
		local _prod = _data[Business][8][2];
		table.insert(_playersID,self:SteamID());
		if _prod-1 >= 0 then
			local _businesses = _data[Business][8][4][2];
			local _found = false;
			local _foundnpcs = {};
			local _upgrades = _data[Business][6];
			local _extra = 0;
			local _worth = _illegaltype.SupplySellWorth;
			for k , v in pairs(_upgrades) do
				if fsrp.I_BusinessPropertyTable[_residingBusiness].BusinessInformation.Upgrades[k].GrowValueIncrease then
					_extra= fsrp.I_BusinessPropertyTable[_residingBusiness].BusinessInformation.Upgrades[k].GrowValueIncrease+_extra
				end
			end

			for k,v in pairs(ents.FindInSphere(self:GetPos(),300)) do
				if v and v:GetClass() == 'cn_npc' then 					
					table.insert(_foundnpcs,v:GetQuest())
				end
			end
			local _npctoremove = "bu_bank";
			for k, v in pairs( _foundnpcs) do
				for x, y in pairs(_businesses) do
					if y == v then
						_npctoremove = x;
						_found = true;
						break;
					end
				end
			end

			if _data[Business][8][4][2][_npctoremove] then
				table.remove(_data[Business][8][4][2],_npctoremove);
			else
				return self:Notify("You must be near the target NPC to launder cash.")
			end
			if _found == false then
				return self:Notify("You must be near the target NPC to launder cash.")
			end
			for k,v in pairs(ents.FindInSphere(self:GetPos(),300)) do
				if v and v:IsPlayer() and _playersID[v:SteamID()] then 
					v:addMoney(((_extra/100*_worth)+_worth))
				end
			end
			self:addMoney(((_extra/100*_worth)+_worth))

			//local _supp = _data[Business][3] 
			//local _extra = math.random(1,fsrp.config.DeliveryMissions[_data[Business][8][1]])

			//_data[Business][3] = math.max(fsrp.config.IllegalBusinessTypes[fsrp.I_BusinessPropertyTable[_residingBusiness].BusinessInformation.Type].MaxSupply,_supp + _extra)
			//_data[Business][8] = nil;
			if _prod-1<=0 then
				
				_data[Business][8] = nil;
				self:Notify("You have finished the " .. _illegaltype.Name .. " laundering mission.")

			else

				_data[Business][8][2] = _prod-1;
				self:Notify("You have progressed in the " .. _illegaltype.Name .. " laundering mission.")

			end

			local _pre = "EVO_"
			if actingServer == true then
				_pre = "DT_";
			end
			local _supp = _pre.."BusinessData";
			self:setFlag( _supp , _data )
			self:SaveBusinessData(actingServer)
			self:setFlag("supplyFlagTag",nil)
			self:FullNWSync();
		end
	end
end

hook.Add( "PlayerUse", "LaunderUse", function( ply, ent )
	
	if ply.LastTime then

		if ply.LastTime < os.time() then
			ply.LastTime = os.time()+5
		else 
			return	
		end
	
	else
		ply.LastTime = os.time()+5;
	end

	if IsValid(ply) and ent:GetClass() == "cn_npc" then
		for k, v in pairs(ply:GetBusiness()) do
			if v[8] and v[8][4] and v[8][4][2] then
				local _found = false;
				for x,y in pairs(v[8][4][2]) do
					if y == ent:GetQuest() then
						_found = true;
					end
				end
				if _found == true then
					ply:LaunderBusiness(k,(game.GetMap()=="rp_downtown_v4c_v2" && true || false))
				end
			end
		end
	end
end )

if SERVER then
	util.AddNetworkString("BusinessMissionSelection")
	net.Receive("BusinessMissionSelection", function(_l,_p)
		local _b = net.ReadInt(8)
		local _ty = net.ReadInt(8)
		local _mis = net.ReadString()
		local _data = _p:GetBusiness();
		if !_data[_b] then
			return _p:Notify("Couldn't find the mission you selected in our database! We apologize for the inconvenience.")
		end
		local _prop = nil;
		for k , v in pairs( fsrp.I_BusinessPropertyTable ) do
			if v.BusinessInformation.Tag == _data[_b][2] then
				_prop = v;
			end
		end
		if _prop == nil then return _p:Notify("We could not locate the business in our database please try again later!") end
		local _residingBusiness = _p:getFlag("ResidingInControlledProperty", 0);
		
		if _ty == 1 then
			if _residingBusiness && _residingBusiness != _prop.ID then return _p:Notify("You must be in your business to start a mission!") end
			local _plytb = {};
			for k , v in pairs( player.GetAll() ) do
				if v:SteamID() != _p:SteamID() then
					if (v:getFlag("organization",0) == _p:getFlag("organization",0))  and (v:getFlag("ResidingInControlledProperty", 0) == _p:getFlag("ResidingInControlledProperty", 0) ) then
						table.insert(_plytb,v:SteamID())
					end
				end
			end
			_p:BeginSupplyMission( _prop.ID,_mis,_plytb,(game.GetMap() == "rp_downtown_v4c_v2" && true || false))			

			return
		elseif _ty == 2 then
			local _upg = net.ReadInt(8);
			_p:UpgradeBusiness(_b, _upg,(game.GetMap() == "rp_downtown_v4c_v2" && true || false))
		
		elseif _ty == 3 then
			if _residingBusiness && _residingBusiness != _prop.ID then return _p:Notify("You must be in your business to start a mission!") end
			local _plytb = {};
			for k , v in pairs( player.GetAll() ) do
				if v:SteamID() != _p:SteamID() then
					if (v:getFlag("organization",0) == _p:getFlag("organization",0))  and (v:getFlag("ResidingInControlledProperty", 0) == _p:getFlag("ResidingInControlledProperty", 0) ) then
						table.insert(_plytb,v:SteamID())
					end
				end
			end
			_p:BeginDeliveryMission( _prop.ID,_mis,_plytb,(game.GetMap() == "rp_downtown_v4c_v2" && true || false))

			return
		end

		return
	end)
end