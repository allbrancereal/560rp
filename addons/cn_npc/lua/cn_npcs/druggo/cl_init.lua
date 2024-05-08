-- Set the name of the NPC. This will be displayed on the top of the panel.
NPC.name = "Drug Dealer"
NPC.model = "models/virtual_youtuber/sister_cleaire/sister_cleaire_npc.mdl"

-- Uncomment to make the NPC sit.
--NPC.sequence = "sit"

NPC.reputation =4;
-- This is the function that gets called when the player presses <E> on the NPC.
/*

fsrp.blackmarket.cache.Selling = {}
fsrp.blackmarket.cache.Buying = {}
fsrp.blackmarket.cache.PercentagePaying 	= math.random( 80, 120 );
fsrp.blackmarket.cache.PercentageSelling 	= math.random( 80, 120 );
*/

function NPC:onStart()
	local _p = LocalPlayer()
	if !fsrp.blackmarket.cache then self:addLeave("Bye bye this menu doesn't work") end
	
	if LocalPlayer():IsGovernmentOfficial() then 
		
		self:addText("Who the fuck are you?")
	
		self:addLeave("I've got nothing to do with you" ) 
	
	else
		
		local _data = LocalPlayer():GetBusiness();
		local _found = false;
		if _data then
			for k , v in pairs(_data) do
				if v[8] and v[8][1] then
					_found = true;
				end
			end
		end

		local _finished = _p:FinishedQuest(8);
		local _ActiveQuests = _p:getFlag("questTable", {} );
		if _found == true then

			self:addText("Quickly let me get that!")
			self:addOption( "Here is the stuff." , function()			
				self:addText("Ok I will most likely leave to another place. I gotta stash this.")
				self:send("deliveryinc")
				self:addLeave("Alright, see you later!")

			end )
		elseif _finished == false then
			if _ActiveQuests[8] == nil then
				self:addText("Hey would you like to make some cash buddy?")				
				self:addOption("Yeah sure! (Quest 8: Grow-Op)", function()
					self:addText("Great, just grow some pot and sell it to me! I give you a great price!")
					self:addOption("Hmm, I think I could get in to this. <Start Quest>", function()
						self:send("startquest8")
						self:close()
					end)
					self:addLeave("This is too sketchy.")
				end)
				self:addLeave("No thank you. <Leave>")
			elseif _ActiveQuests[8].Step == 3 then
				self:addText("Did you get the stuff?")
				self:addOption("Yeah! <Shop>", function()
					IllegalShopUI( )	
					self:close()
				end)
				self:addLeave("No I haven't got shit here. <Leave>")
			else
				self:addText("You have to go grow a plant before you can sell!")
				self:addLeave("Oh okay <Leave>")
			end
		else

			self:addText("Whadd'ya need buddy?")

			self:addOption( "I would like to trade with you. <Shop>", function ()
			
				if !_p:IsNearCNPC( "druggo" , 150 ) then self:addLeave("Thanks.") return _p:Notify("Move closer to Niko to trade with him.") end;
		
				IllegalShopUI( )		

				self:close()
			end )
			
			local _text = "Hey, could you start texting me when you move?"
			
			if LocalPlayer():getFlag("notifyDealerChange", false ) == true then
			
				_text = "Hey, could you stop texting me when you move?"
				
			end
			
			self:addOption( _text , function()
			
				net.Start("changeDealerNotify")
				net.SendToServer()
				self:addText("Alright, now get away")
				self:addLeave("Alright?")
				
			end )

		end
	end


		
	
end
/*
function NPC:BringUpSelling()

	local _totalByID = LocalPlayer():GetTotalAmountInv();
	
	if #LocalPlayer().__Blackmarket.Selling > 0 then
	local _tbl = LocalPlayer().__Blackmarket.Selling;
	
	for k , v in pairs ( _tbl ) do
		print(v)
		if _totalByID[v].Amount > 0 && _totalByID[v].Amount < 5 then
		
			self:addOption( "Sell 1 ($" .. ITEMLIST[v].Cost .. ") " .. ITEMLIST[v].Name , function()
			
				self:send( "Sell" , v, 1 );
				self:onStart()
			end )	
			
		end
		
		if _totalByID[v] >= 5 then
		
		self:addOption( "Sell 5 ($" .. (ITEMLIST[v].Cost*5) .. ") " .. ITEMLIST[v].Name , function()
		
			self:send( "Sell" , v, 5 );
		
			self:onStart()
		end )	
		
		end
		
		if _totalByID[v].Amount > 0 then
			
		
			self:addOption( "Sell All ($" .. (ITEMLIST[v].Cost*_totalByID[v].Amount) .. ") " .. ITEMLIST[v].Name , function()
						
				self:send("Sell", v, _totalByID[v].Amount );
				self:onStart()
						
			end )	
		
		end
		
	end
	
	else
		self:addText( "I am currently not buying anything" )
	
	
	
	end
				self:addOption("Okay can I see something else?", function()
					
					self:onStart()
				
				end )
		
		
				self:addLeave("Okay I actually don't want anything.")
	
end

	


function NPC:BringUpBuying()
	

	local _totalByID = LocalPlayer():GetTotalAmountInv();
	if #LocalPlayer().__Blackmarket.Buying > 0 then
		
		self:addText( "Heres what I got:" )
		local _tbl =  LocalPlayer().__Blackmarket.Buying
		
		for k , v in pairs ( _tbl ) do
				print(v)
			if !ITEMLIST[v] then
				
				self:addOption( "Buy 1 ($" .. ITEMLIST[v].Cost .. ") " .. ITEMLIST[v].Name , function()
				
					self:send("Buy", v , 1);
					self:onStart()
				
				end )	
				self:addOption( "Buy 5 ($" .. (ITEMLIST[v].Cost*5) .. ") " .. ITEMLIST[v].Name , function()
				
					self:send("Buy", v,5 );
					self:onStart()
				
				end )	
				if _totalByID[v] then
				
			
					self:addOption( "Buy All ($" .. (ITEMLIST[v].Cost*_totalByID[v].Amount) .. ") " .. ITEMLIST[v].Name , function()
							
						self:send("Buy",v, _totalByID[v].Amount );
						self:onStart()
							
					end )	
			
				end
			end
		end

	else
		
		self:addText("I currently am not selling anything")
		
	end
		self:addOption("Okay can I see something else?", function()
			
			self:onStart()
		
		end )
		
		self:addLeave("Okay, I gotta go.")
	
	
	
end
*/

