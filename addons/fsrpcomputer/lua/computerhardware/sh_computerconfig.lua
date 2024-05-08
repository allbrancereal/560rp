

rpcomputer = rpcomputer || {};

rpcomputer.config = {}

rpcomputer.config.HardwareTypes = {
	[1] = {
		Name = "Central Processing Unit",
		Price = 180,
		MaxLevel = 5,
		Max = 2,
		Levels = {
			[1] = {
				Name = "AMD Athlon ii x4",
				Model = "models/amd athlon ii x4 620 cpu/amd_athlon_ii_x4_620_cpu.mdl",
				Desc = "Ridiculus mark up for this.",
				Speed = 1,
			},
			[2] = {
				Name = "AMD FX-8350",
				Model = "models/amd-a83850/amd-a83850.mdl",
				Desc = "Quite the old CPU but still an upgrade.",
				Speed = 5,
			},
			[3] = {
				Name = "AMD Ryzen R5 Quad Core",
				Model = "models/amd fx 8320 cpu/amd_fx_8320_cpu.mdl",
				Desc = "It's okay for games but good for mining.",
				Speed = 10,
			},
			[4] = {
				Name = "i7 Quad Core",
				Model = "models/intel corei7 4th gen/intel_corei7_4th_gen.mdl",
				Desc = "Allowing you to make the most demanding calculations per second.",
				Speed = 15,
			},
			[5] = {
				Name = "Intel i7 18-Core",
				Model = "models/intel corei7 4th gen/intel_corei7_4th_gen.mdl",
				Desc = "A beast of a CPU for a huge price.",
				Speed = 25,
			},
			
		},
		
	},
	
	[2] = {
		Name = "Graphics Card",
		Price = 150,
		MaxLevel = 5,
		Max = 4,
		Levels = {
			[1] = {
				Name = "Base Graphics Card",
				Model = "models/gaming-models/nebukadnezar/gibs/pc_gibs/pc_grafix.mdl",
				Desc = "This is the biggest shit, it doesn't even have a name.",
				Speed = 1,
			},
			[2] = {
				Name = "Nvidia GT 1030",
				Model = "models/gt1030_4.mdl",
				Desc = "",
				Speed = 3,
			},
			[3] = {
				Name = "AMD R9 Nano",
				Model = "models/r9nano_4.mdl",
				Desc = "Tiny but fast lil thing",
				Speed = 5,
			},
			[4] = {
				Name = "AMD RX Vega 64",
				Model = "models/amdrxvega/amdrxvega4.mdl",
				Desc = "Very hot off the press",
				Speed = 10,
			},
			[5] = {
				Name = "Nvidia GTX 1080 TI",
				Model = "models/gtx1080ti_4.mdl",
				Desc = "Top of the line many would say.",
				Speed = 12,
			},
			
		},
		
	},
	
	[3] = {
		Name = "Ram Sticks",
		Price = 120,
		Max = 8,
		MaxLevel = 3,
		Levels = {
			[1] = {
				Name = "8 GB",
				Model = "models/gaming-models/nebukadnezar/gibs/pc_gibs/pc_ram.mdl",
				Desc = "The most basic you can have, not the best for this occasion.",
				Speed = 1,
			},
			[2] = {
				Name = "16 GB",
				Model = "models/gaming-models/nebukadnezar/gibs/pc_gibs/pc_ram_2.mdl",
				Desc = "It increases your speed.",
				Speed = 2,
			},
			[3] = {
				Name = "32 GB",
				Model = "models/gaming-models/nebukadnezar/gibs/pc_gibs/pc_ram_3.mdl",
				Desc = "Power wise this is nice.",
				Speed = 3,
			},
			
		},
		
	},
	
	[4] = {
		Name = "Hard Drive",		
		Max = 4,
		Price = 60,
		MaxLevel = 4,
		Levels = {
			[1] = {
				Name = "10 TB Hard Drive",
				Model = "models/gaming-models/nebukadnezar/gibs/pc_gibs/pc_harddrive.mdl",
				Desc = "",
				Speed = 2,
			},
			[2] = {
				Name = "1 TB Hybrid Drive",
				Model = "models/gaming-models/nebukadnezar/gibs/pc_gibs/pc_harddrive.mdl",
				Desc = "Losing lots of space but you get speed.",
				Speed = 4,
			},
			[3] = {
				Name = "512 GB SSD",
				Model = "models/gaming-models/nebukadnezar/gibs/pc_gibs/pc_harddrive.mdl",
				Desc = "Even faster than a hybrid drive for the speed of sanic.",
				Speed = 6,
			},
			[4] = {
				Name = "64 GB NVmE SSD",
				Model = "models/gaming-models/nebukadnezar/gibs/pc_gibs/pc_harddrive.mdl",
				Desc = "Directly under your graphics card.",
				Speed = 8,
			},
			
		},
		
	},
	
} 

rpcomputer.config.coinvalue = 50
rpcomputer.config.Prebuilts = {

	["basecomputer"] = {

		{ Components = { { Level = 1 } }} ;
		{ Components = { { Level = 1 } }} ;
		{ Components = { { Level = 1 } }} ;
		{ Components = { { Level = 1 } }} ;

	};
	["midtier"] = {

		{ Components = { {  Level = 3   } }} ;
		{ Components = { {  Level = 3   } }} ;
		{ Components = { {  Level = 2   } }} ;
		{ Components = { {  Level = 3   } }} ;

	};
	["highend"] = {

		{ Components = { { Level = 5 }  }};
		{ Components = { { Level = 5 }  }};
		{ Components = { { Level = 3 }  }};
		{ Components = { { Level = 4 }  }} ;

	};
	["ultimate"] = {

		{ Components = { { Level = 5 }  }} ;
		{ Components = { { Level = 5 }  }} ;
		{ Components = { { Level = 3 }  }} ;
		{ Components = { { Level = 4 }  }} ;

	};

}

rpcomputer.helper = {};

function rpcomputer.helper.MessagePlayer( _p , text )
	
	_p:Notify( text )

end

function rpcomputer.helper.AddMoney( _p , money )

	return _p:addBank( money );

end

function rpcomputer.helper.GetName( _p )

	return _p:getRPName()

end

function rpcomputer.helper.GetMoney( _p )

	return _p:getBank()

end

local _pMeta = FindMetaTable( "Player" );

function _pMeta:SetupRPComputerData( )

	self.__Computer = rpcomputer.config.Prebuilts.basecomputer;
		
	if self:IsComputerOut() then

		self:GetComputerEntity():SetSpecifications( rpcomputer.config.Prebuilts.basecomputer )
		
	end
	
	if SERVER then
	
		UpdatePlayerComputer( self, self.__Computer )
		
	end
	
end

function _pMeta:GetRPComputer( )

	if !self.__Computer then return self:SetupRPComputerData() end
	
	return self.__Computer;	

end 

function _pMeta:AdjustComputerSpeed( int )

	int = math.max( int, 1.5 )
	
	net.Start( "AdjustComputerAnimationSpeed" )
		net.WriteDouble( int )
	net.Send( self )
	
end

/*
	basecomputer = {

		{ Components = { {Level = 1} }} ; // CPU 
		{ Components = { {Level = 1} }} ; // Graphics Card
		{ Components = { {Level = 1} }} ; // Ram
		{ Components = { {Level = 1} }} ; // Hard Drive

	};
*/
function _pMeta:SetRPComputer( _tbl )

	if !self.__Computer then self:SetupRPComputerData( ); end
	
	self.__Computer = _tbl;
		
	if self:IsComputerOut() then

		self:GetComputerEntity():SetSpecifications( _tbl )
		
	end
	
end 

function _pMeta:UpgradeRPComputer( componentType, index )

	if !rpcomputer.config.HardwareTypes[componentType] then return print( "Could not find hardware type " .. componentType ) end

	local _hardwareType = rpcomputer.config.HardwareTypes[componentType];
	
	local _playerComputer = self:GetRPComputer( );
	
	if !_playerComputer then return print( "Could not find player computer") end
	
	if _playerComputer == NULL then return Error("Tried to modify non existant computer") end;
	
	
	local ind = 1;
	
	if index then 
	
		ind = index;
	
	end
		
	if !_playerComputer[componentType].Components[ind] then
		
		_playerComputer[componentType].Components[ind] = { Level = 0 };
		
	end
	
	if _playerComputer[componentType].Components[ind].Level +1  > _hardwareType.MaxLevel then 
	
		return rpcomputer.helper.MessagePlayer( self , "You may not upgrade this computer past it's maximum level" ) 
		
	end
	
	local _nextLevel = _playerComputer[componentType].Components[ind].Level + 1;

	if !_hardwareType.Levels[ _nextLevel ] then
	
		return rpcomputer.helper.MessagePlayer( self, "This hardware upgrade level does not exist." )
		
	end
	
	local _playerMoney = rpcomputer.helper.GetMoney( self )
	
	local _requiredPayment = _nextLevel * _hardwareType.Price;
	
	if _playerMoney > _requiredPayment then
	
		rpcomputer.helper.AddMoney( self , -_requiredPayment )
		
	else
	
		return rpcomputer.helper.MessagePlayer( self, "You do not have enough money to buy this upgrade" )
		
	end
	
	_playerComputer[componentType].Components[ind].Level = _nextLevel;
	
	
	self.__Computer = _playerComputer;
	
	if self:IsComputerOut() then

		self:GetComputerEntity():SetSpecifications( _playerComputer )
		
	end
		
	self:Notify( "Computer upgrade: " .. rpcomputer.config.HardwareTypes[componentType].Levels[_nextLevel].Name .. " (Lv. " .. _nextLevel .. ")has been purchased."  )
	
	if SERVER then
	
		UpdatePlayerComputer( self, _playerComputer )
		
	end
	
	self:SaveRPComputer( computer )
end 

function _pMeta:IsComputerOut( )

	return self:getFlag( "computerStatus", false )

end

function _pMeta:GetComputerEntity( )
	local _pEI =  self:getFlag( "computerEntityIndex" , 0 );
	
	if _pEI == 0 then return nil end;
	
	return ents.GetByIndex( _pEI )

end

function _pMeta:IsMonitorOut( )

	return self:getFlag( "monitorStatus", false )

end

function _pMeta:GetMonitorEntity( )
	local _pEI =  self:getFlag( "monitorEntityIndex" , 0 );
	
	if _pEI == 0 then return nil end;
	
	return ents.GetByIndex( _pEI )

end

function _pMeta:SetNewComputerComponent( componentType, index , level )

	local _hardwareType = rpcomputer.config.HardwareTypes[componentType];
	
	local lv = level || 1;
	
	local _playerComputer = self:GetRPComputer( );
	
	if !_playerComputer then return end
	
	if index > _hardwareType.Max then 
	
		return rpcomputer.helper.MessagePlayer( self , "You may not get more than #" .. _hardwareType.Max .. " " ..  _hardwareType.Name .. "'s." )

	end
	
	
	_playerComputer[componentType].Components[index] = { Level = lv };
	
	self.__Computer = _playerComputer;
	
	if self:IsComputerOut() then

		self:GetComputerEntity():SetSpecifications( _playerComputer )
		
	end
	
	if SERVER then
	
		UpdatePlayerComputer( self, _playerComputer )
		
	end
		
	self:SaveRPComputer( computer )
		
end

function _pMeta:RemoveRPComputer() 

	if self:IsComputerOut() then

		self:GetComputerEntity():SetSpecifications( {} )
		self:GetComputerEntity():Remove();
		
	end
	
	self.__Computer = {};
	
	if SERVER then
	
		UpdatePlayerComputer( self, self.__Computer )
		
	end

end 

if CLIENT then
	
	net.Receive( "networkClientComputer", function( _l , _p )
		
		local _steamID = net.ReadString( ) ;
		
		local _compData = net.ReadTable( );
		
		if !player.GetBySteamID( _steamID ) then return end
		
		player.GetBySteamID( _steamID ).__Computer = _compData;
			
				
	end )
	

else

	util.AddNetworkString( "networkClientComputer" )

	function UpdatePlayerComputer( _p , computer)
		
			
		net.Start( "networkClientComputer" )
			net.WriteString( _p:SteamID() )
			net.WriteTable( computer )
		net.Broadcast( )
		
	end
	
end