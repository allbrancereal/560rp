
-- This sets the model for the NPC.
NPC.model = "models/sentry/gtav/mexican/mexboss1pm.mdl"
-- This is for player models that support player colors. The values range from 0-1.
NPC.color = Vector(1, 0, 0)
NPC.name = "Doctor Serah"

NPC.reputation =2;
-- Uncomment to make the NPC sit.
--NPC.sequence = "sit"

-- This receives the ignite message from cl_init.lua
-- client is the player that sent the message.
-- As you can see, the seconds argument is available.
--function NPC:onIgnite(client, seconds)
	--client:Ignite(tonumber(seconds) or 5)
--end

-- Called when the entity for the NPC has been created.
-- This allows you to modify the NPC itself.
function NPC:onEntityCreated(entity)
    --print(entity)
    --entity:Ignite(5)
end

function NPC:onresetHP( client )

	local _hp = client:Health()
		
	if _hp >= 75 && _hp <= 99 then
	
		client:SetHealth( 100 );
	
	elseif _hp <= 74 && _hp >=51 then
	
		if client:canAfford( fsrp.config.HealthResetCost ) then
		
			client:SetHealth( 100 )
	
		end
		
	elseif _hp <= 50 && _hp > 0 then

		client:SetHealth( 100 )
		
	end
	
	if client.__Crippled then
	
		client.__Crippled = false;
		client:SetWalkSpeed(fsrp.config.WalkSpeed);
		cleitn:SetRunSpeed(fsrp.config.RunSpeed);
		
	end
	
end

function NPC:onnextPaydayHealMoney( client )

	client.__paydayhealmoney = true;

end