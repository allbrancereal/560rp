local att = {}
att.name = "md_blackops3_ir"
att.displayName = "Thermal Sight"
att.displayNameShort = "Thermal"
att.aimPos = {"BO3_IRPos", "BO3_IRAng"}
att.FOVModifier = 50
att.isSight = true

att.statModifiers = {OverallMouseSensMult = -0.1,
	VelocitySensitivityMult = -0.1}

if CLIENT then
	att.displayIcon = surface.GetTextureID("blackops3/icon_atts/cac_mods_ir")
	att.description = {[1] = {t = "Magnified optic that shows enemy heat signatures.", c = CustomizableWeaponry.textColors.POSITIVE},
	[2] = {t = "Narrow scope reduces awareness.", c = CustomizableWeaponry.textColors.NEGATIVE},
	[3] = {t = "Is very disorienting at close range.", c = CustomizableWeaponry.textColors.NEGATIVE}}

	local old, x, y, ang
	
	att.zoomTextures = {{tex = surface.GetTextureID("blackops3/reticles/scope_reticle_thermal"), offset = {0, 1}}}

	local lens = surface.GetTextureID("models/loyalists/blackops3/public/optic_thermal/mc_mtl_attach_t7_optic_thermal_scope_lens")
	local lensMat = Material("cw2/gui/lense")
end

function att:attachFunc()
	self.OverrideAimMouseSens = 0.75
	self.SimpleTelescopicsFOV = 60
	self.AimViewModelFOV = 40
	self.BlurOnAim = false
	self.ZoomTextures = att.zoomTextures
	self.AimBreathingEnabled = true
	self.MoveWepAwayWhenAiming = true
	self.SimpleTSAcquired = true
	self.ThermalAcquired = true
end

function att:detachFunc()
	self.OverrideAimMouseSens = nil
	self.SimpleTelescopicsFOV = nil
	self.AimViewModelFOV = self.AimViewModelFOV_Orig
	self.BlurOnAim = false
	self:resetAimBreathingState()
	self.MoveWepAwayWhenAiming = false
	self.SimpleTSAcquired = false
	self.ThermalAcquired = false
end

CustomizableWeaponry:registerAttachment(att)

if CLIENT then
	local PP_IRFX = 
	{
		[ "$pp_colour_addr" ] 		= 0,
		[ "$pp_colour_addg" ] 		= 0.15,
		[ "$pp_colour_addb" ] 		= 0.8,
		[ "$pp_colour_brightness" ] = 0.03,
		[ "$pp_colour_contrast" ]	= 1,
		[ "$pp_colour_colour" ] 	= 0.5,
		[ "$pp_colour_mulr" ] 		= 0,
		[ "$pp_colour_mulg" ] 		= 0,
		[ "$pp_colour_mulb" ] 		= 0
	}

	local function CW20_BLACKOPS3_IRFX()
		local ply = LocalPlayer()
		local wep = ply:GetActiveWeapon()
		
		if not IsValid(wep) or not wep.CW20Weapon or not wep.BlackOps3Weapon then
			return
		end
		
		UCT = UnPredictedCurTime()
		local simpleTelescopics = wep.SimpleTSAcquired or not wep:canUseComplexTelescopics()
		
		local hasZoom = (wep.SimpleTelescopicsFOV)
		local canUseIR = (simpleTelescopics and hasZoom and wep.ThermalAcquired)
		
		if not (canUseIR and UCT > wep.AimTime and wep.dt.State == CW_AIMING) then
			return
		end
				
		render.SuppressEngineLighting(true)
		
		FT = FrameTime()
		
		for _, ent in pairs(ents.GetAll()) do
			if ent:IsNPC() or ent:IsPlayer() or ent:IsVehicle() or ent:IsWeapon() then
				if not ent:IsEffectActive(EF_NODRAW) then
					render.SuppressEngineLighting(true)
					render.MaterialOverride( Material("blackops3/util/white") )
					render.SetBlend( 1 )
					ent:DrawModel()
					render.SetBlend( 0 )
					render.MaterialOverride( nil )
					render.SuppressEngineLighting(false)
				end
			end
		end
		
		DrawColorModify(PP_IRFX)
		DrawBloom( 0.65, 2.5, 10, 10, 1, 1, 1, 1, 1 )
		
		render.SuppressEngineLighting(false)
	end
	
	hook.Add("PostDrawOpaqueRenderables", "CW20_BLACKOPS3_IRFX", function()
		CW20_BLACKOPS3_IRFX()
	end)
end