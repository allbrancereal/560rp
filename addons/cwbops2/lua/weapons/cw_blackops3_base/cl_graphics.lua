local Ang0 = Angle(0, 0, 0)

local FT, CT, cos1, cos2, ws, vel, att, ang
local Ang0, curang, curviewbob = Angle(0, 0, 0), Angle(0, 0, 0), Angle(0, 0, 0)
local reg = debug.getregistry()
local GetVelocity = reg.Entity.GetVelocity
local Length = reg.Vector.Length
local Right = reg.Angle.Right
local Up = reg.Angle.Up
local Forward = reg.Angle.Forward
local RotateAroundAxis = reg.Angle.RotateAroundAxis
local GetBonePosition = reg.Entity.GetBonePosition

local ManipulateBonePosition, ManipulateBoneAngles = reg.Entity.ManipulateBonePosition, reg.Entity.ManipulateBoneAngles

//WM
function SWEP:drawAttachmentsWM()
	if not self.AttachmentModelsWM then
		return false
	end
	
	for k, v in pairs(self.AttachmentModelsWM) do
		if v.active and v.ent then
			model = v.ent
			wm = self.WMEnt
			m = wm:GetBoneMatrix(wm:LookupBone(v.bone))
			pos = m:GetTranslation()
			ang = m:GetAngles()
			
			model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z)
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)

			model:SetAngles(ang)
			
			model:DrawModel()
		end
	end
	
	for k, v in pairs(self.elementRenderWM) do
		v(self)
	end
	
	return true
end

function SWEP:setupAttachmentModelsWM()
	-- who would like to leave the model argument empty...at least i won't
	
	if self.AttachmentModelsWM then
		for k, data in pairs(self.AttachmentModelsWM) do
			data.origPos = data.pos
			data.origAng = data.angle
			
			data.ent = self:createManagedCModel(data.model, RENDERGROUP_BOTH)
			data.ent:SetNoDraw(true)
			
			data.active = data.active or false
			
			if data.size then
				data.matrix = Matrix()
				
				data.matrix:Scale(data.size)
				data.ent:EnableMatrix("RenderMultiply", data.matrix)
			end
			
			if data.bodygroups then
				for main, sec in pairs(data.bodygroups) do
					data.ent:SetBodygroup(main, sec)
				end
			end
			
			data.ent:SetupBones()
		end
	end
end

function SWEP:DrawWorldModel()
	if self.dt.Safe then
		if self.CHoldType != self.RunHoldType then
			self:SetHoldType(self.RunHoldType)
			self.CHoldType = self.RunHoldType
		end
	else
		if self.dt.State == CW_RUNNING or self.dt.State == CW_ACTION then
			if self.CHoldType != self.RunHoldType then
				self:SetHoldType(self.RunHoldType)
				self.CHoldType = self.RunHoldType
			end
		else
			if self.CHoldType != self.NormalHoldType then
				self:SetHoldType(self.NormalHoldType)
				self.CHoldType = self.NormalHoldType
			end
		end
	end
				
	if self.DrawTraditionalWorldModel then
		self:DrawModel()
	else
		wm = self.WMEnt
		
		if IsValid(wm) then
			if IsValid(self.Owner) then
				pos, ang = GetBonePosition(self.Owner, self.Owner:LookupBone("ValveBiped.Bip01_R_Hand"))
				
				if pos and ang then
					RotateAroundAxis(ang, Right(ang), self.WMAng[1])
					RotateAroundAxis(ang, Up(ang), self.WMAng[2])
					RotateAroundAxis(ang, Forward(ang), self.WMAng[3])

					pos = pos + self.WMPos[1] * Right(ang) 
					pos = pos + self.WMPos[2] * Forward(ang)
					pos = pos + self.WMPos[3] * Up(ang)
					
					wm:SetRenderOrigin(pos)
					wm:SetRenderAngles(ang)
					wm:DrawModel()
				end
			else
				wm:SetRenderOrigin(self:GetPos())
				wm:SetRenderAngles(self:GetAngles())
				wm:DrawModel()
				wm:DrawShadow()
			end
			self:drawAttachmentsWM()
		else
			self:DrawModel()
		end
	end
end

//VM
function SWEP:buildBoneTable()
	local vm = self.CW_VM
	
	for i = 0, vm:GetBoneCount() - 1 do
		local boneName = vm:GetBoneName(i)
		local bone
		
		if boneName then
			bone = vm:LookupBone(boneName)
		end
		
		-- from the kk ins2 sweps
		-- save the bone indexes and bone names so that we don't have to get it again when we're offsetting them
		self.vmBones[i + 1] = {boneName = boneName, bone = i, curPos = Vector(0, 0, 0), curAng = Angle(0, 0, 0), targetPos = Vector(0, 0, 0), targetAng = Angle(0, 0, 0)}
	end
end

function SWEP:drawAttachments()
	if not self.AttachmentModelsVM then
		return false
	end
	
	local FT = FrameTime()
	
	for k, data in pairs(self.AttachmentModelsVM) do
		if data.active and data.ent then
			local model = data.ent
			local vm = self.CW_VM
			local pos, ang
			
			if data.bone_merge then
				pos = vm:GetPos()
				ang = vm:GetAngles()
			elseif data._bone then
				pos, ang = self:getBoneOrientation(data._bone)
			end
			
			model:SetPos(pos + ang:Forward() * data.pos.x + ang:Right() * data.pos.y + ang:Up() * data.pos.z)
			ang:RotateAroundAxis(ang:Up(), data.angle.y)
			ang:RotateAroundAxis(ang:Right(), data.angle.p)
			ang:RotateAroundAxis(ang:Forward(), data.angle.r)

			model:SetAngles(ang)
			
			if data.animated then
				model:FrameAdvance(FrameTime())
				model:SetupBones()
			end
			
			model:DrawModel()
		end
	end
	
	for k, v in pairs(self.elementRender) do
		v(self)
	end
	
	return true
end

function SWEP:setupAttachmentModels()
	if self.AttachmentModelsVM then
		for k, data in pairs(self.AttachmentModelsVM) do
			data.origPos = data.pos
			data.origAng = data.angle
			
			data.ent = self:createManagedCModel(data.model, RENDERGROUP_BOTH)
			data.ent:SetNoDraw(true)
			
			data.active = data.active or false
			
			if data.size then
				data.matrix = Matrix()
				
				data.matrix:Scale(data.size)
				data.ent:EnableMatrix("RenderMultiply", data.matrix)
			end
			
			if data.bone_merge then
				data.ent:SetParent(self.CW_VM)
				data.ent:AddEffects(EF_BONEMERGE)
			end
			
			if data.bone then
				data._bone = self.CW_VM:LookupBone(data.bone)
			end
			
			if data.bodygroups then
				for main, sec in pairs(data.bodygroups) do
					data.ent:SetBodygroup(main, sec)
				end
			end
			
			data.ent:SetupBones()
		end
	end
end

//CalcView
function SWEP:CalcView(ply, pos, ang, fov)
	self.freeAimOn = self:isFreeAimOn()
	self.autoCenterFreeAim = GetConVarNumber("cw_freeaim_autocenter") > 0
	
	if self.dt.BipodDeployed then
		if not self.forceFreeAimOffTime then
			self.forceFreeAimOffTime = CurTime() + 0.5
		end
	else
		self.forceFreeAimOffTime = false
	end
		
	if self.freeAimOn then
		fov = 90 -- force FOV to 90 when in free aim mode, unfortunately, due to angles getting fucked up when FOV is not 90
		RunConsoleCommand("fov_desired", 90)
	end
	
	-- if we have free aim on, and we are not using a bipod, or we're using a bipod and we have not run out of "free aim time", then we should simulate free aim
	if self.freeAimOn and (not self.forceFreeAimOffTime or CurTime() < self.forceFreeAimOffTime) then
		local aiming = self.dt.State == CW_AIMING
		
		if self.shouldUpdateAngles then
			self.lastEyeAngle = self.Owner:EyeAngles()
			self.shouldUpdateAngles = false
		else
			local dot = math.Clamp(math.abs(self:getFreeAimDotToCenter()) + 0.3, 0.3, 1)
			
			local lazyAim = GetConVarNumber("cw_freeaim_lazyaim")
			self.lastEyeAngle.y = math.NormalizeAngle(self.lastEyeAngle.y - self.mouseX * lazyAim * dot)
			
			if not aiming and CurTime() > self.lastShotTime then -- we only want to modify pitch if we haven't shot lately
				self.lastEyeAngle.p = math.Clamp(self.lastEyeAngle.p + self.mouseY * lazyAim * dot, -89, 89)
			end
		end
		
		if self.autoCenterFreeAim then
			if self.mouseActive then
				self.lastMouseActivity = CurTime() + GetConVarNumber("cw_freeaim_autocenter_time")
			end
			
			local canAutoCenter = CurTime() > self.lastMouseActivity 
			local shouldAutoCenter = false
			local aimAutoCenter = GetConVarNumber("cw_freeaim_autocenter_aim") > 0
			
			if aiming then
				canAutoCenter = true
				shouldAutoCenter = true
			end
		
			if self.autoCenterExclusions[self.dt.State] then
				canAutoCenter = true
				shouldAutoCenter = true
			end
			
			if self.forceFreeAimOffTime then -- if we're being forced to turn free-aim off, do so
				canAutoCenter = true
				shouldAutoCenter = true
			end
		
			if canAutoCenter then
				local frameTime = FrameTime()
				
				self.freeAimAutoCenterSpeed = frameTime * 16
				
				if aiming then
					self.freeAimAutoCenterSpeed = frameTime * 25 --math.Approach(self.freeAimAutoCenterSpeed, frameTime * 40, frameTime * 6)
				end
				
				if self.autoCenterExclusions[self.dt.State] then
					shouldAutoCenter = true
				else
					if CurTime() > self.lastMouseActivity then
						shouldAutoCenter = true
						self.freeAimAutoCenterSpeed = frameTime * 6 --math.Approach(self.freeAimAutoCenterSpeed, frameTime * 6, frameTime * 6)
					end
				end
				
				self.freeAimAutoCenterSpeed = math.Clamp(self.freeAimAutoCenterSpeed, 0, 1)
					
				if shouldAutoCenter then
					self.lastEyeAngle = LerpAngle(self.freeAimAutoCenterSpeed, self.lastEyeAngle, self.Owner:EyeAngles())
				end
			end
		end
		
		local yawDiff = math.AngleDifference(self.lastEyeAngle.y, ang.y)
		local pitchDiff = math.AngleDifference(self.lastEyeAngle.p, ang.p)
		
		local yawLimit = GetConVarNumber("cw_freeaim_yawlimit")
		local pitchLimit = GetConVarNumber("cw_freeaim_pitchlimit")
		
		if yawDiff >= yawLimit then
			self.lastEyeAngle.y = math.NormalizeAngle(ang.y + yawLimit)
		elseif yawDiff <= -yawLimit then
			self.lastEyeAngle.y = math.NormalizeAngle(ang.y - yawLimit)
		end
		
		if pitchDiff >= pitchLimit then
			self.lastEyeAngle.p = math.NormalizeAngle(ang.p + pitchLimit)
		elseif pitchDiff <= -pitchLimit then
			self.lastEyeAngle.p = math.NormalizeAngle(ang.p - pitchLimit)
		end
		
		ang.y = self.lastEyeAngle.y
		ang.p = self.lastEyeAngle.p
		
		ang = ang
	else
		self.shouldUpdateAngles = true
	end
	
	FT, CT = FrameTime(), CurTime()
	
	local resetM203Angles = false
	
	self.M203CameraActive = false
	
	if self.AttachmentModelsVM then
		local m203 = self.AttachmentModelsVM.md_m203
		
		if m203 then
			if self.dt.State ~= CW_CUSTOMIZE then
				local CAMERA = m203.ent:GetAttachment(m203.ent:LookupAttachment("Camera")).Ang
				local modelAng = m203.ent:GetAngles()
				
				RotateAroundAxis(CAMERA, Right(CAMERA), self.M203CameraRotation.p)
				RotateAroundAxis(CAMERA, Up(CAMERA), self.M203CameraRotation.y)
				RotateAroundAxis(CAMERA, Forward(CAMERA), self.M203CameraRotation.r)

				local factor = math.abs(ang.p)
				local intensity = 1
				
				if factor >= 60 then
					factor = factor - 60
					intensity = math.Clamp(1 - math.abs(factor / 15), 0, 1)
				end
				
				self.M203AngDiff = math.NormalizeAngles((modelAng - CAMERA)) * 0.5 * intensity
			end
		end
	end
	
	ang = ang - self.M203AngDiff
	ang = ang - self.CurM203Angles * 0.5
	ang.r = ang.r + self.lastViewRoll
	
	if UnPredictedCurTime() > self.lastViewRollTime then
		self.lastViewRoll = LerpCW20(FrameTime() * 10, self.lastViewRoll, 0)
	end
	
	if UnPredictedCurTime() > self.FOVHoldTime or freeAimOn then
		self.FOVTarget = LerpCW20(FT * 10, self.FOVTarget, 0)
	end	
	
	if self.CalcViewCamera and self.CW_VM:GetAttachment(self.CW_VM:LookupAttachment(self.CalcViewCamera)) then
		local vm = self.CW_VM
		local CAMERA = vm:GetAttachment(vm:LookupAttachment(self.CalcViewCamera)).Ang
		local modelAng = vm:GetAngles()
		
		-- RotateAroundAxis(CAMERA, Right(CAMERA), self.M203CameraRotation.p)
		-- RotateAroundAxis(CAMERA, Up(CAMERA), self.M203CameraRotation.y)
		-- RotateAroundAxis(CAMERA, Forward(CAMERA), self.M203CameraRotation.r)

		local factor = math.abs(ang.p)
		local intensity = self.CalcViewCameraIntensity or 1
		
		if factor >= 60 then
			factor = factor - 60
			intensity = math.Clamp(1 - math.abs(factor / 15), 0, 1)
		end
		
		self.CalcViewCameraAngDiff = math.NormalizeAngles((modelAng - CAMERA)) * 0.5 * intensity
		
		ang = ang - self.CalcViewCameraAngDiff
	end
	
	if self.ReloadViewBobEnabled and self.CalcViewCamera then
		if self.IsReloading and self.Cycle <= 0.9 then
			att = self.Owner:GetAttachment(1)
			
			if att then
				ang = ang * 1
				
				self.LerpBackSpeed = 1
				curang = LerpAngle(FT * 10, curang, (ang - att.Ang) * 0.1)
			else
				self.LerpBackSpeed = math.Approach(self.LerpBackSpeed, 10, FT * 50)
				curang = LerpAngle(FT * self.LerpBackSpeed, curang, Ang0)
			end
		else
			self.LerpBackSpeed = math.Approach(self.LerpBackSpeed, 10, FT * 50)
			curang = LerpAngle(FT * self.LerpBackSpeed, curang, Ang0)
		end

		RotateAroundAxis(ang, Right(ang), curang.p * self.RVBPitchMod)
		RotateAroundAxis(ang, Up(ang), curang.r * self.RVBYawMod)
		RotateAroundAxis(ang, Forward(ang), (curang.p + curang.r) * 0.15 * self.RVBRollMod)
	end
	
	if self.dt.State == CW_AIMING then
		if self.dt.M203Active and self.M203Chamber and not CustomizableWeaponry.grenadeTypes:canUseProperSights(self.Grenade40MM) then
			self.CurFOVMod = LerpCW20(FT * 10, self.CurFOVMod, 5)
		else
			local zoomAmount = self.ZoomAmount
			local simpleTelescopics = not self:canUseComplexTelescopics()
			local shouldDelay = false
			
			if simpleTelescopics then
				if self.SimpleTelescopicsFOV then
					zoomAmount = self.SimpleTelescopicsFOV
					shouldDelay = true
				end
			end
			
			if self.DelayedZoom or shouldDelay then
				if CT > self.AimTime then
					if self.SnapZoom or (self.SimpleTelescopicsFOV and simpleTelescopics) then
						self.CurFOVMod = zoomAmount
					else
						self.CurFOVMod = LerpCW20(FT * 10, self.CurFOVMod, zoomAmount)
					end
				else
					self.CurFOVMod = LerpCW20(FT * 10, self.CurFOVMod, 0)
				end
			else
				if self.SnapZoom or (self.SimpleTelescopicsFOV and simpleTelescopics) then
					self.CurFOVMod = zoomAmount
				else
					self.CurFOVMod = LerpCW20(FT * 10, self.CurFOVMod, zoomAmount)
				end
			end
		end
	else
		self.CurFOVMod = LerpCW20(FT * 10, self.CurFOVMod, 0)
	end
	
	if self.holdingBreath then
		self.BreathFOVModifier = math.Approach(self.BreathFOVModifier, 7, FT * 12)
	else
		self.BreathFOVModifier = math.Approach(self.BreathFOVModifier, 0, FT * 10)
	end
	
	fov = math.Clamp(fov - self.CurFOVMod - self.BreathFOVModifier, 5, 90)
	
	if self.Owner then
		if self.ViewbobEnabled then
			ws = self.Owner:GetWalkSpeed()
			vel = Length(GetVelocity(self.Owner))
			
			local intensity = 1
						
			if self:isPlayerProne() and vel >= self.BusyProneVelocity then
				intensity = 7
				cos1 = math.cos(CT * 6)
				cos2 = math.cos(CT * 7)
				curviewbob.p = cos1 * 0.1 * intensity
				curviewbob.y = cos2 * 0.2 * intensity
			else			
				if self.Owner:OnGround() and vel > ws * 0.3 then
					if vel < ws * 1.2 then
						cos1 = math.cos(CT * 15)
						cos2 = math.cos(CT * 12)
						curviewbob.p = cos1 * 0.15 * intensity
						curviewbob.y = cos2 * 0.1 * intensity
					else
						cos1 = math.cos(CT * 20)
						cos2 = math.cos(CT * 15)
						curviewbob.p = cos1 * 0.25 * intensity
						curviewbob.y = cos2 * 0.15 * intensity
					end
				else
					curviewbob = LerpAngle(FT * 10, curviewbob, Ang0)
				end
			end
		end
	end
	
	fov = fov - self.FOVTarget
	self.curFOV = fov
	
	return pos, ang + curviewbob * self.ViewbobIntensity, fov
end