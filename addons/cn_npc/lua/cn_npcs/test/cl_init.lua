-- Set the name of the NPC. This will be displayed on the top of the panel.
NPC.name = "Cheesenut"

-- Uncomment to make the NPC sit.
--NPC.sequence = "sit"

-- This is the function that gets called when the player presses <E> on the NPC.
function NPC:onStart()
	-- self:addText(<text>) adds text that comes from the NPC.
	self:addText("Hello there, how are you today?")

	-- self:addOption(<text>, <callback>) is a button that you can pick and it will
	-- run the callback function.
	self:addOption("I'm good.", function()
		-- This code is inside a function that gets ran after pressing the option.
		self:addText("That's good!")

		-- self:addLeave(<leave text>) adds a button that closes the dialogue.
		self:addLeave("See you later.")
	end)

	-- You can have as many options as you need.
	self:addOption("I feel cold.", function()
		self:addText("Do you want to feel warmer?")

		self:addOption("Sure!", function()
			--[[
				Chessnut's NPC system comes with an easy ability to network information between
				the client and server.

				You use self:send(<function name>, ...) to have NPC:on<function name> run on the
				opposite state. So here, we tell the server to ignite the player. Look at sv_init.lua
				to see how it looks receiving the message.

				The ellipses (...) means you can pass as many arguments as you want. Here we pass
				the amount of seconds the player will be ignited for.
			--]]
			self:send("Ignite", math.random(5, 10))

			-- Add a leave.
			self:addLeave("Ouch!")
		end)
		self:addLeave("No thanks.")
	end)
end