
util.AddNetworkString("fsrpRPComputerSelection"); // Sends the client the computer selection menu
util.AddNetworkString("toggleSystemActivity"); // Toggles a computers state
util.AddNetworkString("fsrpuseComputer"); // Called when client sends their current entity to the server
util.AddNetworkString("fsrpSendComputer"); // Sends the client the verified computer at index
util.AddNetworkString( "sendDesktopClose" )
util.AddNetworkString( "sendComponentPurchaseRequest" )
util.AddNetworkString( "sendComponentUpgradeRequest" )

// Computer networked
net.Receive( "sendComponentPurchaseRequest", function( _l , _p )

	local _slot = net.ReadInt( 8 );
	local _hardwareType = net.ReadInt( 4 );

	local _rpcomputer = _p:GetRPComputer();
	
	if !_rpcomputer[_hardwareType].Components[_slot] then
		
		if _p:canAffordBank( rpcomputer.config.HardwareTypes[_hardwareType].Price * 2  ) then
		
			_p:addBank( -rpcomputer.config.HardwareTypes[_hardwareType].Price * 2 )
			//_p:Notify( "You have purchased a component. " .. rpcomputer.config.HardwareTypes[_hardwareType].Name );
			_p:SetNewComputerComponent( _hardwareType, _slot , 1 )
		
		else
		
			_p:Notify( "You do not have enough money to purchase this in your bank account" )
			
		end

	else
			
			_p:Notify( "You already have a component in this slot. Upgrade it!" )
		
	end
	
	
end )

net.Receive( "sendComponentUpgradeRequest", function( _l , _p )

	local _slot = net.ReadInt( 8 );
	local _hardwareType = net.ReadInt( 4 );

	local _rpcomputer = _p:GetRPComputer() 
	
	if _rpcomputer[_hardwareType].Components[_slot] then
	
		_p:UpgradeRPComputer( _hardwareType, _slot )
	
	else
	
		_p:Notify("You must purchase the component to upgrade it!")
	
	end
end )

net.Receive( "toggleSystemActivity" , function( _l , _p )
	
	local _systemInUse = net.ReadInt( 16 )
	local _entInQuestion = ents.GetByIndex( _systemInUse );
	
	if _entInQuestion:GetPos():Distance( _p:GetPos() ) > 100 then
	
		return rpcomputer.helper.MessagePlayer( _p , "Get closer to your peripheral to toggle it!" )
	
	end
	
		
	if table.HasValue( { "fsrpcomputer" , "fsrpmonitor" }, _entInQuestion:GetClass() ) then

		local _etype = _entInQuestion:GetClass() == "fsrpcomputer" && "computer" || "monitor";
		local _state = _entInQuestion:IsOn() && "off" || "on";
		local _gender = _p:getGender() != 1 && "his" || "her";

		local _owner = _entInQuestion:getFlag("ownedBy","") == _p:SteamID() && _gender || "a"
		_p:ConCommand( "say /me turned " .. _owner .. " " .. _etype .. " " .. _state .. "." )
		_entInQuestion:ToggleOn()
		
			
		if _entInQuestion:GetClass() == "fsrpcomputer" then
		
			if !_entInQuestion:IsOn() then
							
				for k , v in pairs( _entInQuestion.PlayersInUse ) do
				
					local _player = player.GetBySteamID( k )
					
					if _player then
					
						net.Start("sendDesktopClose")
						net.Send( _player ) 				
					
					end
					
					table.remove( _entInQuestion.PlayersInUse, k )
					
				end
			
			end
			
		end
	
	end

end )


net.Receive( "fsrpuseComputer" ,function( _l , _p ) 

	local _entityInUseIndex = net.ReadInt( 16 )
	local _entityInRangeIndex = net.ReadInt( 16 )
	
	local _entityInUse = ents.GetByIndex( _entityInUseIndex )
	local _entityInRange = ents.GetByIndex( _entityInRangeIndex )
	
	local _computer = _entityInUse;
	local _monitor = _entityInRange;
	
	if _entityInUse:GetClass() != "fsrpcomputer" then
		
		_monitor = _entityInUse;
		_computer = _entityInRange;
	
	end
	
		--return rpcomputer.helper.MessagePlayer( _p , "You can not interact with a computer from it's tower. You need to go to the monitor." )	
	
	--end
	
	local _monitorLocation = _monitor:GetPos( )
	local _computerLocation = _computer:GetPos( )
	local _playerLocation = _p:GetPos( )
	
	if _monitorLocation:Distance( _computerLocation ) > 150 then
	
		return rpcomputer.helper.MessagePlayer( _p , "Move your Monitor closer to your tower to access it." )
	
	end
	
	if _playerLocation:Distance( _monitorLocation ) > 100 then
	
		return rpcomputer.helper.MessagePlayer( _p , "Move closer to your monitor to interact with it." )
		
	end
	
	if !_computer:IsOn() || !_monitor:IsOn() then
	
		return rpcomputer.helper.MessagePlayer( _p , "Computer and / or monitor is not available from serverside, aborting." )
	
	end 
	
	_p:AdjustComputerSpeed( _computer:GetComputerSpeed() )
		
	if !_computer.PlayersInUse[_p:SteamID()] then
	
		_computer.PlayersInUse[_p:SteamID()] = true
	
	end
	
	net.Start( "fsrpSendComputer" )
		net.WriteInt( _computer:EntIndex( ) , 16 )
		net.WriteInt( _monitor:EntIndex( ) , 16 )
	net.Send( _p )
	
end )
/*

	["ultimate"] = {

		{ Components = { { Level = 5 }  }} ;
		{ Components = { { Level = 5 }  }} ;
		{ Components = { { Level = 3 }  }} ;
		{ Components = { { Level = 4 }  }} ;

	};
	*/
local _pMeta = FindMetaTable( 'Player' )

local function dehashcomputer( string )
	local _SplitHardware = string.Explode( "*", string )
	local _ReturnComputer = { [1] = {} , [2] = {} , [3] = {} , [4] = {} };

	for k , v in pairs( _SplitHardware ) do
	
		local _Components = string.Explode( ";" , v ) 
		
		for x, y in pairs( _Components ) do
		
			_ReturnComputer[tonumber(k)][tonumber(x)] = {}
			_ReturnComputer[tonumber(k)][tonumber(x)].Level = tonumber(y)
		
		end
	
	end
	
	
	return _ReturnComputer 
end
local function hashcomputer( specifications )
	
	local _returnstring = "";
	if !specifications then return nil end
	if #specifications <= 0 then return "" end
	
	for k , v in pairs( specifications ) do
	
		local _stringHardware = "";
		
		if v.Components then
		
			for x, y in pairs( v.Components ) do
		
				_stringHardware = x .. "," .. y.Level .. ";";
			
			end
		
		end
		
		if _returnstring != "" then
		
			_returnstring =_returnstring .. "*" ..	_stringHardware;
		
		else
		
			_returnstring = _stringHardware;
			
		end
		
	end

	return _returnstring
	
end

function _pMeta:SaveRPComputer( tb )
	if self:getFlag("loadedIN", false) == false then return end
	if hashcomputer( tb ) == nil then return end
	
	fsdb:Query("UPDATE `fsdb_characterdata` SET `computer`='" .. hashcomputer( tb ) .. "' WHERE `id`='" .. self:SteamID() .. "';");

end
function _pMeta:CreateRPComputerDBEntry()
	if self:getFlag("loadedIN", false) == false then return end

	fsdb:Query( "SELECT * FROM `fsdb_characterdata` WHERE `id`='" .. self:SteamID() .. "';" , function( result, status, error ) 
		
		
		if !result then
			
			// Set it up already
			fsdb:Query( "INSERT INTO `fsdb_characterdata` ( `id`, `business`, `skills`, `knownrecipes` , `computer`) VALUES ('" .. self:SteamID() .. "' , '','','','') ;" )
			self:SetupRPComputerData()			
			
		end

	end)

end
function _pMeta:LoadRPComputer()
	
	if self:getFlag("loadedIn", false) == false then return end
	fsdb:Query( "SELECT `computer` FROM `fsdb_characterdata` WHERE `id`='" .. self:SteamID() .. "';" , function( result, status, error ) 
		
		if result then

			if result[1] && result[1][1] != "" then
				
				local _computer =  dehashcomputer( result[1][1] );
				
				UpdatePlayerComputer( self , _computer )
			
			end
			
		else
			
			self:CreateRPComputerDBEntry()
			
		end
		
	end );

end