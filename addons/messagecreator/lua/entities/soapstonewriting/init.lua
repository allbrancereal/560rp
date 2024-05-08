-- COPYRIGHT MODEL @FROMSOFTWARE DARKSOULS/GARRYS MOD; SCRIPT BY DARKWRAITH AND RAINCHU PLEASE CONTACT THEM (ON STEAM) FOR ANY BUGS/SUGGESTIONS FOR THE SCRIPT!
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include("shared.lua" )

util.AddNetworkString("sendSoapStoneInformation")

function ENT:Use( ply )
	ply.NextUse = ply.NextUse || 0;
		
		
	if ply.NextUse < CurTime() then
	
		ply.NextUse = CurTime() + 3;
			
		net.Start("sendSoapStoneInformation")
			net.WriteInt( self:EntIndex() , 20 )
			net.WriteTable( self.PublicInfo )
		net.Send( ply )
		
		
	end
	
end

// Incase we spawn it in sandbox.
function ENT:OnRemove()

end

