

 
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

local supplyLength = fsrp.config.Printer.SupplyAmount; -- determines how long a supply works for
local printCost = fsrp.config.Printer.Cost; -- determines how much a print will cost
local printTime = fsrp.config.Printer.Time; -- time per print
local printAmount = fsrp.config.Printer.Amount; -- amount a money bag will be printing
local maxPrintSpeed = fsrp.config.Printer.MaxPrintSpeed;
local UpgradeCost = fsrp.config.Printer.UpgradeCost;
util.AddNetworkString("sendMPCommand")
net.Receive("sendMPCommand", function(_l,_p)
	local _com = net.ReadInt(8)
	local _ent = Entity(net.ReadInt(16))
	local _lastbuy = _p:HasCooldown("MPCommand");
	if _lastbuy == true then return end
	if _ent and _ent:GetClass() == "moneyprinter" then
		local _spd = _ent:getFlag("speed",0)
		if _com == 1 and _spd< maxPrintSpeed then -- Plus
			local _useBank = true;
			if !_p:canAffordBank(UpgradeCost) and _p:canAfford(UpgradeCost) then
				_useBank = false
			end
			if _useBank == false and !_p:canAfford(UpgradeCost) then return _p:Notify("You can not afford the printer upgrade cost! ($" .. UpgradeCost .. ")") end
			if _useBank == true then
				_p:addBank(-UpgradeCost)
			else 
				_p:addMoney(-UpgradeCost)
			end
			_ent:setFlag("speed",math.min(_spd+1,maxPrintSpeed))			
			_p:Notify("You have purchased a Money Printer Speed Upgrade for $" .. UpgradeCost)
		elseif _com == 2 and _spd>0 then -- Minus
			_ent:setFlag("speed",math.max(_spd-1,0))	
			_p:addMoney(0.25*UpgradeCost)
			_p:Notify("You have refunded a Money Printer Speed Upgrade for $" .. 0.25*UpgradeCost)
					
		elseif _com == 3 then -- Toggle On
			local _on = _ent:getFlag("on",false);
			_ent:setFlag("on",!_on);			
		elseif _com == 4 then -- Pocket
			//_ent:Remove()
		end
	end
	_p:HasCooldown("MPCommand",.25);
end)
function ENT:Initialize()

	self.Entity:SetModel("models/props_lab/reciever_cart.mdl")
	//self.Entity:SetModelScale(0.15);
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:SetUseType( SIMPLE_USE )
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:GetPhysicsObject():Wake();
	self.Heat=0
	self.HeatMax = 100;
	self.Entity:SetTrigger(false)
	self:OnHeatAdd()
	self:SetPos(self:GetPos()+Vector(0,0,50))
	self:setFlag("lasttime",CurTime())
	self:setFlag("on",true)
	self.Supply = 0
	self.Speed = 0
	self:OnSupplyAdd()

end
if timer.Exists("mptimer") then
	timer.Destroy("mptimer")
end	
timer.Create("mptimer",.1,0,function()
	for k , v in pairs(ents.FindByClass("moneyprinter")) do
		v:CheckTime()		
	end
end)

function ENT:Use( activator, caller )
	if !activator:IsPlayer() then return false; end
	if activator:IsGovernmentOfficial() then
		activator:addMoney(5000)
		activator:PrintMessage("You have confiscated a money printer.")
		self:Remove()
	end
	
end
function ENT:Explode()

	self.effectdata = EffectData()
	local ang = self:GetAngles()
	ang:RotateAroundAxis( self:GetForward(),90);
	ang:RotateAroundAxis(self:GetRight(),90)
	self.effectdata:SetOrigin( self:GetPos() + ang:Forward()*20 )
	self.effectdata:SetEntIndex(self:EntIndex());
	//self.effectdata:SetRadius(64);

	util.Effect( "explosion_meth", self.effectdata )
	for k , v in pairs(ents.FindInSphere(self:GetPos(),300) ) do
		if v and IsValid(v) and (v:GetClass() == "mp_bag" or v:GetClass() == "mp_supply") then
			
			v:Remove()
		elseif v and v:IsPlayer() then


		
			local _skill = skillpoint_Helper_GetSkillPoint(v , "luck" ) || 0;
			local _rand = math.random( 100 - (_skill*5) )
			if _rand > 50 then
				v:Kill()
			end
		end
	end

	self:Remove()
end


function ENT:CheckTime()
	local _on = self:getFlag("on",false);
	local _heat = self:getFlag("heat", 0);
	self:StartSound()
	if _on == true then
		local _lastTime = self:getFlag("lasttime",CurTime());
		local _speed = self:getFlag("speed",0);

		if _lastTime + (printTime-_speed) <= CurTime() then
			self:setFlag("lasttime",CurTime())
			local _supp = self:getFlag("supply",0);
			if _supp - printCost > 0 then  

				self:setFlag("supply",_supp-printCost);
				self:SpitMoney()
			else
				self:setFlag("on",false)
			end
		end
	end
	if _heat >= 100 then
		self:Explode()
	end
end

function ENT:StartSound()
    self.sound = CreateSound(self, Sound("ambient/levels/labs/equipment_printer_loop1.wav"))
    self.sound:SetSoundLevel(52)
    self.sound:PlayEx(1, 100)
end
function ENT:SpitMoney()
	local _on = self:getFlag("on",false);
	local _speed = self:getFlag("speed",0);
	if _on == true then
		local _pos = self:GetPos()

		local _newBag = ents.Create("mp_bag")
		_newBag:SetPos(((_pos+self:GetForward()*15)+self:GetUp()*-10))
		_newBag:Spawn()
		_newBag:setFlag("amount",printAmount)
		if math.random(2) == 1 then
			self:AddHeat(math.random(math.max(0,3-(0.25*_speed))))
		end
	end
end
/*
function ENT:SetupID( id, owner )

	self.ID = id;
	self:setFlag("itemID", id )
	self:setFlag("savedInvEntity", true )
	self:setFlag("ownedBy", owner )
		

end*/
/*
function ENT:Use( activator, caller )
	if !activator:IsPlayer() then return false; end
	
	local _on = self:getFlag("on",false);
	self:setFlag("on",!_on)
	if !_on == true then
		self:setFlag("lasttime",CurTime())		
	end
	/*if !self.ID then self:Remove(); return false; end
	if activator:KeyDown(IN_WALK) then 
	
		if activator:SteamID() != self:getFlag( "ownedBy" ,"" )  then return false; end
		if self.Entity:getFlag("useDelay", 0 ) and self.Entity:getFlag("useDelay", 0 ) > CurTime() then return false; end
		
		self.Entity:setFlag("useDelay", CurTime() + 2.5 )
		
		activator:EmitSound("items/ammocrate_open.wav")
		activator:AddItemByID( ITEMLIST[self.ID].ID )

		
		self:Remove();
	
	end
	
end

*/

function ENT:AddHeat(am)

	self.Heat = math.Clamp( self.Heat+am,0,100);

	self:OnHeatAdd()

end

function ENT:AddSupply(x)
	local _old = self:getFlag("supply",0);
	self.Supply = _old+ (math.max(1,x)*supplyLength);

	self:OnSupplyAdd()
	
end
function ENT:SetSpeed(x)

	self.Speed = x
	self:setFlag("speed",x);
	
end

function ENT:OnSupplyAdd()
	
	self:setFlag("supply",self.Supply);
end

function ENT:OnHeatAdd()
	if self.Heat > self.HeatMax then
			
		self:Explode()
		self:Remove()


		return
	end
	local _alpha = 255* (self.Heat/100);
	//print(Color(255, 255-_alpha , 255-_alpha,255))

	self:SetColor( Color(255, 255-_alpha , 255-_alpha,255) );

	self:setFlag("heat",self.Heat);
end

function ENT:StartTouch(otherEnt)
	if otherEnt:GetClass() == "cooling_water" then
		self:AddHeat(-10);
		self:OnHeatAdd();
		otherEnt:Remove()
	end
end
