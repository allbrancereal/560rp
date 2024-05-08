AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

function ENT:Initialize()
	self.Entity:SetModel( "models/props_c17/FurnitureShelf001b.mdl" )
	self.Entity:DrawShadow( false )
	self.Entity:SetColor( 0,0,0,255 )
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:SetUseType( SIMPLE_USE )
	
	self.Entity:GetPhysicsObject():Wake();
	self:setFlag( 'sign_text' , "Press E to Change me!" )
end

util.AddNetworkString( "signEditor" )
util.AddNetworkString( "sendSignText" )

net.Receive( "sendSignText", function( _l,  _p )

	local _index = net.ReadInt( 12 )
	local _string = net.ReadString( )

	local _entity = ents.GetByIndex( _index ) 

	if _p:GetPos():Distance(_entity:GetPos()) > 500 then
		return _p:Notify("Please move closer to the sign to edit it!")
	end
	_entity:ChangeSignText( _string );

end )

function ENT:ChangeSignText( String )

	self:setFlag( "sign_text" , String );

end

function ENT:Use( activator, caller )
	if !activator:IsPlayer() then return false; end
	/*if activator:KeyDown(IN_WALK) then
	
		activator:GiveItem(115, 1, true);
	
		self:Remove();	
	else*/
	
	if activator:SteamID() != self:getFlag( "ownedBy" ,"" )  then return; end
		
	if activator:KeyDown(IN_WALK) then 
		activator:AddItemByID( 111 )
		self:Remove()
		return
		
	end
	    net.Start( "signEditor" ); 
			net.WriteInt( self:EntIndex( ), 12 );
    	net.Send( activator );	
	//end	
end



