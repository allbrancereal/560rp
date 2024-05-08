-- Set the name of the NPC. This will be displayed on the top of the panel.
NPC.name = "Teleporter"

-- Uncomment to make the NPC sit.
--NPC.sequence = "sit"
local _evoTarget = "209.141.61.129:27016";
NPC.model = "models/player/group01/male_05.mdl"

-- This is the function that gets called when the player presses <E> on the NPC.
function NPC:onStart()
	-- self:addText(<text>) adds text that comes from the NPC.

	if steamworks.IsSubscribed("623950516") then
		
		self:addText("Hello there, would you like to travel to evocity today?")

		-- self:addOption(<text>, <callback>) is a button that you can pick and it will
		-- run the callback function.
		self:addOption("<Disconnect This Server> Yes, I would like to travel to evocity!", function()
			self:send("joinEvo")

			//LocalPlayer():ConCommand("connect " .. _evoTarget)
		end)


	else
		self:addText("Hello there, you must download the RP_Evocity_V33X Map to travel there.")

		self:addOption("<Open Workshop Link> Show me where to get it!", function()
			gui.OpenURL("https://steamcommunity.com/sharedfiles/filedetails/?id=623950516")
		end)
	end
	
	self:addLeave("No thank you!")
end

net.Receive("sendClientToEvo",function()

	timer.Simple(1, function()
		LocalPlayer():ConCommand("connect " .. _evoTarget)
	end)

end)