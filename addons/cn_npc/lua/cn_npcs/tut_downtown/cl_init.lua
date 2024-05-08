-- Set the name of the NPC. This will be displayed on the top of the panel.
NPC.name = "Tutorial NPC"
NPC.model = "models/kemono_friends/oinari_sama/oinari_sama_npc.mdl"


function NPC:ShowBeginning()

	self:addText("Hi! Welcome to WestCoastRP! How can I help you?")

	// Tut Types
	// NPCs Around
	self:addOption("Notable People around Town. <NPCS>", function()
		self:TellMeAboutNPCs()
	end)
	// Crafting Types
	self:addOption("Things to put together. <Crafting>", function()
		self:TellMeAboutCrafting()
	end)
	// Points of Interest
	self:addOption("Places of Interest. <P.O.I.>", function()
		self:TellMeAboutPOI()
	end)
	// Keybinds
	self:addOption("Ways of going about. <Keybinds>", function()
		self:TellMeAboutKeybinds()
	end)
	// Businesses
	self:addOption("Ways of going about. <Businesses>", function()
		self:TellMeAboutBusinesses()
	end)
	// Vehicles
	self:addOption("Where to find a vehicle. <Cars>", function()
		self:TellMeAboutCars()
	end)
	// Healing Up
	self:addOption("Find a doctor. <Healing>", function()
		self:TellMeAboutHealing()
	end)
	// Changing Models
	self:addOption("New Clothes and the like. <Customization>", function()
		self:TellMeAboutCustomization()
	end)
	// Organizations
	self:addOption("Team up with other people! <Organizations>", function()
		self:TellMeAboutOrganizations()
	end)
	// Skils
	self:addOption("Find a Gym. <Skills>", function()
		self:TellMeAboutSkills()
	end)
	self:addLeave("No thank you! Have a good day <Leave>")
	
end

function NPC:MakeBackButton(  )
	
	self:addOption("Tell me about something else.. <Back>", function()
		self:ShowBeginning()
	end)

	self:addLeave("I would like to find other things to do for now!<Leave>")
end

function NPC:MakeBBackButton(  )
	
	self:addOption("Tell me about other business stuff.. <Back>", function()
		self:TellMeAboutBusinesses()
	end)

	self:addLeave("I would like to find other things to do for now!<Leave>")
end

function NPC:TellMeAboutBusinesses(  ) 

	self:addText("Businesses are managed by clubhouses that you can buy on the Maze-Bank foreclosure website..")
	
	self:addOption("How do I buy a clubhouse?", function()

		self:addText("You first must own a computer. When you start it up go to the Maze Bank Foreclosue program. This allows you to purchase a clubhouse in either city.")
		self:MakeBBackButton()
	end)

	self:addOption("How does a clubhouse benefit me?", function()

		self:addText("When you own a clubhouse it serves as a hideout from the police as well as a indermediate buffer between your illegal manufacturing business and your private life.")
		self:MakeBBackButton()
	end)

	self:addOption("How do I acquire a business?", function()

		self:addText("Any clubhouse will have a dedicated computer with a private network connection, allowing you to purchase a business as a third person. Circumventing authorities.")
		self:MakeBBackButton()
	end)

	self:addOption("What is a business mission?", function()

		self:addText("A business mission requires you to either bring an item to a destination or retrieve an item from a location.")
		self:MakeBBackButton()
	end)

	self:addOption("How do I supply a business?", function()

		self:addText("While you are inside your business, you must go to the business menu and select Supply Business. From there you can chose which mission to partake in.")
		self:MakeBBackButton()
	end)
	self:addOption("How do I deliver my product?", function()

		self:addText("When you first select a delivery mission you must bring your product to the drug dealer. He will give you dirty money you will have to launder by bringing it to shops around town.")
		self:MakeBBackButton()
	end)



	self:MakeBackButton()
end

function NPC:TellMeAboutNPCs(  ) 

	self:addText("I can tell you about robbing stores and the dealer.")
	
	self:addOption("Robbery", function()

		self:addText("If you have a weapon equiped while talking to shopkeepers/realtors you can start robbing them.")
		self:MakeBackButton()
	end)

	self:addOption("Dealer", function()

		self:addText("Theres a person going around the map selling rare items that aren't available at all times, if you can find them and keep in contact you can make a fortune.")
		self:MakeBackButton()
	end)


	self:MakeBackButton()
end
function NPC:TellMeAboutCrafting(  ) 

	self:addText("Sure, Press J to bring up the crafting menu. You can see categories at the top, the list of items on the left and the requirements for the currently selected item on the right.")

	
	self:addOption("Using My Crafted Items", function()

		self:addText("You can use your items by left clicking them in the inventory. You drop them when right-clicking.")
		self:MakeBackButton()
	end)
	self:addOption("Picking Crafted Items Back Up", function()

		self:addText("You can pick your crafted items back up by pressing ALT+E.")
		self:MakeBackButton()
	end)
	self:addOption("Weapons", function()

		self:addText("You are limited to a main weapon and sidearm, but you can keep up as many in your inventory as you would like. Press C to unequip weapons.")
		self:MakeBackButton()
	end)

	self:MakeBackButton()
end
function NPC:TellMeAboutPOI(  ) 


	self:addText("I can tell you about the bonfire locations and where you can find a ride to EvoCity.")
	
	
	self:addOption("Bonfires", function()

		self:addText("You can go to the Suburbs, Ghetto Park, Fountain, Downtown, & the Upskirt Industrial.")
		self:MakeBackButton()
	end)

	self:addOption("EvoCity", function()

		self:addText("Theres a tunnel at the suburbs with a guy who will bring you to EvoCity.")
		self:MakeBackButton()
	end)

	self:MakeBackButton()
end
function NPC:TellMeAboutKeybinds(  ) 


	self:addText("Which key are you interested in?")
	
	
	self:addOption("C", function()

		self:addText("C brings up the Character Menu.")
		self:MakeBackButton()
	end)
	self:addOption("F1", function()

		self:addText("F1 brings up the Main Menu.")
		self:MakeBackButton()
	end)
	self:addOption("H", function()

		self:addText("H brings up the Weapon Customization menu when you have a weapon equiped.")
		self:MakeBackButton()
	end)
	self:addOption("J", function()

		self:addText("J brings up the Crafting Menu.")
		self:MakeBackButton()
	end)
	self:addOption("K", function()

		self:addText("K brings up the Skills & Research Menu")
		self:MakeBackButton()
	end)
	self:addOption("I", function()

		self:addText("I brings up the Inventory.")
		self:MakeBackButton()
	end)
	self:addOption("B", function()

		self:addText("B brings up the Buddy Menu.")
		self:MakeBackButton()
	end)
	self:addOption("M", function()

		self:addText("M brings up the MOTD.")
		self:MakeBackButton()
	end)
	self:addOption("N", function()

		self:addText("N brings up the police computer as a Mayor or Police officer.")
		self:MakeBackButton()
	end)

	self:MakeBackButton()
end
function NPC:TellMeAboutCars(  ) 


	self:addText("Cars are acquired at the big dealership in EvoCity. You can also customize them there.")
	
	self:addOption("Customization", function()

		self:addText("You can customize your vehicles in the EvoCity Dealership.")

	end)

	self:MakeBackButton()
end
function NPC:TellMeAboutHealing(  ) 


	self:addText("If you are hurt, you can go to a medic to heal you up. You will be ditching your next payday though.")
	
	self:MakeBackButton()
end
function NPC:TellMeAboutCustomization(  ) 


	self:addText("For sure, theres the ability to change genders, get a facial or acquire hats.")
	
	
	self:addOption("Changing Genders", function()

		self:addText("You can change your gender for $25,000 at the local Plastic Surgeon.")

		self:MakeBackButton()
	end)

	self:addOption("Facial", function()

		self:addText("Facial Specialists around the city allow you to change your clothes/appearance extensively for $1,000.")

		self:MakeBackButton()
	end)
	self:addOption("Hats", function()

		self:addText("You can acquire a hat at any hat shop, usually located near facial specialists.")

		self:MakeBackButton()
	end)

	self:MakeBackButton()
end
function NPC:TellMeAboutOrganizations(  ) 


	self:addText("Finally! If you feel lonely, you can always group up with other people around town, or create a organization of your own.")
	
	
	self:addOption("Joining an Organization", function()


		self:addText("You can join an organization by looking around the two citys or the internet for people to group up with.")

		self:MakeBackButton()

	end)
	
	self:addOption("Creating an Organization", function()

		self:addText("For $25,000 you can create a organization at the local City Council Ward.")

		self:MakeBackButton()
	end)

	self:MakeBackButton()
end
function NPC:TellMeAboutSkills(  ) 


	self:addText("Sure, skills are divided into Research and Gene Points.")
	
	self:addOption("Tell me more about Gene Points.", function()
		self:addText("The doctor around town can help you become stronger, you can choose between: Strength, Influence, Endurance , Perception, Luck, Regeneration, Intelligence and Dexterity.")

		timer.Simple(15,function()
			if !self then return end
			self:addText("It's fine not to be a jack of all traits, these genes tie directly into the crafting system. You will be asked to learn more skills for more intricate things.")
			
			timer.Simple(15,function() 
				if !self then return end
				self:addText("You can also discover gene points when crafting and whatnot.")

				self:MakeBackButton()
			end )
			
		end)
	end)
	self:addOption("Tell me more about Research.", function()

		self:addText("When you craft some items you have a chance of discovering new recipes.")
		
		self:MakeBackButton()

	end)

	self:MakeBackButton()
end

function NPC:onStart()
	/*
	self:addText("Hello there, you want to check out my valuable ores?")

	local _p = LocalPlayer()

	self:addOption("Sure!", function()
	
		ItemShopUI( 3 )
		self:close()

	end)

	self:addLeave("No thanks.")
	*/

	self:ShowBeginning();

end
