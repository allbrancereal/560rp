
-- This sets the model for the NPC.
NPC.model = "models/sentry/gtav/mexican/pologoon1pm.mdl"
-- This is for player models that support player colors. The values range from 0-1.
NPC.color = Vector(1, 0, 0)
NPC.name = "Lonely Wolf"

-- Uncomment to make the NPC sit.
--NPC.sequence = "sit"

-- This receives the ignite message from cl_init.lua
-- client is the player that sent the message.
-- As you can see, the seconds argument is available.

-- Called when the entity for the NPC has been created.
-- This allows you to modify the NPC itself.
function NPC:onEntityCreated(entity)
	self.entity = entity;
    --print(entity)
    --entity:Ignite(5)
end
function NPC:onfinishquest7(_p)
	local _finished, _lfinished = _p:FinishedQuest(7);
	local _ActiveQuests = _p:getFlag("questTable", nil )

	if istable(_ActiveQuests[7]) and _ActiveQuests[7].Step == 2 then
		_p:RewardQuest( 7, _ActiveQuests )
	end


end


function NPC:onstartquest7(  _p )
	local _finished, _lfinished = _p:FinishedQuest(7);

	local _ActiveQuests = _p:getFlag("questTable", nil )

	if _finished == false or (_finished==true and os.time()>_lfinished+QUEST_TABLE[7].Cooldown) then
		_p:StartQuest(7)

	
	else
		_p:Notify("You already rescued the cat!")
	end

end 
