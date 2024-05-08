
NPC = NPC or {}
-- Set the name of the NPC. This will be displayed on the top of the panel.
NPC.name = "Quest Giver Tiara"

-- Uncomment to make the NPC sit.
--NPC.sequence = "sit"

local str = "";
-- This is the function that gets called when the player presses <E> on the NPC.
function NPC:onStart()
	-- self:addText(<text>) adds text that comes from the NPC.
	
		self:addText("Hey there! How are you?") 

	
end

