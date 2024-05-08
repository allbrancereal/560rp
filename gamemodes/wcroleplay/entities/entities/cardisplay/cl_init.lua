
include('shared.lua')

function ENT:Draw()

	if  LocalPlayer():GetPos():Distance( self:GetPos() ) < 2000 then
	
		//self:DrawModel()
		
		self:DrawModel()
		
		if self:getFlag("shouldSpin", false ) == true  then
		
			self:DestroyShadow(  )
		
			self:SetAngles( self:GetAngles() + Angle(0,self:getFlag("spinDirection" , 0) ,0) )
		
		end
	
	end
	
end
ENT.DrawTranslucent = ENT.Draw