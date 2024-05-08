-- Set the name of the NPC. This will be displayed on the top of the panel.
NPC.name = "Police Shop"

NPC.model = "models/kemono_friends/oinari_sama/oinari_sama_player.mdl"
-- Uncomment to make the NPC sit.
--NPC.sequence = "sit"


function NPC:onStart(entity)
	local _p = LocalPlayer()

	
	if (_p:Team() == TEAM_POLICE) then


		ItemShopUI(5 )
	

	end
	
		self:close()
end