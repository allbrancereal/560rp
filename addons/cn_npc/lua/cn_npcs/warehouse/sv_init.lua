
-- This sets the model for the NPC.
NPC.model = "models/player/tfa_dcu_cptcold.mdl"
-- This is for player models that support player colors. The values range from 0-1.
NPC.color = Vector(1, 0, 0)
NPC.name = "Warehouse Manager Triss"
-- Uncomment to make the NPC sit.
--NPC.sequence = "sit"
NPC.reputation =3;


-- Called when the entity for the NPC has been created.
-- This allows you to modify the NPC itself.
function NPC:onEntityCreated(entity)
    --print(entity)
    --entity:Ignite(5)
end