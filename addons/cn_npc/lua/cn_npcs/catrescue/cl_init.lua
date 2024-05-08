-- Set the name of the NPC. This will be displayed on the top of the panel.
NPC.name = "Lonely Wolf"
NPC.model = "models/sentry/gtav/mexican/pologoon1pm.mdl"

-- Uncomment to make the NPC sit.
--NPC.sequence = "sit"

-- This is the function that gets called when the player presses <E> on the NPC.
/*

fsrp.blackmarket.cache.Selling = {}
fsrp.blackmarket.cache.Buying = {}
fsrp.blackmarket.cache.PercentagePaying 	= math.random( 80, 120 );
fsrp.blackmarket.cache.PercentageSelling 	= math.random( 80, 120 );
*/

function NPC:onStart()
	local _p = LocalPlayer()
	local _finished, _lfinished = _p:FinishedQuest(7)
	local _ActiveQuests = _p:getFlag("questTable", {} );
	-- can offer quest

	if _ActiveQuests[7] and _ActiveQuests[7].Step == 2 and _finished == false then
		self:addText("MS PUDDINGWINKS YOU ARE SAFE!!! Thank you so much have this reward!")
		self:send("finishquest7")
		self:addLeave("No problem, cheers!")
	else
		if _finished == false or (_finished==true and _p:getFlag("SVTimeLastPayday",0)>_lfinished+QUEST_TABLE[7].Cooldown) then
			self:addText("You there! I lost my cat, can you please go and get it from the fountain?")
			self:addOption("Yes I will! (Start Quest 7: Rescue Cat (Daily))", function()
				self:send("startquest7")
				self:close()
			end)
			self:addLeave("No I don't have time for your crazy cat.")
		else
			self:addText("Thank you so much for rescuing my kitty!")
			self:addOption("No problem, just hold on to it next time!", function()
				self:addLeave("<Leave>")
			end)

		end
	end
end