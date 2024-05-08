
-- This sets the model for the NPC.
NPC.model = "models/virtual_youtuber/sister_cleaire/sister_cleaire_npc.mdl"
-- This is for player models that support player colors. The values range from 0-1.
NPC.color = Vector(1, 0, 0)
NPC.name = "Plastic Surgeon Dr. Rina Gading"
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


function NPC:onAttemptSexChange( client )

	if client:canAffordBank( fsrp.config.SexChangeCost ) then
		
		fsdb_changeSex( client )
		client:addBank( -fsrp.config.SexChangeCost );
		client:Notify("Your sex has been changed")
		
	else
	
		client:Notify("You cannot afford this")
	end

end

function NPC:onAcquireSkillpoints( client )

	client:PurchaseSkillPoint()
	
end