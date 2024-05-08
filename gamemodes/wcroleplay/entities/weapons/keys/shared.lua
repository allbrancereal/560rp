
if SERVER then
	AddCSLuaFile("shared.lua")
end

if CLIENT then
	SWEP.PrintName = "Keys"
	SWEP.Slot = 1
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

SWEP.Author = "Tibba"
SWEP.Instructions = "Left Click: Lock Door, Right Click: Unlock Door Reload to knock!"
SWEP.Contact = ""
SWEP.Purpose = ""

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false 
SWEP.AnimPrefix	 = "rpg"

SWEP.LockSound = "doors/door_latch1.wav"
SWEP.UnlockSound = "doors/door_latch3.wav"

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
SWEP.ViewModel = ""
SWEP.WorldModel = ""

hook.Add("ShouldCollide","CollideWhileInstanced", function(_p,_p2)

	-- If players are about to collide with each other, then they won't collide.
	if ( IsValid( ent1 ) and IsValid( ent2 ) and ent1:IsPlayer() and ent2:IsPlayer() ) then 
		
		return false 

	end

end)
function SWEP:Initialize()
	self:SetWeaponHoldType("normal")
end

function SWEP:CanPrimaryAttack ( ) return true; end
if SERVER then
	util.AddNetworkString("clientShown")
end

if CLIENT then
	net.Receive("clientShown", function(_l, _p)
		
		local _type = net.ReadBool();


		for k , v in pairs( player.GetAll() ) do
			//if v == LocalPlayer() then return end
			
			v:SetNoDraw( _type )			
		end

	end)
end


function SWEP:PrimaryAttack()
	if CLIENT then return false; end

	local EyeTrace = self.Owner:GetEyeTrace()
/*	
		local closest = nil
		local dist = 600
		for k,v in pairs(ents.FindByClass("prop_vehicle_jeep")) do
			local bufdist = v:GetPos():Distance(self.Owner:GetPos())
			local checkdistance = v:GetPos():Distance(self.Owner:GetPos())
	        if checkdistance > 125 then
				if bufdist < dist then
					dist = bufdist
					closest = v
				    OwnerOfThis = v:GetPropertyTable().PrimaryOwner[1]
					Nick = v:GetPropertyTable().PrimaryOwner[1]:GetRPName()
				end
			end
		end
*/
	local Distance1 = self.Owner:EyePos():Distance(EyeTrace.HitPos);	
		
	//if (EyeTrace.Entity:IsVehicle() and Distance1 < 125) or (EyeTrace.Entity:IsDoor() and Distance1 < 75) then
	if (EyeTrace.Entity:IsDoor() and Distance1 < 75) then
		if (!EyeTrace.Entity || !IsValid(EyeTrace.Entity)) then return false; end
	
		if Distance1 > 75 and EyeTrace.Entity:IsDoor() then return false; end
		self.Weapon:SetNextPrimaryFire(CurTime() + 1)



		local _IsBusinessDoor = EyeTrace.Entity:getFlag("businessDoor",nil);

		local _IsClubHouseDoor = EyeTrace.Entity:getFlag("clubhouseDoor",nil);
		local _IsKeyOwnerInside = self.Owner:getFlag("ResidingInControlledProperty", nil);
		local _business = self.Owner:GetBusiness(true);

		local _ownerWeapons = self.Owner:GetWeapons();

		if (_IsClubHouseDoor) then
			
			//if !self.Owner:IsAdmin() then return self.Owner:Notify("This property is not available yet") end
			local _hasAllowance = self.Owner:HasBusinessIDTag(fsrp.ClubhousePropertyTable[_IsClubHouseDoor].ClubHouseInformation.Tag,true);
			//print(_hasAllowance)

			if _hasAllowance==false then return self.Owner:Notify("You must purchase this property on Maze Bank Foreclosures to access it.") end

			if _IsKeyOwnerInside then
				// Bring owner outside
				if _IsKeyOwnerInside == _IsClubHouseDoor then
					self.Owner:Notify("You have exited: " .. fsrp.ClubhousePropertyTable[_IsClubHouseDoor].Name  )
					self.Owner:setFlag("ResidingInControlledProperty", nil );
					
					local _targetLoc = fsrp.ClubhousePropertyTable[_IsClubHouseDoor].ClubHouseInformation.ExitLoc
					self.Owner:SetPos(_targetLoc[1])
					self.Owner:SetEyeAngles(_targetLoc[2]);

					net.Start("clientShown")
					net.WriteBool(false)
					net.Send(self.Owner)

					self.Owner:SetCollisionGroup(COLLISION_GROUP_PLAYER)
				end

			else
				// if owner owns this business then go in
				self.Owner:Notify("You have entered: " .. fsrp.ClubhousePropertyTable[_IsClubHouseDoor].Name )
				self.Owner:setFlag("ResidingInControlledProperty", _IsClubHouseDoor );
				
				local _targetLoc = fsrp.ClubhousePropertyTable[_IsClubHouseDoor].ClubHouseInformation.EnterLoc
				self.Owner:SetPos(_targetLoc[1]);
				self.Owner:SetEyeAngles(_targetLoc[2]);

				net.Start("clientShown")
				net.WriteBool(true)
				net.Send(self.Owner)

				self.Owner:SetCollisionGroup(COLLISION_GROUP_DEBRIS)

			end
			
		end

		if (_IsBusinessDoor) then
			//if !self.Owner:IsAdmin() then return self.Owner:Notify("This Property is not available yet.") end
			if self.Owner:Team() != TEAM_CIVILLIAN then return self.Owner:Notify("You may only enter Illegal Manufacturing Businesses without a job.") end
				
			local _foundOwning = false;

			for k , v in pairs( _business) do
				if v[2] == fsrp.I_BusinessPropertyTable[_IsBusinessDoor].BusinessInformation.Tag then
					_foundOwning = true;
				end		
			end

			if _foundOwning == false  then
				
				return self.Owner:Notify("Purchase this property on the TheOpenRoad.")

			end

			if _IsKeyOwnerInside then
				
				// Bring owner outside
				if _IsKeyOwnerInside == _IsBusinessDoor then
					self.Owner:Notify("You have exited: " .. fsrp.I_BusinessPropertyTable[_IsBusinessDoor].Name  )
					//self.Owner:Notify("You have exited: " .. fsrp.config.IllegalBusinessTypes[fsrp.I_BusinessPropertyTable[_IsBusinessDoor].BusinessInformation.Type].Name )
					self.Owner:setFlag("ResidingInControlledProperty", nil );
					
					local _targetLoc = fsrp.I_BusinessPropertyTable[_IsBusinessDoor].BusinessInformation.ExitLoc
					self.Owner:SetPos(_targetLoc[1])
					self.Owner:SetEyeAngles(_targetLoc[2]);

					net.Start("clientShown")
					net.WriteBool(false)
					net.Send(self.Owner)
					self.Owner:ShowPropertyHUD(true)
					self.Owner:SetCollisionGroup(COLLISION_GROUP_PLAYER)
				end

			else
				local _pWanted = self:getFlag("warrent", false);
				if _pWanted == true then return self:Notify("You cannot enter your illegal manufacturing factory while there is a warrant out for you!") end
				
				// if owner owns this business then go in
				self.Owner:Notify("You have entered: " .. fsrp.I_BusinessPropertyTable[_IsBusinessDoor].Name )
				self.Owner:setFlag("ResidingInControlledProperty", _IsBusinessDoor );
				
				local _targetLoc = fsrp.I_BusinessPropertyTable[_IsBusinessDoor].BusinessInformation.EnterLoc
				self.Owner:SetPos(_targetLoc[1]);
				self.Owner:SetEyeAngles(_targetLoc[2]);

				net.Start("clientShown")
				net.WriteBool(true)
				net.Send(self.Owner)
				local _map = game.GetMap() == "rp_downtown_v4c_v2" && true || false;
				local _businessinfo = fsrp.I_BusinessPropertyTable[_IsBusinessDoor];
				local _businessmap = _businessinfo.DifferentMap == true && (_map==true&&false|| true) || (game.GetMap()=="rp_downtown_v4c_v2");
				local _data = self.Owner:GetBusiness(_businessmap);
				for k , v in pairs(_data) do

					if istable(v[5]) then
						
						if  v[2] == _businessinfo.BusinessInformation.Tag then
					 	
							if v[5][4] then

								if v[5][4][1] == true then
									self.Owner:FinishInitMission(k,_businessmap)
								end

							end

						end
						
					end
				
				
					if v[5] and v[5] == true then
						if v[7] and v[7][2] and v[2] == _businessinfo.BusinessInformation.Tag then

							if v[7][4] then

								if v[7][4][1] == true then
									self.Owner:FinishSupplyMission(k,_businessmap)
								end

							end

						end
						if v[8] and v[8][2] and v[2] == _businessinfo.BusinessInformation.Tag then

							if v[8][4] then

								if v[8][4][1] == true && !v[8][4][3] then
									self.Owner:FinishDeliveryMission(k,_businessmap)
								end

							end

						end
					end
 				end

 				self.Owner:ShowPropertyHUD()
				self.Owner:SetCollisionGroup(COLLISION_GROUP_DEBRIS)

			end
			
			return true
		end

		local _id = EyeTrace.Entity:getFlag("doorID", nil)
		
		//if Distance1 > 125 and EyeTrace.Entity:IsVehicle() then return false; end
		if !_id && EyeTrace.Entity:IsPoliceDoor() && table.HasValue( {TEAM_POLICE,TEAM_PARAMEDIC,TEAM_MAYOR,TEAM_SWAT},self.Owner:Team()) then
		
			
			EyeTrace.Entity:Fire("lock", "", 0)
			self.Owner:EmitSound(self.LockSound)	
			
			return true
		
		end
		local _pTbl = fsrp.PropertyTable[_id];
		
		if _pTbl then
			
			local _prosOwner = _pTbl.PrimaryOwner && _pTbl.PrimaryOwner[2] || "";
			
			if _prosOwner == self.Owner:SteamID() then
			
					EyeTrace.Entity:Fire("lock", "", 0)
					
					self.Owner:EmitSound(self.LockSound)	
		
				return true
				
			else
			
				for k , v in pairs( player.GetAll() ) do
				
					if v != self.Owner && v:SteamID() == _prosOwner &&  v:HasBuddy( self.Owner ) then
					
							EyeTrace.Entity:Fire("lock", "", 0)
							self.Owner:EmitSound(self.LockSound)	
						
						break
						
					end
				
				end
			end
			
		end
		
	elseif EyeTrace.Entity:IsVehicle() then
		if (!EyeTrace.Entity || !IsValid(EyeTrace.Entity)) then return false; end
	
		if Distance1 > 75 and EyeTrace.Entity:IsVehicle() then return false; end
		self.Weapon:SetNextPrimaryFire(CurTime() + 1)
		local _id = EyeTrace.Entity:getFlag("carOwner", "")
		if _id == "" then return end
		local _player = player.GetBySteamID( _id );
		
		if _id != self.Owner:SteamID() && _player:HasBuddy( self.Owner ) then
		
			EyeTrace.Entity:Fire("lock", "", 0)
			self.Owner:EmitSound(self.LockSound)	
		
		
		elseif self.Owner:SteamID() == _id then
		
			EyeTrace.Entity:Fire("lock", "", 0)
			self.Owner:EmitSound(self.LockSound)	
	
		
		end
	
	end
	/*
	elseif closest then
   		local Distance = self.Owner:GetPos():Distance(closest:GetPos());
	
		if closest and closest:IsValid() and !closest:IsDoor() and (Distance > 100 and closest:IsVehicle()) then
			if self.Owner:CanManipulateDoor(closest) then
       	   		if closest:GetSharedBool("Locked", true) then 
				    self.Owner:Notify("Vehicle already locked!")
					return false;
				else
					closest:Fire("lock", "", 0)
					closest:EmitSound("perp/car_alarm_chirp2.wav")
					closest:EmitSound("perp/car_alarm_chirp2.wav")
					closest:SetSharedBool("Locked", true)
					if OwnerOfThis == self.Owner then
					    self.Owner:Notify("You locked your vehicle.")
					else
					    self.Owner:Notify( "You locked " .. closest:GetSharedEntity("owner"):GetRPName() .. "'s vehicle." )
					end		

    			    self.Weapon:SetNextPrimaryFire(CurTime() + 3)	
    			    return false;
				end
     	   end		
		end		*/	
			
end

function SWEP:SecondaryAttack()
	if CLIENT then return false; end

	local EyeTrace = self.Owner:GetEyeTrace()
	/*
		local closest = nil
		local dist = 600
		for k,v in pairs(ents.FindByClass("prop_vehicle_jeep")) do
			local bufdist = v:GetPos():Distance(self.Owner:GetPos())
			local checkdistance = v:GetPos():Distance(self.Owner:GetPos())
	        if checkdistance > 125 then
				if bufdist < dist then
					dist = bufdist
					closest = v
				    OwnerOfThis = v:GetSharedEntity("owner")
					Nick = v:GetSharedEntity("owner"):GetRPName()
				end
			end
		end
*/
	local Distance1 = self.Owner:EyePos():Distance(EyeTrace.HitPos);	
		
	//if (EyeTrace.Entity:IsVehicle() and Distance1 < 125) or (EyeTrace.Entity:IsDoor() and Distance1 < 75) then		
	if (EyeTrace.Entity:IsDoor() and Distance1 < 75) then		
	
		if (!EyeTrace.Entity || !IsValid(EyeTrace.Entity)) then return false; end
	
		if Distance1 > 75 and EyeTrace.Entity:IsDoor() then return false; end
		//if Distance1 > 125 and EyeTrace.Entity:IsVehicle() then return false; end
	
		self.Weapon:SetNextSecondaryFire(CurTime() + 1)
		local _id = EyeTrace.Entity:getFlag("doorID", nil)
		
		//if Distance1 > 125 and EyeTrace.Entity:IsVehicle() then return false; end
		if !_id && EyeTrace.Entity:IsPoliceDoor() && table.HasValue( {TEAM_POLICE,TEAM_PARAMEDIC,TEAM_MAYOR,TEAM_SWAT},self.Owner:Team()) then
		
			EyeTrace.Entity:Fire("unlock", "", 0)
			self.Owner:EmitSound(self.UnlockSound)	
			return true
		
		end
		
		local _pTbl = fsrp.PropertyTable[_id];
		
		if _pTbl then
		
			local _prosOwner = _pTbl.PrimaryOwner && _pTbl.PrimaryOwner[2] || "";
			
			if _prosOwner == self.Owner:SteamID()  then
			
				EyeTrace.Entity:Fire("unlock", "", 0)
				self.Owner:EmitSound(self.UnlockSound)	
		
				return true
				
			else
			
				for k , v in pairs( player.GetAll() ) do
				
					if v != self.Owner && v:SteamID() == _prosOwner &&  v:HasBuddy( self.Owner ) then
					
						EyeTrace.Entity:Fire("unlock", "", 0)
						self.Owner:EmitSound(self.UnlockSound)	
						
						break
						
					end
				
				end
			end
			
		end
		
	elseif EyeTrace.Entity:IsVehicle() then
		if (!EyeTrace.Entity || !IsValid(EyeTrace.Entity)) then return false; end
	
		if Distance1 > 75 and EyeTrace.Entity:IsVehicle() then return false; end
		self.Weapon:SetNextPrimaryFire(CurTime() + 1)
		local _id = EyeTrace.Entity:getFlag("carOwner", "")
		if _id == "" then return end
		local _player = player.GetBySteamID( _id );
		
		if _id != self.Owner:SteamID() && _player:HasBuddy( self.Owner ) then
		
			
			EyeTrace.Entity:Fire("unlock", "", 0)
			self.Owner:EmitSound(self.UnlockSound)	
		
		
		elseif self.Owner:SteamID() == _id then
		
			EyeTrace.Entity:Fire("unlock", "", 0)
			self.Owner:EmitSound(self.UnlockSound)	
		
		end

	end
	/*
	elseif closest then	
   	    local Distance = self.Owner:GetPos():Distance(closest:GetPos());	
	
		if closest and closest:IsValid() and !closest:IsDoor() and (Distance > 100 and closest:IsVehicle()) then
			if self.Owner:CanManipulateDoor(closest) then
         	   if !closest:GetSharedBool("Locked", false) then 
				    self.Owner:Notify("Vehicle already unlocked!")
					return false;
				else
					closest:Fire("unlock", "", 0)
					closest:EmitSound("perp/car_alarm_chirp2.wav")
					closest:EmitSound("perp/car_alarm_chirp2.wav")
					closest:SetSharedBool("Locked", false)
					if OwnerOfThis == self.Owner then
					    self.Owner:Notify("You unlocked your vehicle.")
					else
					    self.Owner:Notify( "You unlocked " .. closest:GetSharedEntity("owner"):GetRPName() .. "'s vehicle." )
					end	

    			    self.Weapon:SetNextPrimaryFire(CurTime() + 3)	
    			    return false;
				end
    	    end		
		end	
	end	*/
end
function SWEP:Reload() 
	local EyeTrace = self.Owner:GetEyeTrace()
	if self.Owner.LastAction && self.Owner.LastAction > CurTime() - math.random(0.1) then return end
	
	if !EyeTrace.Entity:IsValid() or !EyeTrace.Entity:IsDoor() then return false; end
	
	local Distance = self.Owner:EyePos():Distance(EyeTrace.HitPos);
	
	if Distance > 75 then return false; end
	
	self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )
	self.Weapon:EmitSound("physics/plastic/plastic_box_impact_hard" .. tostring(math.random(1, 4)) .. ".wav", 100, 100)
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self.Owner.LastAction = CurTime()
	
end

function SWEP:GetViewModelPosition ( pos, ang )
	return pos, ang
	
end