
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include("shared.lua" )

ENT.LastAction = 0;


function ENT:ToggleOn()

	local _isOn = self:getFlag("monitorStatus", false );
		
	if !_isOn then
						
		self:EmitSound( "buttons/blip1.wav", 100 )
	
		return self:setFlag("monitorStatus", true );	
	
	else
		
		self:EmitSound( "buttons/combine_button7.wav" , 100 )
		
		return self:setFlag("monitorStatus", false)
	
	end
	
end

function ENT:Use( ply )		

	local _entToFind = "fsrpcomputer";
	local _isEntBesideUs = false;
	local _ent;
	
	if ply:KeyDown( IN_WALK ) then
		if self:getFlag("ownedBy", "") != ply:SteamID() then return end
		
		ply:EmitSound("items/ammocrate_open.wav")
		ply:AddItemByID( 137 );
		ply:setFlag("monitorStatus", false)
		ply:setFlag("monitorEntityIndex",nil)
		
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
	
	if ent and player.GetBySteamID( ent:getFlag("ownedBy", "") ) then 
	
		//ent:SetSpecifications( player.GetBySteamID( ent:getFlag("ownedBy", "") ):GetRPComputer() ) 
	
	end
	
	net.Start("fsrpRPComputerSelection")
		net.WriteBool( _isEntBesideUs ) // if we have required entity we would go for the use
		net.WriteBool( true )
		net.WriteInt( self:EntIndex() ,16 )
		
		if _isEntBesideUs then
		
			net.WriteInt( ent:EntIndex() , 16 )
	
		end
		
	net.Send( ply )
	
end

// Incase we spawn it in sandbox.
function ENT:OnRemove()
end

