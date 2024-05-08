-- Set the name of the NPC. This will be displayed on the top of the panel.
NPC.name = "Mysterious Slav"
NPC.model = "models/gtaiv/characters/niko.mdl"

-- Uncomment to make the NPC sit.
--NPC.sequence = "sit"
local talkedTo = false;
-- This is the function that gets called when the player presses <E> on the NPC.
function NPC:onStart()
	
	-- This code is inside a function that gets ran after pressing the option.
	if LocalPlayer():IsOnQuest(3) then
	self:addText("Welcome to the Market!")
	self:addOption("I would like to invest with you.", function()
		self:addText("Sure what do you want to invest in?")
		self:BuisinessOwner()
		
	end)
	self:addOption( "Who are you?", function()
		self.name = "Niko"
		self:addText( "I am Niko! I kinda run things around here. I can help you find out more information about buisinesses.")
		
		timer.Simple( 2, function ()
		
			self:addText( "You can ask me about requirements for a buisiness, banking and how to get one!" )
			
			self:InfoHowBu()
		
		end )
	
	end )
	elseif !LocalPlayer():IsOnQuest(3) then
	
		self:addOption("Tutorial #3", function ( )
		
			self:addText( "Ahh yes, a newcomer! You must have heard about me!" )
			
			self:addOption( "Yeah what do I need to do?" , function ( )
			
				self:addText( "Simple, just buy one airport share, I will give you the money to do so!" )
				
				self:addOption( "Seems easy enough, let me do it" , function ()
				
					self:send("StartTutorial3")
					self:BuisinessOwner()
			
				end)
								self:addLeave("<Leave> I have heard enough of your blasphimy, begone.")	

			end ) 
						self:addLeave("<Leave> I have heard enough of your blasphimy, begone.")	

		
		end )
	
					self:addLeave("<Leave> I have heard enough of your blasphimy, begone.")	

	
	end
	
end

function NPC:InfoHowBu()


	self:addOption( "I would like to know about buying a buisiness.", function ()
				
		self:addText("All you need for a buisiness is a Buisiness Banking account and a initial share!")
				
		self:addOption("I would like to know more about something else.", function()
			self:InfoHowBu()
		
		end)
				self:addLeave("<Leave> I have heard enough of your blasphimy, begone.")	

	end)
			
	self:addOption( "I would like to know about banking with a buisiness." , function ()
			
		self:addText("You get a amount of interest based on your shares with a buisiness. The more money you have, the more you make each payday!")
			
		self:addOption("I would like to know more about something else.", function()
			self:InfoHowBu()
		
		end)
				self:addLeave("<Leave> I have heard enough of your blasphimy, begone.")	
	
	end)
		
	self:addOption( "I would like to know about how to get a buisiness.", function ()
			
		self:addText("You can buy one from me! I help the companies around town get along and be fair")
			
		if LocalPlayer():getBankAccount() == 3 then
			self:addOption("I would like to know more about buying a buisiness share from you.", function()
				
				self:addText("I guess we can work something out then! (Niko smiles with enthusiasm)")
					
					self:addText("What buisiness would you like to invest in?")
					self:BuisinessOwner()
				end)
			
		end
		self:addOption("I would like to know more about something else.", function()
			self:InfoHowBu()
		
		end)
				self:addLeave("<Leave> I have heard enough of your blasphimy, begone.")	
	end)
		
				self:addLeave("<Leave> I have heard enough of your blasphimy, begone.")	
end


function NPC:BuisinessOwner( )
	local _newTbl = {}
	local _pBs = LocalPlayer():getAllBusinesses();
	for k , v in pairs( BUSINESS_TABLE ) do
		
		
		_newTbl[v.ID] = {}
		_newTbl[v.ID].ID = v.ID
		_newTbl[v.ID].Price = v.Price
		_newTbl[v.ID].Name	= v.Name
	
	end
	
	self:addText("Just so you know, I only take cheque or credit from the bank, I do not deal with cash!")
	
		self:addOption("Buisinesses..", function( )
		
		
				if !LocalPlayer():IsOnQuest( 3 ) then 
										
					self:send("queststep2")
						
				end

				if LocalPlayer():getShares( 1 ).shares < 1 then
		
				self:addOption("Starting Share ( Airport, $100)", function ( )
						

						net.Start("buyInitialShare")
							net.WriteInt( 1, 8 )
						net.SendToServer()
							
					self:addOption("I would like to buy something else.", function()
							
						self:BuisinessOwner()
							
					end)
				
					
					
				self:addLeave("<Leave> I actually do not want to invest in a buisiness.")	
							
				end)
				end
				if LocalPlayer():getShares( 2 ).shares < 1 then
		
				self:addOption("Starting Share ( Bank, $225)", function ( )
							
						net.Start("buyInitialShare")
							net.WriteInt( 2, 8 )
						net.SendToServer()
							
					self:addOption("I would like to buy something else.", function()
							
						self:BuisinessOwner()
							
					end)
				
					
					
				self:addLeave("<Leave> I actually do not want to invest in a buisiness.")	
							
				end)
				
				end
				if LocalPlayer():getShares( 3 ).shares < 1 then
		
				self:addOption("Starting Share ( Cinema Chain, $25)", function ( )
							
						net.Start("buyInitialShare")
							net.WriteInt( 3, 8 )
						net.SendToServer()
							
					self:addOption("I would like to buy something else.", function()
							
						self:BuisinessOwner()
							
					end)
				
					
					
				self:addLeave("<Leave> I actually do not want to invest in a buisiness.")	
				end)
				end
				if LocalPlayer():getShares( 4 ).shares < 1 then
		
				self:addOption("Starting Share ( Farmers Market, $15)", function ( )
							
						net.Start("buyInitialShare")
							net.WriteInt( 4, 8 )
						net.SendToServer()
							
					self:addOption("I would like to buy something else.", function()
							
						self:BuisinessOwner()
							
					end)
				
					
					
				self:addLeave("<Leave> I actually do not want to invest in a buisiness.")	
							
				end)
				if LocalPlayer():getShares( 5 ).shares < 1 then
				end
				self:addOption("Starting Share ( Gas Company, $230)", function ( )
							
						net.Start("buyInitialShare")
							net.WriteInt( 5, 8 )
						net.SendToServer()
							
					self:addOption("I would like to buy something else.", function()
							
						self:BuisinessOwner()
							
					end)
				
					
					
				self:addLeave("<Leave> I actually do not want to invest in a buisiness.")	
							
				end)
				end
				if LocalPlayer():getShares( 6 ).shares < 1 then
		
				self:addOption("Starting Share ( Harbor, $200)", function ( )
							
						net.Start("buyInitialShare")
							net.WriteInt( 6, 8 )
						net.SendToServer()
							
					self:addOption("I would like to buy something else.", function()
							
						self:BuisinessOwner()
							
					end)
				
				self:addLeave("<Leave> I actually do not want to invest in a buisiness.")	
							
				end)
				end
				if LocalPlayer():getShares( 7 ).shares < 1 then
		
				self:addOption("Starting Share ( Laboratory, $200)", function ( )
							
						net.Start("buyInitialShare")
							net.WriteInt( 7, 8 )
						net.SendToServer()
							
					self:addOption("I would like to buy something else.", function()
							
						self:BuisinessOwner()
							
					end)
				
					
				self:addLeave("<Leave> I actually do not want to invest in a buisiness.")	
							
				end)
				end
				if LocalPlayer():getShares( 8 ).shares < 1 then
		
				self:addOption("Starting Share ( Lumber Mill, $150)", function ( )
							
						net.Start("buyInitialShare")
							net.WriteInt( 8, 8 )
						net.SendToServer()
							
					self:addOption("I would like to buy something else.", function()
							
						self:BuisinessOwner()
							
					end)
				
					
					
				self:addLeave("<Leave> I actually do not want to invest in a buisiness.")	
							
				end)
				end
				if LocalPlayer():getShares( 9 ).shares < 1 then
		
				self:addOption("Starting Share ( Mining Company, $205)", function ( )
							
						net.Start("buyInitialShare")
							net.WriteInt( 9, 8 )
						net.SendToServer()
							
					self:addOption("I would like to buy something else.", function()
							
						self:BuisinessOwner()
							
					end)
				
					
					
				self:addLeave("<Leave> I actually do not want to invest in a buisiness.")	
							
				end)
				end

		
				if LocalPlayer():getShares( 10 ).shares < 1 then
		
				self:addOption("Starting Share ( Restaurant Chain, $55)", function ( )
							
						net.Start("buyInitialShare")
							net.WriteInt( 10, 8 )
						net.SendToServer()
							
					self:addOption("I would like to buy something else.", function()
							
						self:BuisinessOwner()
							
					end)
				
					
					
				self:addLeave("<Leave> I actually do not want to invest in a buisiness.")	
							
				end)
				
				end
				if LocalPlayer():getShares( 11 ).shares < 1 then
		
				self:addOption("Starting Share Strip Club ( Strip Club, $40)", function ( )
							
						net.Start("buyInitialShare")
							net.WriteInt( 11, 8 )
						net.SendToServer()
							
					self:addOption("I would like to buy something else.", function()
							
						self:BuisinessOwner()
							
					end)
				
					
					
				self:addLeave("<Leave> I actually do not want to invest in a buisiness.")	
							
				end)
				
				end
				if LocalPlayer():getShares( 12 ).shares < 1 then
		
				self:addOption("Starting Share ( Weapon Company, $190)", function ( )
							
						net.Start("buyInitialShare")
							net.WriteInt( 12, 8 )
						net.SendToServer()
							
					self:addOption("I would like to buy something else.", function()
							
						self:BuisinessOwner()
							
					end)
				
					
					
						self:addLeave("<Leave> I actually do not want to invest in anything.")	

							
				end)
				
				end
		end)
	
	self:addOption("I would like to know more about buying.", function()
		self:InfoHowBu()
		
	end)

	self:addLeave("<Leave> I actually do not want to invest in anything.")	
end

