
-- This sets the model for the NPC.
NPC.model = "models/gtaiv/characters/niko.mdl"
NPC.name = "Mysterious Slav"

-- This is for player models that support player colors. The values range from 0-1.
NPC.color = Vector(1, 0, 0)

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

function NPC:onStartTutorial3( client )
	
	if !client:getFlag("questTable",{})[3] then
		client:StartQuest( 3 );
		
	end

end
function NPC:onqueststep2( client )
	if !client:IsOnQuest(3) then
		client:AdvanceQuestStep( 3)
	end
end