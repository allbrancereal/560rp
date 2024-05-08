include("shared.lua")

function ENT:Initialize ()

end

function ENT:Think()   
	
end   

function ENT:Draw()

    local owner = self.Owner//player.GetBySteamID(self.Entity:getFlag( "hatOwner", "" ))

	local IDCheck = ITEMLIST[self.Entity:getFlag("hatID", 1)]
	if !self || !IsValid(owner) then return end
	if !owner:getFlag("HatEquiped", false ) then return false end
	
	if IDCheck && IDCheck.Hat then
			
	
    if LocalPlayer() == owner and !LocalPlayer():InVehicle() && !IsInThirdperson() then   
	   
	   return false
    
	elseif LocalPlayer():InVehicle() and LocalPlayer() == owner and LocalPlayer():GetVehicle():GetThirdPersonMode() != true then
		
		return false
	
	else
		
		if IsValid(owner:GetRagdollEntity()) then
		
			owner = owner:GetRagdollEntity()
			
		elseif not owner:Alive() then 

			self.Entity:SetNoDraw( true ) 

		end
 
		local boneindex = owner:LookupBone("ValveBiped.Bip01_Head1") || owner:LookupBone("ValveBiped.Bip01_Neck")
		
		if boneindex then
		
			local pos, ang = owner:GetBonePosition(boneindex)
			
			if pos and pos ~= owner:GetPos() then		
			
					local ID = ITEMLIST[self.Entity:getFlag("hatID", 1)]
					
					if ID then						
						
						local newPos = pos + LocalPlayer():getFlag("hatXYZ", Vector(0,0,0) ) + ang:Forward()*ID.Forward + ang:Right()*ID.Right
						
						
						self.Entity:SetPos(newPos)
			
						ang:RotateAroundAxis(ang:Right(),-90)
						ang:RotateAroundAxis(ang:Up(),270)
						//owner:Notify("drawing")
						if ID.AnglesAdjust then
						
							Angles = ang + ID.AnglesAdjust;
						
						else
						
							Angles = ang;
							
						end
						//local _EyeAngAdjust = Angle( math.Clamp(EyeAngles().p, -10,10 ) ,0 , 0 )
						Angles = Angles + LocalPlayer():getFlag("hatPYR", Angle(0,0,0) )// + _EyeAngAdjust;
						
						self.Entity:SetAngles(Angles)
						if LocalPlayer() == owner && LocalPlayer():KeyDown(IN_WALK) then return end
							
						self.Entity:DrawModel()
							
							
				
					return
				
				end	
					
			end
			
		end

		end
		
	end
	
end