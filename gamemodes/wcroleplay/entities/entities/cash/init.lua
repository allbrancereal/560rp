AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
	self.Entity:SetModel("models/hunter/blocks/cube05x05x05.mdl")
	
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:SetUseType( SIMPLE_USE )
	self.Entity:SetCollisionGroup( COLLISION_GROUP_DEBRIS_TRIGGER )
	
	
	self.Entity:GetPhysicsObject():Wake();
end

function ENT:Use(activator, caller)
	if (!activator:IsPlayer()) then return; end
	local _worth = self:getFlag("money_Worth", 0 );
	
	activator:addMoney( _worth );
	activator:Notify("You picked up $" .. _worth );
	self:Remove()
end

hook.Add("PlayerSay", "dropMoneyCommand", function( _p , _text, _teamchat )


	local drop_money = "/drop";
	if (string.sub(_text, 1, string.len(drop_money)) == drop_money) then
			local Amount = string.gsub(_text, "/drop", "")
			Amount = tonumber(Amount);
			
			if Amount then
				if _p:getMoney() >= Amount then
					
					if Amount <= 0 then return end;
					
					local trace = {};
						trace.start = _p:GetShootPos();
						trace.endpos = _p:GetShootPos() + _p:GetAimVector() * 50;
						trace.filter = _p;
					local tRes = util.TraceLine(trace);
					
					_p:addMoney( -Amount )
					
					local _cash = ents.Create('cash');
					_cash:SetPos(tRes.HitPos)
					_cash:Spawn()
					_cash:setFlag( "money_Worth", Amount );
				else
				
					_p:Notify("You do not have that much cash on you.");
					
					return "";
					
				end;
				
			else
			
				_p:Notify("Please enter numbers only.");
				
			end
			
		return "";
		
	end	

end)

function ENT:OnTakeDamage(dmg)

end

function ENT:Explode()

end