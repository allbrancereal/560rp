AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "KRM-262"
	SWEP.CSMuzzleFlashes = true
	SWEP.SnapToGrip = true	
	
	killicon.Add( "cw_blackops3_spartan", "blackops3/icon_kill/cw_blackops3_spartan", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("blackops3/icon_weapons/cw_blackops3_spartan")

	SWEP.IronsightPos = Vector(-8.62, 1.0289, 2.1)
	SWEP.IronsightAng = Vector(0, 0, 0)

	SWEP.BO3_ELOPos = Vector(-8.62, -8.0256, 0.9174)
	SWEP.BO3_ELOAng = Vector(0, 0, 0)

	SWEP.BO3_ReflexPos = Vector(-8.62, -6.4832, 0.4728)
	SWEP.BO3_ReflexAng = Vector(0, 0, 0)

	SWEP.BO3_ACOGPos = Vector(-8.62, -4.8213, 0.96)
	SWEP.BO3_ACOGAng = Vector(0, 0, 0)

	SWEP.BO3_HybirdPos = Vector(-8.62, 38.1634, -0.04)
	SWEP.BO3_HybirdAng = Vector(0, 0, 0)

	SWEP.BO3_HoloPos = Vector(-8.62, -9.3537, 0.5261)
	SWEP.BO3_HoloAng = Vector(0, 0, 0)

	SWEP.BO3_IRPos = Vector(-8.62, 10, 0.5261)
	SWEP.BO3_IRAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(2.95, -3.057, -4.119)
	SWEP.SprintAng = Vector(-13.131, 33.537, -29.906)

	SWEP.CustomizePos = Vector(20.199, -5.829, 5)
	SWEP.CustomizeAng = Vector(21.255, 37.437, 30.848)
	
	SWEP.AlternativePos = Vector(0, 0, 0)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.ViewModelMovementScale = 1.65
	
	SWEP.MuzzleEffect = "muzzleflash_m3"
	SWEP.PosBasedMuz = false
	SWEP.ShellScale = 0.9
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = -2, y = 0, z = -3}
	
	SWEP.BipodAngleLimitYaw = 40
	
	SWEP.SightWithRail = false
	
	SWEP.OffsetBoltOnBipodShoot = true

	SWEP.HUD_3D2DScale = 0.045
	
	SWEP.AttachmentModelsVM = {
		["md_blackops3_sil_ar"] = {model = "models/loyalists/blackops3/spartan/sil_spartan_01.mdl", pos = Vector(56.7703, 0, 7.3407), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_hybrid"] = {model = "models/loyalists/blackops3/public/optic_hybrid.mdl", pos = Vector(12.1296, 0, 3.85), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_reload_cover_animate"},
		["md_blackops3_reflex"] = {model = "models/loyalists/blackops3/public/optic_reflex.mdl", pos = Vector(12.1296, 0, 3.5), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_reload_cover_animate"},
		["md_blackops3_acog"] = {model = "models/loyalists/blackops3/public/optic_acog.mdl", pos = Vector(13.0, 0, 3.7), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_reload_cover_animate"},
		["md_blackops3_holo"] = {model = "models/loyalists/blackops3/public/optic_holo.mdl", pos = Vector(12.1296, 0, 3.7), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_reload_cover_animate"},
		["md_blackops3_ir"] = {model = "models/loyalists/blackops3/public/optic_thermal.mdl", pos = Vector(12.1296, 0, 3.5), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_reload_cover_animate"},
		["md_blackops3_elo"] = {model = "models/loyalists/blackops3/public/optic_laser.mdl", pos = Vector(12.1296, 0, 3.85), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_reload_cover_animate"},
		["md_blackops3_barrel_long"] = {model = "models/loyalists/blackops3/spartan/barrel_spartan_01.mdl", pos = Vector(0, 0, 0), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone_merge = true},
		["bg_blackops3_stock_heavy"] = {model = "models/loyalists/blackops3/spartan/stock_spartan_01.mdl", pos = Vector(0, 0, 0), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone_merge = true},
		["bg_blackops3_stock_light"] = {model = "models/loyalists/blackops3/spartan/stock_spartan_02.mdl", pos = Vector(0, 0, 0), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone_merge = true},
		["md_blackops3_dbal"] = {model = "models/loyalists/blackops3/spartan/dbal_spartan_01.mdl", pos = Vector(50, 4.6036, 6.826), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
	}
	
	SWEP.AttachmentModelsWM = {
		["md_blackops3_sil_ar"] = {model = "models/loyalists/blackops3/spartan/sil_spartan_01.mdl", pos = Vector(25.5193, 0, 3.25), angle = Angle(0, -90, 0), size = Vector(0.45, 0.45, 0.45), bone = "tag_weapon"},
		["md_blackops3_hybrid"] = {model = "models/loyalists/blackops3/public/optic_hybrid.mdl", bone = "tag_weapon", pos = Vector(4.4802, 0, 5.7958), angle = Angle(0, -90, 0), size = Vector(0.45, 0.45, 0.45)},	
		["md_blackops3_reflex"] = {model = "models/loyalists/blackops3/public/optic_reflex.mdl", bone = "tag_weapon", pos = Vector(4.4802, 0, 5.65), angle = Angle(0, -90, 0), size = Vector(0.45, 0.45, 0.45)},
		["md_blackops3_acog"] = {model = "models/loyalists/blackops3/public/optic_acog.mdl", bone = "tag_weapon", pos = Vector(4.4802, 0, 5.7958), angle = Angle(0, -90, 0), size = Vector(0.45, 0.45, 0.45)},	
		["md_blackops3_holo"] = {model = "models/loyalists/blackops3/public/optic_holo.mdl", bone = "tag_weapon", pos = Vector(4.4802, 0, 5.7958), angle = Angle(0, -90, 0), size = Vector(0.45, 0.45, 0.45)},
		["md_blackops3_ir"] = {model = "models/loyalists/blackops3/public/optic_thermal.mdl", bone = "tag_weapon", pos = Vector(4.4802, 0, 5.6), angle = Angle(0, -90, 0), size = Vector(0.45, 0.45, 0.45)},
		["md_blackops3_elo"] = {model = "models/loyalists/blackops3/public/optic_laser.mdl", pos = Vector(4.4802, 0, 5.7958), angle = Angle(0, -90, 0), size = Vector(0.45, 0.45, 0.45), bone = "tag_weapon"},
		["md_blackops3_dbal"] = {model = "models/loyalists/blackops3/spartan/dbal_spartan_01.mdl", pos = Vector(21.5, 2.0049, 3.0281), angle = Angle(0, -90, 0), size = Vector(0.45, 0.45, 0.45), bone = "tag_weapon"},
	}
	
	SWEP.CustomizationMenuScale = 0.035
end

SWEP.SightBGs = {main = 3, carryhandle = 0, none = 1}
SWEP.MagBGs = {main = 2, fast_mag = 2, ext_mag = 1, regular = 0}
SWEP.StockBGs = {main = 5, light = 1, heavy = 1, regular = 0}

SWEP.Attachments = {
	[1] = {header = "Sight", offset = {1100, -300},  atts = {"md_blackops3_elo", "md_blackops3_reflex", "md_blackops3_acog", "md_blackops3_hybrid", "md_blackops3_holo", "md_blackops3_ir"}},
	[2] = {header = "Magazine", offset = {600, 600}, atts = {"bg_blackops3_fast_mag", "bg_blackops3_ext_mag"}},
	[3] = {header = "Barrel", offset = {-100, -300}, atts = {"md_blackops3_barrel_long", "md_blackops3_sil_ar"}},
	[4] = {header = "Stock", offset = {1500, 600}, atts = {"bg_blackops3_stock_heavy", "bg_blackops3_stock_light"}},
	[5] = {header = "Rail", offset = {-100, 600}, atts = {"md_blackops3_dbal"}},
	["+reload"] = {header = "Ammo", offset = {1500, 200}, atts = {"am_magnum", "am_matchgrade"}}
	}

-- coded extended anims
-- INS2-ish nomenclature
SWEP.Animations = {
	base_idle = "base_idle",
	base_fire = "base_fire",
	base_fire_ads = "base_fire_ads",
	base_fire_last = "base_fire_last",
	base_reload_in = "base_reload_in",
	base_reload_in_dm = "base_reload_in_dm",
	base_reload_loop = "base_reload_loop",
	base_reload_loop_dm = "base_reload_loop_dm",
	base_reload_out = "base_reload_out",
	base_reload_out_dm = "base_reload_out_dm",
	base_rechamber = "base_rechamber",
	base_rechamber_ads = "base_rechamber_ads",
	base_draw = "base_draw",
	base_draw_quick = "base_draw_quick",
	base_draw_first = "base_draw_first",
	base_holster = "base_holster",
	base_holster_quick = "base_holster_quick",
	base_jump = "base_jump",
	base_jump_land = "base_jump_land",
	base_melee = "base_melee",
	base_crawl_loop = "base_crawl_loop",
	base_mantle_over = "base_mantle_over",
	base_sprint_in = "base_sprint_in",
	base_sprint_loop = "base_sprint_loop",
	base_sprint_out = "base_sprint_out",
	}
	
SWEP.Sounds = {
	base_reload_in = {
	[1] = {time = 0.0, sound = "Weapon_BLACKOPS3_Cloth.Med"},
	[2] = {time = 0.3, sound = "Weapon_BLACKOPS3_ARGUS.Lever_Open"},
	[3] = {time = 0.9, sound = "Weapon_BLACKOPS3_SPARTAN.Shell_In"},
	},

	base_reload_loop = {
	[1] = {time = 0.35, sound = "Weapon_BLACKOPS3_SPARTAN.Shell_In"},
	},
	
	base_reload_out = {
	[1] = {time = 0.3, sound = "Weapon_BLACKOPS3_ARGUS.Lever_Close"},
	[2] = {time = 0.6, sound = "Weapon_BLACKOPS3_SPARTAN.Pump_Back"},
	[3] = {time = 0.7, sound = "Weapon_BLACKOPS3_SPARTAN.Pump_Forward"},
	},
	
	base_reload_in_dm = {
	[1] = {time = 0.0, sound = "Weapon_BLACKOPS3_Cloth.Med"},
	[2] = {time = 0.3, sound = "Weapon_BLACKOPS3_ARGUS.Lever_Open"},
	[3] = {time = 0.9, sound = "Weapon_BLACKOPS3_SPARTAN.Shell_In"},
	},

	base_reload_loop_dm = {
	[1] = {time = 0.35, sound = "Weapon_BLACKOPS3_SPARTAN.Shell_In"},
	},
	
	base_reload_out_dm = {
	[1] = {time = 0.3, sound = "Weapon_BLACKOPS3_ARGUS.Lever_Close"},
	[2] = {time = 0.6, sound = "Weapon_BLACKOPS3_SPARTAN.Pump_Back"},
	[3] = {time = 0.7, sound = "Weapon_BLACKOPS3_SPARTAN.Pump_Forward"},
	},
	
	base_fire_last = {
	[1] = {time = 0.1, sound = "Weapon_BLACKOPS3_SPARTAN.Pump_Back"},
	[2] = {time = 0.3, sound = "Weapon_BLACKOPS3_SPARTAN.Pump_Forward"},
	},
	
	base_rechamber = {
	[1] = {time = 0.1, sound = "Weapon_BLACKOPS3_SPARTAN.Pump_Back"},
	[2] = {time = 0.3, sound = "Weapon_BLACKOPS3_SPARTAN.Pump_Forward"},
	},
	
	base_rechamber_ads = {
	[1] = {time = 0.1, sound = "Weapon_BLACKOPS3_SPARTAN.Pump_Back"},
	[2] = {time = 0.3, sound = "Weapon_BLACKOPS3_SPARTAN.Pump_Forward"},
	},
	
	base_draw_first = {
	[1] = {time = 0.0, sound = "Weapon_BLACKOPS3_Cloth.Med"},
	[2] = {time = 0.5, sound = "Weapon_BLACKOPS3_SPARTAN.Pump_Back"},
	[3] = {time = 0.7, sound = "Weapon_BLACKOPS3_SPARTAN.Pump_Forward"},
	},
}
	
SWEP.SpeedDec = 30

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "shotgun"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"pump"}
SWEP.Base = "cw_blackops3_base"
SWEP.Category = "CW 2.0 Black Ops III"

SWEP.Author				= "Loyalists"
SWEP.Contact			= ""
SWEP.Purpose			= ""

SWEP.Trivia = {
	text = "Pump-action shotgun. 1-hit kill against enemies in close quarters.",
	x = -300, 
	y = -400, 
--	textFormatFunc = function(self, wep) if wep.ActiveAttachments.md_bipod then return "" else return self.text end end
	}

SWEP.ViewModelFOV	= 65
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/loyalists/blackops3/spartan/v_shot_spartan.mdl"
SWEP.WorldModel		= "models/loyalists/blackops3/spartan/w_shot_spartan.mdl"
SWEP.WM				= "models/loyalists/blackops3/spartan/w_shot_spartan.mdl"
SWEP.WMPos			= Vector(-1,0,0)
SWEP.WMAng			= Vector(-5,0,180)
SWEP.DrawTraditionalWorldModel = false

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.SnapToIdlePostReload = false

SWEP.Primary.ClipSize		= 8
SWEP.Primary.ClipSize_Ext	= 11
SWEP.Primary.DefaultClip	= 12
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "12 Gauge"

SWEP.FireDelay				= 0.2
SWEP.FireSound				= "CW_BLACKOPS3_SPARTAN_FIRE"
SWEP.FireSoundSuppressed	= "CW_BLACKOPS3_SPARTAN_FIRE_SUPPRESSED"
SWEP.Recoil					= 1.5

SWEP.HipSpread = 0.08
SWEP.AimSpread = 0.02
SWEP.VelocitySensitivity = 2.5
SWEP.MaxSpreadInc = 0.08
SWEP.ClumpSpread = 0.025
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 1
SWEP.Shots = 8
SWEP.Damage = 14

SWEP.HolsterSpeed = 1
SWEP.HolsterTime = 0.5

SWEP.DeployTime = 0.83
SWEP.FirstDeployTime = 1.3
SWEP.FirstDrawSpeed = 1

SWEP.ReloadSpeed = 1.0
SWEP.FastMagReloadSpeed = 1.0
SWEP.RechamberDelayMul = 2.5

SWEP.ReloadStartTime = 1.1
SWEP.InsertShellTime = 0.6
SWEP.ReloadFinishWait = 0.91
SWEP.ReloadStartTime_Fast = 1.2
SWEP.InsertShellTime_Fast = 0.86
SWEP.ReloadFinishWait_Fast = 0.91

SWEP.MeleeAttackRange = 50
SWEP.MeleeAttackDamage = 75
SWEP.MeleeInTime = 0.15
SWEP.MeleeOutTime = 0.7

// Custom Features
SWEP.QuickMeleeLogic = true
SWEP.DualMagLogic = false
SWEP.ShotgunReload = true
SWEP.Chamberable = false
SWEP.BoltActionLogic = true -- it's a kind of bolt action...kinda
SWEP.FirstInsertBullet = true
SWEP.FirstInsertBulletDuration = 0.7
SWEP.FastMagInsertBulletAmount = 2

function SWEP:Rechamber()
	if not ( self.BoltActionLogic and not self.isRechambered ) then
		return
	end

	if self.ReloadDelay or CT < self.ReloadWait or self.dt.State == CW_ACTION or self.ShotgunReloadState != 0 then
		return
	end
	
	if CT < self.GlobalDelay then
		return
	end

	local prefix = self:GetPrefix()
	
	local CT = CurTime()

	local time = self.RechamberTime or (self.FireDelay * self.RechamberDelayMul)
	self.BipodDelay = CT + time
	self:SetNextPrimaryFire(CT + time)
	self.ReloadWait = CT + time
	self.HolsterWait = CT + time
	self.isRechambered = true
	
	if self.dt.State == CW_AIMING and not self.ActiveAttachments.md_blackops3_ir then
		self:sendWeaponAnim(prefix .. "rechamber_ads")
	else
		self:sendWeaponAnim(prefix .. "rechamber")
	end
end