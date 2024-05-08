AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Peacekeeper MK2"
	SWEP.CSMuzzleFlashes = true
	SWEP.SnapToGrip = true	
	
	killicon.Add( "cw_blackops3_dlc3_peacekeeper", "blackops3/icon_kill/cw_blackops3_dlc3_peacekeeper", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("blackops3/icon_weapons/cw_blackops3_dlc3_peacekeeper")

	SWEP.IronsightPos = Vector(-8.6463, -5.8172, 1.299)
	SWEP.IronsightAng = Vector(0, 0, 0)

	SWEP.BO3_ELOPos = Vector(-8.6463, -14.0153, 1.0731)
	SWEP.BO3_ELOAng = Vector(0, 0, 0)

	SWEP.BO3_ReflexPos = Vector(-8.6463, -10.4701, 0.4369)
	SWEP.BO3_ReflexAng = Vector(0, 0, 0)

	SWEP.BO3_ACOGPos = Vector(-8.6463, -7.5367, 1.1575)
	SWEP.BO3_ACOGAng = Vector(0, 0, 0)

	SWEP.BO3_HybirdPos = Vector(-8.6463, 32.9479, 0.0472)
	SWEP.BO3_HybirdAng = Vector(0, 0, 0)

	SWEP.BO3_HoloPos = Vector(-8.6463, -12.8273, 0.4834)
	SWEP.BO3_HoloAng = Vector(0, 0, 0)

	SWEP.BO3_IRPos = Vector(-8.6463, -5.8172, 1.299)
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

	SWEP.HUD_3D2DScale = 0.045
	
	SWEP.AttachmentModelsVM = {
		["md_blackops3_grip_ar"] = {model = "models/loyalists/blackops3/dlc_peacekeeper/peacekeeper_foregrip_01.mdl", pos = Vector(30.8187, 0, 0.5153), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_grip_smg"] = {model = "models/loyalists/blackops3/dlc_peacekeeper/peacekeeper_foregrip_01.mdl", pos = Vector(30.8187, 0, 0.5153), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_sil_ar"] = {model = "models/loyalists/blackops3/isr27/sil_isr27_01.mdl", pos = Vector(47.1147, 0, 8.5781), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_hybrid"] = {model = "models/loyalists/blackops3/public/optic_hybrid.mdl", pos = Vector(8.1442, 0, 13.4286), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_reflex"] = {model = "models/loyalists/blackops3/public/optic_reflex.mdl", pos = Vector(8.1442, 0, 13.2), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_acog"] = {model = "models/loyalists/blackops3/public/optic_acog.mdl", pos = Vector(8.1442, 0, 13.1238), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_holo"] = {model = "models/loyalists/blackops3/public/optic_holo.mdl", pos = Vector(8.1442, 0, 13.4286), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_ir"] = {model = "models/loyalists/blackops3/public/optic_thermal.mdl", pos = Vector(8.1442, 0, 13.4286), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_elo"] = {model = "models/loyalists/blackops3/public/optic_laser.mdl", pos = Vector(8.1442, 0, 13.4286), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_dbal"] = {model = "models/loyalists/blackops3/xr2/dbal_xr2_01.mdl", pos = Vector(43.4705, -5.5902, 9.6747), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_barrel_long"] = {model = "models/loyalists/blackops3/dlc_peacekeeper/peacekeeper_barrel_01.mdl", pos = Vector(0, 0, 0), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone_merge = true},
		["bg_blackops3_stock_heavy"] = {model = "models/loyalists/blackops3/dlc_peacekeeper/peacekeeper_stock_01.mdl", pos = Vector(0, 0, 0), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone_merge = true},
		["bg_blackops3_stock_light"] = {model = "models/loyalists/blackops3/dlc_peacekeeper/peacekeeper_stock_01.mdl", pos = Vector(0, 0, 0), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone_merge = true},
	}
	
	SWEP.AttachmentModelsWM = {
		["md_blackops3_grip_ar"] = {model = "models/loyalists/blackops3/dlc_peacekeeper/peacekeeper_foregrip_01.mdl", pos = Vector(12.1178, 0, 0.3228), angle = Angle(0, -90, 0), size = Vector(0.4, 0.4, 0.4), bone = "tag_weapon"},
		["md_blackops3_grip_smg"] = {model = "models/loyalists/blackops3/dlc_peacekeeper/peacekeeper_foregrip_01.mdl", pos = Vector(12.1178, 0, 0.3228), angle = Angle(0, -90, 0), size = Vector(0.4, 0.4, 0.4), bone = "tag_weapon"},
		["md_blackops3_sil_ar"] = {model = "models/loyalists/blackops3/isr27/sil_isr27_01.mdl", pos = Vector(19.1696, 0, 3.4399), angle = Angle(0, -90, 0), size = Vector(0.4, 0.4, 0.4), bone = "tag_weapon"},
		["md_blackops3_hybrid"] = {model = "models/loyalists/blackops3/public/optic_hybrid.mdl", bone = "tag_weapon", pos = Vector(3.8156, 0, 5.3323), angle = Angle(0, -90, 0), size = Vector(0.4, 0.4, 0.4)},	
		["md_blackops3_reflex"] = {model = "models/loyalists/blackops3/public/optic_reflex.mdl", bone = "tag_weapon", pos = Vector(3.8156, 0, 5.3323), angle = Angle(0, -90, 0), size = Vector(0.4, 0.4, 0.4)},
		["md_blackops3_acog"] = {model = "models/loyalists/blackops3/public/optic_acog.mdl", bone = "tag_weapon", pos = Vector(3.8156, 0, 5.3323), angle = Angle(0, -90, 0), size = Vector(0.4, 0.4, 0.4)},	
		["md_blackops3_holo"] = {model = "models/loyalists/blackops3/public/optic_holo.mdl", bone = "tag_weapon", pos = Vector(3.8156, 0, 5.3323), angle = Angle(0, -90, 0), size = Vector(0.4, 0.4, 0.4)},
		["md_blackops3_ir"] = {model = "models/loyalists/blackops3/public/optic_thermal.mdl", bone = "tag_weapon", pos = Vector(3.8156, 0, 5.3323), angle = Angle(0, -90, 0), size = Vector(0.4, 0.4, 0.4)},
		["md_blackops3_elo"] = {model = "models/loyalists/blackops3/public/optic_laser.mdl", pos = Vector(3.8156, 0, 5.3323), angle = Angle(0, -90, 0), size = Vector(0.4, 0.4, 0.4), bone = "tag_weapon"},
		["md_blackops3_dbal"] = {model = "models/loyalists/blackops3/xr2/dbal_xr2_01.mdl", pos = Vector(16.3163, -2.1869, 3.7469), angle = Angle(0, -90, 0), size = Vector(0.4, 0.4, 0.4), bone = "tag_weapon"},
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
SWEP.SightBGs = {main = 2, carryhandle = 0, none = 1}
SWEP.BarrelBGs = {main = 4, long = 1, regular = 0}
SWEP.StockBGs = {main = 3, light = 1, heavy = 1, regular = 0}
SWEP.WMSightBGs = {main = 1, carryhandle = 0, none = 1}
SWEP.WMBarrelBGs = {main = 2, long = 1, regular = 0}

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
	base_draw_quick = "base_draw_quick",
	base_draw_first = "base_draw_first",
	base_holster = "base_holster",
	base_holster_quick = "base_holster_quick",
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
	grip_draw_quick = "grip_draw_quick",
	grip_draw_first = "grip_draw_first",
	grip_holster = "grip_holster",
	grip_holster_quick = "grip_holster_quick",
	grip_melee = "grip_melee",
	grip_crawl_loop = "grip_crawl_loop",
	grip_mantle_over = "grip_mantle_over",
	grip_sprint_in = "grip_sprint_in",
	grip_sprint_loop = "grip_sprint_loop",
	grip_sprint_out	= "grip_sprint_out",
	}
	
SWEP.Sounds = { 
	base_reload = {
	[1] = {time = 0.68, sound = "Weapon_BLACKOPS3_PEACEKEEPER.Magout"},
	[2] = {time = 1.50, sound = "Weapon_BLACKOPS3_PEACEKEEPER.Magin"},
	},

	base_reload_empty = {
	[1] = {time = 0.68, sound = "Weapon_BLACKOPS3_PEACEKEEPER.Magout"},
	[2] = {time = 1.50, sound = "Weapon_BLACKOPS3_PEACEKEEPER.Magin"},
	[3] = {time = 2.15, sound = "Weapon_BLACKOPS3_PEACEKEEPER.Bolt_Back"},
	[4] = {time = 2.30, sound = "Weapon_BLACKOPS3_PEACEKEEPER.Bolt_Forward"},
	},	
	
	base_reload_ext = {
	[1] = {time = 0.4, sound = "Weapon_BLACKOPS3_PEACEKEEPER.Magout"},
	[2] = {time = 1.75, sound = "Weapon_BLACKOPS3_PEACEKEEPER.Magin"},
	},

	base_reload_empty_ext = {
	[1] = {time = 0.4, sound = "Weapon_BLACKOPS3_PEACEKEEPER.Magout"},
	[2] = {time = 1.75, sound = "Weapon_BLACKOPS3_PEACEKEEPER.Magin"},
	[3] = {time = 2.2, sound = "Weapon_BLACKOPS3_PEACEKEEPER.Bolt_Back"},
	[4] = {time = 2.35, sound = "Weapon_BLACKOPS3_PEACEKEEPER.Bolt_Forward"},
	},
	
	base_reload_dm = {
	[1] = {time = 0.5, sound = "Weapon_BLACKOPS3_PEACEKEEPER.Magout"},
	[2] = {time = 1.1, sound = "Weapon_BLACKOPS3_PEACEKEEPER.Magin"},
	},

	base_reload_empty_dm = {
	[1] = {time = 0.5, sound = "Weapon_BLACKOPS3_PEACEKEEPER.Magout"},
	[2] = {time = 1.1, sound = "Weapon_BLACKOPS3_PEACEKEEPER.Magin"},
	[3] = {time = 1.6, sound = "Weapon_BLACKOPS3_PEACEKEEPER.Bolt_Forward"},
	},
	
	base_reload_dm_quick = {
	[1] = {time = 0.5, sound = "Weapon_BLACKOPS3_PEACEKEEPER.Magout"},
	[2] = {time = 0.9, sound = "Weapon_BLACKOPS3_PEACEKEEPER.Magin"},
	},

	base_reload_empty_dm_quick = {
	[1] = {time = 0.5, sound = "Weapon_BLACKOPS3_PEACEKEEPER.Magout"},
	[2] = {time = 0.9, sound = "Weapon_BLACKOPS3_PEACEKEEPER.Magin"},
	[3] = {time = 1.5, sound = "Weapon_BLACKOPS3_PEACEKEEPER.Bolt_Forward"},
	},
	
	base_draw_first = {
	[1] = {time = 0.50, sound = "Weapon_BLACKOPS3_PEACEKEEPER.Bolt_Back"},
	[2] = {time = 0.75, sound = "Weapon_BLACKOPS3_PEACEKEEPER.Bolt_Forward"},
	},
	
	grip_reload = {
	[1] = {time = 0.68, sound = "Weapon_BLACKOPS3_PEACEKEEPER.Magout"},
	[2] = {time = 1.50, sound = "Weapon_BLACKOPS3_PEACEKEEPER.Magin"},
	},

	grip_reload_empty = {
	[1] = {time = 0.68, sound = "Weapon_BLACKOPS3_PEACEKEEPER.Magout"},
	[2] = {time = 1.50, sound = "Weapon_BLACKOPS3_PEACEKEEPER.Magin"},
	[3] = {time = 2.15, sound = "Weapon_BLACKOPS3_PEACEKEEPER.Bolt_Back"},
	[4] = {time = 2.30, sound = "Weapon_BLACKOPS3_PEACEKEEPER.Bolt_Forward"},
	},	
	
	grip_reload_ext = {
	[1] = {time = 0.4, sound = "Weapon_BLACKOPS3_PEACEKEEPER.Magout"},
	[2] = {time = 1.75, sound = "Weapon_BLACKOPS3_PEACEKEEPER.Magin"},
	},

	grip_reload_empty_ext = {
	[1] = {time = 0.4, sound = "Weapon_BLACKOPS3_PEACEKEEPER.Magout"},
	[2] = {time = 1.75, sound = "Weapon_BLACKOPS3_PEACEKEEPER.Magin"},
	[3] = {time = 2.2, sound = "Weapon_BLACKOPS3_PEACEKEEPER.Bolt_Back"},
	[4] = {time = 2.35, sound = "Weapon_BLACKOPS3_PEACEKEEPER.Bolt_Forward"},
	},
	
	grip_reload_dm = {
	[1] = {time = 0.5, sound = "Weapon_BLACKOPS3_PEACEKEEPER.Magout"},
	[2] = {time = 1.1, sound = "Weapon_BLACKOPS3_PEACEKEEPER.Magin"},
	},

	grip_reload_empty_dm = {
	[1] = {time = 0.5, sound = "Weapon_BLACKOPS3_PEACEKEEPER.Magout"},
	[2] = {time = 1.1, sound = "Weapon_BLACKOPS3_PEACEKEEPER.Magin"},
	[3] = {time = 1.6, sound = "Weapon_BLACKOPS3_PEACEKEEPER.Bolt_Forward"},
	},
	
	grip_reload_dm_quick = {
	[1] = {time = 0.5, sound = "Weapon_BLACKOPS3_PEACEKEEPER.Magout"},
	[2] = {time = 0.9, sound = "Weapon_BLACKOPS3_PEACEKEEPER.Magin"},
	},

	grip_reload_empty_dm_quick = {
	[1] = {time = 0.5, sound = "Weapon_BLACKOPS3_PEACEKEEPER.Magout"},
	[2] = {time = 0.9, sound = "Weapon_BLACKOPS3_PEACEKEEPER.Magin"},
	[3] = {time = 1.5, sound = "Weapon_BLACKOPS3_PEACEKEEPER.Bolt_Forward"},
	},
	
	grip_draw_first = {
	[1] = {time = 0.50, sound = "Weapon_BLACKOPS3_PEACEKEEPER.Bolt_Back"},
	[2] = {time = 0.75, sound = "Weapon_BLACKOPS3_PEACEKEEPER.Bolt_Forward"},
	},
}
	
SWEP.SpeedDec = 10

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

SWEP.ViewModelFOV	= 65
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/loyalists/blackops3/dlc_peacekeeper/v_ar_peacekeeper.mdl"
SWEP.WorldModel		= "models/loyalists/blackops3/dlc_peacekeeper/w_ar_peacekeeper.mdl"
SWEP.WM				= "models/loyalists/blackops3/dlc_peacekeeper/w_ar_peacekeeper.mdl"
SWEP.WMPos			= Vector(-1,0,0)
SWEP.WMAng			= Vector(-3,0,180)
SWEP.DrawTraditionalWorldModel = false

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.SnapToIdlePostReload = false

SWEP.Primary.ClipSize		= 32
SWEP.Primary.ClipSize_Ext	= 45
SWEP.Primary.DefaultClip	= 128
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5.56x45MM"

SWEP.FireDelay				= 60/652
SWEP.FireSound				= "CW_BLACKOPS3_PEACEKEEPER_FIRE"
SWEP.FireSoundSuppressed	= "CW_BLACKOPS3_PEACEKEEPER_FIRE_SUPPRESSED"
SWEP.Recoil					= 0.35

SWEP.HipSpread = 0.2
SWEP.AimSpread = 0.01
SWEP.VelocitySensitivity = 3.0
SWEP.MaxSpreadInc = 0.15
SWEP.SpreadPerShot = 0.005
SWEP.SpreadCooldown = 0.25
SWEP.Shots = 1
SWEP.Damage = 30

SWEP.HolsterSpeed = 1

SWEP.DeployTime = 0.83
SWEP.FirstDeployTime = 1.3
SWEP.FirstDrawSpeed = 1

SWEP.ReloadSpeed = 1.0
SWEP.ReloadTime = 2.3
SWEP.ReloadTime_Empty = 3.0
SWEP.ReloadHalt = 2.3
SWEP.ReloadHalt_Empty = 3.0
SWEP.ReloadTime_Fast = 1.6
SWEP.ReloadTime_Empty_Fast = 2.17

SWEP.MeleeAttackRange = 50
SWEP.MeleeAttackDamage = 75
SWEP.MeleeInTime = 0.15
SWEP.MeleeOutTime = 0.7

// Custom Features
SWEP.QuickMeleeLogic = true
SWEP.DualMagLogic = true