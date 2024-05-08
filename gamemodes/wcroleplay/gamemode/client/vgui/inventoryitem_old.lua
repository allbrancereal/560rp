
local PANEL = {};

local buttonSize = ( ScrH() == 2160 ) && 200 || ( ScrH() == 1080 ) && 100 || ( ScrH() == 720 ) && 45 || 50;	

function PANEL:Init() 
	

	local _p = LocalPlayer();
	self:SetSize( buttonSize , buttonSize )
	//self.mdl:SetSize( buttonSize, buttonSize )
	self.IsTrueItem	= false;
	self.ListItem = nil;
	
	self:SetVisible(true)	
	self.TargetUI = nil;
	self.InventorySlotCache = _p:getFlag("inventory", nil )
	
end


function PANEL:SetItemTable( )
		
		local ListItem = self.ListItem;
		
		if ListItem && !self.mdl then
		
			self.mdl = vgui.Create( "DModelPanel", self  )
			
		end

		if self.mdl && !ListItem then
		
			self.mdl:Remove();
			
			return
		end
		
		if !self.mdl then
		
			self.mdl = vgui.Create( "DModelPanel", self  )
		
		end
		
		//self.mdl:SetFOV( 12 )

		self.mdl:SetPos( 5, 5 )
		self.mdl:SetSize( buttonSize - 10, buttonSize -10 )
		
		self.mdl:SetCamPos( ListItem.CamPos )

		self.mdl:SetLookAt(ListItem.LookAt )

		self.mdl:SetModel( ListItem.Model )

		//self.mdl:SetDirectionalLight( BOX_RIGHT, Color( 255, 255, 255, 255 ) )

		//self.mdl:SetDirectionalLight( BOX_LEFT, Color( 255, 255, 255, 255 ) )

		//self.mdl:SetAmbientLight( Vector( -64, -64, -64 ) ) 

		//self.mdl:SetColor( Color( 200, 200, 200 ) )

		//self.mdl:SetAnimated( false )		

		self.mdl:SetMouseInputEnabled(false)
		self.mdl:SetVisible(true)
		//local iSeq = self.mdl.Entity:LookupSequence('ragdoll')
	
		//self.mdl.Entity:ResetSequence(iSeq)
		

		//self:MoveToFront()
end

function PANEL:Update()
	
	self.InventorySlotCache = LocalPlayer():getFlag("inventory", nil )

	if !self.InventorySlotCache then
	
		self.IsTrueItem = false
			
		self.ListItem = nil;
			
		self:SetItemTable( )
		
		return
		
	end
		
	local _inventorySlot = self.InventorySlotCache[self.ID];
		
	if !self.ID || !self.InventorySlotCache || !_inventorySlot then
	
		self.IsTrueItem = false
			
		self.ListItem = nil;
			
		self:SetItemTable( )
			
		return
	
	end
		
	if self.IsTrueItem && ( _inventorySlot.Amount < 1 ) then
			
		self.IsTrueItem = false
			
		self.ListItem = nil;
			
		self:SetItemTable( )
			
		return
		
	end

	
	if _inventorySlot.ID && ITEMLIST[_inventorySlot.ID] then
		
		local _perpetualItem = _inventorySlot.ID;
		self.ListItem = ITEMLIST[_perpetualItem]
		
		self:SetItemTable(	)
		
		self.IsTrueItem = true;
		
		return
		
	end
end


function PANEL:SetInventorySlot( int )
	local _p = LocalPlayer();

	self.ID = int;
	
	if self.InventorySlotCache && self.InventorySlotCache[self.ID] then
		
		self.ListItem				= ITEMLIST[self.InventorySlotCache[self.ID].ID];
	
		self.IsTrueItem			 	= true ;
		
	end
		
	if self.IsTrueItem then
	
		
		self:SetItemTable(self.ListItem	)
		
	end
	
	
end

function PANEL:OnMousePressed(k)
	if self.IsTrueItem then
	
	
		LocalPlayer():Notify( ITEMLIST[self.InventorySlotCache[self.ID].ID].Name  )
		
		if k == 107 || k == MOUSE_LEFT then
			
			net.Start("useItemAtIndex")
				net.WriteInt( self.ID , 8 )
				net.WriteInt(  self.InventorySlotCache[self.ID].ID, 32 );
			net.SendToServer()
		
			timer.Simple( .2 , function( )
			
				self:Update( )
				
			end ) 
			
		elseif k == 108 || k == MOUSE_RIGHT then
					
			net.Start("dropItemAtIndex")
				net.WriteInt( self.ID ,8)
				net.WriteInt(  self.InventorySlotCache[self.ID].ID, 32 );
			net.SendToServer()
			
			timer.Simple( .2 , function( )
			
				self:Update( )
				
			end ) 
			
		end
		
	end
	
	/*
	if k == MOUSE_RIGHT && self.ID && self.InventorySlotCache[self.ID].ID &&  self.InventorySlotCache[self.ID].Amount > 1  then
		
		net.Start("dropItemAtIndex")
			net.WriteInt( self.ID , 6 )
			net.WriteInt(  self.InventorySlotCache[self.ID].ID, 8 );
		net.SendToServer()
		LocalPlayer():Notify("clicked on slot: " .. self.ID .. " at id:" .. self.InventorySlotCache[self.ID].ID )
		self:Update()
		
		if self.InventorySlotCache[self.ID].Amount - 1 ==  0 then self.mdl:Remove() end
	elseif k == MOUSE_LEFT && self.ID &&  self.InventorySlotCache[self.ID].ID && self.InventorySlotCache[self.ID].Amount > 1 then
		
			net.Start("useItemAtIndex")
				net.WriteInt( self.ID , 6 )
				net.WriteInt(  self.InventorySlotCache[self.ID].ID, 8 );
			net.SendToServer()
		
		LocalPlayer():Notify("clicked left on slot: " .. self.ID .. " at id:" .. self.InventorySlotCache[self.ID].ID )
		
		self:Update()
		if self.InventorySlotCache[self.ID].Amount - 1 ==  0 then self.mdl:Remove() end

	end 
	*/
	
end

function PANEL:OnMouseReleased( k )

	if self.ID then
	
		self.TargetUI:RefreshSlot( self.ID )

		
	end
 
end

function PANEL:Paint( w, h )

	if self:IsHovered() && self.TargetUI && self.TargetUI.SlotID != self.ID then
		
		if self.delayTime && self.delayTime > CurTime() then return end
		
		self.TargetUI:RefreshSlot( self.ID )
		self.delayTime = CurTime() + 1 
		
	end
	surface.SetDrawColor(255, 255, 255, 255)
	surface.DrawOutlinedRect(0, 0,w, h )
	
end


//vgui.Register("inventoryitem_old", PANEL)