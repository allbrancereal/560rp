local reg = debug.getregistry()
local GetVelocity = reg.Entity.GetVelocity
local Length = reg.Vector.Length
local SP = game.SinglePlayer()
local noNormal = Vector(1, 1, 1)
local Right = reg.Angle.Right
local Up = reg.Angle.Up
local Forward = reg.Angle.Forward
local RotateAroundAxis = reg.Angle.RotateAroundAxis
local IFTP, vel, prefix, cwaa, time

function SWEP:ShotgunReloadThink()
	vel = Length(GetVelocity(self.Owner))
	IFTP = IsFirstTimePredicted()
	prefix = self:GetPrefix()
	cwaa = self.ActiveAttachments
	local num
	
	if cwaa.bg_blackops3_fast_mag then
		num = self.FastMagInsertBulletAmount or 1
	elseif cwaa.bg_blackops3_ext_mag then
		num = self.ExtMagInsertBulletAmount or 1
	else
		num = self.InsertBulletAmount or 1
	end
	
	if IFTP then
		local mag, ammo = self:Clip1(), self.Owner:GetAmmoCount(self.Primary.Ammo)
		
		-- omgwtf,my fault,it shouldn't be like this
		-- local backupammo = ammo - mag
		local maxReloadAmount = self.Primary.ClipSize
		
		local speed = (self.FastMagReloadSpeed / self.ReloadSpeed) or self.ReloadSpeed
		
		if self.ShotgunReloadState == 1 then
			if self.Owner:KeyPressed(IN_ATTACK) and self:Clip1() ~= 0 then
				self.ShotgunReloadState = 2
				self.ForcedReloadStop = true
			end
			
			-- if self.firstInsertBulletTime and self.ReloadDelay and self.FirstInsertBullet and not self.IsBulletInserted then
				-- if CT < self.ReloadDelay and CT > self.firstInsertBulletTime then
					-- self.IsBulletInserted = true
					-- self.firstInsertBulletTime = nil
					
					-- if SERVER then
						-- if ammo >= 0 then
							-- if ammo < num then
								-- self:SetClip1(mag + ammo)
								-- self.Owner:SetAmmo(0, self.Primary.Ammo)
							-- else
								-- self:SetClip1(mag + num)
								-- self.Owner:SetAmmo(ammo - num, self.Primary.Ammo)
							-- end
						-- end
					-- end
				-- end
			-- end
			
			if CT > self.ReloadDelay then
				if cwaa.bg_blackops3_fast_mag then
					self:sendWeaponAnim(prefix .. "reload_loop_dm", speed)
				else
					self:sendWeaponAnim(prefix .. "reload_loop", self.ReloadSpeed)
				end
				
				if SERVER and not SP then
					self.Owner:SetAnimation(PLAYER_RELOAD)
				end
				
				if self.Chamberable and not self.WasEmpty then  -- if the weapon is chamberable + we've cocked it - we can add another shell in there
					maxReloadAmount = self.Primary.ClipSize + 1
				end
				
				-- if we've filled up the weapon (or we have no ammo left), we go to the "end reload" state
				if mag + num >= maxReloadAmount or ammo - num <= 0 then
					self.ShotgunReloadState = 2
				end
				
				if SERVER then
					-- if ammo is less than the insert amount,discharge them all
					if ammo >= 0 then
						if ammo < num then
							self:SetClip1(mag + ammo)
							self.Owner:SetAmmo(0, self.Primary.Ammo)
						else
							self:SetClip1(mag + num)
							self.Owner:SetAmmo(ammo - num, self.Primary.Ammo)
						end
					end
				end
				-- PrintMessage( HUD_PRINTTALK, self.Owner:GetAmmoCount(self.Primary.Ammo) )
				if cwaa.bg_blackops3_fast_mag then
					self.ReloadDelay = CT + (self.InsertShellTime_Fast or self.InsertShellTime) / (self.FastMagReloadSpeed or self.ReloadSpeed)
				else
					self.ReloadDelay = CT + self.InsertShellTime / self.ReloadSpeed
				end
				
			end
		elseif self.ShotgunReloadState == 2 then
			if self.Owner:KeyPressed(IN_ATTACK) then
				self.ShotgunReloadState = 2
				self.ForcedReloadStop = true
			end
			
			if CT > self.ReloadDelay then
				if not self.WasEmpty then
					if cwaa.bg_blackops3_fast_mag then
						self:sendWeaponAnim(prefix .. "reload_out_dm", speed)
					else
						self:sendWeaponAnim(prefix .. "reload_out", self.ReloadSpeed)
					end
					self.ShotgunReloadState = 0
					
					local time
					if cwaa.bg_blackops3_fast_mag then
						time = (self.ReloadFinishWait_Fast or self.ReloadFinishWait) / self.ReloadSpeed
					else
						time = self.ReloadFinishWait / self.ReloadSpeed
					end
					self:SetNextPrimaryFire(time)
					self:SetNextSecondaryFire(time)
					self.ReloadWait = time
					self.ReloadDelay = nil
				else
					local canInsertMore = false
					
					if cwaa.bg_blackops3_fast_mag then
						waitTime = self.ReloadFinishWait_Fast or self.ReloadFinishWait
						pumpTime = self.PumpMidReloadWait_Fast or self.PumpMidReloadWait
					else
						waitTime = self.ReloadFinishWait
						pumpTime = self.PumpMidReloadWait
					end
					
					if not self.ForcedReloadStop and self.Chamberable and self:Clip1() < self.Primary.ClipSize + 1 and self.Owner:GetAmmoCount(self.Primary.Ammo) > 0 then
						waitTime = pumpTime or waitTime
						canInsertMore = true
					end
					if cwaa.bg_blackops3_fast_mag then
						self:sendWeaponAnim(prefix .. "reload_out_dm", speed)
					else
						self:sendWeaponAnim(prefix .. "reload_out", self.ReloadSpeed)
					end
					self.ShotgunReloadState = 0
					
					local time = CT + waitTime / self.ReloadSpeed
					self:SetNextPrimaryFire(time)
					self:SetNextSecondaryFire(time)
					self.ReloadWait = time
					
					if not canInsertMore then
						self.ReloadDelay = nil
					else
						self.ReloadDelay = time
					end
					
					if canInsertMore then -- if we can chamber and we haven't chambered up fully + we have some ammo to spare
						self.ShotgunReloadState = 1 -- we add another shell in there
						self.WasEmpty = false
					end
				end
			end
		end
	end
end

function SWEP:ChargedLogicThink()
	CT = CurTime()

	if self.ChargedLogic then
		if self.upTime and CT > self.upTime then
			self.upTime = nil
			self.isCharging = false
			self.allowsChargedShot = true
		end
		
		-- forces player to keep pressing mouse left
		if not self.Owner:KeyDown(IN_ATTACK) then
			self.allowsChargedShot = false
			self.isCharging = false
		end
	end
end

function SWEP:MeleeAttack(timeToImpact, timeCooldown, damage, range, aabb, suffix)
	timeToImpact = timeToImpact or self.MeleeInTime
	timeCooldown = timeCooldown or self.MeleeOutTime
	damage = damage or self.MeleeAttackDamage
	range = damage or self.MeleeAttackRange
	aabb = aabb or self.PrimaryHitAABB
	suffix = suffix or ""
	
	if not IsValid(self.Owner) then
		return
	end
	
	if not self:canFireWeapon(1) then
		return
	end
	
	if not self:canFireWeapon(2) then
		return false
	end
	
	if not self.QuickMeleeLogic and not self.MeleeLogic then
		return
	end

	-- if self.isMeleeAttacking then
		-- return
	-- end	
	
	self.isMeleeAttacking = true
	
	local prefix = self:GetPrefix()
	
	self:EmitSound("Weapon_BLACKOPS3_Cloth.Med")
	
	if IsFirstTimePredicted() then	
		self:beginMeleeAttack(timeToImpact, damage, range, aabb)
		-- self.Owner:SetAnimation( PLAYER_ATTACK1 )
		self:sendWeaponAnim(prefix .. "melee" .. suffix,1)
	end
	
	self:delayEverything(timeToImpact + timeCooldown)
end

function SWEP:MeleeLogicThink()
	if not self.QuickMeleeLogic and not self.MeleeLogic then
		return
	end
	
	CT = CurTime()
	if (SP and SERVER) or IsFirstTimePredicted() then
	
		if self.attackDamageTime and CT > self.attackDamageTime then
			if self.isMeleeAttacking then
				self.attackDamageTime = nil
				self.isMeleeAttacking = false
				self:EmitSound("Weapon_BLACKOPS3_Cloth.Melee")
				
				-- local rand_para = -3
				-- local rand_command = math.Rand( -rand_para, rand_para )

				-- self.Owner:ViewPunch(Angle(-2 * rand_command, 2 * rand_command, 2 * rand_command))
				
				self.Owner:LagCompensation(true)
					local eyeAngles = self.Owner:EyeAngles()
					local forward = eyeAngles:Forward()
					local traceData = {}
					traceData.start = self.Owner:GetShootPos()
					traceData.endpos = traceData.start + forward * self.attackRange
					
					traceData.mins = self.attackAABB[1]:Rotate(eyeAngles)
					traceData.maxs = self.attackAABB[2]:Rotate(eyeAngles)
					
					traceData.filter = self.Owner
					
					local trace = util.TraceHull(traceData)
				self.Owner:LagCompensation(false)
				
				if trace.Hit then
					local ent = trace.Entity
					
					if IsValid(ent) then
						local sounds = nil
						
						if ent:IsPlayer() then
							-- sounds = self.PlayerHitSounds
							-- self:createBloodEffect(ent, trace)
						elseif ent:IsNPC() then
							-- sounds = self.NPCHitSounds[ent:GetClass()] or self.PlayerHitSounds
							-- self:createBloodEffect(ent, trace)
						else
							
							if SERVER then
								local phys = ent:GetPhysicsObject()
								
								if phys and phys:IsValid() then
									phys:AddVelocity(forward * self.PushVelocity)
								end
							end
						end
						
						if SERVER then
							local forceDir = noNormal
							local forceMultiplier = 0
							
							if not ent:IsPlayer() and not ent:IsNPC() then
								forceDir = trace.HitNormal
							end
							
							local damageInfo = DamageInfo()
							damageInfo:SetDamage(self:getDealtDamage(ent))
							damageInfo:SetAttacker(self.Owner)
							damageInfo:SetInflictor(self)
							damageInfo:SetDamageForce(forward * self.DamageForce * forceDir)
							damageInfo:SetDamagePosition(trace.HitPos)
							
							ent:TakeDamageInfo(damageInfo)
						end
						
						sounds = sounds or self.MiscHitSounds
						self:EmitSound("Weapon_BLACKOPS3_Melee.Riflebutt")
					else
						self:EmitSound("Weapon_BLACKOPS3_Melee.Riflebutt")
					end
					
				end
			end
		end
	end
end

function SWEP:beginMeleeAttack(timeToImpact, damage, range, aabb)
	self.attackDamageTime = CurTime() + timeToImpact
	self.attackDamage = damage
	self.attackRange = range
	self.attackAABB = aabb
end

function SWEP:getDealtDamage(ent)
	local dmg = type(self.attackDamage) == "table" and math.random(self.attackDamage[1], self.attackDamage[2]) or self.attackDamage
	
	local velocity = self.Owner:GetVelocity()
	dmg = dmg + velocity:Length() / self.VelocityToDamageDivider
	
	return dmg
end

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
	-- it is now based on self.FireDelay
	local time = self.RechamberTime or (self.FireDelay * self.RechamberDelayMul)
	self.BipodDelay = CT + time
	self:SetNextPrimaryFire(CT + time)
	self.ReloadWait = CT + time
	self.HolsterWait = CT + time
	self.isRechambered = true
	
	if self.dt.State == CW_AIMING then
		self:sendWeaponAnim(prefix .. "rechamber_ads")
	else
		self:sendWeaponAnim(prefix .. "rechamber")
	end

end