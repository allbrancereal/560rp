AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )



function ENT:Initialize()
	self.Entity:SetModel("models/hunter/blocks/cube05x05x05.mdl")
	
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	//self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	//self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:SetUseType( SIMPLE_USE )
	
	local phys = self.Entity:GetPhysicsObject()
	if ( IsValid( phys ) ) then -- Always check with IsValid! The ent might not have physics!
	
		phys:Wake()
	end
		
end



function ENT:Use( activator, caller )
	//activator:EmitSound("items/ammocrate_open.wav")
	//activator:AddItemByID( ITEMLIST[self.ID].ID )
	local _ItemsToAdd = self.ID || self:getFlag("itemID", nil ) 
	
	if _ItemsToAdd then
		if istable(_ItemsToAdd) then
		
			for k , v in pairs(_ItemsToAdd) do
			
				activator:AddItemByID( ITEMLIST[v].ID );
					
				activator:Notify("Picked up item: x1 " .. ITEMLIST[v].Name )
				
			end
					activator:EmitSound("items/ammocrate_open.wav")
		
		else
			if ITEMLIST[_ItemsToAdd].WeaponClass then
				if activator:KeyDown(KEY_LALT) then
								
					activator:EmitSound("items/ammocrate_open.wav")
					activator:AddItemByID( ITEMLIST[_ItemsToAdd].ID );
					activator:Notify("Picked up item: x1 " .. ITEMLIST[_ItemsToAdd].Name )

					return
				end
				local _item =  ITEMLIST[_ItemsToAdd];
				_weaponSlot = activator:getFlag( "itemSlot_" .. _item.SlotType , nil );
				if !_weaponSlot then
				
					activator:EmitSound( "items/ammo_pickup.wav" )
					activator:setFlag( "itemSlot_" .. _item.SlotType, _item.ID )
					
					activator:Give( _item.WeaponClass )
					activator:SelectWeapon(_item.WeaponClass)
					fsdb_saveClient( activator )
				else
				
					activator:EmitSound("items/ammocrate_open.wav")
					activator:AddItemByID( ITEMLIST[_ItemsToAdd].ID );
					activator:Notify("Picked up item: x1 " .. ITEMLIST[_ItemsToAdd].Name )
				
				end
				
				self:Remove()
			else
				activator:EmitSound("items/ammocrate_open.wav")

				activator:AddItemByID( _ItemsToAdd );
					
				activator:Notify("Picked up item: x1 " .. ITEMLIST[_ItemsToAdd].Name )
				self:Remove()
			end
				
		
		end
			
	end
	
	self:Remove()
end

