AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Bloodhound"
	SWEP.CSMuzzleFlashes = true
	SWEP.SnapToGrip = true	
	
	killicon.Add( "cw_blackops3_38", "blackops3/icon_kill/cw_blackops3_38", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("blackops3/icon_weapons/cw_blackops3_38")

	SWEP.IronsightPos = Vector(-8.95, 15.0334, 4.85)
	SWEP.IronsightAng = Vector(0, 0, 0)

	SWEP.BO3_ReflexPos = Vector(-9.57, -3.6666, -1.4127)
	SWEP.BO3_ReflexAng = Vector(0, 0, 0)

	SWEP.BO3_ACOGPos = Vector(-9.57, -3.1656, -0.5752)
	SWEP.BO3_ACOGAng = Vector(0, 0, 0)

	SWEP.BO3_HybirdPos = Vector(-9.57, 40.8841, -1.7)
	SWEP.BO3_HybirdAng = Vector(0, 0, 0)

	SWEP.BO3_HoloPos = Vector(-9.57, -5.7148, -1.4143)
	SWEP.BO3_HoloAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(2.95, -3.057, -4.119)
	SWEP.SprintAng = Vector(-13.131, 33.537, -29.906)
	
--	SWEP.SprintPos = Vector(0, 0, 0)
--	SWEP.SprintAng = Vector(-15.478, 21.809, -31.659)

	SWEP.CustomizePos = Vector(20.199, -5.829, 5)
	SWEP.CustomizeAng = Vector(21.255, 37.437, 30.848)
	
--	SWEP.CustomizePos = Vector(10.854, 0, 1.004)
--	SWEP.CustomizeAng = Vector(16.25, 25.139, 16.18)
	
	SWEP.AlternativePos = Vector(0, 0, 0)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.ViewModelMovementScale = 1.65
	
	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.PosBasedMuz = false
	
	SWEP.Shell = false
	SWEP.ShellScale = 0.9
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = -2, y = 0, z = -3}
	
	SWEP.BipodAngleLimitYaw = 40
	
	SWEP.SightWithRail = false
	
	SWEP.OffsetBoltOnBipodShoot = true

	SWEP.HUD_3D2DScale = 0.045
	
	SWEP.AttachmentModelsVM = {
		["md_blackops3_grip_ar"] = {model = "models/loyalists/blackops3/xr2/grip_xr2_01.mdl", pos = Vector(35.8512, 0, 4.6576), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_grip_smg"] = {model = "models/loyalists/blackops3/xr2/grip_xr2_02.mdl", pos = Vector(35.8512, 0, 4.6576), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_sil_ar"] = {model = "models/loyalists/blackops3/xr2/sil_xr2.mdl", pos = Vector(57.1673, 0, 7.7996), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_hybrid"] = {model = "models/loyalists/blackops3/public/optic_hybrid.mdl", pos = Vector(5.0144, 0, 14.4715), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_reflex"] = {model = "models/loyalists/blackops3/public/optic_reflex.mdl", pos = Vector(4.502, 0, 14.2), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_acog"] = {model = "models/loyalists/blackops3/public/optic_acog.mdl", pos = Vector(7.6532, 0, 14.15), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_holo"] = {model = "models/loyalists/blackops3/public/optic_holo.mdl", pos = Vector(6.5202, 0, 14.4715), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
	}
	
	SWEP.ForeGripHoldPos = {
		["j_thumb_le_0"] = {pos = Vector(0, -0.926, -1.297), angle = Angle(-16.667, 0, 0) },
		["j_thumb_le_1"] = {pos = Vector(0, 0, -2.037), angle = Angle(-52.223, 0, 0) },
		["j_shoulder_le"] = {pos = Vector(14.258, 2.036, -6.853), angle = Angle(0, 0, 0) },
		["j_thumb_le_2"] = {pos = Vector(0, -1.297, 0), angle = Angle(0, 0, 0) },
		["j_wrist_le"] = {pos = Vector(0, 0, 0), angle = Angle(-72.223, 0, 0) }
	}	
	
	SWEP.ForegripOverridePos = {		
		["customizing"] = {
		["j_shoulder_le"] = { pos = Vector(-6.481, 5.741, -13.148), angle = Angle(0, 0, 0) },
		},
	}
	
	SWEP.LaserPosAdjust = Vector(1, 0, 0)
	SWEP.LaserAngAdjust = Angle(2, 180, 0) 	
	
	SWEP.SpecterAxisAlign = {right = 0, up = 0, forward = 0}
	SWEP.M82AxisAlign = {right = 0, up = 0, forward = 0}
	SWEP.MORSAxisAlign = {right = 0, up = 0, forward = -180}

	SWEP.AimSwayIntensity = 0.3
	
	SWEP.CustomizationMenuScale = 0.035
end

SWEP.DWBGs = {main = 1, dw = 1, regular = 0}

SWEP.SkinIDs = {
	none = 0, 
	skin1 = 1, 
	au = 2
	}

SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {
	-- [1] = {header = "Miscs", offset = {1100, -500},  atts = {"md_blackops3_dw"}},
	["+reload"] = {header = "Ammo", offset = {500, 200}, atts = {"am_magnum", "am_matchgrade"}}
	}

-- coded extended anims
-- INS2-ish nomenclature
SWEP.Animations = {
	base_idle = "base_idle",
	base_fire = "base_fire",
	base_fire_ads = "base_fire_ads",
	base_reload = "base_reload",
	base_reload_empty = "base_reload",
	base_draw = "base_draw",
	base_draw_first = "base_draw_first",
	base_holster = "base_holster",
	base_jump = "base_jump",
	base_jump_land = "base_jump_land",
	base_melee = "base_melee",
	base_crawl_loop = "base_crawl_loop",
	base_mantle_over = "base_mantle_over",
	base_sprint_in = "base_sprint_in",
	base_sprint_loop = "base_sprint_loop",
	base_sprint_out	= "base_sprint_out",
	
	dw_idle = "dw_idle",
	dw_fire = "dw_fire",
	dw_fire_lh = "dw_fire_lh",
	dw_fire_rh = "dw_fire_lh",
	dw_reload = "dw_reload",
	dw_reload_empty = "dw_reload_empty",
	dw_draw = "dw_draw",
	dw_draw_first = "dw_draw_first",
	dw_holster = "dw_holster",
	dw_jump = "dw_jump",
	dw_jump_land = "dw_jump_land",
	dw_crawl_loop = "dw_crawl_loop",
	dw_sprint_in = "dw_sprint_in",
	dw_sprint_loop = "dw_sprint_loop",
	dw_sprint_out	= "dw_sprint_out",
	}
	
SWEP.Sounds = { 
	base_reload = {
	[1] = {time = 0.4, sound = "Weapon_BLACKOPS3_38.Cylinder_Open"},
	[2] = {time = 1.06, sound = "Weapon_BLACKOPS3_38.Magout"},
	[3] = {time = 2.0, sound = "Weapon_BLACKOPS3_38.Magin"},
	[4] = {time = 2.65, sound = "Weapon_BLACKOPS3_38.Cylinder_Close"},
	},

	base_reload_empty = {
	[1] = {time = 0.4, sound = "Weapon_BLACKOPS3_38.Cylinder_Open"},
	[2] = {time = 1.06, sound = "Weapon_BLACKOPS3_38.Magout"},
	[3] = {time = 2.0, sound = "Weapon_BLACKOPS3_38.Magin"},
	[4] = {time = 2.65, sound = "Weapon_BLACKOPS3_38.Cylinder_Close"},
	},
	
	base_draw_first = {
	[1] = {time = 0.2, sound = "Weapon_BLACKOPS3_38.Cylinder_Latch"},
	[2] = {time = 0.6, sound = "Weapon_BLACKOPS3_38.Hammer_Back"},
	},
}
	
SWEP.SpeedDec = 30

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "revolver"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_blackops3_base"
SWEP.Category = "CW 2.0 Black Ops III"

SWEP.Author				= "Loyalists"
SWEP.Contact			= ""
SWEP.Purpose			= ""

SWEP.Trivia = {
	text = "Semi-auto revolver.",
	x = -300, 
	y = -400, 
--	textFormatFunc = function(self, wep) if wep.ActiveAttachments.md_bipod then return "" else return self.text end end
	}

SWEP.ViewModelFOV	= 65
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/loyalists/blackops3/38/v_pistol_38.mdl"
SWEP.WorldModel		= "models/loyalists/blackops3/38/w_pistol_38.mdl"
SWEP.WM		= "models/loyalists/blackops3/38/w_pistol_38.mdl"
SWEP.WMPos			= Vector(0,-1,0)
SWEP.WMAng			= Vector(0,0,180)
SWEP.DrawTraditionalWorldModel = false

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.SnapToIdlePostReload = false

SWEP.Primary.ClipSize		= 8
SWEP.Primary.DefaultClip	= 32
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".44 Magnum"

SWEP.FireDelay				= 60/400
SWEP.FireSound				= "CW_BLACKOPS3_38_FIRE"
SWEP.Recoil					= 0.5

SWEP.HipSpread = 0.3
SWEP.AimSpread = 0.05
SWEP.VelocitySensitivity = 3.0
SWEP.MaxSpreadInc = 0.1
SWEP.SpreadPerShot = 0.001
SWEP.SpreadCooldown = 0.24
SWEP.Shots = 1
SWEP.Damage = 50

SWEP.HolsterSpeed = 1

SWEP.DeployTime = 0.5
SWEP.FirstDeployTime = 1.3
SWEP.FirstDrawSpeed = 1

SWEP.ReloadSpeed = 1.0
SWEP.ReloadTime = 3.1
SWEP.ReloadTime_Empty = 3.1
SWEP.ReloadHalt = 3.1
SWEP.ReloadHalt_Empty = 3.1

SWEP.MeleeAttackRange = 50
SWEP.MeleeAttackDamage = 40
SWEP.MeleeInTime = 0.15
SWEP.MeleeOutTime = 0.6
SWEP.MeleeAttackDamageWindow = 0.05

SWEP.ViewbobIntensity = 0.25

// Custom Features
SWEP.Chamberable = false
SWEP.CanRestOnObjects = false
SWEP.QuickMeleeLogic = true
SWEP.DualMagLogic = true
-- SWEP.DualWieldLogic = false

local reg = debug.getregistry()
local GetVelocity = reg.Entity.GetVelocity
local Length = reg.Vector.Length
local SP = game.SinglePlayer()
local noNormal = Vector(1, 1, 1)
local mag, ammo

-- function SWEP:CreateMuzzle()
	-- if self.Owner:ShouldDrawLocalPlayer() then
		-- return
	-- end

	-- vm = self.CW_VM
	
	-- if IsValid(vm) then
		-- vm:StopParticles()

		-- muz = vm:LookupAttachment(self.MuzzleAttachmentName)
		-- muz_alt = vm:LookupAttachment("3")
		
		-- if muz_alt then
			-- muz_alt2 = vm:GetAttachment(muz_alt)
			
			-- if muz_alt2 then
				-- EA = EyeAngles()
				
				-- local pos = muz_alt2.Pos
				-- local ang = EA
				
				-- if self.MuzzlePosMod then
					-- pos = muz_alt2.Pos + EA:Right() * self.MuzzlePosMod.x + EA:Forward() * self.MuzzlePosMod.y + EA:Up() * self.MuzzlePosMod.z
				-- end
				
				-- if self.dt.Suppressed then
					-- if self.MuzzleEffectSupp then
						-- if not self.NoSilMuz then
							-- if (self.dt.State == CW_AIMING and self.SimulateCenterMuzzle) or (self.dt.State == CW_AIMING and self:canUseSimpleTelescopics()) then
								-- ParticleEffect(self.MuzzleEffectSupp, pos + self.Owner:GetVelocity() * 0.03 + EA:Forward() * 70 - EA:Up() * 3, EA, vm)
							-- else
								-- if self.PosBasedMuz then
									-- ParticleEffect(self.MuzzleEffectSupp, pos + self.Owner:GetVelocity() * 0.03, EA, vm) -- using velocity to add to the position 'simulates' attaching it to a control point
								-- else
									-- ParticleEffectAttach(self.MuzzleEffectSupp, PATTACH_POINT_FOLLOW, vm, muz_alt)
								-- end
							-- end
						-- end
					-- end
				-- else
					-- if self.MuzzleEffect then
						-- if (self.dt.State == CW_AIMING and self.SimulateCenterMuzzle) or (self.dt.State == CW_AIMING and self:canUseSimpleTelescopics()) then
							-- ParticleEffect(self.MuzzleEffect, pos + self.Owner:GetVelocity() * 0.03 + EA:Forward() * 70 - EA:Up() * 3, EA, vm)
						-- else
							-- if self.PosBasedMuz then
								-- ParticleEffect(self.MuzzleEffect, pos + self.Owner:GetVelocity() * 0.03, EA, vm)
							-- else
								-- ParticleEffectAttach(self.MuzzleEffect, PATTACH_POINT_FOLLOW, vm, muz_alt)
							-- end
						-- end
					-- end
					
					-- dlight = DynamicLight(self:EntIndex())
					
					-- dlight.r = 255 
					-- dlight.g = 218
					-- dlight.b = 74
					-- dlight.Brightness = 4
					-- dlight.Pos = pos + self.Owner:GetAimVector() * 3
					-- dlight.Size = 96
					-- dlight.Decay = 128
					-- dlight.DieTime = CurTime() + FrameTime()
				-- end
			-- end
		-- end
		
		-- if muz then
			-- muz2 = vm:GetAttachment(muz)
			
			-- if muz2 then
				-- EA = EyeAngles()
				
				-- local pos = muz2.Pos
				-- local ang = EA
				
				-- if self.MuzzlePosMod then
					-- pos = muz2.Pos + EA:Right() * self.MuzzlePosMod.x + EA:Forward() * self.MuzzlePosMod.y + EA:Up() * self.MuzzlePosMod.z
				-- end
				
				-- if self.dt.Suppressed then
					-- if self.MuzzleEffectSupp then
						-- if not self.NoSilMuz then
							-- if (self.dt.State == CW_AIMING and self.SimulateCenterMuzzle) or (self.dt.State == CW_AIMING and self:canUseSimpleTelescopics()) then
								-- ParticleEffect(self.MuzzleEffectSupp, pos + self.Owner:GetVelocity() * 0.03 + EA:Forward() * 70 - EA:Up() * 3, EA, vm)
							-- else
								-- if self.PosBasedMuz then
									-- ParticleEffect(self.MuzzleEffectSupp, pos + self.Owner:GetVelocity() * 0.03, EA, vm) -- using velocity to add to the position 'simulates' attaching it to a control point
								-- else
									-- ParticleEffectAttach(self.MuzzleEffectSupp, PATTACH_POINT_FOLLOW, vm, muz)
								-- end
							-- end
						-- end
					-- end
				-- else
					-- if self.MuzzleEffect then
						-- if (self.dt.State == CW_AIMING and self.SimulateCenterMuzzle) or (self.dt.State == CW_AIMING and self:canUseSimpleTelescopics()) then
							-- ParticleEffect(self.MuzzleEffect, pos + self.Owner:GetVelocity() * 0.03 + EA:Forward() * 70 - EA:Up() * 3, EA, vm)
						-- else
							-- if self.PosBasedMuz then
								-- ParticleEffect(self.MuzzleEffect, pos + self.Owner:GetVelocity() * 0.03, EA, vm)
							-- else
								-- ParticleEffectAttach(self.MuzzleEffect, PATTACH_POINT_FOLLOW, vm, muz)
							-- end
						-- end
					-- end
					
					-- dlight = DynamicLight(self:EntIndex())
					
					-- dlight.r = 255 
					-- dlight.g = 218
					-- dlight.b = 74
					-- dlight.Brightness = 4
					-- dlight.Pos = pos + self.Owner:GetAimVector() * 3
					-- dlight.Size = 96
					-- dlight.Decay = 128
					-- dlight.DieTime = CurTime() + FrameTime()
				-- end
			-- end
		-- end
	-- end
-- end
