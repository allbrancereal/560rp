
if SERVER then
	AddCSLuaFile("shared.lua")
end

if CLIENT then
	SWEP.PrintName = "Hand Cuffs"
	SWEP.Slot = 2
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

SWEP.Author = "Fried rice"
SWEP.Instructions = "Left Click: Restrain or Release"
SWEP.Contact = "support@560rp.com"
SWEP.Purpose = "Let civillians know that they cannot run."

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.AnimPrefix	 = "rpg"

SWEP.Spawnable = false
SWEP.AdminSpawnable = true
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

SWEP.ViewModel = "models/katharsmodels/handcuffs/handcuffs-1.mdl";
SWEP.WorldModel = "models/katharsmodels/handcuffs/handcuffs-1.mdl"; 

if CLIENT then
	function SWEP:GetViewModelPosition ( Pos, Ang )
		Ang:RotateAroundAxis(Ang:Forward(), 90);
		Pos = Pos + Ang:Forward() * 6;
		Pos = Pos + Ang:Right() * 2;
		return Pos, Ang;
	end 
end

function SWEP:Initialize()
		self:SetWeaponHoldType("slam")
end

function SWEP:Think()
end

function SWEP:PrimaryAttack()	
	if self.Owner:Team() != TEAM_POLICE then self:Remove(); return end
	
	self.Weapon:SetNextPrimaryFire(CurTime() + 1)
	self.Weapon:SetNextSecondaryFire(CurTime() + 1)
	
	local EyeTrace = self.Owner:GetEyeTrace();
	
	self.Weapon:EmitSound("npc/vort/claw_swing" .. math.random(1, 2) .. ".wav")
	
	if CLIENT then return false; end
	
	local Distance = self.Owner:EyePos():Distance(EyeTrace.HitPos);
	if Distance > 75 then return false; end
	if !EyeTrace.Entity or !EyeTrace.Entity:IsValid() or !EyeTrace.Entity:IsPlayer() then return false; end
	
	if EyeTrace.Entity:Team() != TEAM_CIVILLIAN then self.Owner:Notify('You cannot arrest government employees.'); return false; end
	
	if (EyeTrace.Entity:getFlag("cuffed", false) == true) then
		//if (EyeTrace.Entity.arrestingOfficer != self.Owner) then
		//	self.Owner:Notify('You are the not the arresting officer and therefore cannot release this suspect.')
		//else
			EyeTrace.Entity:Arrest()
			self.Owner:Notify('You have released ' .. EyeTrace.Entity:getRPName() .. '.')
			EyeTrace.Entity:Notify("You have been released.")
		//end
		
		return
		
	else
	
	
	self.Owner:Notify('You have restrained ' .. EyeTrace.Entity:getRPName() .. '! Take him to the jail to finish the job!');
	EyeTrace.Entity:Notify('You have been restrained! Please cooperate with the officer or risk being banned.');

	EyeTrace.Entity:Arrest(self.Owner:SteamID())
	
	end
end

function SWEP:SecondaryAttack()
	self:PrimaryAttack();
end

function SWEP:DrawWorldModel()
	if (IsValid(self.Owner)) then
		local att = self.Owner:GetAttachment(self.Owner:LookupAttachment("anim_attachment_RH" ))
		if (att) then
			local pos, ang = att.Pos, att.Ang 
			ang:RotateAroundAxis(ang:Up(), 210)
			ang:RotateAroundAxis(ang:Forward(), -20)
			ang:RotateAroundAxis(ang:Right(), -12)
			self:SetRenderOrigin(pos + ang:Up() * 1 + ang:Forward() * -1 + ang:Right() * 1)
			self:SetRenderAngles(ang)
		end
	end
	self:DrawModel()
end