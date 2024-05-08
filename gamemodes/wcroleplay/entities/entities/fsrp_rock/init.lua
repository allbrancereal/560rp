


AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')


function ENT:Initialize()
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_NONE )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:SetUseType( SIMPLE_USE )
	self.Entity:SetRenderMode( RENDERMODE_TRANSALPHA )
	self.Entity:SetCollisionGroup( COLLISION_GROUP_INTERACTIVE )
	
	self.Entity:GetPhysicsObject():Wake();
	self:SetRockType( "iron" )
	
end

local _eMeta = FindMetaTable("Entity")
function _eMeta:SetRockType( dominanttype )

	self:setFlag( "mining_rockType", dominanttype );

end

function _eMeta:GetRocktype()

	return self:getFlag("mining_rockType", "");

end