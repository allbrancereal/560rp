CustomizableWeaponry_BlackOps3_DLC2 = true

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "KN-44"
	SWEP.CSMuzzleFlashes = true
	SWEP.SnapToGrip = true	
	
	killicon.Add( "cw_blackops3_dlc2_arak", "blackops3/icon_kill/cw_blackops3_dlc2_arak", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("blackops3/icon_weapons/cw_blackops3_dlc2_arak")
	
	SWEP.IronsightPos = Vector(-9.57, -3.1626, 0.76)
	SWEP.IronsightAng = Vector(0, 0, 0)

	SWEP.BO3_ELOPos = Vector(-9.57, -8.2371, -0.7806)
	SWEP.BO3_ELOAng = Vector(0, 0, 0)

	SWEP.BO3_ReflexPos = Vector(-9.57, -3.6666, -1.4127)
	SWEP.BO3_ReflexAng = Vector(0, 0, 0)

	SWEP.BO3_ACOGPos = Vector(-9.57, -3.1656, -0.5752)
	SWEP.BO3_ACOGAng = Vector(0, 0, 0)

	SWEP.BO3_HybirdPos = Vector(-9.57, 40.8841, -1.7)
	SWEP.BO3_HybirdAng = Vector(0, 0, 0)

	SWEP.BO3_HoloPos = Vector(-9.57, -5.7148, -1.4143)
	SWEP.BO3_HoloAng = Vector(0, 0, 0)

	SWEP.BO3_IRPos = Vector(-9.57, 10, -1.7)
	SWEP.BO3_IRAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(2.95, -3.057, -4.119)
	SWEP.SprintAng = Vector(-13.131, 33.537, -29.906)

	SWEP.CustomizePos = Vector(20.199, -5.829, 5)
	SWEP.CustomizeAng = Vector(21.255, 37.437, 30.848)
	
	SWEP.AlternativePos = Vector(0, 0, 0)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.ViewModelMovementScale = 1.65
	
	SWEP.MuzzleEffect = "muzzleflash_ak74"
	SWEP.PosBasedMuz = false
	SWEP.ShellScale = 0.9
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = -2, y = 0, z = -3}
	
	SWEP.BipodAngleLimitYaw = 40
	
	SWEP.SightWithRail = false
	
	SWEP.OffsetBoltOnBipodShoot = true

	SWEP.HUD_3D2DScale = 0.045
	
	SWEP.AttachmentModelsVM = {
		["md_blackops3_grip_ar"] = {model = "models/loyalists/blackops3/arak/grip_arak_01.mdl", pos = Vector(36.4427, 0, 4.7339), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_grip_smg"] = {model = "models/loyalists/blackops3/xr2/grip_xr2_02.mdl", pos = Vector(35.8512, 0, 4.6576), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_sil_ar"] = {model = "models/loyalists/blackops3/isr27/sil_isr27_01.mdl", pos = Vector(56.3316, 0, 7.7996), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_hybrid"] = {model = "models/loyalists/blackops3/public/optic_hybrid.mdl", pos = Vector(5.0144, 0, 14.4715), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_reflex"] = {model = "models/loyalists/blackops3/public/optic_reflex.mdl", pos = Vector(4.502, 0, 14.2), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_acog"] = {model = "models/loyalists/blackops3/public/optic_acog.mdl", pos = Vector(7.6532, 0, 14.15), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_holo"] = {model = "models/loyalists/blackops3/public/optic_holo.mdl", pos = Vector(6.5202, 0, 14.4715), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_ir"] = {model = "models/loyalists/blackops3/public/optic_thermal.mdl", pos = Vector(5.3515, 0, 14.0), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_elo"] = {model = "models/loyalists/blackops3/public/optic_laser.mdl", pos = Vector(5.3515, 0, 14.4953), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_dbal"] = {model = "models/loyalists/blackops3/xr2/dbal_xr2_01.mdl", pos = Vector(35.2281, -4.1412, 11.7847), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
	}
	
	SWEP.AttachmentModelsWM = {
		["md_blackops3_grip_ar"] = {model = "models/loyalists/blackops3/arak/grip_arak_01.mdl", pos = Vector(13.1, 0, 1.8251), angle = Angle(0, -90, 0), size = Vector(0.4, 0.4, 0.4), bone = "tag_weapon"},
		["md_blackops3_grip_smg"] = {model = "models/loyalists/blackops3/xr2/grip_xr2_02.mdl", pos = Vector(13.2, 0, 1.7), angle = Angle(0, -90, 0), size = Vector(0.4, 0.4, 0.4), bone = "tag_weapon"},
		["md_blackops3_sil_ar"] = {model = "models/loyalists/blackops3/isr27/sil_isr27_01.mdl", bone = "tag_weapon", pos = Vector(21, 0, 2.9), angle = Angle(0, -90, 0), size = Vector(0.4, 0.4, 0.4)},
		["md_blackops3_hybrid"] = {model = "models/loyalists/blackops3/public/optic_hybrid.mdl", bone = "tag_weapon", pos = Vector(2, 0, 5.5), angle = Angle(0, -90, 0), size = Vector(0.4, 0.4, 0.4)},	
		["md_blackops3_reflex"] = {model = "models/loyalists/blackops3/public/optic_reflex.mdl", bone = "tag_weapon", pos = Vector(1.8058, 0, 5.4), angle = Angle(0, -90, 0), size = Vector(0.4, 0.4, 0.4)},
		["md_blackops3_acog"] = {model = "models/loyalists/blackops3/public/optic_acog.mdl", bone = "tag_weapon", pos = Vector(3.2, 0, 5.45), angle = Angle(0, -90, 0), size = Vector(0.4, 0.4, 0.4)},	
		["md_blackops3_holo"] = {model = "models/loyalists/blackops3/public/optic_holo.mdl", bone = "tag_weapon", pos = Vector(1.8058, 0, 5.4), angle = Angle(0, -90, 0), size = Vector(0.4, 0.4, 0.4)},
		["md_blackops3_ir"] = {model = "models/loyalists/blackops3/public/optic_thermal.mdl", bone = "tag_weapon", pos = Vector(2, 0, 5.5), angle = Angle(0, -90, 0), size = Vector(0.4, 0.4, 0.4)},
		["md_blackops3_elo"] = {model = "models/loyalists/blackops3/public/optic_laser.mdl", bone = "tag_weapon", pos = Vector(2, 0, 5.5), angle = Angle(0, -90, 0), size = Vector(0.4, 0.4, 0.4)},
		["md_blackops3_dbal"] = {model = "models/loyalists/blackops3/xr2/dbal_xr2_01.mdl", pos = Vector(13.1484, -1.7924, 4.4938), angle = Angle(0, -90, 0), size = Vector(0.4, 0.4, 0.4), bone = "tag_weapon"},
	}
	
	SWEP.ForegripOverridePos = {		
		["customizing"] = {
		["j_shoulder_le"] = { pos = Vector(-6.481, 5.741, -13.148), angle = Angle(0, 0, 0) },
		},
	}

	SWEP.AimSwayIntensity = 0.3
	
	SWEP.CustomizationMenuScale = 0.035
end

SWEP.MagBGs = {main = 1, fast_mag = 2, ext_mag = 1, regular = 0}
SWEP.StockBGs = {main = 4, light = 2, heavy = 1, regular = 0}

SWEP.Attachments = {
	[1] = {header = "Sight", offset = {1100, -300},  atts = {"md_blackops3_elo", "md_blackops3_reflex", "md_blackops3_acog", "md_blackops3_hybrid", "md_blackops3_holo", "md_blackops3_ir"}},
	[2] = {header = "Handguard", offset = {-100, 600}, atts = {"md_blackops3_grip_ar", "md_blackops3_grip_smg"}},
	[3] = {header = "Magazine", offset = {1100, 600}, atts = {"bg_blackops3_fast_mag", "bg_blackops3_ext_mag"}},
	[4] = {header = "Barrel", offset = {-100, -300}, atts = {"md_blackops3_barrel_long", "md_blackops3_sil_ar"}},
	[5] = {header = "Stock", offset = {1500, 600}, atts = {"bg_blackops3_stock_heavy", "bg_blackops3_stock_light"}},
	[6] = {header = "Rail", offset = {500, 600}, atts = {"md_blackops3_dbal"}},
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
	base_holster = "base_holster",
	base_melee = "base_melee",
	base_crawl_loop = "base_crawl_loop",
	base_mantle_over = "base_mantle_over",
	base_sprint_in = "base_sprint_in",
	base_sprint_loop = "base_sprint_loop",
	base_sprint_out	= "base_sprint_out",
	
	grip_idle = "grip_idle",
	grip_fire = "grip_fire",
	grip_fire_ads = "grip_fire_ads",
	grip_reload = "grip_reload",
	grip_reload_empty = "grip_reload_empty",
	grip_reload_ext = "grip_reload_ext",
	grip_reload_empty_ext = "grip_reload_empty_ext",
	grip_reload_dm = "grip_reload_dm",
	grip_reload_empty_dm = "grip_reload_empty_dm",
	grip_reload_dm_quick = "grip_reload_dm_quick",
	grip_reload_empty_dm_quick = "grip_reload_empty_dm_quick",
	grip_draw = "grip_draw",
	grip_draw_first = "grip_draw_first",
	grip_holster = "grip_holster",
	grip_melee = "grip_melee",
	grip_crawl_loop = "grip_crawl_loop",
	grip_mantle_over = "grip_mantle_over",
	grip_sprint_in = "grip_sprint_in",
	grip_sprint_loop = "grip_sprint_loop",
	grip_sprint_out	= "grip_sprint_out",
	}
	
SWEP.Sounds = { 
	base_reload = {
	[1] = {time = 0.68, sound = "Weapon_BLACKOPS3_ARAK.Magout"},
	[2] = {time = 1.50, sound = "Weapon_BLACKOPS3_ARAK.Magin"},
	},

	base_reload_empty = {
	[1] = {time = 0.68, sound = "Weapon_BLACKOPS3_ARAK.Magout"},
	[2] = {time = 1.50, sound = "Weapon_BLACKOPS3_ARAK.Magin"},
	[3] = {time = 2.35, sound = "Weapon_BLACKOPS3_ARAK.Bolt_Back"},
	[4] = {time = 2.50, sound = "Weapon_BLACKOPS3_ARAK.Bolt_Forward"},
	},	

	base_reload_ext = {
	[1] = {time = 0.4, sound = "Weapon_BLACKOPS3_ARAK.Magout"},
	[2] = {time = 1.75, sound = "Weapon_BLACKOPS3_ARAK.Magin"},
	},

	base_reload_empty_ext = {
	[1] = {time = 0.4, sound = "Weapon_BLACKOPS3_ARAK.Magout"},
	[2] = {time = 1.75, sound = "Weapon_BLACKOPS3_ARAK.Magin"},
	[3] = {time = 2.7, sound = "Weapon_BLACKOPS3_ARAK.Bolt_Back"},
	[4] = {time = 2.9, sound = "Weapon_BLACKOPS3_ARAK.Bolt_Forward"},
	},	
	
	base_reload_dm = {
	[1] = {time = 0.5, sound = "Weapon_BLACKOPS3_ARAK.Magout"},
	[2] = {time = 1.1, sound = "Weapon_BLACKOPS3_ARAK.Magin"},
	},

	base_reload_empty_dm = {
	[1] = {time = 0.5, sound = "Weapon_BLACKOPS3_ARAK.Magout"},
	[2] = {time = 1.1, sound = "Weapon_BLACKOPS3_ARAK.Magin"},
	[3] = {time = 1.75, sound = "Weapon_BLACKOPS3_ARAK.Bolt_Back"},
	[4] = {time = 1.9, sound = "Weapon_BLACKOPS3_ARAK.Bolt_Forward"},
	},
	
	base_reload_dm_quick = {
	[1] = {time = 0.5, sound = "Weapon_BLACKOPS3_ARAK.Magout"},
	[2] = {time = 0.9, sound = "Weapon_BLACKOPS3_ARAK.Magin"},
	},

	base_reload_empty_dm_quick = {
	[1] = {time = 0.5, sound = "Weapon_BLACKOPS3_ARAK.Magout"},
	[2] = {time = 0.9, sound = "Weapon_BLACKOPS3_ARAK.Magin"},
	[3] = {time = 1.75, sound = "Weapon_BLACKOPS3_ARAK.Bolt_Back"},
	[4] = {time = 2.0, sound = "Weapon_BLACKOPS3_ARAK.Bolt_Forward"},
	},
	
	base_draw_first = {
	[1] = {time = 0.50, sound = "Weapon_BLACKOPS3_ARAK.Bolt_Back"},
	[2] = {time = 0.75, sound = "Weapon_BLACKOPS3_ARAK.Bolt_Forward"},
	},
	
	grip_reload = {
	[1] = {time = 0.68, sound = "Weapon_BLACKOPS3_ARAK.Magout"},
	[2] = {time = 1.50, sound = "Weapon_BLACKOPS3_ARAK.Magin"},
	},

	grip_reload_empty = {
	[1] = {time = 0.68, sound = "Weapon_BLACKOPS3_ARAK.Magout"},
	[2] = {time = 1.50, sound = "Weapon_BLACKOPS3_ARAK.Magin"},
	[3] = {time = 2.35, sound = "Weapon_BLACKOPS3_ARAK.Bolt_Back"},
	[4] = {time = 2.50, sound = "Weapon_BLACKOPS3_ARAK.Bolt_Forward"},
	},	
	
	grip_reload_ext = {
	[1] = {time = 0.4, sound = "Weapon_BLACKOPS3_ARAK.Magout"},
	[2] = {time = 1.75, sound = "Weapon_BLACKOPS3_ARAK.Magin"},
	},

	grip_reload_empty_ext = {
	[1] = {time = 0.4, sound = "Weapon_BLACKOPS3_ARAK.Magout"},
	[2] = {time = 1.75, sound = "Weapon_BLACKOPS3_ARAK.Magin"},
	[3] = {time = 2.7, sound = "Weapon_BLACKOPS3_ARAK.Bolt_Back"},
	[4] = {time = 2.9, sound = "Weapon_BLACKOPS3_ARAK.Bolt_Forward"},
	},
	
	grip_reload_dm = {
	[1] = {time = 0.5, sound = "Weapon_BLACKOPS3_ARAK.Magout"},
	[2] = {time = 1.1, sound = "Weapon_BLACKOPS3_ARAK.Magin"},
	},

	grip_reload_empty_dm = {
	[1] = {time = 0.5, sound = "Weapon_BLACKOPS3_ARAK.Magout"},
	[2] = {time = 1.1, sound = "Weapon_BLACKOPS3_ARAK.Magin"},
	[3] = {time = 1.75, sound = "Weapon_BLACKOPS3_ARAK.Bolt_Back"},
	[4] = {time = 1.9, sound = "Weapon_BLACKOPS3_ARAK.Bolt_Forward"},
	},
	
	grip_reload_dm_quick = {
	[1] = {time = 0.5, sound = "Weapon_BLACKOPS3_ARAK.Magout"},
	[2] = {time = 0.9, sound = "Weapon_BLACKOPS3_ARAK.Magin"},
	},

	grip_reload_empty_dm_quick = {
	[1] = {time = 0.5, sound = "Weapon_BLACKOPS3_ARAK.Magout"},
	[2] = {time = 0.9, sound = "Weapon_BLACKOPS3_ARAK.Magin"},
	[3] = {time = 1.75, sound = "Weapon_BLACKOPS3_ARAK.Bolt_Back"},
	[4] = {time = 2.0, sound = "Weapon_BLACKOPS3_ARAK.Bolt_Forward"},
	},
	
	grip_draw_first = {
	[1] = {time = 0.50, sound = "Weapon_BLACKOPS3_ARAK.Bolt_Back"},
	[2] = {time = 0.75, sound = "Weapon_BLACKOPS3_ARAK.Bolt_Forward"},
	},
}
	
SWEP.SpeedDec = 30

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_blackops3_base"
SWEP.Category = "CW 2.0 Black Ops III"

SWEP.Author				= "Loyalists"
SWEP.Contact			= ""
SWEP.Purpose			= ""

SWEP.Trivia = {
	text = "Full-auto assault rifle. Fast fire rate with moderate recoil.",
	x = -300, 
	y = -400, 
--	textFormatFunc = function(self, wep) if wep.ActiveAttachments.md_bipod then return "" else return self.text end end
	}

SWEP.ViewModelFOV	= 65
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/loyalists/blackops3/arak/v_ar_arak.mdl"
SWEP.WorldModel		= "models/loyalists/blackops3/arak/w_ar_arak.mdl"
SWEP.WM				= "models/loyalists/blackops3/arak/w_ar_arak.mdl"
SWEP.WMPos			= Vector(0,0,0)
SWEP.WMAng			= Vector(-3,-90,180)
SWEP.DrawTraditionalWorldModel = false

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.SnapToIdlePostReload = false

SWEP.Primary.ClipSize		= 30
SWEP.Primary.ClipSize_Ext	= 42
SWEP.Primary.DefaultClip	= 120
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5.45x39MM"

SWEP.FireDelay				= 60/625
SWEP.FireSound				= "CW_BLACKOPS3_ARAK_FIRE"
SWEP.FireSoundSuppressed	= "CW_BLACKOPS3_ARAK_FIRE_SUPPRESSED"
SWEP.Recoil					= 0.45

SWEP.HipSpread = 0.187
SWEP.AimSpread = 0.01
SWEP.VelocitySensitivity = 3.0
SWEP.MaxSpreadInc = 0.1
SWEP.SpreadPerShot = 0.001
SWEP.SpreadCooldown = 0.24
SWEP.Shots = 1
SWEP.Damage = 40

SWEP.HolsterSpeed = 1

SWEP.DeployTime = 0.83
SWEP.FirstDeployTime = 1.3
SWEP.FirstDrawSpeed = 1

SWEP.ReloadSpeed = 1.0
SWEP.ReloadTime = 2.2
SWEP.ReloadTime_Empty = 3.0
SWEP.ReloadHalt = 2.2
SWEP.ReloadHalt_Empty = 3.0
SWEP.ReloadTime_Ext = 2.6
SWEP.ReloadTime_Empty_Ext = 3.5
SWEP.ReloadTime_Fast = 2.0
SWEP.ReloadTime_Empty_Fast = 2.77

SWEP.MeleeAttackRange = 50
SWEP.MeleeAttackDamage = 75
SWEP.MeleeInTime = 0.15
SWEP.MeleeOutTime = 0.7

SWEP.ViewbobIntensity = 0.25

// Custom Features
SWEP.QuickMeleeLogic = true
SWEP.DualMagLogic = true
