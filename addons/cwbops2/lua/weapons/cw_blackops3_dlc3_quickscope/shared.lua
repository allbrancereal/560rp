AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "RSA Interdiction"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	killicon.Add( "cw_blackops3_dlc3_quickscope", "blackops3/icon_kill/cw_blackops3_dlc3_quickscope", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("blackops3/icon_weapons/cw_blackops3_dlc3_quickscope")
	
	SWEP.MuzzleEffect = "muzzleflash_SR25"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	
	SWEP.ShellScale = 0.9
	SWEP.ShellOffsetMul = 1
	SWEP.ShellDelay = 0.7
	SWEP.ShellPosOffset = {x = 0, y = 0, z = 0}

	SWEP.IronsightPos = Vector(-10.2728, -24.275, 0.1704)
	SWEP.IronsightAng = Vector(0, 0, 0)

	SWEP.BO3_ELOPos = Vector(-10.2728, -32.1174, 0.9545)
	SWEP.BO3_ELOAng = Vector(0, 0, 0)

	SWEP.BO3_ACOGPos = Vector(-10.2728, -32.2637, 1.1059)
	SWEP.BO3_ACOGAng = Vector(0, 0, 0)

	SWEP.BO3_HybirdPos = Vector(-10.2728, 19.9959, 0.0154)
	SWEP.BO3_HybirdAng = Vector(0, 0, 0)

	SWEP.BO3_IRPos = Vector(-10.2728, -24.275, 0.1704)
	SWEP.BO3_IRAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(2.95, -3.057, -4.119)
	SWEP.SprintAng = Vector(-13.131, 33.537, -29.906)
	
	SWEP.CustomizePos = Vector(20.199, -5.829, 5)
	SWEP.CustomizeAng = Vector(21.255, 37.437, 30.848)
	
	SWEP.AlternativePos = Vector(0, 0, 0)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.AimBreathingEnabled = true
	SWEP.CrosshairEnabled = false
	
	SWEP.RTAlign = {right = 0, up = 0, forward = 127.5}
	
	SWEP.CustomizationMenuScale = 0.045
	
	SWEP.OverrideAimMouseSens = 0.3
	
	SWEP.AttachmentModelsVM = {
		["md_blackops3_sil_ar"] = {model = "models/loyalists/blackops3/dlc_quickscope/quickscope_sil_01.mdl", pos = Vector(80.7339, 0, 12.0368), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_hybrid"] = {model = "models/loyalists/blackops3/public/optic_hybrid.mdl", pos = Vector(13.2621, 0, 17.5089), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_acog"] = {model = "models/loyalists/blackops3/public/optic_acog.mdl", pos = Vector(14.9717, 0, 17.2071), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_ir"] = {model = "models/loyalists/blackops3/public/optic_thermal.mdl", pos = Vector(13.2621, 0, 16.9517), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_elo"] = {model = "models/loyalists/blackops3/public/optic_laser.mdl", pos = Vector(13.2621, 0, 17.5089), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["bg_blackops3_stock_heavy"] = {model = "models/loyalists/blackops3/dlc_quickscope/quickscope_stock_01.mdl", pos = Vector(0, 0, 0), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone_merge = true},
	}
	
	SWEP.AttachmentModelsWM = {
		["md_blackops3_sil_ar"] = {model = "models/loyalists/blackops3/dlc_quickscope/quickscope_sil_01.mdl", pos = Vector(32.5637, 0, 4.2925), angle = Angle(0, -90, 0), size = Vector(0.4, 0.4, 0.4), bone = "tag_weapon"},
		["md_blackops3_hybrid"] = {model = "models/loyalists/blackops3/public/optic_hybrid.mdl", pos = Vector(5.3771, 0, 6.3213), angle = Angle(0, -90, 0), size = Vector(0.4, 0.4, 0.4), bone = "tag_weapon"},
		["md_blackops3_acog"] = {model = "models/loyalists/blackops3/public/optic_acog.mdl", pos = Vector(5.3771, 0, 6.3213), angle = Angle(0, -90, 0), size = Vector(0.4, 0.4, 0.4), bone = "tag_weapon"},
		["md_blackops3_ir"] = {model = "models/loyalists/blackops3/public/optic_thermal.mdl", pos = Vector(5.3771, 0, 6.3213), angle = Angle(0, -90, 0), size = Vector(0.4, 0.4, 0.4), bone = "tag_weapon"},
		["md_blackops3_elo"] = {model = "models/loyalists/blackops3/public/optic_laser.mdl", pos = Vector(5.3771, 0, 6.3213), angle = Angle(0, -90, 0), size = Vector(0.4, 0.4, 0.4), bone = "tag_weapon"},
	}
end

SWEP.MuzzleVelocity = 936

SWEP.PreventQuickScoping = true
SWEP.QuickScopeSpreadIncrease = 0.2

SWEP.SightBGs = {main = 2, carryhandle = 0, none = 1}
SWEP.MagBGs = {main = 1, ext_mag = 1, regular = 0}
SWEP.StockBGs = {main = 4, light = 2, heavy = 1, regular = 0}
SWEP.BarrelBGs = {main = 6, regular = 0, none = 1}
SWEP.WMSightBGs = {main = 1, carryhandle = 0, none = 1}
SWEP.WMBarrelBGs = {main = 2, regular = 0, none = 1}

SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {
	[1] = {header = "Sight", offset = {1100, -100},  atts = {"md_blackops3_elo", "md_blackops3_acog", "md_blackops3_hybrid", "md_blackops3_ir"}},
	[2] = {header = "Magazine", offset = {1100, 800}, atts = {"bg_blackops3_fast_mag", "bg_blackops3_ext_mag"}},
	[3] = {header = "Barrel", offset = {-100, -100}, atts = {"md_blackops3_sil_ar"}},
	[4] = {header = "Stock", offset = {1700, 800}, atts = {"bg_blackops3_stock_heavy", "bg_blackops3_stock_light"}},
	["+reload"] = {header = "Ammo", offset = {1700, 400}, atts = {"am_magnum", "am_matchgrade"}}
	}

SWEP.Animations = {
	base_idle = "base_idle",
	base_fire = "base_fire",
	base_fire_ads = "base_fire_ads",
	base_rechamber = "base_rechamber",
	base_rechamber_ads = "base_rechamber_ads",
	base_reload = "base_reload",
	base_reload_empty = "base_reload_empty",
	base_reload_ext = "base_reload_ext",
	base_reload_empty_ext = "base_reload_empty_ext",
	base_reload_dm = "base_reload_dm",
	base_reload_empty_dm = "base_reload_empty_dm",
	base_draw = "base_draw",
	base_draw_first = "base_draw_first",
	base_draw_quick = "base_draw_quick",
	base_holster = "base_holster",
	base_holster_quick = "base_holster_quick",
	base_melee = "base_melee",
	base_crawl_loop = "base_crawl_loop",
	base_mantle_over = "base_mantle_over",
	base_sprint_in = "base_sprint_in",
	base_sprint_loop = "base_sprint_loop",
	base_sprint_out = "base_sprint_out",
	}
	
SWEP.Sounds = { 
	base_reload = {
	[1] = {time = 0.2, sound = "Weapon_BLACKOPS3_QUICKSCOPE.Spin"},
	[2] = {time = 0.5, sound = "Weapon_BLACKOPS3_QUICKSCOPE.Magout"},
	[3] = {time = 2.2, sound = "Weapon_BLACKOPS3_QUICKSCOPE.Magin"},
	[4] = {time = 2.5, sound = "Weapon_BLACKOPS3_QUICKSCOPE.Tap"},
	},

	base_reload_empty = {
	[1] = {time = 0.35, sound = "Weapon_BLACKOPS3_QUICKSCOPE.Bolt_Back"},
	[2] = {time = 1.0, sound = "Weapon_BLACKOPS3_QUICKSCOPE.Spin"},
	[3] = {time = 1.5, sound = "Weapon_BLACKOPS3_QUICKSCOPE.Magout"},
	[4] = {time = 2.9, sound = "Weapon_BLACKOPS3_QUICKSCOPE.Magin"},
	[5] = {time = 3.2, sound = "Weapon_BLACKOPS3_QUICKSCOPE.Tap"},
	[6] = {time = 4.1, sound = "Weapon_BLACKOPS3_QUICKSCOPE.Bolt_Forward"},
	},	

	base_reload_ext = {
	[1] = {time = 0.2, sound = "Weapon_BLACKOPS3_QUICKSCOPE.Spin"},
	[2] = {time = 0.5, sound = "Weapon_BLACKOPS3_QUICKSCOPE.Magout"},
	[3] = {time = 2.2, sound = "Weapon_BLACKOPS3_QUICKSCOPE.Magin"},
	[4] = {time = 2.5, sound = "Weapon_BLACKOPS3_QUICKSCOPE.Tap"},
	[5] = {time = 2.6, sound = "Weapon_BLACKOPS3_QUICKSCOPE.Spin"},
	},

	base_reload_empty_ext = {
	[1] = {time = 0.35, sound = "Weapon_BLACKOPS3_QUICKSCOPE.Bolt_Back"},
	[2] = {time = 1.0, sound = "Weapon_BLACKOPS3_QUICKSCOPE.Spin"},
	[3] = {time = 1.5, sound = "Weapon_BLACKOPS3_QUICKSCOPE.Magout"},
	[4] = {time = 2.9, sound = "Weapon_BLACKOPS3_QUICKSCOPE.Magin"},
	[5] = {time = 3.2, sound = "Weapon_BLACKOPS3_QUICKSCOPE.Tap"},
	[6] = {time = 3.3, sound = "Weapon_BLACKOPS3_QUICKSCOPE.Spin"},
	[7] = {time = 4.1, sound = "Weapon_BLACKOPS3_QUICKSCOPE.Bolt_Forward"},
	},	
	
	base_reload_dm = {
	[1] = {time = 0.2, sound = "Weapon_BLACKOPS3_QUICKSCOPE.Spin"},
	[2] = {time = 0.5, sound = "Weapon_BLACKOPS3_QUICKSCOPE.Magout"},
	[3] = {time = 1.8, sound = "Weapon_BLACKOPS3_QUICKSCOPE.Magin"},
	[4] = {time = 2.0, sound = "Weapon_BLACKOPS3_QUICKSCOPE.Tap"},
	},

	base_reload_empty_dm = {
	[1] = {time = 0.2, sound = "Weapon_BLACKOPS3_QUICKSCOPE.Bolt_Back"},
	[2] = {time = 0.7, sound = "Weapon_BLACKOPS3_QUICKSCOPE.Spin"},
	[3] = {time = 1.1, sound = "Weapon_BLACKOPS3_QUICKSCOPE.Magout"},
	[4] = {time = 2.5, sound = "Weapon_BLACKOPS3_QUICKSCOPE.Magin"},
	[5] = {time = 2.9, sound = "Weapon_BLACKOPS3_QUICKSCOPE.Tap"},
	[6] = {time = 3.0, sound = "Weapon_BLACKOPS3_QUICKSCOPE.Spin"},
	[7] = {time = 3.4, sound = "Weapon_BLACKOPS3_QUICKSCOPE.Bolt_Forward"},
	},
	
	base_rechamber = {
	[1] = {time = 0.35, sound = "Weapon_BLACKOPS3_QUICKSCOPE.Bolt_Back"},
	[2] = {time = 0.7, sound = "Weapon_BLACKOPS3_QUICKSCOPE.Bolt_Forward"},
	},

	base_rechamber_ads = {
	[1] = {time = 0.35, sound = "Weapon_BLACKOPS3_QUICKSCOPE.Bolt_Back"},
	[2] = {time = 0.7, sound = "Weapon_BLACKOPS3_QUICKSCOPE.Bolt_Forward"},
	},	
	
	base_draw_first = {
	[1] = {time = 0.55, sound = "Weapon_BLACKOPS3_QUICKSCOPE.Shell_In"},
	[2] = {time = 0.9, sound = "Weapon_BLACKOPS3_QUICKSCOPE.Tap"},
	},	
}

SWEP.SpeedDec = 50

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"bolt"}
SWEP.Base = "cw_blackops3_base"
SWEP.Category = "CW 2.0 Black Ops III"

SWEP.Author				= "Loyalists"
SWEP.Contact			= ""
SWEP.Purpose			= ""

SWEP.Trivia = {
	text = "Bolt-action sniper rifle. 1-shot kill to the upper chest and above.",
	x = -300, 
	y = -400, 
--	textFormatFunc = function(self, wep) if wep.ActiveAttachments.md_bipod then return "" else return self.text end end
	}

SWEP.ViewModelFOV	= 60
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/loyalists/blackops3/dlc_quickscope/v_sr_quickscope.mdl"
SWEP.WorldModel		= "models/loyalists/blackops3/dlc_quickscope/w_sr_quickscope.mdl"
SWEP.WM 			= "models/loyalists/blackops3/dlc_quickscope/w_sr_quickscope.mdl"
SWEP.WMPos 			= Vector(-1, 0, 2)
SWEP.WMAng 			= Vector(-5, 0, 180)
	
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 6
SWEP.Primary.ClipSize_Ext	= 8
SWEP.Primary.DefaultClip	= 24
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".338 Lapua"

SWEP.FireDelay 				= 0.2
SWEP.FireSound				= "CW_BLACKOPS3_QUICKSCOPE_FIRE"
SWEP.FireSoundSuppressed	= "CW_BLACKOPS3_QUICKSCOPE_FIRE_SUPPRESSED"
SWEP.Recoil 				= 1.5

SWEP.HipSpread = 0.1
SWEP.AimSpread = 0.001
SWEP.VelocitySensitivity = 1.5
SWEP.MaxSpreadInc = 0.2
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 1.55
SWEP.Shots = 1
SWEP.Damage = 75

SWEP.HolsterSpeed = 1
SWEP.HolsterTime = 1.3

SWEP.DeployTime = 1.4
SWEP.FirstDeployTime = 1.8
SWEP.FirstDrawSpeed = 1

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 3.5
SWEP.ReloadTime_Empty = 4.8
SWEP.ReloadHalt = 3.5
SWEP.ReloadHalt_Empty = 4.8
SWEP.ReloadTime_Ext = 3.5
SWEP.ReloadTime_Empty_Ext = 4.8
SWEP.ReloadTime_Fast = 2.7
SWEP.ReloadTime_Empty_Fast = 3.9

SWEP.RechamberSpeed = 1
SWEP.RechamberTime = 0.9
-- SWEP.RechamberDelayMul = 2.8

// Custom Features
SWEP.QuickMeleeLogic = true
SWEP.BoltActionLogic = true
SWEP.DualMagLogic = false
SWEP.Chamberable = false

if CLIENT then
	local old, x, y, ang
	local reticle = surface.GetTextureID("blackops3/reticles/reflex_26")
	local reticle2 = surface.GetTextureID("blackops3/reticles/i_wpn_t7_loot_sniper_quickscope_reticle_c")
	
	local lensstring = "models/loyalists/blackops3/dlc_quickscope/scope/mc_mtl_wpn_t7_loot_sniper_quickscope_scope_lens_base"
	local lens = surface.GetTextureID(lensstring)
	local lensMat = Material("cw2/gui/lense")
	local RTMat = Material(lensstring)
	local rim = surface.GetTextureID("blackops3/reticles/scope_reticle_rim")
	
	local cd, alpha = {}, 0.5
	local Ini = true

	-- render target var setup
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
		
		-- if not self.freeAimOn then
			ang:RotateAroundAxis(ang:Right(), self.RTAlign.right)
			ang:RotateAroundAxis(ang:Up(), self.RTAlign.up)
			ang:RotateAroundAxis(ang:Forward(), self.RTAlign.forward)
		-- end
		
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
				surface.SetDrawColor(0, 0, 0, 255 * alpha)
				-- surface.SetTexture(lens)
				-- surface.DrawTexturedRectRotated(size * 0.5, size * 0.5, size, size, 90)
				surface.DrawRect(0, 0, size, size, 90)
				
				surface.SetDrawColor(255, 255, 255, 255)
				surface.SetTexture(rim)
				surface.DrawTexturedRectRotated(size * 0.5, size * 0.5, size * 0.9, size * 0.9, self.RTAlign.forward)
				
				surface.SetDrawColor(255, 255, 255, 255)
				surface.SetTexture(reticle2)
				surface.DrawTexturedRectRotated(size * 0.5, size * 0.5, size * 1.2, size * 1.2, self.RTAlign.forward)
				
				surface.SetDrawColor(255, 75, 75, 255)
				surface.SetTexture(reticle)
				surface.DrawTexturedRectRotated(size * 0.5, size * 0.5, size * 0.05, size * 0.05, self.RTAlign.forward)
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