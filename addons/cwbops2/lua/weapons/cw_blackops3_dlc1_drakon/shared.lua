CustomizableWeaponry_BlackOps3_DLC1 = true

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Drakon"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	killicon.Add( "cw_blackops3_dlc1_drakon", "blackops3/icon_kill/cw_blackops3_dlc1_drakon", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("blackops3/icon_weapons/cw_blackops3_dlc1_drakon")
	
	SWEP.MuzzleEffect = "muzzleflash_SR25"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	
	SWEP.ShellScale = 0.9
	SWEP.ShellOffsetMul = 1
	SWEP.ShellDelay = 0.0
	SWEP.ShellPosOffset = {x = 0, y = 0, z = 0}

	SWEP.IronsightPos = Vector(-9.24, -14.8513, 0.815)
	SWEP.IronsightAng = Vector(0, 0, 0)

	SWEP.BO3_ELOPos = Vector(-9.24, -19.7453, 0.2872)
	SWEP.BO3_ELOAng = Vector(0, 0, 0)

	SWEP.BO3_ACOGPos = Vector(-9.24, -12.3447, 0.54)
	SWEP.BO3_ACOGAng = Vector(0, 0, 0)

	SWEP.BO3_HybirdPos = Vector(-9.24, 23.1667, -0.54)
	SWEP.BO3_HybirdAng = Vector(0, 0, 0)

	SWEP.BO3_IRPos = Vector(-9.24, -14.5005, 0.54)
	SWEP.BO3_IRAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(2.95, -3.057, -4.119)
	SWEP.SprintAng = Vector(-13.131, 33.537, -29.906)
	
	SWEP.CustomizePos = Vector(20.199, -5.829, 5)
	SWEP.CustomizeAng = Vector(21.255, 37.437, 30.848)
	
	SWEP.AlternativePos = Vector(0, 0, 0)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.AimBreathingEnabled = true
	SWEP.CrosshairEnabled = false
	
	SWEP.HipFireFOVIncrease = false
	
	SWEP.RTAlign = {right = 0, up = 0, forward = 180}

	SWEP.OverrideAimMouseSens = 0.3
	
	SWEP.CustomizationMenuScale = 0.035
	
	SWEP.AttachmentModelsVM = {
		["md_blackops3_sil_ar"] = {model = "models/loyalists/blackops3/drakon/sil_drakon_01.mdl", pos = Vector(74.7898, 0, 8.7103), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_hybrid"] = {model = "models/loyalists/blackops3/public/optic_hybrid.mdl", pos = Vector(7.9812, 0, 15.7), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_acog"] = {model = "models/loyalists/blackops3/public/optic_acog.mdl", pos = Vector(7.9812, 0, 15.4), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_ir"] = {model = "models/loyalists/blackops3/public/optic_thermal.mdl", pos = Vector(7.9812, 0, 15.4), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["bg_blackops3_stock_heavy"] = {model = "models/loyalists/blackops3/drakon/stock_drakon_01.mdl", pos = Vector(0, 0, 0), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone_merge = true},
		["bg_blackops3_stock_light"] = {model = "models/loyalists/blackops3/drakon/stock_drakon_02.mdl", pos = Vector(0, 0, 0), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone_merge = true},
		["md_blackops3_elo"] = {model = "models/loyalists/blackops3/public/optic_laser.mdl", pos = Vector(7.9812, 0, 15.8), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
	}
	
	SWEP.AttachmentModelsWM = {
		["md_blackops3_sil_ar"] = {model = "models/loyalists/blackops3/drakon/sil_drakon_01.mdl", pos = Vector(27.8412, 0, 3.2227), angle = Angle(0, -90, 0), size = Vector(0.3, 0.3, 0.3), bone = "tag_weapon"},
		["md_blackops3_hybrid"] = {model = "models/loyalists/blackops3/public/optic_hybrid.mdl", pos = Vector(3.2593, 0, 5.7788), angle = Angle(0, -90, 0), size = Vector(0.4, 0.4, 0.4), bone = "tag_weapon"},
		["md_blackops3_acog"] = {model = "models/loyalists/blackops3/public/optic_acog.mdl", pos = Vector(3.2593, 0, 5.7788), angle = Angle(0, -90, 0), size = Vector(0.4, 0.4, 0.4), bone = "tag_weapon"},
		["md_blackops3_ir"] = {model = "models/loyalists/blackops3/public/optic_thermal.mdl", pos = Vector(3.2593, 0, 5.7788), angle = Angle(0, -90, 0), size = Vector(0.4, 0.4, 0.4), bone = "tag_weapon"},
		["md_blackops3_elo"] = {model = "models/loyalists/blackops3/public/optic_laser.mdl", pos = Vector(3.2593, 0, 5.7788), angle = Angle(0, -90, 0), size = Vector(0.4, 0.4, 0.4), bone = "tag_weapon"},
	}
end

SWEP.MuzzleVelocity = 936

SWEP.PreventQuickScoping = true
SWEP.QuickScopeSpreadIncrease = 0.2

SWEP.SightBGs = {main = 1, carryhandle = 0, none = 1}
SWEP.MagBGs = {main = 2, fast_mag = 2, ext_mag = 1, regular = 0}
SWEP.StockBGs = {main = 5, light = 1, heavy = 1, regular = 0}
SWEP.WMSightBGs = {main = 1, carryhandle = 0, none = 1}

SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {
	[1] = {header = "Sight", offset = {1100, -100},  atts = {"md_blackops3_elo", "md_blackops3_acog", "md_blackops3_hybrid", "md_blackops3_ir"}},
	[2] = {header = "Magazine", offset = {1100, 800}, atts = {"bg_blackops3_fast_mag", "bg_blackops3_ext_mag"}},
	[3] = {header = "Barrel", offset = {-100, -100}, atts = {"md_blackops3_sil_ar"}},
	[4] = {header = "Stock", offset = {2000, 800}, atts = {"bg_blackops3_stock_heavy", "bg_blackops3_stock_light"}},
	["+reload"] = {header = "Ammo", offset = {2000, 1200}, atts = {"am_magnum", "am_matchgrade"}}
	}

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
	base_sprint_out	= "base_sprint_out",
	}
	
SWEP.Sounds = { 
	base_reload = {
	[1] = {time = 0.5, sound = "Weapon_BLACKOPS3_DRAKON.Magout"},
	[2] = {time = 1.9, sound = "Weapon_BLACKOPS3_DRAKON.Magin"},
	},

	base_reload_empty = {
	[1] = {time = 0.5, sound = "Weapon_BLACKOPS3_DRAKON.Magout"},
	[2] = {time = 1.9, sound = "Weapon_BLACKOPS3_DRAKON.Magin"},
	[3] = {time = 2.7, sound = "Weapon_BLACKOPS3_DRAKON.Bolt_Back"},
	[4] = {time = 2.85, sound = "Weapon_BLACKOPS3_DRAKON.Bolt_Forward"},
	},	

	base_reload_ext = {
	[1] = {time = 0.5, sound = "Weapon_BLACKOPS3_DRAKON.Magout"},
	[2] = {time = 1.9, sound = "Weapon_BLACKOPS3_DRAKON.Magin"},
	},

	base_reload_empty_ext = {
	[1] = {time = 0.5, sound = "Weapon_BLACKOPS3_DRAKON.Magout"},
	[2] = {time = 1.9, sound = "Weapon_BLACKOPS3_DRAKON.Magin"},
	[3] = {time = 2.7, sound = "Weapon_BLACKOPS3_DRAKON.Bolt_Back"},
	[4] = {time = 2.85, sound = "Weapon_BLACKOPS3_DRAKON.Bolt_Forward"},
	},	
	
	base_reload_dm = {
	[1] = {time = 0.25, sound = "Weapon_BLACKOPS3_DRAKON.Magout"},
	[2] = {time = 1.4, sound = "Weapon_BLACKOPS3_DRAKON.Magin"},
	},

	base_reload_empty_dm = {
	[1] = {time = 0.25, sound = "Weapon_BLACKOPS3_DRAKON.Magout"},
	[2] = {time = 1.4, sound = "Weapon_BLACKOPS3_DRAKON.Magin"},
	[3] = {time = 1.9, sound = "Weapon_BLACKOPS3_DRAKON.Bolt_Forward"},
	},
	
	base_draw_first = {
	[1] = {time = 0.5, sound = "Weapon_BLACKOPS3_DRAKON.Bolt_Back"},
	[2] = {time = 0.65, sound = "Weapon_BLACKOPS3_DRAKON.Bolt_Forward"},
	},
}

SWEP.SpeedDec = 50

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_blackops3_base"
SWEP.Category = "CW 2.0 Black Ops III"

SWEP.Author				= "Loyalists"
SWEP.Contact			= ""
SWEP.Purpose			= ""

SWEP.Trivia = {
	text = "Semi-auto sniper rifle. Eliminates enemies with 2 body shots, or 1 shot to the head.",
	x = -300, 
	y = -400, 
--	textFormatFunc = function(self, wep) if wep.ActiveAttachments.md_bipod then return "" else return self.text end end
	}

SWEP.ViewModelFOV	= 65
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/loyalists/blackops3/drakon/v_sr_drakon.mdl"
SWEP.WorldModel		= "models/loyalists/blackops3/drakon/w_sr_drakon.mdl"
SWEP.WM 			= "models/loyalists/blackops3/drakon/w_sr_drakon.mdl"
SWEP.WMPos			= Vector(-1, 0, 0)
SWEP.WMAng			= Vector(-5, 0, 180)
	
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 20
SWEP.Primary.ClipSize_Ext	= 28
SWEP.Primary.DefaultClip	= 80
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "7.62x51MM"

SWEP.FireDelay				= 60/240
SWEP.FireSound				= "CW_BLACKOPS3_DRAKON_FIRE"
SWEP.FireSoundSuppressed	= "CW_BLACKOPS3_DRAKON_FIRE_SUPPRESSED"
SWEP.Recoil					= 1.0

SWEP.HipSpread = 0.1
SWEP.AimSpread = 0.001
SWEP.VelocitySensitivity = 1.5
SWEP.MaxSpreadInc = 0.2
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 1.4
SWEP.Shots = 1
SWEP.Damage = 80

SWEP.HolsterSpeed = 1
SWEP.HolsterTime = 1

SWEP.DeployTime = 1.2
SWEP.FirstDeployTime = 1.4

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.9
SWEP.ReloadTime_Empty = 3.6
SWEP.ReloadHalt = 2.9
SWEP.ReloadHalt_Empty = 3.6
SWEP.ReloadTime_Fast = 2.1
SWEP.ReloadTime_Empty_Fast = 2.4

SWEP.RechamberSpeed = 1
SWEP.RechamberTime = 0.75

SWEP.MeleeAttackRange = 50
SWEP.MeleeAttackDamage = 75
SWEP.MeleeInTime = 0.15
SWEP.MeleeOutTime = 0.7

SWEP.ViewbobIntensity = 0.25

// Custom Features
SWEP.QuickMeleeLogic = true
SWEP.DualMagLogic = false

if CLIENT then
	local old, x, y, ang
	local reticle = surface.GetTextureID("blackops3/reticles/i_wpn_t7_snp_drakon_scope_reticle_c")
	local reticle2 = surface.GetTextureID("blackops3/reticles/i_t7_attach_optic_reflex_reticle_c")
	
	local lensstring = "models/loyalists/blackops3/drakon/scope/i_wpn_t7_snp_drakon_scope_glass_front_c"
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
				surface.DrawTexturedRectRotated(size * 0.5, size * 0.5, size * 1.0, size * 1.0, self.RTAlign.forward)
				
				surface.SetDrawColor(255, 255, 255, 255)
				surface.SetTexture(reticle)
				surface.DrawTexturedRectRotated(size * 0.5, size * 0.5, size * 1.2, size * 1.2, self.RTAlign.forward)
				
				surface.SetDrawColor(255, 75, 75, 255)
				surface.SetTexture(reticle2)
				surface.DrawTexturedRectRotated(size * 0.5, size * 0.5, size * 0.25, size * 0.25, self.RTAlign.forward)
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