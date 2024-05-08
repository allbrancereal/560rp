AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "P-06"
	SWEP.CSMuzzleFlashes = true
	SWEP.SnapToGrip = true	
	
	killicon.Add( "cw_blackops3_dlc1_p08", "blackops3/icon_kill/cw_blackops3_dlc1_p08", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("blackops3/icon_weapons/cw_blackops3_dlc1_p08")

	SWEP.IronsightPos = Vector(-9.58, -27.2858, 1.6)
	SWEP.IronsightAng = Vector(0, 0, 0)

	SWEP.BO3_ELOPos = Vector(-9.47, -21.8772, 3.2086)
	SWEP.BO3_ELOAng = Vector(0, 0, 0)

	SWEP.BO3_ACOGPos = Vector(-9.47, -21.8772, 3.3761)
	SWEP.BO3_ACOGAng = Vector(0, 0, 0)

	SWEP.BO3_HybirdPos = Vector(-9.47, 18.8504, 2.36)
	SWEP.BO3_HybirdAng = Vector(0, 0, 0)
	
	SWEP.BO3_HoloPos = Vector(-9.47, -27.066, 2.8089)
	SWEP.BO3_HoloAng = Vector(0, 0, 0)

	SWEP.BO3_IRPos = Vector(-9.47, 18.8504, 3.3761)
	SWEP.BO3_IRAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(2.95, -3.057, -4.119)
	SWEP.SprintAng = Vector(-13.131, 33.537, -29.906)

	SWEP.CustomizePos = Vector(20.199, -5.829, 5)
	SWEP.CustomizeAng = Vector(21.255, 37.437, 30.848)
	
	SWEP.AlternativePos = Vector(0, 0, 0)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.ViewModelMovementScale = 1.65
	
	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.PosBasedMuz = false
	SWEP.ShellScale = 0.9
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = -2, y = 0, z = -3}
	
	SWEP.BipodAngleLimitYaw = 40
	
	SWEP.OffsetBoltOnBipodShoot = true
	
	SWEP.AttachmentModelsVM = {
		["md_blackops3_sil_ar"] = {model = "models/loyalists/blackops3/p08/sil_p08_01.mdl", pos = Vector(58.1688, 0, 11.6861), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_hybrid"] = {model = "models/loyalists/blackops3/public/optic_hybrid.mdl", pos = Vector(8.2786, 0, 16.2954), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_acog"] = {model = "models/loyalists/blackops3/public/optic_acog.mdl", pos = Vector(10.7052, 0, 16.0305), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_holo"] = {model = "models/loyalists/blackops3/public/optic_holo.mdl", pos = Vector(9.9369, 0, 16.2044), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_ir"] = {model = "models/loyalists/blackops3/public/optic_thermal.mdl", pos = Vector(10.7794, 0, 15.827), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_elo"] = {model = "models/loyalists/blackops3/public/optic_laser.mdl", pos = Vector(10.7794, 0, 16.4), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
	}
	
	SWEP.AttachmentModelsWM = {
		["md_blackops3_sil_ar"] = {model = "models/loyalists/blackops3/p08/sil_p08_01.mdl", bone = "tag_weapon", pos = Vector(19.5, 0, 3.6), angle = Angle(0, -90, 0), size = Vector(0.3, 0.3, 0.3)},
		["md_blackops3_hybrid"] = {model = "models/loyalists/blackops3/public/optic_hybrid.mdl", bone = "tag_weapon", pos = Vector(4, 0, 5.2), angle = Angle(0, -90, 0), size = Vector(0.5, 0.5, 0.5)},	
		["md_blackops3_acog"] = {model = "models/loyalists/blackops3/public/optic_acog.mdl", pos = Vector(4.4451, 0, 5.0425), angle = Angle(0, -90, 0), size = Vector(0.5, 0.5, 0.5), bone = "tag_weapon"},
		["md_blackops3_holo"] = {model = "models/loyalists/blackops3/public/optic_holo.mdl", pos = Vector(4.2849, 0, 4.9524), angle = Angle(0, -90, 0), size = Vector(0.5, 0.5, 0.5), bone = "tag_weapon"},
		["md_blackops3_ir"] = {model = "models/loyalists/blackops3/public/optic_thermal.mdl", pos = Vector(4.1391, 0, 4.9048), angle = Angle(0, -90, 0), size = Vector(0.5, 0.5, 0.5), bone = "tag_weapon"},
		["md_blackops3_elo"] = {model = "models/loyalists/blackops3/public/optic_laser.mdl", pos = Vector(4.1391, 0, 5.1), angle = Angle(0, -90, 0), size = Vector(0.5, 0.5, 0.5), bone = "tag_weapon"},
	}
	
	SWEP.RTAlign = {right = 0, up = 0, forward = 0}
	
	SWEP.OverrideAimMouseSens = 0.3
	SWEP.AimSwayIntensity = 0.3
	
	SWEP.CustomizationMenuScale = 0.035
end

SWEP.SightBGs = {main = 2, carryhandle = 0, none = 1}
SWEP.MagBGs = {main = 1, fast_mag = 2, ext_mag = 1, regular = 0}
SWEP.StockBGs = {main = 6, light = 2, heavy = 1, regular = 0}
SWEP.RailBGs = {main = 3, cover = 1, regular = 0}

SWEP.WMSightBGs = {main = 1, carryhandle = 0, none = 1}

SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {
	[1] = {header = "Sight", offset = {1100, -300},  atts = {"md_blackops3_elo", "md_blackops3_acog", "md_blackops3_hybrid", "md_blackops3_ir"}},
	[2] = {header = "Magazine", offset = {1100, 600}, atts = {"bg_blackops3_fast_mag", "bg_blackops3_ext_mag"}},
	[3] = {header = "Barrel", offset = {-100, -300}, atts = {"md_blackops3_sil_ar"}},
	[4] = {header = "Stock", offset = {1500, 600}, atts = {"bg_blackops3_stock_heavy", "bg_blackops3_stock_light"}},
	[5] = {header = "Rail", offset = {-100, 600}, atts = {"md_blackops3_cover"}},
	["+reload"] = {header = "Ammo", offset = {1500, 200}, atts = {"am_magnum", "am_matchgrade"}}
	}

-- coded extended anims
-- INS2-ish nomenclature
SWEP.Animations = {
	base_idle = "base_idle",
	base_fire = "base_fire",
	base_fire_ads = "base_fire_ads",
	base_reload = "base_reload",
	base_reload_empty = "base_reload_empty",
	base_reload_ext = "base_reload_ext",
	base_reload_empty_ext = "base_reload_empty_ext",
	base_reload_dm = "base_reload_dm",
	base_reload_empty_dm = "base_reload_empty_dm",
	base_reload_dm_quick = "base_reload_dm_quick",
	base_reload_empty_dm_quick = "base_reload_empty_dm_quick",
	base_draw = "base_draw",
	base_draw_first = "base_draw_first",
	base_draw_quick = "base_draw_quick",
	base_holster = "base_holster",
	base_holster_quick = "base_holster_quick",
	base_jump = "base_jump",
	base_jump_land = "base_jump_land",
	base_melee = "base_melee",
	base_crawl_loop = "base_crawl_loop",
	base_mantle_over = "base_mantle_over",
	base_sprint_in = "base_sprint_in",
	base_sprint_loop = "base_sprint_loop",
	base_sprint_out	= "base_sprint_out",
	}
	
SWEP.Sounds = { 
	base_reload = {
	[1] = {time = 0.35, sound = "Weapon_BLACKOPS3_P08.Magout"},
	[2] = {time = 1.9, sound = "Weapon_BLACKOPS3_P08.Magin"},
	},

	base_reload_empty = {
	[1] = {time = 0.35, sound = "Weapon_BLACKOPS3_P08.Magout"},
	[2] = {time = 1.9, sound = "Weapon_BLACKOPS3_P08.Magin"},
	[3] = {time = 2.8, sound = "Weapon_BLACKOPS3_P08.Bolt_Back"},
	},	

	base_reload_ext = {
	[1] = {time = 0.35, sound = "Weapon_BLACKOPS3_P08.Magout"},
	[2] = {time = 1.9, sound = "Weapon_BLACKOPS3_P08.Magin"},
	},

	base_reload_empty_ext = {
	[1] = {time = 0.35, sound = "Weapon_BLACKOPS3_P08.Magout"},
	[2] = {time = 1.9, sound = "Weapon_BLACKOPS3_P08.Magin"},
	[3] = {time = 2.8, sound = "Weapon_BLACKOPS3_P08.Bolt_Back"},
	},	
	
	base_reload_dm = {
	[1] = {time = 0.2, sound = "Weapon_BLACKOPS3_P08.Magout"},
	[2] = {time = 1.2, sound = "Weapon_BLACKOPS3_P08.Magin"},
	},

	base_reload_empty_dm = {
	[1] = {time = 0.2, sound = "Weapon_BLACKOPS3_P08.Magout"},
	[2] = {time = 1.2, sound = "Weapon_BLACKOPS3_P08.Magin"},
	[3] = {time = 1.6, sound = "Weapon_BLACKOPS3_P08.Bolt_Release"},
	},
	
	base_draw_first = {
	[1] = {time = 0.4, sound = "Weapon_BLACKOPS3_P08.Bolt_Back"},
	},
}
	
SWEP.SpeedDec = 30

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"3burst"}
SWEP.Base = "cw_blackops3_base"
SWEP.Category = "CW 2.0 Black Ops III"

SWEP.Author				= "Loyalists"
SWEP.Contact			= ""
SWEP.Purpose			= ""

SWEP.Trivia = {
	text = "Charged burst sniper rifle. Hold the trigger to charge up and fire 3 deadly rounds at a rapid fire rate.",
	x = -300, 
	y = -400, 
--	textFormatFunc = function(self, wep) if wep.ActiveAttachments.md_bipod then return "" else return self.text end end
	}

SWEP.ViewModelFOV	= 65
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/loyalists/blackops3/p08/v_sr_p08.mdl"
SWEP.WorldModel		= "models/loyalists/blackops3/p08/w_sr_p08.mdl"
SWEP.WM				= "models/loyalists/blackops3/p08/w_sr_p08.mdl"
SWEP.WMPos			= Vector(-1,0,0)
SWEP.WMAng			= Vector(-3,0,180)
SWEP.DrawTraditionalWorldModel = false

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.SnapToIdlePostReload = false

SWEP.Primary.ClipSize		= 15
SWEP.Primary.ClipSize_Ext	= 21
SWEP.Primary.DefaultClip	= 75
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "7.62x51MM"

SWEP.FireDelay				= 0.06
SWEP.FireSound				= "CW_BLACKOPS3_P08_FIRE"
SWEP.FireSoundSuppressed	= "CW_BLACKOPS3_P08_FIRE_SUPPRESSED"
SWEP.Recoil					= 0.15

SWEP.HipSpread = 0.15
SWEP.AimSpread = 0.01
SWEP.VelocitySensitivity = 1.5
SWEP.MaxSpreadInc = 0.1
SWEP.SpreadPerShot = 0.002
SWEP.SpreadCooldown = 0.8
SWEP.Shots = 1
SWEP.Damage = 75

SWEP.ViewbobIntensity = 0.25

SWEP.HolsterSpeed = 1
SWEP.HolsterTime = 1

SWEP.DeployTime = 0.83
SWEP.FirstDeployTime = 1.3
SWEP.FirstDrawSpeed = 1

SWEP.ReloadSpeed = 1.0
SWEP.ReloadTime = 2.9
SWEP.ReloadTime_Empty = 3.8
SWEP.ReloadHalt = 2.9
SWEP.ReloadHalt_Empty = 3.8
SWEP.ReloadTime_Fast = 2.15
SWEP.ReloadTime_Empty_Fast = 2.45

SWEP.MeleeAttackRange = 50
SWEP.MeleeAttackDamage = 75
SWEP.MeleeInTime = 0.15
SWEP.MeleeOutTime = 0.75
SWEP.MeleeAttackDamageWindow = 0.05

SWEP.ChargeUpTime = 0.5
SWEP.ChargeDownTime = 0.5
SWEP.BurstCooldownMul = 8

// Custom Features
SWEP.QuickMeleeLogic = true
SWEP.DualMagLogic = false
SWEP.ChargedLogic = true

if CLIENT then
	local old, x, y, ang
	local reticle = surface.GetTextureID("blackops3/reticles/i_t7_attach_optic_thermal_reticle_c")

	local lensstring = "models/loyalists/blackops3/p08/mc_mtl_wpn_t7_p08_scope_overlay"
	local lens = surface.GetTextureID(lensstring)
	local lensMat = Material("blackops3/reticles/i_t7_attach_optic_thermal_reticle_c")
	local RTMat = Material(lensstring)
	
	local cd, alpha = {}, 0.5
	local Ini = true

	cd.x = 0
	cd.y = 0
	cd.w = 512
	cd.h = 512
	cd.fov = 3
	cd.drawviewmodel = false
	cd.drawhud = false
	cd.dopostprocess = false

	function SWEP:RenderTargetFunc()
		if not self.CW_VM then
			return
		end
	
		local complexTelescopics = self:canUseComplexTelescopics()
		
		-- if not complexTelescopics then
			-- RTMat:SetTexture("$basetexture", lensMat:GetTexture("$basetexture"))
			-- return
		-- end
		
		if self.dt.State == CW_AIMING and not self.Peeking and self.AimPos == self.IronsightPos then
			alpha = math.Approach(alpha, 0, FrameTime() * 5)
		else
			alpha = math.Approach(alpha, 1, FrameTime() * 5)
		end
		
		x, y = ScrW(), ScrH()
		old = render.GetRenderTarget()

		ang = self:getTelescopeAngles()
		
		if self.ViewModelFlip then
			ang.r = -self.BlendAng.z
		else
			ang.r = self.BlendAng.z
		end
		
		if not self.freeAimOn then
			ang:RotateAroundAxis(ang:Right(), self.RTAlign.right)
			ang:RotateAroundAxis(ang:Up(), self.RTAlign.up)
			ang:RotateAroundAxis(ang:Forward(), self.RTAlign.forward)
		end
		
		local size = self:getRenderTargetSize()

		cd.w = size
		cd.h = size
		cd.angles = ang
		cd.origin = self.Owner:GetShootPos()
		
		render.SetRenderTarget(self.ScopeRT)
		render.SetViewPort(0, 0, size, size)
			if alpha < 1 or Ini then
				render.RenderView(cd)
				Ini = false
			end
			
			ang = self.Owner:EyeAngles()
			ang.p = ang.p + self.BlendAng.x
			ang.y = ang.y + self.BlendAng.y
			ang.r = ang.r + self.BlendAng.z
			ang = -ang:Forward()
			
			-- local light = render.ComputeLighting(self.Owner:GetShootPos(), ang)
			
			cam.Start2D()
				surface.SetDrawColor(255, 255, 255, 255)
				surface.SetTexture(reticle)
				surface.DrawTexturedRectRotated(size * 0.5, size * 0.5, size, size, self.RTAlign.forward)
				
				surface.SetDrawColor(0, 0, 0, 255 * alpha)
				-- surface.SetTexture(lens)
				-- surface.DrawTexturedRectRotated(size * 0.5, size * 0.5, size, size, 90)
				surface.DrawRect(0, 0, size, size, 90)
			cam.End2D()
			
		render.SetViewPort(0, 0, x, y)
		render.SetRenderTarget(old)
		
		-- if RTMat then
			-- if self.dt.State == CW_AIMING then
				RTMat:SetTexture("$basetexture", self.ScopeRT)
			-- else
				-- RTMat:SetTexture("$basetexture", lensstring)
			-- end
		-- end
	end
end