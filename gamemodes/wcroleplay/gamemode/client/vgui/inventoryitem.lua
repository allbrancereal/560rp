
local PANEL = {};

//local buttonSize = ( ScrH() == 2160 ) && 200 || ( ScrH() == 1080 ) && 150  || ( ScrH() == 1080 ) && 100 || ( ScrH() == 720 ) && 45 || 150;	

function PANEL:Init() 

	local _p = LocalPlayer();
	self:SetSize( buttonSize , buttonSize )
	//self.mdl:SetSize( buttonSize, buttonSize )
	self.IsTrueItem	= false;
	self.ListItem = nil;
	self:SetVisible(true)	
	self.TargetUI = nil;
	self.InventorySlotCache = LoadStringToInventory(_p:getFlag("inventory", nil ))
	self.ID = NULL;
	
end
local oldThink = 0;

function PANEL:OnDragDrop(_t)
	
	if _t then
		local _itemproxy = _t;
		self.InventorySlotCache = LoadStringToInventory(LocalPlayer():getFlag("inventory", nil ))

		local _targetslot = self.ID
		local _fromslot = _itemproxy.ID
		if self.InventorySlotCache[_fromslot].Amount then
			net.Start("swapinventoryitem")
				net.WriteInt(_targetslot,8)
				net.WriteInt(_fromslot,8)
			net.SendToServer()
		end
		if self.TargetUI then
			timer.Simple( .25, function() 
				self.TargetUI:RefreshSlot( self.InventorySlotCache[self.TargetUI.SlotID].ID )
					
				for k , v in pairs( self.InventorySlotCache ) do
					
					for k , v in pairs( self.AllButtons ) do
						
						v:SetItemTable()
							
					end
						
				end
				
						
						for k , v in pairs( LocalPlayer().__itemSlots ) do
						
							if v.SlotID && LocalPlayer():getFlag("itemSlot_" .. v.SlotID ) then
								
								local _item = ITEMLIST[LocalPlayer():getFlag("itemSlot_" .. v.SlotID )];
								v.mdl:SetModel( _item.Model )
								v.txt = _item.Name;
							
							
							end
							
						end
						
			end)
		end
		_t:Remove()
	end

end
function PANEL:SetItemTable( )
		
	self.InventorySlotCache = LoadStringToInventory( LocalPlayer():getFlag("inventory", "" ))
	if self.mdl then self.mdl:Remove(); end
	if self.InventorySlotCache[self.ID] then
		//PrintTable( self.InventorySlotCache[self.ID] )
	
		self.mdl = vgui.Create( "DModelPanel", self  )
		//self.mdl:SetFOV( 12 )
		self.mdl:SetVisible(true)
		self.mdl:Dock(FILL)
		self.mdl:DockMargin(5,5,5,5);
	
		local ListItem = ITEMLIST[self.InventorySlotCache[self.ID].ID];
		self.mdl:SetPos( 5, 5 )
		//self.mdl:SetSize( buttonSize - 10, buttonSize -10 )
		
		if ListItem then
		
			self.mdl:SetCamPos( ListItem.CamPos )

			self.mdl:SetLookAt( ListItem.LookAt )

			self.mdl:SetModel( ListItem.Model )
			function self.mdl:LayoutEntity( Entity ) 
				if ListItem.Skin then
					Entity:SetSkin(ListItem.Skin);
				end
				if ListItem.Scale then
					Entity:SetModelScale(ListItem.Scale);
				end
				Entity:SetAngles(Entity:GetAngles()+Angle(0,.1,0))
			end
		end
		
		//self.mdl:SetDirectionalLight( BOX_RIGHT, Color( 255, 255, 255, 255 ) )

		//self.mdl:SetDirectionalLight( BOX_LEFT, Color( 255, 255, 255, 255 ) )

		//self.mdl:SetAmbientLight( Vector( -64, -64, -64 ) ) 

		//self.mdl:SetColor( Color( 200, 200, 200 ) )

		//self.mdl:SetAnimated( false )		

		self.mdl:SetMouseInputEnabled(false)
		//local iSeq = self.mdl.Entity:LookupSequence('ragdoll')
	
		//self.mdl.Entity:ResetSequence(iSeq)
		

		//self:MoveToFront()
		
	end
end

function PANEL:Update()

end


function PANEL:SetInventorySlot( int )

end
if LocalPlayer().SlotToGrab then
	LocalPlayer().SlotToGrab:Remove()
end
function PANEL:OnMousePressed(k) 
		self.Pressed = true;
	if k == MOUSE_LEFT then 
		self.MousePress = CurTime() 
		LocalPlayer().TargetSlot = self;
		timer.Simple(.2, function()
			if LocalPlayer().TargetSlot and LocalPlayer().TargetSlot.Pressed == true then
				// timer appeared
				self = LocalPlayer().TargetSlot;
				_itemproxy = vgui.Create("inventoryitem");
				_itemproxy.Think = function(self) self:SetPos(gui.MouseX()+1,gui.MouseY()+1)	end
				_itemproxy:Droppable("inventoryitem")
				_itemproxy.ID = self.ID
				_itemproxy.TargetUI = self.TargetUI
				local _x , _y = self:GetSize();
				_itemproxy:SetSize(_x,_y);
				_itemproxy:SetItemTable()
				_itemproxy:MakePopup()
				_itemproxy.Pressed = true;
				LocalPlayer().SlotToGrab = _itemproxy
			end
		end)

	end 

end
function PANEL:OnMouseReleased(k) self:OnMouseReleasedImplementation(k,false) end

function PANEL:OnMouseReleasedImplementation(k,isSlotToGrab)
		self.Pressed = false;

		if LocalPlayer().SlotToGrab then
			if  LocalPlayer().SlotToGrab.Pressed == true and self:IsHovered() == true  then
				self:OnDragDrop(LocalPlayer().SlotToGrab)
			end
			
			LocalPlayer().SlotToGrab:Remove()
			LocalPlayer().SlotToGrab = nil;
		end
		if  k == MOUSE_LEFT  and self.MousePress and CurTime()- self.MousePress < 0.15 then
			if LocalPlayer():getFlag("lastAction", 0 ) > CurTime() then return end
			LocalPlayer():setFlag("lastAction", CurTime() + .5 )
			if !self.InventorySlotCache[self.ID] then return end
				

				if !ITEMLIST[self.InventorySlotCache[self.ID].ID].CanUse(LocalPlayer()) then
					return LocalPlayer():Notify("You may not use this item at this time!")
				end

				net.Start("useItemAtIndex")
						net.WriteInt( self.ID, 8 )
						net.WriteInt(  self.InventorySlotCache[self.ID].ID, 32 );
				net.SendToServer()

					timer.Simple( .25, function() 
						if self.TargetUI then
							self.TargetUI:RefreshSlot( self.TargetUI.SlotID )
						end
						
						if self.AllButtons then
							for k , v in pairs( self.AllButtons ) do
						
							v:SetItemTable()
							
						end
					end
							

							
							for k , v in pairs( LocalPlayer().__itemSlots ) do
								
								if v.SlotID && LocalPlayer():getFlag("itemSlot_" .. v.SlotID ) then
									
									v:UpdateItemSlot()
									
								end
								
							end
							
				end)
			
		elseif k == MOUSE_RIGHT then

			local MENU = DermaMenu()
			//MENU:SetFontInternal( "Trebuchet24")
			local subMenu1= MENU:AddSubMenu( "Set Action Bar" )

			for i =1 , 6 do
				

				subMenu1:AddOption("Set Slot " .. i ,function()
					local _abar = LocalPlayer().ActionBar;
					_abar.ItemSlot[i].ItemSlot = self.TargetUI.SlotID;
					_abar.ItemSlot[i].ID = self.TargetUI.SlotID//self.InventorySlotCache[self.TargetUI.SlotID].ID;
					_abar.ItemSlot[i]:SetItemTable()
					local _stbl = LocalPlayer():getFlag("actionbarslots",{});
					_stbl[i] = {};
					_stbl[i].ItemSlot = _abar.ItemSlot[i].ItemSlot
					_stbl[i].ID = _abar.ItemSlot[i].ID

					LocalPlayer():setFlag("actionbarslots",_stbl)
					net.Start("sendItemSlots")
						net.WriteTable(_stbl)
					net.SendToServer()
				end)
			end
			MENU:AddOption("Drop",function()
				if !ITEMLIST[self.InventorySlotCache[self.TargetUI.SlotID].ID].OnDropped(LocalPlayer()) then
					return LocalPlayer():Notify("You may not drop this item!")
				end
				net.Start("dropItemAtIndex")
					net.WriteInt( self.TargetUI.SlotID, 8 )
					net.WriteInt(  self.InventorySlotCache[self.TargetUI.SlotID].ID, 32 );
				net.SendToServer()
				
				timer.Simple( .25, function() 
				
					self.TargetUI:RefreshSlot( self.InventorySlotCache[self.TargetUI.SlotID].ID )
						
					for k , v in pairs( self.InventorySlotCache ) do
						
						for k , v in pairs( self.AllButtons ) do
							
							v:SetItemTable()
								
						end
							
					end
					
							
							for k , v in pairs( LocalPlayer().__itemSlots ) do
							
								if v.SlotID && LocalPlayer():getFlag("itemSlot_" .. v.SlotID ) then
									
									local _item = ITEMLIST[LocalPlayer():getFlag("itemSlot_" .. v.SlotID )];
									v.mdl:SetModel( _item.Model )
									v.txt = _item.Name;
								
								
								end
								
							end
							
				end)
			end)
					
			
			MENU:Open( gui.MouseX()+1, gui.MouseY()+1 )			
		end
		
	
end

local lastHover = 0;

function PANEL:Think()

	if self:IsHovered() && lastHover < CurTime() then
	
		if self and self.TargetUI != nil then 
			self.TargetUI:RefreshSlot( self.ID )
		end
		
		LocalPlayer():setFlag("TargetSlot", self.ID)
		//print("set target slot " .. self.ID)
		lastHover = CurTime() +0.1
		
	end
	
end

function PANEL:Paint( w, h )

	if self:IsHovered() && self.TargetUI && self.TargetUI.SlotID != self.ID then
		

		if self.delayTime && self.delayTime > CurTime() then return end
		
		self.delayTime = CurTime() + 1 
		
	end
	
			if self.InventorySlotCache[self.ID]	then
			
			local _Item = ITEMLIST[self.InventorySlotCache[self.ID].ID];
				
				if (istable(_Item) and (_Item.Tradeable == false || _Item.Illegal == true)) then
				
					surface.SetDrawColor( 255 ,0 ,0 ,255 )
					surface.DrawOutlinedRect( 0, 0, w, h )
				
				else

					surface.SetDrawColor( 255 ,255 ,255,255 )
					surface.DrawOutlinedRect( 0, 0, w, h )
				
				
				
				end
			else
			
			
					surface.SetDrawColor( 128 ,128,128,255   )
					surface.DrawOutlinedRect( 0, 0, w, h )
				
				
			end
	
end


vgui.Register("inventoryitem", PANEL)