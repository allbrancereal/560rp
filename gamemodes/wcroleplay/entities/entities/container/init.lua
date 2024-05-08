


AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()	
	self.Entity:SetPos( self.Entity:GetPos() + Vector( 0,0,25 ) )
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:SetUseType( SIMPLE_USE )
	self:FigureContainer(1)
end
/*fsrp.config.VisibleContainers = {
	[1] = {
		name = "Wood Crate",
		model = "models/props_junk/wood_crate001a.mdl",
		slots = 32,
		scale = 1,
	};
	[2] = {
		name = "Large Crate",
		model = "models/props_junk/wood_crate002a.mdl",
		slots = ,
		scale = 1,
	};
	[3] = {
		name = "Small Box",
		model = "models/props_junk/cardboard_box004a.mdl",
		slots = 4,
		scale = 1,
	};
	[4] = {
		name = "Moving Box",
		model = "models/props_junk/cardboard_box002b.mdl",
		slots = 8,
		scale = 1,
	};
	[5] = {
		name = "File Cabinet",
		model = "models/props_lab/filecabinet02.mdl",
		slots = 4,
		scale = 1,
	};
	[6] = {
		name = "Closet",
		model = "models/props_wasteland/controlroom_storagecloset001a.mdl",
		slots = 16,
		scale = 1,
	};
	[7] = {
		name = "Fridge",
		model = "models/props_c17/FurnitureFridge001a.mdl",
		slots = 12,
		scale = 1,
	};
	[8] = {
		name = "Industrial Fridge",
		model = "models/props_wasteland/kitchen_fridge001a.mdl",
		slots = 18,
		scale = 1,
	};
	[9] = {
		name = "Dresser",
		model = "models/props_c17/FurnitureDrawer001a.mdl",
		slots = 10,
		scale = 1,
	};
}
*/

function ENT:FigureContainer(_containerType)

	local _containerInfo = fsrp.config.VisibleContainers[_containerType]

	if _containerType == nil then self:Remove() print("removed container") end
	if _containerType == -1 then
		self:setFlag("invisible",true);
		self:setFlag("config",{max = self:getFlag("maximum",12),content = {}});
	elseif _containerInfo then
		self:setFlag("config", {max = _containerInfo.slots,content={}});
		self:SetModel(_containerInfo.model)
	end

end


function ENT:Use( activator, caller )
	if !activator:IsPlayer() then return false; end
	/*if self.Entity:GetTable().Tapped and self.Entity:GetTable().Tapped > CurTime() then return false; end
	if (activator != self:GetTable().Owner) then return false; end
	if activator:KeyDown(IN_WALK) then 
		if (self:GetTable().Owner == activator) then
			activator:GiveItem(self:GetTable().ItemID, 1, true);
			self.Tapped = CurTime() + 5
			self:Remove()
		end	
		
	    return
	end*/
	
	if activator:KeyDown(IN_WALK) then 
		if activator:SteamID() != self:getFlag( "ownedBy" ,"" )  then return; end
		if self:getFlag("itemID",nil) == nil then return end
		activator:AddItemByID( self:getFlag("itemID",nil) )
		self:Remove()
		return
		
	end
	
end

-- Called when the entity's transmit state should be updated.
function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS;
end;