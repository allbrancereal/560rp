


local SCREEN_W, SCREEN_H = 1920, 1080;

local _w, _h = ScrW( ), ScrH( );

local _wMod, _hMod = _w / SCREEN_W, _h / SCREEN_H;

function IllegalShopUI( )	
	local _ourShopInfo = LocalPlayer():getFlag( "blackMarket", {} ).Selling;
	local _ourBuyingInfo = LocalPlayer():getFlag( "blackMarket", {} ).Buying;

		LocalPlayer():setFlag("restrictInv", true)
	FRAME = vgui.Create( "DFrame" )
	FRAME:SetSize( _wMod * 1500, _hMod * 900 )
	FRAME:Center()
	local _frameX , _frameY = FRAME:GetPos();
	FRAME:SetPos( 0, _frameY )
	FRAME:ShowCloseButton(false)
	FRAME:SetTitle( "Drug Dealer" )
	FRAME:MakePopup()
	FRAME.Alpha = 0;
	FRAME.SelectedText = "Hover over an Item";
	FRAME.SelectedDesc = "The description will be here (=";
	FRAME.OnClose = function()
	
		LocalPlayer():setFlag("restrictInv", false)
		
	end 
	
	function FRAME:Paint( w,  h )
	
		draw.RoundedBoxEx( 0,0,0,w,h,Color( 25, 25 ,25, math.Clamp( FRAME.Alpha , 0, 128 ) ) )
		draw.RoundedBoxEx( 0,_wMod* 10, _hMod * 30,w/3 - _wMod * 25,h - _hMod * 40 ,Color( 56, 56 ,56,math.Clamp( FRAME.Alpha , 0 , 185 )  ) )
		
		draw.RoundedBoxEx( 0, w/1.5 ,_hMod * 30 , w/3 - _wMod * 25, h - _hMod * 40 ,Color( 56, 56 ,56, math.Clamp( FRAME.Alpha, 0 , 185)  ) )
		draw.SimpleText( FRAME.SelectedText , "ShopDescFont", w/2 , _hMod * 50, Color(255,255,255, FRAME.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		draw.SimpleText( FRAME.SelectedDesc , "ShopDescFont", w/2 , _hMod * 75, Color(255,255,255, FRAME.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		draw.SimpleText( "You" , "Trebuchet24", w/2 + _wMod * 200 , _hMod * 50, Color(255,255,255, FRAME.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		draw.SimpleText( "The Dealer", "Trebuchet24", w/2 - _wMod * 200 , _hMod * 50, Color(255,255,255, FRAME.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	
	end 
	local _closButton = vgui.Create( "DButton", FRAME )
	_closButton:SetSize( _wMod * 35 , _hMod * 35 )
	_closButton:SetPos( FRAME:GetWide() - _wMod * 35 , 0 )
	_closButton:SetText( "x" )
	function _closButton:OnMousePressed()
	
		LocalPlayer():setFlag("restrictInv", false)
		FRAME:Remove()
	
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

	
	local _Shoplist = vgui.Create( "DScrollPanel" , FRAME )
	_Shoplist:SetSize( FRAME:GetWide()/2 - 40 , FRAME:GetTall() - _hMod * 75)
	_Shoplist:SetPos(_wMod *  30 , _hMod * 50 )
	local _Shopgrid = vgui.Create( "DGrid", _Shoplist )
	_Shopgrid:SetCols( 4 )
	_Shopgrid:SetColWide( _wMod * 95 )
	_Shopgrid:SetRowHeight( 95 * _hMod  )
	
	if !LocalPlayer().shopilPanelInv then
	
		LocalPlayer().shopilPanelInv = {};
			
	end
	
	if !LocalPlayer().shopilPanelShopIcons then
	
		LocalPlayer().shopilPanelShopIcons = {};
	
	else
	
	
		for k , v in pairs( _Shopgrid:GetChildren() ) do
		
			v:Remove()
			
		end
	
		for k , v in pairs( LocalPlayer().shopilPanelShopIcons ) do
		
			v:Remove()
			
		end
		
	end
	lastTouch = 0;
	local MAX_SLOTS = fsrp.config.InventoryWSlots * fsrp.config.InventoryYSlots; 
	
	local _list = vgui.Create( "DScrollPanel" , FRAME )
	_list:SetSize( FRAME:GetWide()/3 - 35 , FRAME:GetTall() - _hMod * 75)
	_list:SetPos( FRAME:GetWide()/1.5 + 10 , _hMod * 50 )
	local _grid = vgui.Create( "DGrid", _list )
	_grid:SetCols( 4 )
	_grid:SetColWide( 95 * _wMod )
	_grid:SetRowHeight( 95 * _hMod )
	
	for i = 1, MAX_SLOTS do
	
		
		butCache = vgui.Create("DButton", _list )
		butCache.ID = i;
		butCache.InventorySlotCache = LoadStringToInventory(LocalPlayer():getFlag("inventory", nil ))

		butCache.TargetMDL = FRAMEmdl
		
		butCache:SetSize( buttonSize,buttonSize)
		butCache:SetTextColor( Color( 255 ,255 ,255 , FRAME.Alpha ) )
		butCache:SetToolTip( "Left Click to sell 1, Right click to sell all." )

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
		function butCache:OnMousePressed( k )
		
			//if self:IsDown() && lastTouch < CurTime() then
				//lastTouch = CurTime() + 0.1
				if !self.InventorySlotCache[self.ID] || !self.InventorySlotCache[self.ID].ID then return end
				if !self.ID then return end
				

				local _Item = ITEMLIST[self.InventorySlotCache[self.ID].ID];
				local _amount = false;
				
				if _Item.RestrictBlackMarketSale then return LocalPlayer():Notify("You may not sell this item to the Black Market") end

				if k ==MOUSE_RIGHT then
					if self.InventorySlotCache[self.ID].Amount >= 10 then
					
						_amount = true;
					
					end
					
				end
				//if !table.HasValue(_ourBuyingInfo, _Item.ID ) then return end
				
				net.Start("sendIllegalSellRequestToServer")
					net.WriteInt( _Item.ID , 16 )
					net.WriteInt( self.ID , 8 )
					net.WriteBool( _amount )
				net.SendToServer()
				
				timer.Simple( .1, function()
					
					for k , v in pairs( _grid:GetChildren() ) do
						
						
						v:SetItemTable()
						
						
					end
					
				end )
			//end
			
		end
		
		
		function butCache:Paint( w, h )
		
			if self.InventorySlotCache[self.ID]	then
			
			local _Item = ITEMLIST[self.InventorySlotCache[self.ID].ID];
				
				if _ourBuyingInfo and !table.HasValue(_ourBuyingInfo, _Item.ID ) && _Item.RestrictBlackMarketSale then
					
					
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
			
				draw.SimpleText( "\t\t".. self.InventorySlotCache[self.ID].Amount .. "x" , "Trebuchet24", _wMod * 20, _hMod * 12.5, Color(255,255,255, FRAME.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			
			end	
		end
		
		table.insert( LocalPlayer().shopilPanelInv, butCache );
		
		_grid:AddItem( butCache )
		
	end	
	
	
	if istable(_ourShopInfo) and _ourShopInfo != nil and #_ourShopInfo > 0 then
		for k , v in pairs( _ourShopInfo ) do
			local ListItem = ITEMLIST[v];
			if ListItem then
				
				local Mdl = vgui.Create("DModelPanel", _Shopgrid )
				local nbutCache = vgui.Create("DButton", Mdl )
				nbutCache.ItemID = v;
				nbutCache:SetText( ListItem.Name )
				Mdl:SetSize(buttonSize,buttonSize )
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
					//if !table.HasValue(_ourBuyingInfo, ListItem.ID ) then return end
					local _amount = false;
					
					if keyCode == MOUSE_RIGHT then
					
						_amount = true;
						
					end
					
					
					net.Start("sendIllegalBuyRequestToServer")
						net.WriteInt( self.ItemID, 16 )
						net.WriteBool( _amount );
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
					if ListItem.Skin != nil  then
						self.TargetMDL.Entity:SetSkin(ListItem.Skin);
					end
					if ListItem.Scale != nil then
						self.TargetMDL.Entity:SetModelScale(ListItem.Scale);
					end
						FRAME.SelectedText = ListItem.Name .. " (Buy for $" .. ListItem.Cost .. ")";
						FRAME.SelectedDesc = ListItem.Description
					end
				
					draw.SimpleText( "$" .. ListItem.Cost , "Trebuchet24",_wMod * 20, _hMod * 12.5, Color(255,255,255, FRAME.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

				end 
				table.insert( LocalPlayer().shopilPanelShopIcons, invMdl );
				_Shopgrid:AddItem( Mdl )
				
			end
		
		end
	end
	
	
end
