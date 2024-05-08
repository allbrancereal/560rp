-- local reg = debug.getregistry()
-- local GetVelocity = reg.Entity.GetVelocity
-- local Length = reg.Vector.Length
local wasSprinting, isSprinting, wasCrawling, isCrawling, wasEnteringCrawling, isEnteringCrawling, can

-- the following animations can be interrupted at any time you want
SWEP.InterruptableAnims = {
	["base_sprint_in"] = true,
	["base_sprint_loop"] = true,
	["base_sprint_out"] = true,
	["base_mantle_over"] = true,
	["base_crawl_loop"] = true,
	["base_fire_last"] = true,
	["base_fire_ads"] = true,
	["base_fire"] = true,
	["base_idle"] = true,
	
	["grip_sprint_in"] = true,
	["grip_sprint_loop"] = true,
	["grip_sprint_out"] = true,
	["grip_mantle_over"] = true,
	["grip_crawl_loop"] = true,
	["grip_fire_last"] = true,
	["grip_fire_ads"] = true,
	["grip_fire"] = true,
	["grip_idle"] = true,
	
	["dw_sprint_in"] = true,
	["dw_sprint_loop"] = true,
	["dw_sprint_out"] = true,
	["dw_mantle_over"] = true,
	["dw_crawl_loop"] = true,
	["dw_fire_last"] = true,
	["dw_fire_ads"] = true,
	["dw_fire"] = true,
	["dw_idle"] = true,
	}

SWEP.RestAnimationsStates = {[CW_ACTION] = true,
	[CW_CUSTOMIZE] = true,
	[CW_HOLSTER_START] = true,
	[CW_HOLSTER_END] = true}

function SWEP:GetPrefix()
	local prefix
	
	if self.isGripAttached then
		prefix = "grip_"
	elseif self.DualWieldLogic then
		prefix = "dw_"
	else
		prefix = "base_"
	end
	
	return prefix
end

if CLIENT then
	-- great thanks to kk!
	function SWEP:canPlayRestAnimations(checkType)
		checkType = checkType or 1
		-- local vel = GetVelocity(self.Owner)
		-- local len = Length(vel)
		-- local ws = self.Owner:GetWalkSpeed()
		
		if not self.Owner:OnGround() then
			return false
		end
		
		-- if not self:isInterruptableAnim() then
			-- return false
		-- end
		
		if not self:canFireWeapon(1) then
			return false
		end

		if (self.ReloadDelay and CT < self.ReloadDelay) or CurTime() < self.GlobalDelay then
			return false
		end
		
		if not self:canFireWeapon(2) then
			return false
		end
		
		if self.dt.BipodDeployed then
			return false
		end
		
		if self.isMeleeAttacking or self.attackDamageTime then
			return false
		end
		
		if self.dt.State == CW_CUSTOMIZE then
			return false
		end
		
		if checkType == 1 then
			-- this one is more strict
			if self.InactiveWeaponStates[self.dt.State] then
				return false
			end
		elseif checkType == 0 then
			if self.RestAnimationsStates[self.dt.State] then
				return false
			end
		else
		end
		
		return true
	end

	function SWEP:isInterruptableAnim()
		local cwaa = self.ActiveAttachments
		local prefix = self:GetPrefix()
		local vm = self.CW_VM
		local seq = vm:GetSequenceName(vm:GetSequence())
		local cycle = vm:GetCycle()
		-- wait,GetCycle can only be executed in clientside?
		if self.InterruptableAnims[seq] or cycle > 0.98 then
			return true
		else
			return false
		end
	end

	function SWEP:RestAnimationsThink()
		local prefix = self:GetPrefix()
		if self.Animations[prefix .. "sprint_loop"] then
			wasSprinting = self._wasSprinting
			isSprinting = self:isRunning()
			can = self:canPlayRestAnimations(0)
			
			if isSprinting != wasSprinting and wasSprinting != nil then
				if isSprinting and self:isInterruptableAnim() and can then
					self:sprintingAnimFunc()
				elseif self:isInterruptableAnim() then
					self:idleAnimFunc()
				end
			end
			
			self._wasSprinting = isSprinting
			
			if isSprinting then 
				return 
			end
		end
	
		if self.Animations[prefix .. "mantle_over"] then
			wasEnteringCrawling = self._wasEnteringPlayerProne
			isEnteringCrawling = self:isPlayerEnteringProne()
			can = self:canPlayRestAnimations(2)
			
			if isEnteringCrawling != wasEnteringCrawling and wasEnteringCrawling != nil then
				if isEnteringCrawling and self:isInterruptableAnim() and can then
					self:sendWeaponAnim(prefix .. "mantle_over", 0.75)
				elseif self:isInterruptableAnim() then
					self:idleAnimFunc()
				end
			end
			
			self._wasEnteringPlayerProne = isEnteringCrawling
			
			if isEnteringCrawling then 
				return 
			end
		end
	
		if self.Animations[prefix .. "crawl_loop"] then
			wasCrawling = self._wasPlayerProne
			isCrawling = self.dt.State == CW_PRONE_MOVING
			can = self:canPlayRestAnimations(2)
			
			if isCrawling != wasCrawling and wasCrawling != nil then
				if isCrawling and self:isInterruptableAnim() and can then
					self:proneAnimFunc()
				elseif self:isInterruptableAnim() then
					self:idleAnimFunc()
				end
			end
			
			self._wasPlayerProne = isCrawling
			
			if isCrawling then 
				return 
			end
		end
	end
end

function SWEP:proneAnimFunc()
	local cwaa = self.ActiveAttachments
	local prefix = self:GetPrefix()
	local act
	local speed = self.CrawlingSpeed or 0.75
	
	if self.Animations[prefix .. "crawl_loop"] then
		act = "crawl_loop"
		self:sendWeaponAnim(prefix .. act, speed)
	else
		self:idleAnimFunc()
	end

end

function SWEP:sprintingAnimFunc()
	local cwaa = self.ActiveAttachments
	local prefix = self:GetPrefix()
	local act
	local speed = self.SprintSpeed or 1
	
	if self.Animations[prefix .. "sprint_loop"] then
		act = "sprint_loop"
		self:sendWeaponAnim(prefix .. act, speed)
	else
		self:idleAnimFunc()
	end

end

function SWEP:idleAnimFunc()
	local cwaa = self.ActiveAttachments
	local prefix = self:GetPrefix()
	local act
	
	if self:Clip1() <= 0 and self.Animations[prefix .. "idle_empty"] then
		act = "idle_empty"
	else
		act = "idle"
	end
	
	self:sendWeaponAnim(prefix .. act)
end

-- what will happen if i blend the fas2 with cw2?
function SWEP:playFireAnim()
	local cwaa = self.ActiveAttachments
	local prefix = self:GetPrefix()
	local act
	
	if self:Clip1() - self.AmmoPerShot <= 0 and self.Animations[prefix .. "fire_last"] then
		act = "fire_last"
	elseif self.dt.State == CW_AIMING or self.dt.BipodDeployed then
		act = "fire_ads"
	else
		act = "fire"
	end
	
	self:sendWeaponAnim(prefix .. act)
end

function SWEP:holsterAnimFunc()
	local cwaa = self.ActiveAttachments
	local prefix = self:GetPrefix()
	
	self:sendWeaponAnim(prefix .. "holster", self.HolsterSpeed)
end

function SWEP:drawAnimFunc()
	local cwaa = self.ActiveAttachments
	local prefix = self:GetPrefix()
	
	if self.FirstDeploy then		
		self:sendWeaponAnim(prefix .. "draw_first", self.DrawSpeed)
	else
		self:sendWeaponAnim(prefix .. "draw", self.DrawSpeed)
	end
end

function SWEP:reloadAnimFunc(mag)
	-- local psc = self.primarySightCategory	
	-- local currentPrimarySight = self:getActiveAttachmentInCategory(psc)
	local cwaa = self.ActiveAttachments
	local prefix = self:GetPrefix()
	-- local IrAimPos = CustomizableWeaponry.sights[currentPrimarySight]
	-- local multiple = self.DualMagReloadMul or 0.75
	local used = self.isFirstMagUsed
	
	if mag == 0 then
		if cwaa.bg_blackops3_ext_mag then
			self:sendWeaponAnim(prefix .. "reload_empty_ext", self.ReloadSpeed)
		elseif cwaa.bg_blackops3_fast_mag then
			if self.DualMagLogic then
				if used then
					self:sendWeaponAnim(prefix .. "reload_empty_dm", self.ReloadSpeed)
				else
					self:sendWeaponAnim(prefix .. "reload_empty_dm_quick", self.ReloadSpeed)
				end
			else
				self:sendWeaponAnim(prefix .. "reload_empty_dm", self.ReloadSpeed)
			end
		else
			self:sendWeaponAnim(prefix .. "reload_empty", self.ReloadSpeed)
		end
	else
		if cwaa.bg_blackops3_ext_mag then
			self:sendWeaponAnim(prefix .. "reload_ext", self.ReloadSpeed)
		elseif cwaa.bg_blackops3_fast_mag then
			if self.DualMagLogic then
				if used then
					self:sendWeaponAnim(prefix .. "reload_dm", self.ReloadSpeed)
				else
					self:sendWeaponAnim(prefix .. "reload_dm_quick", self.ReloadSpeed)
				end
			else
				self:sendWeaponAnim(prefix .. "reload_dm", self.ReloadSpeed)
			end
		else
			self:sendWeaponAnim(prefix .. "reload", self.ReloadSpeed)
		end
	end
end