-- Set the name of the NPC. This will be displayed on the top of the panel.
NPC.name = "City Council Ward"
NPC.model = "models/kemono_friends/oinari_sama/oinari_sama_npc.mdl"
NPC.reputation =6;
-- Uncomment to make the NPC sit.
--NPC.sequence = "sit"

-- This is the function that gets called when the player presses <E> on the NPC.
function NPC:onStart()
	-- self:addText(<text>) adds text that comes from the NPC.
	self:addText("Hello there, welcome to the Downtown PD. You may access many legal services from here.")
	local _p = LocalPlayer();
	local _finished, _lfinished = _p:FinishedQuest(9);
	local _ActiveQuests = _p:getFlag("questTable", {} );
	
	local _hasMoney = QUEST_TABLE[9].Condition(_p)
	if !_p:IsVIP() or (_p:IsDev() and _finished == false) then
		if _finished != true and (!_ActiveQuests[9]) then
			self:addOption("I would like to enrol in the VIP program (Quest 9)", function()
				self:addText("Great! All you need to do is donate $5,000,000 to our local government and we will set you up.")

				self:send("startquest9")
				self:addLeave("Thank you <Leave>")
			end)
		elseif _hasMoney and _ActiveQuests[9].Step == 1 then
			self:addOption("I would like to hand my VIP program requirement in. <-$5,000,000>",function()
				self:send("finishquest9")
				self:addLeave("Thank you <Leave>")
			end)
		end
	end

	-- self:addOption(<text>, <callback>) is a button that you can pick and it will
	-- run the callback function.
	local _p = LocalPlayer()
		local _amountMayors = #team.GetPlayers( TEAM_MAYOR );

		if _amountMayors < 1 then
			
			local _IsMayoralCandidate = LocalPlayer():getFlag("MayoralCandidate", false)

			if _IsMayoralCandidate then
				
				self:addOption("I would like to secede from the mayoral ballot.", function()

					self:addText("Really? I thought this town could have used some leadership.")
					self:send("mayoralBallot" )

					self:addLeave("I'm not into public appearances.")
				end )

			else

				self:addOption("I would like to put my name on the mayoral ballot.", function()

					self:addText("Sure thing.")
					self:send("mayoralBallot" )
					self:addLeave("Thank you!")

				end )

			end	
		end

		self:addOption("I would like to change my name. ($" .. fsrp.config.NameChangeCost .. ") ", function()
			-- This code is inside a function that gets ran after pressing the option.
			self:addText("Easy, just fill out this form!")

			self:send("ShowNameChangeMenu" )
			-- self:addLeave(<leave text>) adds a button that closes the dialogue.
			self:addLeave("See you later.")
		end)

		local _org = _p:getFlag('organization', nil)

		if _org == nil || _org == 0 then
			
			self:addOption("I would like to create a organization. ($" .. fsrp.config.OrganizationCost .. ") ", function()
				-- This code is inside a function that gets ran after pressing the option.
				self:addText("Easy, just fill out this form!")

				self:send("BuyOrganization" )
				-- self:addLeave(<leave text>) adds a button that closes the dialogue.
				self:close()

			end)
		
		else

			local _actualOrg = fsrp.orgs[_org]

			if _actualOrg then
				
				if _actualOrg[4] == _p:SteamID() then
					
					self:addOption("I would like to disband my organization.", function()
						-- This code is inside a function that gets ran after pressing the option.
						self:addText("Easy, just fill out this form!")

						self:send("DisbandOrganization" )
						-- self:addLeave(<leave text>) adds a button that closes the dialogue.
						self:close()

					end)

				else

					self:addOption("I would like to leave my organization.", function()
						-- This code is inside a function that gets ran after pressing the option.
						self:addText("Easy, just fill out this form!")

						self:send("LeaveOrganization" )
						-- self:addLeave(<leave text>) adds a button that closes the dialogue.
						self:close()

					end)

				end


			end
		end
		
	self:addLeave("I am lost.")

end