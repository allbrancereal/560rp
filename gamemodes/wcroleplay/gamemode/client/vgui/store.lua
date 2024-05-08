


local SCREEN_W, SCREEN_H = 1920, 1080;

local _w, _h = ScrW( ), ScrH( );

local _wMod, _hMod = _w / SCREEN_W, _h / SCREEN_H;

function ItemShopUI( typeShop )
	if !fsrp.stores.cache[typeShop] then return end
	
	local _ourShopInfo = fsrp.stores.cache[typeShop];
	
	FRAME = vgui.Create( "DFrame" )
	FRAME:SetSize( _wMod * 1500, _hMod * 900 )
	FRAME:Center()
	local _frameX , _frameY = FRAME:GetPos();
	FRAME:SetPos( 0, _frameY )
	FRAME:ShowCloseButton(true)
	FRAME:SetTitle( _ourShopInfo.Name )
	FRAME:MakePopup()
	FRAME.Alpha = 0;
	FRAME.SelectedText = "Hover over an Item";
	FRAME.SelectedDesc = "The description will be here (=";
	function FRAME:OnClose()
	
		LocalPlayer():setFlag("restrictInv", false)
		
	end
	LocalPlayer():setFlag("restrictInv", true)
	function FRAME:Paint( w,  h )
	
		draw.RoundedBoxEx( 0,0,0,w,h,Color( 25, 25 ,25, math.Clamp( FRAME.Alpha , 0, 128 ) ) )
		draw.RoundedBoxEx( 0,_wMod* 10, _hMod * 30,w/3 - _wMod * 25,h - _hMod * 40 ,Color( 56, 56 ,56,math.Clamp( FRAME.Alpha , 0 , 185 )  ) )
		
		draw.RoundedBoxEx( 0, w/1.5 ,_hMod * 30 , w/3 - _wMod * 25, h - _hMod * 40 ,Color( 56, 56 ,56, math.Clamp( FRAME.Alpha, 0 , 185)  ) )
		draw.SimpleText( FRAME.SelectedText , "ShopDescFont", w/2 , _hMod * 50, Color(255,255,255, FRAME.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		draw.SimpleText( FRAME.SelectedDesc , "ShopDescFont", w/2 , _hMod * 75, Color(255,255,255, FRAME.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		draw.SimpleText( "You" , "Trebuchet24", w/2 + _wMod * 200 , _hMod * 50, Color(255,255,255, FRAME.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		draw.SimpleText( _ourShopInfo.Name , "Trebuchet24", w/2 - _wMod * 200 , _hMod * 50, Color(255,255,255, FRAME.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	
	end 

	function FRAME:Think()
	
		if FRAME.Alpha < 255 then
		
			FRAME.Alpha = Lerp( 0.05, FRAME.Alpha , 255 )
			
		end
	
	end
	
	local FRAMEmdl = vgui.Create( "DModelPanel", FRAME )
	
	FRAMEmdl:SetPos( FRAME:GetWide() / 3 , _hMod * 100 )
	FRAMEmdl:SetSize( FRAME:GetWide() /3 , FRAME:GetTall() - _hMod * 200 )


	function FRAMEmdl:LayoutEntity( Entity ) 
		if self.ListItem and self.ListItem.Skin then
			Entity:SetSkin(ListItem.Skin);
		end
		if self.ListItem and self.ListItem.Scale then
			Entity:SetModelScale(ListItem.Scale);
		end
		Entity:SetAngles(Entity:GetAngles()+Angle(0,.1,0))
	end
	local _Shoplist = vgui.Create( "DScrollPanel" , FRAME )
	_Shoplist:SetSize( FRAME:GetWide()/2 - 40 , FRAME:GetTall() - _hMod * 75)
	_Shoplist:SetPos(_wMod *  30 , _hMod * 50 )
	local _Shopgrid = vgui.Create( "DGrid", _Shoplist )
	_Shopgrid:SetCols( 4 )
	_Shopgrid:SetColWide( 95 * _wMod )
	_Shopgrid:SetRowHeight( 95 * _hMod  )
	lastTouch = 0;
	if !LocalPlayer().shopPanelInv then
	
		LocalPlayer().shopPanelInv = {};
			
	end
	
	if !LocalPlayer().shopPanelShopIcons then
	
		LocalPlayer().shopPanelShopIcons = {};
	
	
		for k , v in pairs( LocalPlayer().shopPanelShopIcons ) do
		
			v:Remove()
			
		end
		
	end
	local buttonSize = ( ScrH() == 2160 ) && 150 || ( ScrH() == 1080 ) && 90 || ( ScrH() == 720 ) && 40 || _wMod * 80;	

	local MAX_SLOTS = fsrp.config.InventoryWSlots * fsrp.config.InventoryYSlots; 
	
	local _list = vgui.Create( "DScrollPanel" , FRAME )
	_list:SetSize( FRAME:GetWide()/3 - 35 , FRAME:GetTall() - _hMod * 75)
	_list:SetPos( FRAME:GetWide()/1.5 + 10 , _hMod * 50 )
	local _grid = vgui.Create( "DGrid", _list )
	_grid:SetCols( 4 )
	_grid:SetColWide( _wMod * 95 )
	_grid:SetRowHeight( 95 * _hMod )
	
	for i = 1, MAX_SLOTS do
	
		
		butCache = vgui.Create("DButton", invMdl )
		butCache.ID = i;
		butCache.InventorySlotCache = LoadStringToInventory(LocalPlayer():getFlag("inventory", nil ))
	
		butCache.TargetMDL = FRAMEmdl
		
		butCache:SetSize(buttonSize,buttonSize )
		butCache:SetTextColor( Color( 255 ,255 ,255 , FRAME.Alpha ) )
		butCache:SetToolTip( "Left Click to sell 1, you can hold it and it'll keep selling." )

		local butCacheLabelTest = vgui.Create( "DPanel", butCache)
		function butCache:SetItemTable( )
				
			self.InventorySlotCache = LoadStringToInventory( LocalPlayer():getFlag("inventory", "" ))
			butCacheLabelTest.InventorySlotCache = LoadStringToInventory( LocalPlayer():getFlag("inventory", "" ))
			if self.mdl then self.mdl:Remove(); end
			if self.InventorySlotCache[self.ID] then
				//PrintTable( self.InventorySlotCache[self.ID] )
				local ListItem = ITEMLIST[self.InventorySlotCache[self.ID].ID];
				if ListItem && ListItem.Tradeable == true then
				
				self.mdl = vgui.Create( "DModelPanel", self  )
				//self.mdl:SetFOV( 12 )
				self.mdl:SetVisible(true)
				
			
				self.mdl:SetPos( 5, 5 )
				self.mdl:SetSize( self:GetWide() , self:GetTall() )
				
				self.mdl:SetCamPos( ListItem.CamPos )

				self.mdl:SetLookAt(ListItem.LookAt )

				self.mdl:SetModel( ListItem.Model )

				//self.mdl:SetDirectionalLight( BOX_RIGHT, Color( 255, 255, 255, 255 ) )

				//self.mdl:SetDirectionalLight( BOX_LEFT, Color( 255, 255, 255, 255 ) )

				//self.mdl:SetAmbientLight( Vector( -64, -64, -64 ) ) 

				//self.mdl:SetColor( Color( 200, 200, 200 ) )

				//self.mdl:SetAnimated( false )		

				function self.mdl:LayoutEntity( Entity ) 
					if ListItem.Skin then
						Entity:SetSkin(ListItem.Skin);
					end
					if ListItem.Scale then
						Entity:SetModelScale(ListItem.Scale);
					end
					Entity:SetAngles(Entity:GetAngles()+Angle(0,.1,0))
				end
				self.mdl:SetMouseInputEnabled(false)
				//local iSeq = self.mdl.Entity:LookupSequence('ragdoll')
			
				//self.mdl.Entity:ResetSequence(iSeq)
				

				//self:MoveToFront()
				end
			end
		end
		butCache:SetItemTable()
		function butCache:OnMousePressed( keyCode )
			
			local _amount = false;
		
			if keyCode == MOUSE_RIGHT then
			
				_amount = true;
				
			end
		
			if lastTouch < CurTime() then
				lastTouch = CurTime() + 0.1
				
				net.Start("sendSellRequestToServer")
					net.WriteInt( self.ID , 16 ) // Slot
					//net.WriteInt( typeShop , 8 )
					net.WriteBool( _amount );
				net.SendToServer()
				
				timer.Simple( .1, function()
					
					for k , v in pairs( _grid:GetChildren() ) do
						
						
						v:SetItemTable()
						
						
					end
					
				end )
				
			end
			
		end
		
		function butCache:Paint( w, h )
		
			if self.InventorySlotCache[self.ID]	then
			
			local _Item = ITEMLIST[self.InventorySlotCache[self.ID].ID];
		
				if _Item.Tradeable == false || _Item.Illegal == true then
				
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
					FRAME.SelectedText = _Item.Name .. " (Sell for $" .. _Item.Cost * _ourShopInfo.SellRate .. ")";
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
			
				draw.SimpleText( "\t\t".. self.InventorySlotCache[self.ID].Amount .. "x" , "Trebuchet24", _wMod * 20, _hMod * 12.5, Color(255,255,255, FRAME.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			
			end	
		end
		
		table.insert( LocalPlayer().shopPanelInv, butCache );
		
		_grid:AddItem( butCache )
		
	end	
	
	
	
	
	for k , v in pairs( _ourShopInfo.Items ) do
		
		 
		local ListItem = ITEMLIST[v];
		if ListItem then
		
		local Mdl = vgui.Create("DModelPanel", _Shopgrid )
		local nbutCache = vgui.Create("DButton", Mdl )
		nbutCache.ItemID = v;
		nbutCache:SetText( ITEMLIST[v].Name )
		Mdl:SetSize(buttonSize, buttonSize )
		nbutCache:SetSize( Mdl:GetWide(), Mdl:GetTall() )
		Mdl:SetModel( ListItem.Model )
		nbutCache:SetTextColor( Color( 255 ,255 ,255 , FRAME.Alpha ) )
		nbutCache:SetToolTip( "Left Click to purchase 1, Right click to purchase 5" )
		Mdl:SetCamPos( ListItem.CamPos )
		Mdl.TargetMDL = FRAMEmdl
		nbutCache.TargetMDL = Mdl.TargetMDL;

		Mdl:SetLookAt(ListItem.LookAt )

		Mdl:SetModel( ListItem.Model )

		Mdl:SetMouseInputEnabled(false)
		Mdl:SetVisible(true)
			Mdl.Item  = ListItem;
			function Mdl:LayoutEntity( Entity ) 
				if ListItem.Skin then
					Entity:SetSkin(ListItem.Skin);
				end
				if ListItem.Scale then
					Entity:SetModelScale(ListItem.Scale);
				end
				Entity:SetAngles(Entity:GetAngles()+Angle(0,.1,0))
			end
		function nbutCache:OnMousePressed( keyCode )
					
			local _amount = false;
			
			if keyCode == MOUSE_RIGHT then
			
				_amount = true;
				
			end
			
			net.Start("sendBuyRequestToServer")
				net.WriteInt( self.ItemID, 16 )
				net.WriteBool( _amount );
				net.WriteInt( typeShop , 8 )
			net.SendToServer()
			
			timer.Simple( .25, function()
					
				for k , v in pairs( _grid:GetChildren() ) do
					
					
					v:SetItemTable()
				end
				
			end )
			
		end
		
		function nbutCache:Paint( w, h )
		
			surface.SetDrawColor( 255 ,255 ,255 , FRAME.Alpha  )
			surface.DrawOutlinedRect( 0, 0, w, h )
		
			if self:IsHovered() && self.TargetMDL:GetModel() != ListItem.Model then
			
				self.TargetMDL:SetModel( ListItem.Model )
				self.TargetMDL:SetCamPos( ListItem.CamPos )
				self.TargetMDL:SetLookAt( ListItem.LookAt )
				if ListItem.Skin != nil then
					self.TargetMDL.Entity:SetSkin(ListItem.Skin);
				end
				if ListItem.Scale != nil  then
					self.TargetMDL.Entity:SetModelScale(ListItem.Scale);
				end

				FRAME.SelectedText = ListItem.Name .. " (Buy for $" .. ListItem.Cost .. ")";
				FRAME.SelectedDesc = ListItem.Description
			end
		
			draw.SimpleText( "$" .. ListItem.Cost , "Trebuchet24", _wMod * 20, _hMod * 12.5, Color(255,255,255, FRAME.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

		end 
		table.insert( LocalPlayer().shopPanelShopIcons, invMdl );
		_Shopgrid:AddItem( Mdl )
		
		end
		
	end
	
	
end
