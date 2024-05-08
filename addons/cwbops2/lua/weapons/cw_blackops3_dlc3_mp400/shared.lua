CustomizableWeaponry_BlackOps3_DLC3 = true

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "HG 40"
	SWEP.CSMuzzleFlashes = true
	SWEP.SnapToGrip = true	
	
	killicon.Add( "cw_blackops3_dlc3_mp400", "blackops3/icon_kill/cw_blackops3_dlc3_mp400", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("blackops3/icon_weapons/cw_blackops3_dlc3_mp400")

	SWEP.IronsightPos = Vector(-10.0761, -2.3307, 1.9446)
	SWEP.IronsightAng = Vector(0, 0, 0)

	SWEP.BO3_ELOPos = Vector(-10.0761, -13.8342, 0.5512)
	SWEP.BO3_ELOAng = Vector(0, 0, 0)

	SWEP.BO3_ReflexPos = Vector(-10.0761, -13.3824, -0.094)
	SWEP.BO3_ReflexAng = Vector(0, 0, 0)

	SWEP.BO3_ACOGPos = Vector(-10.0761, -8.3883, 0.5683)
	SWEP.BO3_ACOGAng = Vector(0, 0, 0)

	SWEP.BO3_HybirdPos = Vector(-10.0761, 38.1534, -0.4952)
	SWEP.BO3_HybirdAng = Vector(0, 0, 0)

	SWEP.BO3_HoloPos = Vector(-10.0761, -15.225, -0.0212)
	SWEP.BO3_HoloAng = Vector(0, 0, 0)

	SWEP.BO3_IRPos = Vector(-10.0761, -2.3307, 1.9446)
	SWEP.BO3_IRAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(2.95, -3.057, -4.119)
	SWEP.SprintAng = Vector(-13.131, 33.537, -29.906)

	SWEP.CustomizePos = Vector(20.199, -5.829, 5)
	SWEP.CustomizeAng = Vector(21.255, 37.437, 30.848)
	
	SWEP.AlternativePos = Vector(0, 0, 0)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.ViewModelMovementScale = 1.65
	
	SWEP.MuzzleEffect = "muzzleflash_smg"
	SWEP.PosBasedMuz = false
	SWEP.ShellScale = 0.9
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = -2, y = 0, z = -3}
	
	SWEP.BipodAngleLimitYaw = 40
	
	SWEP.SightWithRail = false
	
	SWEP.OffsetBoltOnBipodShoot = true

	SWEP.HUD_3D2DScale = 0.045
	
	SWEP.AttachmentModelsVM = {
		["md_blackops3_grip_ar"] = {model = "models/loyalists/blackops3/dlc_mp400/mp400_foregrip_01.mdl", pos = Vector(34.7284, 0, 4.3541), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_grip_smg"] = {model = "models/loyalists/blackops3/dlc_mp400/mp400_foregrip_01.mdl", pos = Vector(34.7284, 0, 4.3541), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_sil_ar"] = {model = "models/loyalists/blackops3/isr27/sil_isr27_01.mdl", pos = Vector(58.0764, 0, 9.5612), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_hybrid"] = {model = "models/loyalists/blackops3/public/optic_hybrid.mdl", pos = Vector(16.8603, 0, 12.5796), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_reflex"] = {model = "models/loyalists/blackops3/public/optic_reflex.mdl", pos = Vector(15.8603, 0, 12.3222), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_acog"] = {model = "models/loyalists/blackops3/public/optic_acog.mdl", pos = Vector(18.8323, 0, 12.3383), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_holo"] = {model = "models/loyalists/blackops3/public/optic_holo.mdl", pos = Vector(15.8603, 0, 12.5796), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_ir"] = {model = "models/loyalists/blackops3/public/optic_thermal.mdl", pos = Vector(16.2171, 0, 12.0724), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_elo"] = {model = "models/loyalists/blackops3/public/optic_laser.mdl", pos = Vector(15.8603, 0, 12.5796), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_dbal"] = {model = "models/loyalists/blackops3/dlc_mp400/mp400_dbal_01.mdl", pos = Vector(33.1971, 2.4976, 7.2923), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone = "tag_weapon"},
		["md_blackops3_barrel_long"] = {model = "models/loyalists/blackops3/dlc_mp400/mp400_barrel_01.mdl", pos = Vector(0, 0, 0), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone_merge = true},
		["bg_blackops3_stock_heavy"] = {model = "models/loyalists/blackops3/dlc_mp400/mp400_stock_01.mdl", pos = Vector(0, 0, 0), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone_merge = true},
		["bg_blackops3_stock_light"] = {model = "models/loyalists/blackops3/dlc_mp400/mp400_stock_01.mdl", pos = Vector(0, 0, 0), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), bone_merge = true},
	}
	
	SWEP.AttachmentModelsWM = {
		["md_blackops3_grip_ar"] = {model = "models/loyalists/blackops3/dlc_mp400/mp400_foregrip_01.mdl", pos = Vector(13.8559, 0, 1.4797), angle = Angle(0, -90, 0), size = Vector(0.4, 0.4, 0.4), bone = "tag_weapon"},
		["md_blackops3_grip_smg"] = {model = "models/loyalists/blackops3/dlc_mp400/mp400_foregrip_01.mdl", pos = Vector(13.8559, 0, 1.4797), angle = Angle(0, -90, 0), size = Vector(0.4, 0.4, 0.4), bone = "tag_weapon"},
		["md_blackops3_sil_ar"] = {model = "models/loyalists/blackops3/isr27/sil_isr27_01.mdl", pos = Vector(22.5885, 0, 3.7992), angle = Angle(0, -90, 0), size = Vector(0.4, 0.4, 0.4), bone = "tag_weapon"},
		["md_blackops3_hybrid"] = {model = "models/loyalists/blackops3/public/optic_hybrid.mdl", pos = Vector(6.5512, 0, 5.0514), angle = Angle(0, -90, 0), size = Vector(0.4, 0.4, 0.4), bone = "tag_weapon"},
		["md_blackops3_reflex"] = {model = "models/loyalists/blackops3/public/optic_reflex.mdl", bone = "tag_weapon", pos = Vector(6.5512, 0, 5.0514), angle = Angle(0, -90, 0), size = Vector(0.4, 0.4, 0.4)},
		["md_blackops3_acog"] = {model = "models/loyalists/blackops3/public/optic_acog.mdl", bone = "tag_weapon", pos = Vector(6.5512, 0, 5.0514), angle = Angle(0, -90, 0), size = Vector(0.4, 0.4, 0.4)},	
		["md_blackops3_holo"] = {model = "models/loyalists/blackops3/public/optic_holo.mdl", bone = "tag_weapon", pos = Vector(6.5512, 0, 5.0514), angle = Angle(0, -90, 0), size = Vector(0.4, 0.4, 0.4)},
		["md_blackops3_ir"] = {model = "models/loyalists/blackops3/public/optic_thermal.mdl", bone = "tag_weapon", pos = Vector(6.5512, 0, 5.0514), angle = Angle(0, -90, 0), size = Vector(0.4, 0.4, 0.4)},
		["md_blackops3_elo"] = {model = "models/loyalists/blackops3/public/optic_laser.mdl", bone = "tag_weapon", pos = Vector(6.5512, 0, 5.0514), angle = Angle(0, -90, 0), size = Vector(0.4, 0.4, 0.4)},
		["md_blackops3_dbal"] = {model = "models/loyalists/blackops3/dlc_mp400/mp400_dbal_01.mdl", pos = Vector(13.1484, -1.7924, 4.4938), angle = Angle(0, -90, 0), size = Vector(0.4, 0.4, 0.4), bone = "tag_weapon"},
	}
	
	SWEP.ForegripOverridePos = {		
		["customizing"] = {
		["j_shoulder_le"] = { pos = Vector(-6.481, 5.741, -13.148), angle = Angle(0, 0, 0) },
		},
	}

	SWEP.AimSwayIntensity = 0.3
	
	SWEP.CustomizationMenuScale = 0.035
end

SWEP.MagBGs = {main = 1, ext_mag = 1, regular = 0}
SWEP.SightBGs = {main = 2, carryhandle = 0, none = 1}
SWEP.BarrelBGs = {main = 3, regular = 0, long = 1}
SWEP.StockBGs = {main = 5, light = 1, heavy = 1, regular = 0}

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
	base_draw = "base_draw",
	base_draw_quick = "base_draw_quick",
	base_draw_first = "base_draw_first",
	base_draw_first_stock = "base_draw_first_stock",
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
	grip_draw = "grip_draw",
	grip_draw_quick = "grip_draw_quick",
	grip_draw_first = "grip_draw_first",
	grip_draw_first_stock = "grip_draw_first_stock",
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
	[1] = {time = 0.4, sound = "Weapon_BLACKOPS3_MP400.Magout"},
	[2] = {time = 1.40, sound = "Weapon_BLACKOPS3_MP400.Magin"},
	},

	base_reload_empty = {
	[1] = {time = 0.4, sound = "Weapon_BLACKOPS3_MP400.Bolt_Lock"},
	[2] = {time = 0.90, sound = "Weapon_BLACKOPS3_MP400.Magout"},
	[3] = {time = 1.6, sound = "Weapon_BLACKOPS3_MP400.Magin"},
	[4] = {time = 2.2, sound = "Weapon_BLACKOPS3_MP400.Bolt_Release"},
	},	

	base_reload_ext = {
	[1] = {time = 0.4, sound = "Weapon_BLACKOPS3_MP400.Magout"},
	[2] = {time = 1.40, sound = "Weapon_BLACKOPS3_MP400.Magin"},
	},

	base_reload_empty_ext = {
	[1] = {time = 0.4, sound = "Weapon_BLACKOPS3_MP400.Bolt_Lock"},
	[2] = {time = 0.90, sound = "Weapon_BLACKOPS3_MP400.Magout"},
	[3] = {time = 1.6, sound = "Weapon_BLACKOPS3_MP400.Magin"},
	[4] = {time = 2.2, sound = "Weapon_BLACKOPS3_MP400.Bolt_Release"},
	},	
	
	base_reload_dm = {
	[1] = {time = 0.3, sound = "Weapon_BLACKOPS3_MP400.Magout"},
	[2] = {time = 0.9, sound = "Weapon_BLACKOPS3_MP400.Magin"},
	},

	base_reload_empty_dm = {
	[1] = {time = 0.3, sound = "Weapon_BLACKOPS3_MP400.Magout"},
	[2] = {time = 0.9, sound = "Weapon_BLACKOPS3_MP400.Magin"},
	[3] = {time = 1.35, sound = "Weapon_BLACKOPS3_MP400.Bolt_Release"},
	},
	
	base_draw_first = {
	[1] = {time = 0.50, sound = "Weapon_BLACKOPS3_MP400.Bolt_Release"},
	},
	
	base_draw_first_stock = {
	[1] = {time = 0.3, sound = "Weapon_BLACKOPS3_MP400.Stock"},
	},
	
	grip_reload = {
	[1] = {time = 0.4, sound = "Weapon_BLACKOPS3_MP400.Magout"},
	[2] = {time = 1.40, sound = "Weapon_BLACKOPS3_MP400.Magin"},
	},

	grip_reload_empty = {
	[1] = {time = 0.4, sound = "Weapon_BLACKOPS3_MP400.Bolt_Lock"},
	[2] = {time = 0.90, sound = "Weapon_BLACKOPS3_MP400.Magout"},
	[3] = {time = 1.6, sound = "Weapon_BLACKOPS3_MP400.Magin"},
	[4] = {time = 2.2, sound = "Weapon_BLACKOPS3_MP400.Bolt_Release"},
	},	

	grip_reload_ext = {
	[1] = {time = 0.4, sound = "Weapon_BLACKOPS3_MP400.Magout"},
	[2] = {time = 1.40, sound = "Weapon_BLACKOPS3_MP400.Magin"},
	},

	grip_reload_empty_ext = {
	[1] = {time = 0.4, sound = "Weapon_BLACKOPS3_MP400.Bolt_Lock"},
	[2] = {time = 0.90, sound = "Weapon_BLACKOPS3_MP400.Magout"},
	[3] = {time = 1.6, sound = "Weapon_BLACKOPS3_MP400.Magin"},
	[4] = {time = 2.2, sound = "Weapon_BLACKOPS3_MP400.Bolt_Release"},
	},	
	
	grip_reload_dm = {
	[1] = {time = 0.3, sound = "Weapon_BLACKOPS3_MP400.Magout"},
	[2] = {time = 0.9, sound = "Weapon_BLACKOPS3_MP400.Magin"},
	},

	grip_reload_empty_dm = {
	[1] = {time = 0.3, sound = "Weapon_BLACKOPS3_MP400.Magout"},
	[2] = {time = 0.9, sound = "Weapon_BLACKOPS3_MP400.Magin"},
	[3] = {time = 1.35, sound = "Weapon_BLACKOPS3_MP400.Bolt_Release"},
	},
	
	grip_draw_first = {
	[1] = {time = 0.50, sound = "Weapon_BLACKOPS3_MP400.Bolt_Release"},
	},
	
	grip_draw_first_stock = {
	[1] = {time = 0.3, sound = "Weapon_BLACKOPS3_MP400.Stock"},
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

SWEP.Trivia = {
	text = "Full-auto submachine gun. Blitzkrieg your enemies and protect your squad with this versatile weapon that packs a punch.",
	x = -300, 
	y = -400, 
--	textFormatFunc = function(self, wep) if wep.ActiveAttachments.md_bipod then return "" else return self.text end end
	}

SWEP.ViewModelFOV	= 65
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/loyalists/blackops3/dlc_mp400/v_smg_mp400.mdl"
SWEP.WorldModel		= "models/loyalists/blackops3/dlc_mp400/w_smg_mp400.mdl"
SWEP.WM				= "models/loyalists/blackops3/dlc_mp400/w_smg_mp400.mdl"
SWEP.WMPos			= Vector(-1,-3,-1)
SWEP.WMAng			= Vector(-3,0,180)
SWEP.DrawTraditionalWorldModel = false

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.SnapToIdlePostReload = false

SWEP.Primary.ClipSize		= 32
SWEP.Primary.ClipSize_Ext	= 45
SWEP.Primary.DefaultClip	= 128
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "9x19MM"

SWEP.FireDelay				= 60/517
SWEP.FireSound				= "CW_BLACKOPS3_MP400_FIRE"
SWEP.FireSoundSuppressed	= "CW_BLACKOPS3_MP400_FIRE_SUPPRESSED"
SWEP.Recoil					= 0.3

SWEP.HipSpread = 0.15
SWEP.AimSpread = 0.02
SWEP.VelocitySensitivity = 3.0
SWEP.MaxSpreadInc = 0.15
SWEP.SpreadPerShot = 0.005
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 35

SWEP.HolsterSpeed = 1

SWEP.DeployTime = 0.83
SWEP.FirstDeployTime = 1.3
SWEP.FirstDrawSpeed = 1

SWEP.ReloadSpeed = 1.0
SWEP.ReloadTime = 2.2
SWEP.ReloadTime_Empty = 2.8
SWEP.ReloadHalt = 2.2
SWEP.ReloadHalt_Empty = 2.8
SWEP.ReloadTime_Fast = 1.5
SWEP.ReloadTime_Empty_Fast = 1.8

SWEP.MeleeAttackRange = 50
SWEP.MeleeAttackDamage = 75
SWEP.MeleeInTime = 0.15
SWEP.MeleeOutTime = 0.7

SWEP.ViewbobIntensity = 0.25

// Custom Features
SWEP.QuickMeleeLogic = true
SWEP.DualMagLogic = false

function SWEP:IndividualInitialize()
	local cwaa = self.ActiveAttachments
	local prefix = self:GetPrefix()
	
	if self.BoltActionLogic then
		self.isRechambered = true
	end
	
	if self.FirstDeploy then
		if cwaa.bg_blackops3_stock_heavy or cwaa.bg_blackops3_stock_light then
			self:playAnim(prefix .. "draw_first_stock", self.DrawSpeed)
		else
			self:playAnim(prefix .. "draw_first", self.DrawSpeed)
		end
	else
		self:playAnim(prefix .. "draw", self.DrawSpeed)
	end
	
	if CLIENT then
		self:setupAttachmentModelsWM()
	end
end

function SWEP:drawAnimFunc()
	local cwaa = self.ActiveAttachments
	local prefix = self:GetPrefix()
	
	if self.FirstDeploy then
		if cwaa.bg_blackops3_stock_heavy or cwaa.bg_blackops3_stock_light then
			self:sendWeaponAnim(prefix .. "draw_first_stock", self.DrawSpeed)
		else
			self:sendWeaponAnim(prefix .. "draw_first", self.DrawSpeed)
		end
	else
		self:sendWeaponAnim(prefix .. "draw", self.DrawSpeed)
	end
end