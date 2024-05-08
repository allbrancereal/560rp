
include('shared.lua')

function ENT:Draw()
		self:DestroyShadow(  )

	if LocalPlayer():GetPos():Distance(self:GetPos()) <= 2800 &&  LocalPlayer():getFlag("InVCustomization", false) == true then
		
		self:DrawModel()
	
		
		if self:getFlag("shouldSpin", false ) != false then
		
			self:SetAngles( self:GetAngles() + Angle(0,self:getFlag("spinDirection" , .1) ,0) )
		
		end
	
	end

end
function ENT:DrawTranslucent()

	if LocalPlayer():GetPos():Distance(self:GetPos()) > 2800 then
	
		self:DrawModel()
		
		self:DestroyShadow(  )
		
	end

end