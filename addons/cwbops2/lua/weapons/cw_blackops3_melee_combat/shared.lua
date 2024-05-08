AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Combat Knife"
	SWEP.CSMuzzleFlashes = true
	SWEP.SnapToGrip = true	
	
	killicon.Add( "cw_blackops3_melee_combat", "blackops3/icon_kill/cw_blackops3_melee_combat", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("blackops3/icon_weapons/cw_blackops3_melee_combat")

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

	SWEP.CustomizePos = Vector(10.199, -20.829, 8)
	SWEP.CustomizeAng = Vector(21.255, 47.437, 30.848)
	
	SWEP.AlternativePos = Vector(0, 0, 0)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.ViewModelMovementScale = 1.65
	
	SWEP.MuzzleEffect = nil
	SWEP.PosBasedMuz = false
	
	SWEP.Shell = false
	SWEP.ShellScale = 0.9
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = -2, y = 0, z = -3}

	SWEP.HUD_3D2DScale = 0.045
	
	SWEP.AttachmentModelsVM = {
		["md_blackops3_bipod"] = {model = "models/loyalists/blackops3/locus/locus_bipod.mdl", pos = Vector(-14.5511, 36.3246, -0.4241), angle = Angle(-90, 0, 0), size = Vector(0.75, 0.75, 0.75), bone = "tag_weapon"},
	}

	SWEP.AttachmentModelsWM = {
		["md_blackops3_bipod"] = {model = "models/loyalists/blackops3/locus/locus_bipod.mdl", pos = Vector(1.5223, -14.829, 4.7497), angle = Angle(-160, -180, 0), size = Vector(0.3, 0.3, 0.3), bone = "tag_weapon", bodygroups = {[0] = 1,}},
	}
	
	SWEP.AimSwayIntensity = 0.3
	SWEP.CustomizationMenuScale = 0.035
end

SWEP.Attachments = {
	[1] = {header = "Miscs", offset = {500, -500},  atts = {"md_blackops3_bipod"}},
	}

-- coded extended anims
-- INS2-ish nomenclature
SWEP.Animations = {
	base_idle = "base_idle",
	base_melee_primary = {"base_melee_1", "base_melee_2"},
	base_melee_secondary = "base_melee_3",
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
	}
	
SWEP.Sounds = { 
	base_reload = {
	[1] = {time = 0.4, sound = "Weapon_BLACKOPS3_38.Cylinder_Open"},
	},
}
	
SWEP.SpeedDec = 0

SWEP.Slot = 0
SWEP.SlotPos = 0
SWEP.NormalHoldType = "knife"
SWEP.RunHoldType = "knife"
SWEP.FireModes = {"auto"}
SWEP.Base = "cw_blackops3_base"
SWEP.Category = "CW 2.0 Black Ops III"

SWEP.Author				= "Loyalists"
SWEP.Contact			= ""
SWEP.Purpose			= ""

SWEP.ViewModelFOV	= 65
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/loyalists/blackops3/melee/knife_combat/v_melee_knife_combat.mdl"
SWEP.WorldModel		= "models/loyalists/blackops3/melee/knife_combat/w_melee_knife_combat.mdl"
SWEP.WM		= "models/loyalists/blackops3/melee/knife_combat/w_melee_knife_combat.mdl"
SWEP.WMPos			= Vector(-1,-2,0)
SWEP.WMAng			= Vector(0,0,180)
SWEP.DrawTraditionalWorldModel = false

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.SnapToIdlePostReload = false

SWEP.FireDelay				= 0.5
SWEP.Primary.ClipSize		= 0
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= ""

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

SWEP.DeployTime = 0.4
SWEP.FirstDeployTime = 0.8
SWEP.FirstDrawSpeed = 1

SWEP.ReloadSpeed = 1.0
SWEP.ReloadTime = 0
SWEP.ReloadTime_Empty = 0
SWEP.ReloadHalt = 0
SWEP.ReloadHalt_Empty = 0

SWEP.PrimaryMeleeAttackRange = 10
SWEP.PrimaryMeleeAttackDamage = 75
SWEP.PrimaryMeleeInTime = 0.2
SWEP.PrimaryMeleeOutTime = 0.5
SWEP.SecondaryMeleeAttackRange = 10
SWEP.SecondaryMeleeAttackDamage = 100
SWEP.SecondaryMeleeInTime = 0.3
SWEP.SecondaryMeleeOutTime = 0.5

// Custom Features
SWEP.Chamberable = false
SWEP.CanRestOnObjects = false
SWEP.QuickMeleeLogic = false
SWEP.MeleeLogic = true
SWEP.FakeBipod = true
SWEP.HolsterUnderwater = false
SWEP.FiremodesEnabled = false
SWEP.NearWallEnabled = false
-- SWEP.SprintingEnabled = false