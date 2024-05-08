
-- This sets the model for the NPC.
NPC.model = "models/props_unique/atm01.mdl"
-- This is for player models that support player colors. The values range from 0-1.
NPC.color = Vector(1, 0, 0)
NPC.name = "ATM"

-- Uncomment to make the NPC sit.
--NPC.sequence = "sit"

-- This receives the ignite message from cl_init.lua
-- client is the player that sent the message.
-- As you can see, the seconds argument is available.
