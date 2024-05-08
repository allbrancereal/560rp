-- Set the name of the NPC. This will be displayed on the top of the panel.
NPC.name = "Warehouse Manager Triss"

NPC.model = "models/player/tfa_dcu_cptcold.mdl"
-- Uncomment to make the NPC sit.
--NPC.sequence = "sit"
NPC.reputation =3;

-- This is the function that gets called when the player presses <E> on the NPC.
function NPC:onStart()
	-- self:addText(<text>) adds text that comes from the NPC.
	self:addText("Hello there! You can manage your warehouse with me.")

	self:addOption("I would like to manage my bank warehouse.", function()
	
		WarehouseUI( LocalPlayer():getFlag( "warehouseAcessingRemotely", false ) )
		self:close()
	end)
	
	self:addLeave("<Leave> No, thanks.")
end