local reg = debug.getregistry()
local GetVelocity = reg.Entity.GetVelocity
local Length = reg.Vector.Length

// CALLBACKS
CustomizableWeaponry.callbacks:addNew("postAttachAttachment", "CW20_BLACKOPS3_CALLBACK_POSTATTACH", function(wep,cur,curPos)
	if not wep.BlackOps3Weapon then
		return
	end
	
	local attTable = wep.Attachments[cur]
	local att = inherit or CustomizableWeaponry:findAttachment(attTable.atts[curPos])
	-- be advised - attTable.last = curPos
	
	if att.isSight then
		wep.currentSight = att.name
	end
	
	if CLIENT then
		if wep.AttachmentModelsWM and wep.AttachmentModelsWM[attTable.atts[curPos]] then
			local model = wep.AttachmentModelsWM[attTable.atts[curPos]]
			
			if model then
				model.active = true
			end
			
			if att.isSight then
				if model.active and not att.isBG then
					if wep.WMEnt and wep.WMSightBGs and wep.WMSightBGs.none then
						wep.WMEnt:SetBodygroup(wep.WMSightBGs.main, wep.WMSightBGs.none)
					end
				end
			end
			
			if att.elementRenderWM then
				wep.elementRenderWM[att.name] = att.elementRenderWM
			end
		end
	end
end)

CustomizableWeaponry.callbacks:addNew("adjustViewmodelPosition", "CW20_BLACKOPS3_CALLBACK_ADJUSTVMPOS", function(wep, TargetPos, TargetAng)
	if not wep.BlackOps3Weapon then
		return
	end

	if CLIENT then
		local vel = GetVelocity(wep.Owner)
		local len = Length(vel)
		local ws = wep.Owner:GetWalkSpeed()
		local prefix = wep:GetPrefix()
		
		if wep.Animations[prefix .. "sprint_loop"] and (wep.dt.State == CW_RUNNING or (((len > ws * wep.RunStateVelocity and wep.Owner:KeyDown(IN_SPEED)) or len > ws * 3 or (wep.ForceRunStateVelocity and len > wep.ForceRunStateVelocity)) and wep.Owner:OnGround())) then
			return wep.AlternativePos, wep.AlternativeAng
		end
		
		if wep.Animations[prefix .. "crawl_loop"] and wep.dt.State == CW_PRONE_MOVING then
			return wep.AlternativePos, wep.AlternativeAng
		end
		
		if wep.dt.State == CW_HOLSTER_START or wep.dt.State == CW_HOLSTER_END then
			return wep.AlternativePos, wep.AlternativeAng
		end
	end
end)

-- SOUND
CustomizableWeaponry:addRegularSound("Weapon_BLACKOPS3_UTIL.Empty", "weapons/blackops3/arak/wpn_ar_standard_start_ads.wav")
CustomizableWeaponry:addRegularSound("Weapon_BLACKOPS3_Melee.Riflebutt", 
	{
	"weapons/blackops3/rifle_butt/imp_rifle_butt_00.wav",
	"weapons/blackops3/rifle_butt/imp_rifle_butt_01.wav",
	"weapons/blackops3/rifle_butt/imp_rifle_butt_02.wav",
	"weapons/blackops3/rifle_butt/rifle_hit_00.wav",
	"weapons/blackops3/rifle_butt/rifle_hit_01.wav",
	"weapons/blackops3/rifle_butt/rifle_miss.wav"
	}
)

CustomizableWeaponry:addRegularSound("Weapon_BLACKOPS3_Cloth.Regular", 
	{
	"weapons/blackops3/cloth/fly_cloth_00.wav",
	"weapons/blackops3/cloth/fly_cloth_01.wav",
	"weapons/blackops3/cloth/fly_cloth_02.wav",
	"weapons/blackops3/cloth/fly_cloth_03.wav"
	}
)

CustomizableWeaponry:addRegularSound("Weapon_BLACKOPS3_Cloth.Med", 
	{
	"weapons/blackops3/cloth/fly_cloth_med_00.wav",
	"weapons/blackops3/cloth/fly_cloth_med_01.wav",
	"weapons/blackops3/cloth/fly_cloth_med_02.wav",
	"weapons/blackops3/cloth/fly_cloth_med_03.wav",
	"weapons/blackops3/cloth/fly_cloth_med_04.wav",
	"weapons/blackops3/cloth/fly_cloth_med_05.wav",
	"weapons/blackops3/cloth/fly_cloth_med_06.wav",
	"weapons/blackops3/cloth/fly_cloth_med_07.wav",
	"weapons/blackops3/cloth/fly_cloth_med_08.wav",
	"weapons/cw_foley/foley_medium1.wav",
	"weapons/cw_foley/foley_medium2.wav",
	"weapons/cw_foley/foley_medium3.wav",
	}
)

CustomizableWeaponry:addRegularSound("Weapon_BLACKOPS3_Cloth.Short", 
	{
	"weapons/blackops3/cloth/fly_cloth_shrt_00.wav",
	"weapons/blackops3/cloth/fly_cloth_shrt_01.wav",
	"weapons/blackops3/cloth/fly_cloth_shrt_02.wav",
	"weapons/blackops3/cloth/fly_cloth_shrt_03.wav",
	"weapons/blackops3/cloth/fly_cloth_shrt_04.wav",
	"weapons/blackops3/cloth/fly_cloth_short_05.wav",
	"weapons/blackops3/cloth/fly_cloth_shrt_06.wav"
	}
)
	
CustomizableWeaponry:addRegularSound("Weapon_BLACKOPS3_Cloth.Melee", 
	{
	"weapons/blackops3/cloth/riot_shield_swing_cloth_00.wav",
	"weapons/blackops3/cloth/riot_shield_swing_cloth_01.wav",
	}
)

-- AMMO TYPES
