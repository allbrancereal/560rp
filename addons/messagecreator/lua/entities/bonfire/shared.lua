-- COPYRIGHT MODEL @FROMSOFTWARE DARKSOULS/GARRYS MOD; SCRIPT BY DARKWRAITH AND RAINCHU PLEASE CONTACT THEM (ON STEAM) FOR ANY BUGS/SUGGESTIONS FOR THE SCRIPT! 
ENT.Type                = "anim"
ENT.Base                = "base_anim"
ENT.PrintName           = "Bonfire"
ENT.Category            = "Dark Souls"
ENT.Author              = "Mario.S"
ENT.Purpose             = "Kindle the Bonfire"
ENT.Instructions        = "Use to Kindle the Bonfire, use again to teleport to others."
ENT.Spawnable 			= true  
ENT.AdminOnly 			= false
ENT.MaxBurnTime 		= 29
ENT.ParticleOne			= "fire_small_02"
ENT.ParticleTwo			= "embers_medium_03"
ENT.ParticleThree		= "burning_gib_01b"
ENT.Time = 0;
ENT.BonfireID = 0;

game.AddParticles("particles/dwdarksouls/fire_01.pcf")


local _time = 0;   
function ENT:Think()


	if CLIENT then
		if LocalPlayer():GetPos():Distance( self:GetPos() ) < 100 then
		if self.IsLit  then
			local light = DynamicLight(self:EntIndex())
			if light then
				local amountToAdd = self:LocalToWorld( Vector( 0, 0, 10 ) )
				light.Pos = amountToAdd
				light.r = 160
				light.g = 60
				light.b = 25
				light.Brightness = .01
				light.Size = 100
				light.DieTime = CurTime() + FrameTime()
				light.Style = 6
			end
		
		
			if CurTime() > self.Time then
			
			ParticleEffectAttach(self.ParticleOne, PATTACH_ABSORIGIN_FOLLOW, self, 0)
			ParticleEffectAttach(self.ParticleTwo, PATTACH_ABSORIGIN_FOLLOW, self, 0)
			ParticleEffectAttach(self.ParticleThree, PATTACH_ABSORIGIN_FOLLOW, self, 0)
				self.Time = CurTime() + 15
			end
			--ParticleEffect( self.ParticleTwo, Vector position, Angle angles, Entity parent )
			--ParticleEffect( self.ParticleThree, Vector position, Angle angles, Entity parent )
		else
			self:StopParticles() 
		end
		end
	end
end	   

function ENT:LightUp( bool )

	self.IsLit = bool

end


function ENT:SpawnFunction( ply, tr )
	if not tr.Hit then return end

	local spawnpos = tr.HitPos + tr.HitNormal * 16

	local ent = ents.Create( "bonfire" )
	ent:SetPos( spawnpos )
	ent:Spawn()
	return ent
end
 
function ENT:Initialize()
	if SERVER then
		self:SetUseType( SIMPLE_USE )
		self:SetModel( "models/dwdarksouls/bonfireblend.mdl" )
		self:SetMoveType( MOVETYPE_NONE )
		self:SetSolid( SOLID_VPHYSICS )
	end
   self.BonfireID = 0;
   
   
   
	if !_P1 && !_P2 && !_P3 then

		_P1 = PrecacheParticleSystem(self.ParticleOne)
		_P2 = PrecacheParticleSystem(self.ParticleTwo)
		_P3 = PrecacheParticleSystem(self.ParticleThree)

	end

	self:SetCollisionGroup( COLLISION_GROUP_NONE )
end
 
 
BonfireTaxis = BonfireTaxis || {};
BonfireTaxis.Cache = BonfireTaxis.Cache || {};

BonfireTaxis.Config = {
	["rp_downtown_tits_v2"] = {

		{ ID = 1, name = "Suburbs Apartments", pos = Vector(-1344.546 , -8002.758 , -195.969), mat = Material( "rp_downtown_v4c_v2/bonfires/suburbs.jpg") };
		{ ID = 2, name = "Ghetto Park", pos = Vector(5639.171 , 1135.317 , -200.336 ), mat = Material( "rp_downtown_v4c_v2/bonfires/ghettopark.jpg" )};
		{ ID = 3,name = "Downtown", pos =  Vector(-443.465 , 302.17 , -195.969 ), mat = Material( "rp_downtown_v4c_v2/bonfires/downtown.jpg" )};
		{ ID = 4,name = "Fountain", pos = Vector(-1916.722 , -1738.147 , -195.969 ), mat = Material( "rp_downtown_v4c_v2/bonfires/fountain.jpg" )};
		{ ID = 5,name = "Outskirts", pos = Vector(-3628.042 , 3969.282 , -203.969 ), mat = Material( "rp_downtown_v4c_v2/bonfires/outskirt.jpg" )};

	}
}

function ENT:SetBonfireID( id )

	self.BonfireID = id;
	
	if SERVER then
	
		net.Start("updateClientBonfireIDs")
			net.WriteInt( id, 8 )
			net.WriteInt( self:EntIndex() ,32 )
		net.Broadcast()
		
	end
	
end

if SERVER then
	util.AddNetworkString("updateClientBonfireIDs")
	util.AddNetworkString("GetWhiteScreen")
	util.AddNetworkString("sendReadyTP")
	
	function sendPlayerWhiteScreen( _p )
		
		net.Start("GetWhiteScreen")
		net.Send( _p )
	
	end
	
	net.Receive( "getTeleportCall" , function( _l , _p )
		
		local _id = net.ReadInt( 8 )
		local _index = -1
		for k , v in pairs( ents.FindByClass( "bonfire" ) ) do
		
			if v:getFlag("bonfireID" , 0 ) == _id then
			
				_index = v:EntIndex()
			
			end
			
		end
		
		if _index == -1 then return end 
		_p:setFlag("teleportDestinationID", _index ) 
		_p:setFlag("shouldTeleport", true )
		_p:HasCooldown("BonfireTeleport", 300)
		sendPlayerWhiteScreen( _p )
	end )
	
	net.Receive( "sendReadyTP", function( _l , _p )
		local _destination = _p:getFlag("teleportDestinationID", 0 );
		
		if _p:getFlag("shouldTeleport", true) && _destination != 0 then
			
			entityGoto( _p , ents.GetByIndex( _destination ) );
			timer.Simple(2, function()
			
				_p:setFlag("shouldTeleport", false) 
			
			end )
		end		
	
	end )
	
else
	net.Receive("updateClientBonfireIDs", function( _l , _p )
	
		local _id = net.ReadInt(8)
		local _ind = net.ReadInt(32)
		
		ents.GetByIndex( 32 ):SetBonfireID( _id );
	
	end )
	
end
function GenerateBonfiresFromTable()

	if CLIENT then return end
	
	if !BonfireTaxis.Config [game.GetMap()] then return end
	
		
	if #BonfireTaxis.Cache  > 1 then
	
		for k , v in pairs( BonfireTaxis.Cache  ) do 
	 
			if IsValid(ents.GetByIndex(v)) then 
		
				ents.GetByIndex(v):Remove() 
		
			
		
			end
	
		end
	
	end
	for k , v in pairs( ents.FindByClass("bonfire") ) do v:Remove() end
	
	BonfireTaxis.Cache  = {};
	if SERVER then
	local index = 0;
	for k , v in pairs( BonfireTaxis.Config[game.GetMap()] ) do
		index = index+1;
		if v.nospawn then return end
		local _ent = ents.Create("bonfire")
		_ent:SetPos( v.pos );
		_ent:SetAngles( Angle( 0 , math.random( -180, 180 ) , 0 ) )
		_ent.BonfireID = index 
		_ent:setFlag("bonfireID", index )
		_ent:Spawn()
		table.insert( BonfireTaxis.Cache , _ent:EntIndex() );
		
	end
	
	
		updateClientBonfireTaxis()
	end
	
end

function updateClientBonfireTaxis( )

	net.Start("sendBonfireTaxisToClient")
		net.WriteTable( BonfireTaxis.Cache  )
	net.Broadcast()
	
	
	
end

if CLIENT then

	net.Receive("sendBonfireTaxisToClient", function( _l , _p ) 
		if !BonfireTaxis then
			BonfireTaxis = {};
			BonfireTaxis.Cache  = {};
		end
		BonfireTaxis.Cache  = net.ReadTable()
	
	end )

else

	util.AddNetworkString("sendBonfireTaxisToClient")
	
end

hook.Add("PlayerFullyConnected", "SendPlayerBones", function( ply, clientside )
	
	if !clientside then
	
		updateClientBonfireTaxis( ply ) 
		retrieveSigns( 50 )
		
	end
	
	if !clientside && #player.GetAll() == 1 then
	
		GenerateBonfiresFromTable()
		
	end


end )