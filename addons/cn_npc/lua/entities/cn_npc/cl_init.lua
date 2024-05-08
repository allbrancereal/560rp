--[[
	Chessnut's NPC System
	Do not re-distribute without author's permission.

	Revision f59168a397dba8e36c56a2b029ce5f6b2e7545853cd1e8cd533b97d1aa2b08c2
--]]

include("shared.lua")

ENT.AutomaticFrameAdvance = true

function ENT:Initialize()
	timer.Simple(IsValid(LocalPlayer()) and 1 or 5, function()
		if (IsValid(self)) then
            self:setAnim()

			local uniqueID = self:GetQuest()

			if (uniqueID and cnQuests[uniqueID]) then
				self.GetPlayerColor = function()
					return cnQuests[uniqueID].color
				end
			end
		end
	end)
end

function ENT:createBubble()
	self.bubble = ClientsideModel("models/extras/info_speech.mdl", RENDERGROUP_OPAQUE)
	self.bubble:SetPos(self:GetPos() + Vector(0, 0, 84))
	self.bubble:SetModelScale(0.6, 0)
	
end

function ENT:Draw()
	local realTime = RealTime()

	self:FrameAdvance(realTime - (self.lastTick or realTime))
	self.lastTick = realTime
	
	local bubble = self.bubble
	
	if (IsValid(bubble)) then
		local realTime = RealTime()

		bubble:SetRenderOrigin(self:GetPos() + Vector(0, 0, 84 + math.sin(realTime * 3) * 0.75))
		bubble:SetRenderAngles(Angle(0, realTime * 100, 0))
	end
		if  bubble and IsValid(bubble) && IsValid(LocalPlayer()) && bubble:GetPos():Distance(LocalPlayer():GetPos()) > 450 then
		
			bubble:SetNoDraw(false)
		else
			if bubble and IsValid(bubble) then
				bubble:SetNoDraw(true)
			end
		end
		local extra = Vector( 0, 0, 80 )
		local anglee = self:GetAngles()
		local positionn = self:GetPos() + extra
		anglee:RotateAroundAxis( anglee:Up(), 90 )
	 
			local shootPos = LocalPlayer():GetShootPos();
			local dist = self:GetPos():Distance(LocalPlayer():GetPos());
			
			if (dist <= 450) then
				local trace = {}
				trace.start = shootPos;
				trace.endpos = self:GetPos();
				trace.filter = {LocalPlayer(), v};
				
				if (LocalPlayer():InVehicle()) then table.insert(trace.filter, LocalPlayer():GetVehicle()); end
				
				local tr = util.TraceLine( trace ) 
				
					local alpha3 = 255;
					
					if (dist >= 300) then
						local moreDist = 450 - dist;
						local percOff = moreDist / (450 - 300);
						
						alpha3 = 255 * percOff;
					end
								
					local ang = LocalPlayer():EyeAngles()
					ang:RotateAroundAxis(ang:Forward(),90)
					ang:RotateAroundAxis(ang:Right(),90)
					if cnQuests[self:GetQuest()] then
						cam.Start3D2D( positionn,  Angle(0,ang.y,ang.r), 0.4 )
							draw.SimpleText( cnQuests[self:GetQuest()].name, "Trebuchet5", 0, 0, Color( 255, 255, 255, alpha3 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
						cam.End3D2D()
					end			
				
			
		end
	if cnQuests[self:GetQuest()] and !cnQuests[self:GetQuest()].Invisible then
		self:DrawModel()
	else
		self:DestroyShadow();
	end
end

function ENT:Think()
	if (!IsValid(self.bubble)) then
		self:createBubble()
	end

	if ((self.nextAnimCheck or 0) < CurTime()) then
		self:setAnim()
		self.nextAnimCheck = CurTime() + 60
	end

	self:SetNextClientThink(CurTime() + 0.25)

	return true
end

function ENT:OnRemove()
	if (IsValid(self.bubble)) then
		self.bubble:Remove()
	end
end