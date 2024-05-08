AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Sheiva"
	SWEP.CSMuzzleFlashes = true
	SWEP.SnapToGrip = true	
	
	killicon.Add( "cw_blackops3_dlc2_shva", "blackops3/icon_kill/cw_blackops3_dlc2_shva", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("blackops3/icon_weapons/cw_blackops3_dlc2_shva")

	SWEP.IronsightPos = Vector(-7.1062, -12.6835, 1.0186)
	SWEP.IronsightAng = Vector(0, 0, 0)

	SWEP.BO3_ELOPos = Vector(-7.1062, -13.295, -0.9784)
	SWEP.BO3_ELOAng = Vector(0, 0, 0)

	SWEP.BO3_ACOGPos = Vector(-7.1062, -9.3945, -0.8331)
	SWEP.BO3_ACOGAng = Vector(0, 0, 0)

	SWEP.BO3_HybirdPos = Vector(-7.1062, 31.5759, -1.95)
	SWEP.BO3_HybirdAng = Vector(0, 0, 0)

	SWEP.BO3_ReflexPos = Vector(-7.1062, -11.746, -1.4127)
	SWEP.BO3_ReflexAng = Vector(0, 0, 0)

	SWEP.BO3_HoloPos = Vector(-7.1062, -18.0861, -1.5976)
	SWEP.BO3_HoloAng = Vector(0, 0, 0)

	SWEP.BO3_IRPos = Vector(-7.1062, 10, -1.7)
	SWEP.BO3_IRAng = Vector(0, 0, 0)
	
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
		["md_blackops3_grip_ar"] = {model = "models/loyalists/blackops3/shva/grip_shva_01.mdl", pos = Vector(36.6469, 0, 3.0905), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_grip_smg"] = {model = "models/loyalists/blackops3/shva/grip_shva_02.mdl", pos = Vector(37.1345, 0, 2.8155), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_sil_ar"] = {model = "models/loyalists/blackops3/shva/sil_shva_01.mdl", pos = Vector(47.9929, 0, 7.7996), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_hybrid"] = {model = "models/loyalists/blackops3/public/optic_hybrid.mdl", pos = Vector(14.5109, 0, 14.1204), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_reflex"] = {model = "models/loyalists/blackops3/public/optic_reflex.mdl", pos = Vector(14.5, 0, 13.7695), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_acog"] = {model = "models/loyalists/blackops3/public/optic_acog.mdl", pos = Vector(16.4419, 0, 13.772), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_holo"] = {model = "models/loyalists/blackops3/public/optic_holo.mdl", pos = Vector(14.5, 0, 14.1204), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_ir"] = {model = "models/loyalists/blackops3/public/optic_thermal.mdl", pos = Vector(14.5375, 0, 13.5533), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_elo"] = {model = "models/loyalists/blackops3/public/optic_laser.mdl", pos = Vector(14.5, 0, 14.1204), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_dbal"] = {model = "models/loyalists/blackops3/shva/dbal_shva_01.mdl", pos = Vector(37.2, -0.0059, 7.8436), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
	}
	
	SWEP.AttachmentModelsWM = {
		["md_blackops3_grip_ar"] = {model = "models/loyalists/blackops3/shva/grip_shva_01.mdl", pos = Vector(14.7151, 0, 1.1261), angle = Angle(0, -90, 0), size = Vector(0.4, 0.4, 0.4), bone = "tag_weapon"},
		["md_blackops3_grip_smg"] = {model = "models/loyalists/blackops3/shva/grip_shva_02.mdl", pos = Vector(14.8296, 0, 1.0909), angle = Angle(0, -90, 0), size = Vector(0.4, 0.4, 0.4), bone = "tag_weapon"},
		["md_blackops3_sil_ar"] = {model = "models/loyalists/blackops3/shva/sil_shva_01.mdl", pos = Vector(19.1187, 0, 3.0856), angle = Angle(0, -90, 0), size = Vector(0.4, 0.4, 0.4), bone = "tag_weapon"},
		["md_blackops3_hybrid"] = {model = "models/loyalists/blackops3/public/optic_hybrid.mdl", bone = "tag_weapon", pos = Vector(5.5816, 0, 5.6296), angle = Angle(0, -90, 0), size = Vector(0.4, 0.4, 0.4)},	
		["md_blackops3_reflex"] = {model = "models/loyalists/blackops3/public/optic_reflex.mdl", pos = Vector(5.8939, 0, 5.4904), angle = Angle(0, -90, 0), size = Vector(0.4, 0.4, 0.4), bone = "tag_weapon"},
		["md_blackops3_acog"] = {model = "models/loyalists/blackops3/public/optic_acog.mdl", pos = Vector(6.8474, 0, 5.5575), angle = Angle(0, -90, 0), size = Vector(0.4, 0.4, 0.4), bone = "tag_weapon"},
		["md_blackops3_holo"] = {model = "models/loyalists/blackops3/public/optic_holo.mdl", bone = "tag_weapon", pos = Vector(5.5816, 0, 5.6296), angle = Angle(0, -90, 0), size = Vector(0.4, 0.4, 0.4)},
		["md_blackops3_ir"] = {model = "models/loyalists/blackops3/public/optic_thermal.mdl", pos = Vector(5.5816, 0, 5.4496), angle = Angle(0, -90, 0), size = Vector(0.4, 0.4, 0.4), bone = "tag_weapon"},
		["md_blackops3_elo"] = {model = "models/loyalists/blackops3/public/optic_laser.mdl", pos = Vector(5.5816, 0, 5.6296), angle = Angle(0, -90, 0), size = Vector(0.4, 0.4, 0.4), bone = "tag_weapon"},
		["md_blackops3_dbal"] = {model = "models/loyalists/blackops3/shva/dbal_shva_01.mdl", pos = Vector(14.9205, 0.0522, 3.1107), angle = Angle(0, -90, 0), size = Vector(0.4, 0.4, 0.4), bone = "tag_weapon"},
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

SWEP.Attachments = {
	[1] = {header = "Sight", offset = {1100, -300},  atts = {"md_blackops3_elo", "md_blackops3_reflex", "md_blackops3_acog", "md_blackops3_hybrid", "md_blackops3_holo", "md_blackops3_ir"}},
	[2] = {header = "Handguard", offset = {-100, 800}, atts = {"md_blackops3_grip_ar", "md_blackops3_grip_smg"}},
	[3] = {header = "Magazine", offset = {1100, 800}, atts = {"bg_blackops3_fast_mag", "bg_blackops3_ext_mag"}},
	[4] = {header = "Barrel", offset = {-100, -300}, atts = {"md_blackops3_barrel_long", "md_blackops3_sil_ar"}},
	[5] = {header = "Stock", offset = {1700, 800}, atts = {"bg_blackops3_stock_heavy", "bg_blackops3_stock_light"}},
	[6] = {header = "Rail", offset = {1100, 300}, atts = {"md_blackops3_dbal"}},
	["+reload"] = {header = "Ammo", offset = {1700, 200}, atts = {"am_magnum", "am_matchgrade"}}
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
	base_sprint_out = "base_sprint_out",
	
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
	grip_sprint_out = "grip_sprint_out",
	}
	
SWEP.Sounds = { 
	base_reload = {
	[1] = {time = 0.6, sound = "Weapon_BLACKOPS3_SHVA.Magout"},
	[2] = {time = 1.8, sound = "Weapon_BLACKOPS3_SHVA.Magin"},
	},

	base_reload_empty = {
	[1] = {time = 0.6, sound = "Weapon_BLACKOPS3_SHVA.Magout"},
	[2] = {time = 1.8, sound = "Weapon_BLACKOPS3_SHVA.Magin"},
	[4] = {time = 2.2, sound = "Weapon_BLACKOPS3_Cloth.Med"},
	[3] = {time = 2.8, sound = "Weapon_BLACKOPS3_SHVA.Bolt_Down"},
	},	

	base_reload_ext = {
	[1] = {time = 0.6, sound = "Weapon_BLACKOPS3_SHVA.Magout"},
	[2] = {time = 1.8, sound = "Weapon_BLACKOPS3_SHVA.Magin"},
	},

	base_reload_empty_ext = {
	[1] = {time = 0.6, sound = "Weapon_BLACKOPS3_SHVA.Magout"},
	[2] = {time = 1.8, sound = "Weapon_BLACKOPS3_SHVA.Magin"},
	[3] = {time = 2.2, sound = "Weapon_BLACKOPS3_Cloth.Med"},
	[4] = {time = 2.8, sound = "Weapon_BLACKOPS3_SHVA.Bolt_Down"},
	},	
	
	base_reload_dm = {
	[1] = {time = 0.5, sound = "Weapon_BLACKOPS3_SHVA.Magout"},
	[2] = {time = 0.8, sound = "Weapon_BLACKOPS3_SHVA.Magin"},
	},

	base_reload_empty_dm = {
	[1] = {time = 0.5, sound = "Weapon_BLACKOPS3_SHVA.Magout"},
	[2] = {time = 0.8, sound = "Weapon_BLACKOPS3_SHVA.Magin"},
	[3] = {time = 1.45, sound = "Weapon_BLACKOPS3_SHVA.Button_Press"},
	},
	
	base_reload_dm_quick = {
	[1] = {time = 0.5, sound = "Weapon_BLACKOPS3_SHVA.Magout"},
	[2] = {time = 0.8, sound = "Weapon_BLACKOPS3_SHVA.Magin"},
	},

	base_reload_empty_dm_quick = {
	[1] = {time = 0.5, sound = "Weapon_BLACKOPS3_SHVA.Magout"},
	[2] = {time = 0.8, sound = "Weapon_BLACKOPS3_SHVA.Magin"},
	[3] = {time = 1.45, sound = "Weapon_BLACKOPS3_SHVA.Button_Press"},
	},
	
	base_draw = {
	[1] = {time = 0.1, sound = "Weapon_BLACKOPS3_Cloth.Med"},
	},
	
	base_draw_first = {
	[1] = {time = 0.1, sound = "Weapon_BLACKOPS3_Cloth.Med"},
	[2] = {time = 0.7, sound = "Weapon_BLACKOPS3_SHVA.Bolt_Down"},
	},
	
	grip_reload = {
	[1] = {time = 0.6, sound = "Weapon_BLACKOPS3_SHVA.Magout"},
	[2] = {time = 1.8, sound = "Weapon_BLACKOPS3_SHVA.Magin"},
	},

	grip_reload_empty = {
	[1] = {time = 0.6, sound = "Weapon_BLACKOPS3_SHVA.Magout"},
	[2] = {time = 1.8, sound = "Weapon_BLACKOPS3_SHVA.Magin"},
	[4] = {time = 2.2, sound = "Weapon_BLACKOPS3_Cloth.Med"},
	[3] = {time = 2.8, sound = "Weapon_BLACKOPS3_SHVA.Bolt_Down"},
	},	

	grip_reload_ext = {
	[1] = {time = 0.6, sound = "Weapon_BLACKOPS3_SHVA.Magout"},
	[2] = {time = 1.8, sound = "Weapon_BLACKOPS3_SHVA.Magin"},
	},

	grip_reload_empty_ext = {
	[1] = {time = 0.6, sound = "Weapon_BLACKOPS3_SHVA.Magout"},
	[2] = {time = 1.8, sound = "Weapon_BLACKOPS3_SHVA.Magin"},
	[3] = {time = 2.2, sound = "Weapon_BLACKOPS3_Cloth.Med"},
	[4] = {time = 2.8, sound = "Weapon_BLACKOPS3_SHVA.Bolt_Down"},
	},	
	
	grip_reload_dm = {
	[1] = {time = 0.5, sound = "Weapon_BLACKOPS3_SHVA.Magout"},
	[2] = {time = 0.8, sound = "Weapon_BLACKOPS3_SHVA.Magin"},
	},

	grip_reload_empty_dm = {
	[1] = {time = 0.5, sound = "Weapon_BLACKOPS3_SHVA.Magout"},
	[2] = {time = 0.8, sound = "Weapon_BLACKOPS3_SHVA.Magin"},
	[3] = {time = 1.45, sound = "Weapon_BLACKOPS3_SHVA.Button_Press"},
	},
	
	grip_reload_dm_quick = {
	[1] = {time = 0.5, sound = "Weapon_BLACKOPS3_SHVA.Magout"},
	[2] = {time = 0.8, sound = "Weapon_BLACKOPS3_SHVA.Magin"},
	},

	grip_reload_empty_dm_quick = {
	[1] = {time = 0.5, sound = "Weapon_BLACKOPS3_SHVA.Magout"},
	[2] = {time = 0.8, sound = "Weapon_BLACKOPS3_SHVA.Magin"},
	[3] = {time = 1.45, sound = "Weapon_BLACKOPS3_SHVA.Button_Press"},
	},
	
	grip_draw = {
	[1] = {time = 0.1, sound = "Weapon_BLACKOPS3_Cloth.Med"},
	},
	
	grip_draw_first = {
	[1] = {time = 0.1, sound = "Weapon_BLACKOPS3_Cloth.Med"},
	[2] = {time = 0.7, sound = "Weapon_BLACKOPS3_SHVA.Bolt_Down"},
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
	text = "Semi-auto marksman assault rifle. Eliminates enemy infantry in 2 shots.",
	x = -300, 
	y = -400, 
--	textFormatFunc = function(self, wep) if wep.ActiveAttachments.md_bipod then return "" else return self.text end end
	}

SWEP.ViewModelFOV	= 65
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/loyalists/blackops3/shva/v_ar_shva.mdl"
SWEP.WorldModel		= "models/loyalists/blackops3/shva/w_ar_shva.mdl"
SWEP.WM				= "models/loyalists/blackops3/shva/w_ar_shva.mdl"
SWEP.WMPos			= Vector(-0.5,0,0)
SWEP.WMAng			= Vector(-3,0,180)
SWEP.DrawTraditionalWorldModel = false

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.SnapToIdlePostReload = false

SWEP.Primary.ClipSize		= 20
SWEP.Primary.ClipSize_Ext	= 28
SWEP.Primary.DefaultClip	= 140
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "7.62x51MM"

SWEP.FireDelay				= 60/257
SWEP.FireSound				= "CW_BLACKOPS3_SHVA_FIRE"
SWEP.FireSoundSuppressed	= "CW_BLACKOPS3_SHVA_FIRE_SUPPRESSED"
SWEP.Recoil					= 0.5

SWEP.HipSpread = 0.187
SWEP.AimSpread = 0.01
SWEP.VelocitySensitivity = 3.0
SWEP.MaxSpreadInc = 0.1
SWEP.SpreadPerShot = 0.001
SWEP.SpreadCooldown = 0.24
SWEP.Shots = 1
SWEP.Damage = 51

SWEP.HolsterSpeed = 1

SWEP.DeployTime = 0.83
SWEP.FirstDeployTime = 1.2
SWEP.FirstDrawSpeed = 1

SWEP.ReloadSpeed = 1.0
SWEP.ReloadTime = 2.8
SWEP.ReloadTime_Empty = 3.4
SWEP.ReloadHalt = 2.8
SWEP.ReloadHalt_Empty = 3.4
SWEP.ReloadTime_Fast = 1.6
SWEP.ReloadTime_Empty_Fast = 2.1

SWEP.ViewbobIntensity = 0.25

// Custom Features
SWEP.QuickMeleeLogic = true
SWEP.DualMagLogic = true
