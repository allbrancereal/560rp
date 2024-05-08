


local SCREEN_W, SCREEN_H = 1920, 1080;

local _w, _h = ScrW( ), ScrH( );

local _wMod, _hMod = _w / SCREEN_W, _h / SCREEN_H;
local FRAME;
net.Receive( "networkPlayerWarehouse", function( _l , _p )
	 
	LocalPlayer():setFlag("warehouseItems", net.ReadTable() );

	if !FRAME then return end
	
					for k , v in pairs( FRAME._grid:GetChildren() ) do
						
						
						v:SetItemTable()
						
						
					end
					for k , v in pairs( FRAME._WarehouseGrid:GetChildren() ) do
						
						
						v:SetItemTable()
						
						
					end
end )

net.Receive("sendWarehouse", function( _l , _p ) 

	WarehouseUI( net.ReadBool() );
	
end )
local _pMeta=  FindMetaTable( 'Player' )

function _pMeta:NearNPC ( NPCID )
	
	for k, v in pairs(ents.FindByClass("cn_npc")) do
	
			local uniqueID = v:GetQuest()
			
			if (uniqueID == NPCID) then
			
				if (self:GetPos():Distance(v:GetPos()) < 500) then
				
					return true;
					
				end
				
			end
			
		end
		
		return false;
		
end
function WarehouseUI( isRemote , overRide)	
	local _ourShopInfo = LocalPlayer():getFlag( "blackMarket", {} ).Selling;
	local _ourBuyingInfo = LocalPlayer():getFlag( "blackMarket", {} ).Buying;
	//if !LocalPlayer():IsDev() then return LocalPlayer():Notify("In works!") end
	if !LocalPlayer():NearNPC("warehouse") && !isRemote then return LocalPlayer():Notify("You need to be closer to the warehouse NPC!") end
	FRAME = vgui.Create( "DFrame" )
	
	FRAME:SetSize( _wMod * 1500, _hMod * 900 )
	FRAME:Center()
		LocalPlayer():setFlag("restrictInv", true)
	local _frameX , _frameY = FRAME:GetPos();
	FRAME:SetPos( 0, _frameY )
	FRAME:ShowCloseButton(false)
	FRAME:SetTitle( "Your Warehouse" )
	FRAME:MakePopup()
	FRAME.Alpha = 0;
	FRAME.SelectedText = "Hover over an Item";
	FRAME.SelectedDesc = "The description will be here (=";
	function FRAME:OnClose() 
	
		LocalPlayer():setFlag("restrictInv", false)
		net.Start("endWarehouse")
		net.SendToServer()
	
	end
	function FRAME:Paint( w,  h )
	
		draw.RoundedBoxEx( 0,0,0,w,h,Color( 25, 25 ,25, math.Clamp( FRAME.Alpha , 0, 128 ) ) )
		draw.RoundedBoxEx( 0,_wMod* 10, _hMod * 30,w/3 - _wMod * 25,h - _hMod * 40 ,Color( 56, 56 ,56,math.Clamp( FRAME.Alpha , 0 , 185 )  ) )
		
		draw.RoundedBoxEx( 0, w/1.5 ,_hMod * 30 , w/3 - _wMod * 25, h - _hMod * 40 ,Color( 56, 56 ,56, math.Clamp( FRAME.Alpha, 0 , 185)  ) )
		draw.SimpleText( FRAME.SelectedText , "ShopDescFont", w/2 , _hMod * 50, Color(255,255,255, FRAME.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		draw.SimpleText( FRAME.SelectedDesc , "ShopDescFont", w/2 , _hMod * 75, Color(255,255,255, FRAME.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		draw.SimpleText( "Inventory" , "Trebuchet24", w/2 + _wMod * 200 , _hMod * 50, Color(255,255,255, FRAME.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		draw.SimpleText( "Warehouse", "Trebuchet24", w/2 - _wMod * 200 , _hMod * 50, Color(255,255,255, FRAME.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	
	end 
	function FRAME:Think()
	
		if FRAME.Alpha < 255 then
		
			FRAME.Alpha = Lerp( 0.05, FRAME.Alpha , 255 )
			
		end
	
	end
	
	local FRAMEmdl = vgui.Create( "DModelPanel", FRAME )
	
	FRAMEmdl:SetPos( FRAME:GetWide() / 3 , _hMod * 100 )
	FRAMEmdl:SetSize( FRAME:GetWide() /3 , FRAME:GetTall() - _hMod * 200 )
	local buttonSize = _wMod * 90;	

	
	local _WarehouseList = vgui.Create( "DScrollPanel" , FRAME )
	_WarehouseList:SetSize( FRAME:GetWide()/3 - _wMod * 40 , FRAME:GetTall() - _hMod * 75)
	_WarehouseList:SetPos(_wMod *  30 , _hMod * 50 )
	local _WarehouseGrid = vgui.Create( "DGrid", _WarehouseList )
	_WarehouseGrid:SetCols( 4 )
	_WarehouseGrid:SetColWide( _wMod * 95 )
	_WarehouseGrid:SetRowHeight( 95 * _hMod  )
	lastTouch = 0;
	local MAX_SLOTS = fsrp.config.InventoryWSlots * fsrp.config.InventoryYSlots; 
	
	local _list = vgui.Create( "DScrollPanel" , FRAME )
	_list:SetSize( FRAME:GetWide()/3 - 35 , FRAME:GetTall() - _hMod * 75)
	_list:SetPos( FRAME:GetWide()/1.5 + 10 , _hMod * 50 )
	local _grid = vgui.Create( "DGrid", _list )
	_grid:SetCols( 4 )
	_grid:SetColWide( 95 * _wMod )
	_grid:SetRowHeight( 95 * _hMod )
	
	FRAME.InvList = _list
	FRAME.WarehouseList = _WarehouseList
	local _WarehouseItems = LocalPlayer():getFlag("warehouseItems",{});
	for i = 1, MAX_SLOTS do
	
		
		butCache = vgui.Create("DButton", _list )
		butCache.ID = i;
		butCache.InventorySlotCache = LoadStringToInventory(LocalPlayer():getFlag("inventory", nil ))

		butCache.TargetMDL = FRAMEmdl
		
		butCache:SetSize( buttonSize,buttonSize)
		
		butCache:SetTextColor( Color( 255 ,255 ,255 , FRAME.Alpha ) )
		butCache:SetToolTip( "Left Click to Deposit 1, Right click to Deposit 5" )

		local butCacheLabelTest = vgui.Create( "DPanel", butCache)
		function butCache:SetItemTable( )
				
			self.InventorySlotCache = LoadStringToInventory( LocalPlayer():getFlag("inventory", "" ))
			butCacheLabelTest.InventorySlotCache = LoadStringToInventory( LocalPlayer():getFlag("inventory", "" ))
			if self.mdl then self.mdl:Remove(); end
			
			if self.InventorySlotCache[self.ID] then
				//PrintTable( self.InventorySlotCache[self.ID] )

				local ListItem = ITEMLIST[self.InventorySlotCache[self.ID].ID];
				if ListItem && ListItem.Illegal == true then
				
				self.mdl = vgui.Create( "DModelPanel", self  )
				//self.mdl:SetFOV( 12 )
				self.mdl:SetVisible(true)
				
			
				self.mdl:SetPos( 5, 5 )
				self.mdl:SetSize( self:GetWide(), self:GetTall() )
				
				self.mdl:SetCamPos( ListItem.CamPos )

				self.mdl:SetLookAt(ListItem.LookAt )

				self.mdl:SetModel( ListItem.Model )

				//self.mdl:SetDirectionalLight( BOX_RIGHT, Color( 255, 255, 255, 255 ) )

				//self.mdl:SetDirectionalLight( BOX_LEFT, Color( 255, 255, 255, 255 ) )

				//self.mdl:SetAmbientLight( Vector( -64, -64, -64 ) ) 

				//self.mdl:SetColor( Color( 200, 200, 200 ) )

				//self.mdl:SetAnimated( false )		

				if ListItem.Scale then
					self.mdl.Entity:SetModelScale(ListItem.Scale);
				end
				self.mdl:SetMouseInputEnabled(false)
				//local iSeq = self.mdl.Entity:LookupSequence('ragdoll')
			
				//self.mdl.Entity:ResetSequence(iSeq)
				

				//self:MoveToFront()
				end
			end
		end
		butCache:SetItemTable()
		FRAME._grid = _grid;
		FRAME._WarehouseGrid = _WarehouseGrid;
		function butCache:OnMousePressed( k )
		
			//if self:IsDown() && lastTouch < CurTime() then
				//lastTouch = CurTime() + 0.1
				if !self.InventorySlotCache[self.ID] || !self.InventorySlotCache[self.ID].ID then return end
				local _Item = ITEMLIST[self.InventorySlotCache[self.ID].ID];
				local _amount = false;
			
				if k ==MOUSE_RIGHT then
					if self.InventorySlotCache[self.ID].Amount >= 10 then
					
						_amount = true;
					
					end
					
				end
				//if !table.HasValue(_ourBuyingInfo, _Item.ID ) then return end
				
				net.Start( "WarehouseAction_Inventory" )
					if k == MOUSE_RIGHT then
						net.WriteBool( false )
					elseif k == MOUSE_LEFT then
						net.WriteBool( true )
					end
					net.WriteInt( self.ID, 16 )
				net.SendToServer()
				
				timer.Simple( .1, function()
					
					for k , v in pairs( FRAME._grid:GetChildren() ) do
						
						
						v:SetItemTable()
						
						
					end
					for k , v in pairs( FRAME._WarehouseGrid:GetChildren() ) do
						
						
						v:SetItemTable()
						
						
					end
					
				end )
			//end
			
		end
		local _maxSlots = LocalPlayer():IsPremium() && fsrp.config.warehouses.SlotsPremium ||  LocalPlayer():IsDonator() && fsrp.config.warehouses.SlotsDonator || fsrp.config.warehouses.SlotsUser; 
	
		
		function butCache:Paint( w, h )
		
			if self.InventorySlotCache[self.ID]	then
			
			local _Item = ITEMLIST[self.InventorySlotCache[self.ID].ID];
				
				if #_WarehouseItems >= _maxSlots then
					
					
					surface.SetDrawColor( 255 ,0 ,0 ,FRAME.Alpha  )
					surface.DrawOutlinedRect( 0, 0, w, h )
					
					
					
				else

					
						surface.SetDrawColor( 255 ,255 ,255,FRAME.Alpha   )
						
						surface.DrawOutlinedRect( 0, 0, w, h )
					
				
				
				end
				
				//draw.SimpleText( self.InventorySlotCache[self.ID].Amount .. "x" , "Trebuchet20", 12.5, 10, Color(255,255,255, FRAME.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				
				if self:IsHovered() && self.TargetMDL:GetModel() != ITEMLIST[self.InventorySlotCache[self.ID].ID].Model then
					
					
					self.TargetMDL:SetModel( _Item.Model )
					self.TargetMDL:SetCamPos( _Item.CamPos )
					self.TargetMDL:SetLookAt( _Item.LookAt )
					if _Item.Skin then
						self.TargetMDL:SetSkin(_Item.Skin);
					end
					if _Item.Scale then
						self.TargetMDL:SetModelScale(_Item.Scale);
					end
					FRAME.SelectedText = _Item.Name .. " (Sell for $" .. _Item.Cost .. ")";
					FRAME.SelectedDesc = _Item.Description;
				end
				
			else
			
					surface.SetDrawColor( 128 ,128,128,FRAME.Alpha   )
					surface.DrawOutlinedRect( 0, 0, w, h )
				
				
			end
			
		end 
		
		local butx ,buty = butCache:GetSize()
		butCacheLabelTest:SetSize( butx, buty )
		butCacheLabelTest.ID = i;
		butCacheLabelTest.InventorySlotCache = LoadStringToInventory(LocalPlayer():getFlag("inventory", nil ))
		butCacheLabelTest:MoveToFront()
		butCacheLabelTest:SetMouseInputEnabled( false )
		function butCacheLabelTest:Paint( w, h )
			if self.InventorySlotCache && self.InventorySlotCache[self.ID] && self.InventorySlotCache[self.ID].ID then
			
				draw.SimpleText("\t\t".. self.InventorySlotCache[self.ID].Amount .. "x" , "Trebuchet24", 12.5, 10, Color(255,255,255, FRAME.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			
			end	
		end
		
		
		_grid:AddItem( butCache )
		
	end	
	
		local _maxSlots = LocalPlayer():IsPremium() && fsrp.config.warehouses.SlotsPremium ||  LocalPlayer():IsDonator() && fsrp.config.warehouses.SlotsDonator || fsrp.config.warehouses.SlotsUser; 
	
	
	local _player = LocalPlayer();
	
					
		for i = 1, _maxSlots do
		
			
			butCache = vgui.Create("DButton", FRAME._WarehouseList )
			butCache.ID = i;
			butCache.InventorySlotCache = _player:getFlag("warehouseItems", {});

			butCache.TargetMDL = FRAMEmdl
			butCache:SetText("")
			butCache:SetSize( buttonSize,buttonSize)
			butCache:SetTextColor( Color( 255 ,255 ,255 , FRAME.Alpha ) )
			butCache:SetToolTip( "Left Click to Withdraw 1, Right Click to Withdraw 5, Middle Mouse to Remove" )

			local butCacheLabelTest = vgui.Create( "DPanel", butCache)
			function butCache:SetItemTable( )
					
				self.InventorySlotCache =_player:getFlag("warehouseItems", {});
				butCacheLabelTest.InventorySlotCache =_player:getFlag("warehouseItems", {});
				if self.mdl then self.mdl:Remove(); end
				
				if self.InventorySlotCache[self.ID] then
					//PrintTable( self.InventorySlotCache[self.ID] )

					local ListItem = ITEMLIST[self.InventorySlotCache[self.ID].ID];
					if ListItem && ListItem.Illegal == true then
					
					self.mdl = vgui.Create( "DModelPanel", self  )
					//self.mdl:SetFOV( 12 )
					self.mdl:SetVisible(true)
					
				
					self.mdl:SetPos( 5, 5 )
					self.mdl:SetSize( self:GetWide(), self:GetTall() )
					
					self.mdl:SetCamPos( ListItem.CamPos )

					self.mdl:SetLookAt(ListItem.LookAt )

					self.mdl:SetModel( ListItem.Model )

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
			end
			butCache:SetItemTable()
			function butCache:OnMousePressed( k )
			
				//if self:IsDown() && lastTouch < CurTime() then
					//lastTouch = CurTime() + 0.1
					if !self.InventorySlotCache[self.ID] || !self.InventorySlotCache[self.ID].ID then return end
					local _Item = ITEMLIST[self.InventorySlotCache[self.ID].ID];
					local _amount = false;
				
					if _Item.RestrictPlayerTrade then return end
					/*
					net.Start("sendIllegalSellRequestToServer")
						net.WriteInt( _Item.ID , 16 )
						net.WriteInt( self.ID , 8 )
						net.WriteBool( _amount )
					net.SendToServer()
					*/
					
					net.Start( "WarehouseAction_Home" )
						if k == MOUSE_RIGHT then
							net.WriteInt( 2,4 )
						elseif k == MOUSE_LEFT then
							net.WriteInt( 1,4 )
						elseif k == MOUSE_MIDDLE then
							net.WriteInt( 3,4 )
						end
						net.WriteInt( self.ID, 16 )
						net.WriteBool( LocalPlayer():KeyDown( IN_ALT1 ) )
					net.SendToServer()
					
					timer.Simple( .1, function()
						
						if !FRAME then return end
						
						for k , v in pairs( FRAME._grid:GetChildren() ) do
							
							
							v:SetItemTable()
							
							
						end
						for k , v in pairs( FRAME._WarehouseGrid:GetChildren() ) do
							
							
							v:SetItemTable()
							
							
						end
						
					end )
				//end
				
			end
			
			
			function butCache:Paint( w, h )
			
				if self.InventorySlotCache[self.ID]	then
				
				local _Item = ITEMLIST[self.InventorySlotCache[self.ID].ID];
					
					if _Item.RestrictPlayerTrade then
						
						
						surface.SetDrawColor( 255 ,0 ,0 ,FRAME.Alpha  )
						surface.DrawOutlinedRect( 0, 0, w, h )
						
						
						
					else

						
							surface.SetDrawColor( 255 ,255 ,255,FRAME.Alpha   )
							
							surface.DrawOutlinedRect( 0, 0, w, h )
						
					
					
					end
					
					//draw.SimpleText( self.InventorySlotCache[self.ID].Amount .. "x" , "Trebuchet20", 12.5, 10, Color(255,255,255, FRAME.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
					
					if self:IsHovered() && self.TargetMDL:GetModel() != ITEMLIST[self.InventorySlotCache[self.ID].ID].Model then
						
						
						self.TargetMDL:SetModel( _Item.Model )
						self.TargetMDL:SetCamPos( _Item.CamPos )
						self.TargetMDL:SetLookAt( _Item.LookAt )
					if _Item.Skin then
						self.TargetMDL:SetSkin(_Item.Skin);
					end
					if _Item.Scale then
						self.TargetMDL.Entity:SetModelScale(_Item.Scale);
					end
						FRAME.SelectedText = _Item.Name .. " ($" .. _Item.Cost .. ")";
						FRAME.SelectedDesc = _Item.Description;
					end
					
				else
				
						surface.SetDrawColor( 128 ,128,128,FRAME.Alpha   )
						surface.DrawOutlinedRect( 0, 0, w, h )
					
					
				end
				
			end 
			
			local butx ,buty = butCache:GetSize()
			butCacheLabelTest:SetSize( butx, buty )
			butCacheLabelTest.ID = i;
			butCacheLabelTest.InventorySlotCache = _player:getFlag("warehouseItems", {});
			butCacheLabelTest:MoveToFront()
			butCacheLabelTest:SetMouseInputEnabled( false )
			function butCacheLabelTest:Paint( w, h )
				if self.InventorySlotCache && self.InventorySlotCache[self.ID] && self.InventorySlotCache[self.ID].ID then
				
					draw.SimpleText( "\t\t".. self.InventorySlotCache[self.ID].Amount .. "x" , "Trebuchet24", 12.5, 10, Color(255,255,255, FRAME.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				
				end	
			end
					
			FRAME._WarehouseGrid:AddItem( butCache )
			if !LocalPlayer().WarehouseItemPanel then 
				
				LocalPlayer().WarehouseItemPanel = {}
				
			end
			
			table.insert( LocalPlayer().WarehouseItemPanel , butCache )
		end
	
	local _closButton = vgui.Create( "DButton", FRAME )
	_closButton:SetSize( _wMod * 150 , _hMod * 35 )
	_closButton:SetPos( FRAME:GetWide()/2 - _wMod * 60 , FRAME:GetTall() - _hMod * 100 )
	_closButton:SetText( "" )
	function _closButton:Paint( w, h )
	
		if self:IsHovered() && !self:IsDown() then
			
			surface.SetDrawColor( 255 ,255 ,255 ,255 )
			
		elseif self:IsDown() then
		
			surface.SetDrawColor( 25 ,25 ,25 ,255 )
			
		else
		
			surface.SetDrawColor( 56 ,56 ,56 ,255 )
			
		end
		
		surface.DrawRect( 0,0, w, h )
		
		draw.SimpleText( "Close" , "Trebuchet24", w/2,h/2, Color(255,255,255, FRAME.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

	end

	function _closButton:OnMousePressed()
	
		LocalPlayer():setFlag("restrictInv", false)
		net.Start("endWarehouse")
		net.SendToServer()
		FRAME:Remove()
	
	end
	
	return FRAME;
	
end
