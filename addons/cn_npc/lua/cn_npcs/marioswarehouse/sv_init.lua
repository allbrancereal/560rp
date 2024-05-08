
-- This sets the model for the NPC.
NPC.model = "models/player/Berserk/Guts_Teen.mdl"
-- This is for player models that support player colors. The values range from 0-1.
NPC.color = Vector(1, 0, 0)
NPC.name = "Mario"

NPC.reputation =5;
-- Uncomment to make the NPC sit.
--NPC.sequence = "sit"

-- Called when the entity for the NPC has been created.
-- This allows you to modify the NPC itself.
function NPC:onStartRobbery(entity)
    --print(entity)
    --entity:Ignite(5)
    entity:StartBankRobbery(self)
end