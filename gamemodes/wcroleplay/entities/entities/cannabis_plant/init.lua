AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self.Entity:SetModel("models/alakran/marijuana/pot.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:SetUseType(SIMPLE_USE)
	self.Entity:SetAngles(Angle(0, math.random(1, 360), 0))
	self.Damage = 100
	self.drugWeedAmount = math.random(25, 45)
	self.Growth = 1
	self:setFlag( "weed_SpawnTime", CurTime() )
	self:setFlag( "weed_GrowthTime", CurTime() )
	self.Entity:GetPhysicsObject():Wake()
	
end

function ENT:OnTakeDamage(dmg)
    self.Damage = self.Damage - dmg:GetDamage()
    if self.Damage <= 0 then
         self:Remove()
    end
end

function ENT:Use(activator, ent)

	local _spawnTime   = self:getFlag( "weed_SpawnTime", 0 );
	local _curTime	   = CurTime()
	local _timeElapsed = _curTime - _spawnTime;
	local _owner;
	
	for k , v in pairs( player.GetAll() ) do
			
		if v:SteamID() == self:getFlag( "ownedBy", "" ) then
					
			_owner = v;
				
			break
					
		end
				
	end
			
	local _org = activator:getFlag("organization",0);
	local _memberAmount = 0;

	for k , v in pairs( player.GetAll() ) do
		
		if v:getFlag("organization",0) == _org then
			
			_memberAmount = _memberAmount+1;

		end

	end

	local _OrgBonus = _memberAmount >5 && true || false;
	//print(_OrgBonus)
	if(activator:IsPlayer()) then
	
		if _timeElapsed > 300 && _timeElapsed < 450 then
		
			activator:Notify( "You have trimmed the bud too early, therefore you have not received as many weed nugs" );
			
			//activator:AddCannabisCount( math.random( 1, 5 ) );
				for i=1, math.random( 1, 5 ) do
					activator:AddItemByID( 57 );
				end
			
			self:EmitSound( "items/ammocrate_open.wav" , 100, 100, 1 , CHAN_ITEM )
			
			if _owner then
			
				_owner:setFlag("maxcannabisplants", math.Clamp( _owner:getFlag( "maxcannabisplants", 0 ) - 1 , 0 , _owner:GetCannabisPlantLimit() ) )
			
			end
			
			self:Remove()
			
		elseif _timeElapsed > 450 then
		
			
			self:EmitSound( "items/ammocrate_open.wav" , 100, 100, 1 , CHAN_ITEM )
		
			
			/* if tonumber(os.date( "%H" , os.time() )) >= 20 && tonumber(os.date( "%H" , os.time() ))  < 21 then
				
				activator:ChatPrint("You have received double cannabis because it's bonus hour!")
				for i=1, math.random( 31, 60 ) do
					activator:AddItemByID( 57 );
				end
			else */

				//activator:ChatPrint("Bonus hour is at 8PM it's " .. os.date( "%r" , os.time() ) .. " Server Time.")
				local _lv = 1;
				if self.Owner:GetRotoLevel(18) then
					_lv = self.Owner:GetRotoLevel(18)[1]
				end
				if _owner != activator && _owner:getFlag("organization","") != activator:getFlag("organization","") then
					activator:AddRotoXP(13,RotoLevelSystem.config.RewardXP+(RotoLevelSystem.config.RewardXPPerLevel*_lv)/20)
				
				else
					_owner:AddRotoXP(11,RotoLevelSystem.config.RewardXP+(RotoLevelSystem.config.RewardXPPerLevel*_lv))
				end
				local _minC,_maxC = 1, 30;
				_maxC = _maxC + (_lv*1)
				if _OrgBonus then

					_minC = 30;
					_maxC = 60;

				end
				local _hascd = _owner:HasCooldown("WeedBoost") ;
				if _hascd == true then				
					_minC = _minC*2;
					_maxC = _maxC*2;
				end
				if os.time()-LastGlobalWeedBoost>3600 then
					
					_minC = _minC*2;
					_maxC = _maxC*2;

				end
				
			// end

			if _owner then
			
				_owner:setFlag("maxcannabisplants", math.Clamp( _owner:getFlag( "maxcannabisplants", 0 ) - 1 , 0 , _owner:GetCannabisPlantLimit() ) )
				
				if _owner:HasOrgBoost() == true then
					
					_minC = _minC*2;
					_maxC = _maxC*2;

				end
			end
					local _am = math.random( _minC, _maxC );
					for i=1, _am do
						activator:AddItemByID( 57 );
					end
					local _sam= math.random(1,5)
					if math.random( 0, 100 ) > (100-fsrp.config.SeedChance) then
						for i=1,_sam do
							activator:AddItemByID( 96 );
						end						
					end

					activator:Notify("You have received cannabis for your troubles. You have picked up " .. _am .." grams of bud and " .. _sam .. " seeds.")
			
			self:Remove()
			
		else
		
			activator:Notify( "The buds are not ready for extraction." )
		
		end
	
	end
	
end

function ENT:Think()
			
	if CurTime() - self:getFlag("weed_GrowthTime", 0 ) > 90 then
        if self.Growth < 5 then
            self.Growth = self.Growth + 1
            self.Entity:SetModel("models/alakran/marijuana/marijuana_stage"..self.Growth..".mdl")
            
			self:setFlag( "weed_GrowthTime", CurTime() )
            local Pos, Ang = LocalToWorld(Vector(0,0,10), Angle(0,0,90), self:GetPos(), self:GetAngles())
			local WeedGrowthEffect = WeedGrowthEffect or EffectData()
			
			local _owner = self:getFlag( "ownedBy", "" );
		
			_col = Color( 255 , 0 ,0  )
			

		
			WeedGrowthEffect:SetOrigin(Pos)
			WeedGrowthEffect:SetMagnitude(1)
			WeedGrowthEffect:SetScale(1.2)
			WeedGrowthEffect:SetRadius(1)
			WeedGrowthEffect:SetColor( _col.r,_col.g,_col.b,_col.a  )	
			util.Effect("weed_growth_effect",WeedGrowthEffect)
        end
    end
end
