local att = {}
att.name = "md_blackops3_holo"
att.displayName = "BOA 3"
att.displayNameShort = "BOA"
att.aimPos = {"BO3_HoloPos", "BO3_HoloAng"}
att.FOVModifier = 10
att.isSight = true
-- att.colorType = CustomizableWeaponry.colorableParts.COLOR_TYPE_SIGHT

if CLIENT then
	att.displayIcon = surface.GetTextureID("blackops3/icon_atts/cac_mods_holographic")
	att.description = {
	[1] = {t = "Precision reflex sight.", c = CustomizableWeaponry.textColors.POSITIVE},
	[2] = {t = "1.5X ZOOM.", c = CustomizableWeaponry.textColors.POSITIVE}
	}
	
	att.reticle = "blackops3/reticles/reflex_2"
	att._reticleSize = 15
	
	function att:elementRender()
		if not self.ActiveAttachments[att.name] then return end
		if not self.AttachmentModelsVM[att.name] then return end
		
		local rc = self:getSightColor(att.name)
		
		local isAiming = self:isAiming()
		local isScopePos = (self.AimPos == self[att.aimPos[1]] and self.AimAng == self[att.aimPos[2]])
		
		local attachmEnt = self.AttachmentModelsVM[att.name].ent
		local model_stencil = "models/loyalists/blackops3/public/optic_holo_stencil.mdl"
		local model_att = "models/loyalists/blackops3/public/optic_holo.mdl"
		
		if not (isScopePos and (isAiming or self.dt.BipodDeployed)) then 
		-- if not ((isAiming or self.dt.BipodDeployed)) then 
			return
		end
		
		/*enable/reset stencils*/
		render.ClearStencil()
		render.SetStencilEnable(true)
			
		render.SetStencilWriteMask(1)
		render.SetStencilTestMask(1)
		render.SetStencilReferenceValue(1)
		render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_ALWAYS)
		render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
		render.SetStencilFailOperation(STENCILOPERATION_KEEP)
		render.SetStencilZFailOperation(STENCILOPERATION_KEEP)
		
		
		/*draw mesh/model*/
		
		attachmEnt:SetModel(model_stencil)
		attachmEnt:DrawModel()
		
		/*prepare(?) stencils*/
		render.SetStencilWriteMask(2)
		render.SetStencilTestMask(2)
		render.SetStencilReferenceValue(2)
		render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
		render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
		render.SetStencilWriteMask(1)
		render.SetStencilTestMask(1)
		render.SetStencilReferenceValue(1)
		
		/*render reticle*/
		render.SetMaterial(att._reticle)
		-- dist = math.Clamp(math.Distance(1, 1, diff, diff), 0, 0.13)
		
		local EA = self:getReticleAngles()

		local renderColor = self:getSightColor(att.name)
		
		local pos = EyePos() + EA:Forward() * 12 *(attachmEnt:GetPos():Distance(EyePos()))
		
		local trace = {}
		trace.start = self.Owner:GetShootPos()
		trace.endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector()*60000
		trace.filter = self.Owner
		local tr = util.TraceLine(trace)

		local target
		target = tr.Entity
		target = IsValid(target) and (target:IsNPC() or target:IsPlayer())
		target = target and not ((self.IsReloading and self.CW_VM:GetCycle() < 0.98) or self.NearWall or self.dt.State == CW_CUSTOMIZE)
		
		cam.IgnoreZ(true)
			-- render.CullMode(MATERIAL_CULLMODE_CW)
			for i = 1, 2 do
				if (target) then
					render.DrawSprite(pos, att._reticleSize, att._reticleSize, Color(255, 75, 75, 255))
				else
					render.DrawSprite(pos, att._reticleSize, att._reticleSize, Color(100, 255, 100, 255))
				end
			end
			-- render.CullMode(MATERIAL_CULLMODE_CCW)
		cam.IgnoreZ(false)
		
		attachmEnt:SetModel(model_att)
		attachmEnt:DrawModel()
		
		/*disable stencils*/
		render.SetStencilEnable(false)
	end
end

CustomizableWeaponry:registerAttachment(att)