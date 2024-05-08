-- COPYRIGHT MODEL @FROMSOFTWARE DARKSOULS/GARRYS MOD; SCRIPT BY DARKWRAITH AND RAINCHU PLEASE CONTACT THEM (ON STEAM) FOR ANY BUGS/SUGGESTIONS FOR THE SCRIPT!
include("shared.lua" )
 
function ENT:Draw( )
	self:DestroyShadow()
	if LocalPlayer():GetPos():Distance( self:GetPos() ) < 1000 then
		self:DrawModel()
	end
end
