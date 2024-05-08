local att = {}
att.name = "md_blackops3_hybrid"
att.displayName = "Varix 3"
att.displayNameShort = "Varix"
att.aimPos = {"BO3_HybirdPos", "BO3_HybirdAng"}
att.FOVModifier = 50
att.isSight = true
att.colorType = CustomizableWeaponry.colorableParts.COLOR_TYPE_SIGHT

if CLIENT then
	att.displayIcon = surface.GetTextureID("blackops3/icon_atts/cac_mods_dualoptic")
	att.description = {[1] = {t = "Provides 5x zoom for FOV and a bright reticle to ease aiming.", c = CustomizableWeaponry.textColors.POSITIVE}}
	
	att.reticle = "blackops3/reticles/acog_35"
	att._reticleSize = 15

	function att:elementRender()
		if not self.ActiveAttachments[att.name] then return end
		if not self.AttachmentModelsVM[att.name] then return end
		
		local rc = self:getSightColor(att.name)
		
		local isAiming = self:isAiming()
		local isScopePos = (self.AimPos == self[att.aimPos[1]] and self.AimAng == self[att.aimPos[2]])
		local attachmEnt = self.AttachmentModelsVM[att.name].ent
		local model_stencil = "models/loyalists/blackops3/public/optic_hybrid_stencil.mdl"
		local model_att = "models/loyalists/blackops3/public/optic_hybrid.mdl"
		
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
		
		cam.IgnoreZ(true)
			-- render.CullMode(MATERIAL_CULLMODE_CW)
			for i = 1, 2 do
				render.DrawSprite(pos, att._reticleSize, att._reticleSize, Color(rc.r,rc.g,rc.b,150 + math.random(50)))
			end
			-- render.CullMode(MATERIAL_CULLMODE_CCW)
		cam.IgnoreZ(false)
		
		attachmEnt:SetModel(model_att)
		attachmEnt:DrawModel()
		
		/*disable stencils*/
		render.SetStencilEnable(false)
	end
	
	-- function att:drawReticle()
		-- if not self:isAiming() or not self:isReticleActive() then
			-- return
		-- end
		
		-- diff = self:getDifferenceToAimPos(self.EoTechPos, self.EoTechAng, 1)
		
		-- if diff > 0.9 and diff < 1.1 then
			-- cam.IgnoreZ(true)
				-- render.SetMaterial(att._reticle)
				-- dist = math.Clamp(math.Distance(1, 1, diff, diff), 0, 0.13)
				
				-- local EA = self.Owner:EyeAngles() + self.Owner:GetPunchAngle()
				
				-- local renderColor = self:getSightColor(att.name)
				-- renderColor.a = (0.13 - dist) / 0.13 * 255
				
				-- local pos = EyePos() + EA:Forward() * 100
				
				-- for i = 1, 2 do
					-- render.DrawSprite(pos, att._reticleSize, att._reticleSize, renderColor)
				-- end
			-- cam.IgnoreZ(false)
		-- end
	-- end
end

CustomizableWeaponry:registerAttachment(att)