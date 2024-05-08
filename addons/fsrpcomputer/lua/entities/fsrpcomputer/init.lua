
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include("shared.lua" )
ENT.LastAction = 0;

function ENT:ToggleOn()

	local _isOn = self:getFlag("computerStatus", false );
	
	
	
	if !_isOn then
						
		sound.Play( "ambient/machines/thumper_startup1.wav", self:GetPos() , 100 )
	
		return self:setFlag("computerStatus", true );	
	
	else
	
		for k , v in pairs( self.PlayersInUse ) do
			
			local _player = player.GetBySteamID( k )
				
			if _player then
			
				net.Start("sendDesktopClose")
				net.Send( _player ) 				
				
			end
				
			self.PlayersInUse[k] = nil
				
		end
		
		sound.Play( "vehicles/APC/apc_shutdown.wav", self:GetPos(), 100 )
		
		return self:setFlag("computerStatus", false)
	
	end
	
end

/*
ENT.Specifications		= {
	{ Components = { { Level = 1 } }} ; // cpu ,2
	{ Components = { { Level = 1 } }} ; // gpu ,4
	{ Components = { { Level = 1 } }} ; // ram,8
	{ Components = { { Level = 1 } }} ; // hdd,4
}
*/
local _baseSpeedTable = {
	2,
	1.25,
	1,
	0.6
}
local _eMeta = FindMetaTable( 'Entity' )
function _eMeta:GetComputerSpeed( )
	if self:GetClass() != "fsrpcomputer" then return end
	local _ComputerSpecs = rpcomputer.config.Prebuilts["basecomputer"]//self:getFlag("computerSpecifications", {} ) ;
	local _speed = 0;
	local i = 1;
	
	for k , v in pairs( _ComputerSpecs ) do
	
		for x , y in pairs( _ComputerSpecs[i].Components ) do
			
			_speed = _speed + ( y.Level * _baseSpeedTable[k] )
			
		end
		
		_speed = _speed + #v.Components * _baseSpeedTable[k] ;
		
		i = i + 1;
		
	end 
	
	_speed = _speed * 0.5;
	_ownedby = self:getFlag("ownedBy", "")
	_owner = player.GetBySteamID(_ownedby);
	if _owner then
		_hasCountdown = _owner:HasCooldown("BitcoinBoost");
		if _hasCountdown == true then
			_speed =_speed*2
		end 
		if _owner:HasOrgBoost() == true then
			_speed =_speed*2			
		end
	end
	return _speed;
end

hook.Add( "PlayerDeath" , "disableComputerOnDeath", function( vic , inf , attacker  )

	for k , v in pairs( ents.FindByClass("fsrpcomputer") ) do
	
		if v.PlayersInUse[vic:SteamID()] then
		
			local _player = player.GetBySteamID( vic:SteamID() )
				
			if _player then
			
				net.Start("sendDesktopClose")
				net.Send( _player ) 	
				
				if _player:GetComputerEntity() && _player:GetComputerEntity().PlayersInUse[vic:SteamID()] then
				
					_player:GetComputerEntity().PlayersInUse[vic:SteamID()] = nil			
				
				end
				
			end		
		
		end
		
	end

end )

function _eMeta:SetSpecifications( tbl )
	self.Specifications = tbl;
	
	self:setFlag("computerSpecifications", tbl );
		
end 
function ENT:Use( ply )		

	local _entToFind = "fsrpmonitor";
	local _isEntBesideUs = false;
	local _ent;
	//if !player.GetBySteamID( self:getFlag("ownedBy", "") ) then self:Remove() end
	if #self.PlayersInUse > 0 then return ply:Notify( "Someone is already accessing this computer" ) end
	if player.GetBySteamID( self:getFlag("ownedBy","") ) then
	
		self:SetSpecifications( player.GetBySteamID( self:getFlag("ownedBy", "") ):GetRPComputer() ) 
	
	end
	
	if ply:KeyDown( IN_WALK ) then
		if self:getFlag("ownedBy", "") != ply:SteamID() then return end
		
		ply:EmitSound("items/ammocrate_open.wav")
		ply:AddItemByID( 79 );
		ply:setFlag("computerStatus", false)
		ply:setFlag("computerEntityIndex",nil)
		
		self:setFlag( "miningProgress", nil)
		self:setFlag( "minedCoins" , nil )
		self:Remove()
		
		return 
	end
	
	if self.LastAction > CurTime() then return end
	
	self.LastAction = CurTime() + 2
		
	for k , v in pairs( ents.FindInSphere( self:GetPos() , 100 ) ) do
	
		if v:GetClass() == _entToFind && v:getFlag("ownedBy","") == self:getFlag("ownedBy","")  then
		
			_isEntBesideUs = true;
			
			ent = v;
			
			break;
			
		end
		
	end
	
	//ply:Notify( self:GetComputerSpeed() )
	net.Start("fsrpRPComputerSelection")
		net.WriteBool( _isEntBesideUs ) // if we have required entity we would go for the use
		net.WriteBool( false ) // is monitor?
		net.WriteInt( self:EntIndex() ,16 )
		
		if _isEntBesideUs then
		
			net.WriteInt( ent:EntIndex() , 16 )
	
		end
		
	net.Send( ply )
	
end

local interval = 0.25
util.AddNetworkString( "claimMinedCoins" )

net.Receive( "claimMinedCoins" , function( _l, _p )

	if !_p:IsComputerOut() then return end
	if !_p:GetComputerEntity() then return end
	
	local _computer = _p:GetComputerEntity()
	
	local _coinsMined = _computer:getFlag("minedCoins", 0 );

	/*
	if tonumber(os.date( "%H" , os.time() )) >= 21 && tonumber(os.date( "%H" , os.time() ))  < 22 then
			
		_coinsMined = _coinsMined * 2;
		_p:ChatPrint("You have received double the coin value because it's bonus hour!")

	else

		_p:ChatPrint("Bonus hour is at 9PM it's " .. os.date( "%r" , os.time() ) .. " Server Time.")

	end
	*/

	local _org = _p:getFlag("organization",0);
	local _memberAmount = 0;

	for k , v in pairs( player.GetAll() ) do
		
		if v:getFlag("organization",0) == _org then
			
			_memberAmount = _memberAmount+1;

		end

	end

	local _OrgBonus = _memberAmount >5 && true || false;

	if _OrgBonus then
		_coinsMined = _coinsMined*1.25;
	end
	
	if _coinsMined <= 0 then return end
	
	_p:addBank( _coinsMined * rpcomputer.config.coinvalue )
	_p:Notify( "You have received $" .. _coinsMined * rpcomputer.config.coinvalue .. " from selling " .. _coinsMined .. " coins." )
	
	_computer:setFlag("minedCoins", 0 )
	
	
end )

function ENT:Think()

	--if self:getFlag("computerStatus", false ) == true then
		

		if self.timer < CurTime() then
			
			self.timer = CurTime() + interval

			self:setFlag("miningProgress", (self:getFlag("miningProgress", 0) + self:GetComputerSpeed()  ) )

		end

		if self:getFlag( "miningProgress" ,0) > 100 then

				self:setFlag( "miningProgress", 0)
				self:setFlag( "minedCoins" , (self:getFlag( "minedCoins", 0) + 1) )



		end 

	--end
	
	if self:WaterLevel() > 0 then

		self:Remove()
		
		local explode = ents.Create( "env_explosion" )
		explode:SetPos( self:GetPos())
		explode:Spawn() 
		explode:SetKeyValue( "iMagnitude", tostring(bitconfig.exploisionSize) )
		explode:Fire( "Explode", 1, 0 )
		explode:EmitSound( "weapon_AWP.Single", 400, 400 ) 


		for k , v in pairs( self.PlayersInUse ) do
			
			local _player = player.GetBySteamID( k )
				
			if _player then
			
				net.Start("sendDesktopClose")
				net.Send( _player ) 				
				
			end
				
			self.PlayersInUse[k] = nil
				
		end
		

	end

end

function ENT:OnTakeDamage(damage )

	self.health = self.health - damage:GetDamage()

	if self.health <= 0 then
		
		self:Remove()
		explodePos = self:GetPos()

		timer.Simple(0.1 , function()

			local explode = ents.Create( "env_explosion" )
			explode:SetPos( explodePos)
			explode:Spawn() 
			explode:SetKeyValue( "iMagnitude", tostring(3) )
			explode:Fire( "Explode", 1, 0 )
			explode:EmitSound( "weapon_AWP.Single", 400, 400 ) 

			end)

	end

end

// Incase we spawn it in sandbox.
function ENT:OnRemove()
end

