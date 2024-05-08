



local SCREEN_W, SCREEN_H = 1920, 1080;

local _w, _h = ScrW( ), ScrH( );

local _wMod, _hMod = _w / SCREEN_W, _h / SCREEN_H;

net.Receive("sendTradeWindow" , function( _l , _p )

	TradePlayer( net.ReadString() )

end )

net.Receive("closeTradingWindow", function( _l , _p )

	if LocalPlayer().FRAME && ispanel( LocalPlayer().FRAME ) then
	
		LocalPlayer().FRAME:Remove()
		
	end

end ) 

net.Receive("updateClientTradeMoney", function( _l , _p )
	if !FRAME then return end
	
	local _money = net.ReadInt( 32 )
	local _isLocal = net.ReadBool()
	local _p2 = player.GetBySteamID( LocalPlayer():getFlag("tradingPartner", "" ) );
	
	if _isLocal then
		
		FRAME.SelfOfferingMoney = _money;
			
	else 
		
		FRAME:SetOfferMoney(_money);
		
	end
	
end )


net.Receive("getTradeUpdate", function( _l , _p )

		local _newTable = net.ReadTable();
		local _isLocal = net.ReadBool()
			
		if _isLocal then
		
			LocalPlayer():setFlag("tradeItems", _newTable )
			
			
		else 
		
			player.GetBySteamID( LocalPlayer():getFlag("tradingPartner", "" ) ):setFlag("tradeItems", _newTable )
		
		end
					
					if FRAME._Player1InvGrid then
					
						for k , v in pairs( FRAME._Player1InvGrid:GetChildren() ) do
							
							
							v:SetItemTable()
							
						end
						FRAME.IsP2Confirmed = false;
						
					end
					
					if FRAME._Player2Grid then
						
						for k , v in pairs( FRAME._Player2Grid:GetChildren() ) do
							
							
							v:SetItemTable()
							
							
						end
						FRAME.ConfirmButton.IsConfirmed = false;
					
					end
					
					if FRAME._Player1Grid then
						
						for k , v in pairs( FRAME._Player1Grid:GetChildren() ) do
							
							
							v:SetItemTable()
							
							
						end
						
					end
					
		
		
end )

net.Receive("broadcastConfirmation", function( _l , _p )

	local _IsLocal = net.ReadBool()
	local _confirmationState = net.ReadBool()

	if _IsLocal then
	
		FRAME.ConfirmButton.IsConfirmed = _confirmationState;
		LocalPlayer():Notify("You have confirmed your offer")
	else
	
		FRAME.IsP2Confirmed = _confirmationState;
		LocalPlayer():Notify("The other player has confirmed.")
	end
	
end )

function TradePlayer( steamID )	
	//local _ourShopInfo = LocalPlayer():getFlag( "blackMarket", {} ).Selling;
	//local _ourBuyingInfo = LocalPlayer():getFlag( "blackMarket", {} ).Buying;

	_player = player.GetBySteamID( steamID )
	
	local _pBasket = LocalPlayer():getFlag("tradeItems", {});
	local _p2Basket = _player:getFlag("tradeItems", {} );
	
	
	FRAME = vgui.Create( "DFrame" )
	FRAME:SetSize( _wMod * 1500, _hMod * 900 )
	FRAME:Center()
	local _frameX , _frameY = FRAME:GetPos();
	FRAME:SetPos( 0, _frameY )
	FRAME:ShowCloseButton(false)
	FRAME.OfferingMoney = 0;
	FRAME.SelfOfferingMoney = 0;
	local _pMoneyFrame = vgui.Create("DPanel", FRAME)
	
	LocalPlayer():setFlag("restrictInv", true)
	_pMoneyFrame:SetPos( _wMod * 15 , _hMod * 17.5 )
	_pMoneyFrame:SetSize(_wMod * 200,_hMod* 30 )
	function _pMoneyFrame:Paint( w , h )
	
		surface.SetDrawColor( 128, 128 ,128 ,128 )
		surface.DrawRect( 0,0,w,h)
	
	
	end
	FRAME.IsP2Confirmed = false;
		
	local _pMoney = vgui.Create("DNumSlider", _pMoneyFrame)
	
	_pMoney:SetPos( _wMod *5 , _hMod * 5)
	_pMoney:SetSize( _pMoneyFrame:GetWide() - _wMod * 10 , _pMoneyFrame:GetTall() -  _hMod * 10  )
	
	_pMoney:SetText( "Give Money" )
	_pMoney:SetMin( 0 )
	_pMoney:SetMax( LocalPlayer():getMoney() )
	_pMoney:SetDecimals( 0 )
	//_pMoney:SetFont( "Trebuchet24" ) 
	_pMoney:SetValue(0)
	function _pMoney:OnValueChanged( val )
		
		timer.Simple( 0.1 , function( )
		
			net.Start("tradeClientMoney")
				net.WriteInt( val , 32 )
			net.SendToServer()
			
		end )
		
	end
	
	local _p2MoneyFrame = vgui.Create("DPanel", FRAME)
	
	_p2MoneyFrame:SetPos( _wMod * 15 , _hMod * 442.5 )
	_p2MoneyFrame:SetSize(_wMod* 200,_hMod * 30 )
	
	local _p2Money = vgui.Create("DTextEntry", _p2MoneyFrame)
	
	_p2Money:SetPos( _wMod *5 , _hMod * 5)
	_p2Money:SetSize( _p2MoneyFrame:GetWide() - _wMod * 10 , _p2MoneyFrame:GetTall() -  _hMod * 10  )
	_p2Money:SetText( FRAME.OfferingMoney )
	_p2Money:SetFont( "Trebuchet24" )
	_p2Money.AllowInput = function( self, stringValue )
		return true
	end
	
	function FRAME:SetOfferMoney( int )
	
		self.OfferingMoney = int;
		_p2Money:SetText(self.OfferingMoney);
		
	end
	
	function FRAME:SetOurMoney( int )
	
		self.SelfOfferingMoney = int;
		
	end
	
	if _player then
	
		FRAME:SetTitle( "Trading " .. _player:getRPName() )
	
	end
	
	FRAME:MakePopup()
	FRAME.Alpha = 0;
	FRAME.SelectedText = "Hover over an Item";
	FRAME.SelectedDesc = "The description will be here (=";
	function FRAME:OnClose()
	
		LocalPlayer():setFlag("restrictInv", false)
		LocalPlayer()._Player2Grid = nil
		LocalPlayer()._Player1InvGrid = nil
		LocalPlayer()._Player1Grid = nil
		net.Start("sendTradeEnd")
		net.SendToServer()
	end 
	
	function FRAME:Paint( w,  h )
	
		draw.RoundedBoxEx( 0,0,0,w,h,Color( 25, 25 ,25, math.Clamp( FRAME.Alpha , 0, 128 ) ) )
		draw.RoundedBoxEx( 0,_wMod* 10, h*0.5,w/3 - _wMod * 25,h*0.5 - _hMod * 20 ,Color( 56, 56 ,56,math.Clamp( FRAME.Alpha , 0 , 185 )  ) )
		
		
		draw.RoundedBoxEx( 0,_wMod* 10, _hMod * 30,w/3 - _wMod * 25,h*0.5 - _hMod * 40 ,Color( 56, 56 ,56,math.Clamp( FRAME.Alpha , 0 , 185 )  ) )
		
		draw.RoundedBoxEx( 0, w/1.5 ,_hMod * 30 , w/3 - _wMod * 25, h - _hMod * 40 ,Color( 56, 56 ,56, math.Clamp( FRAME.Alpha, 0 , 185)  ) )
		draw.SimpleText( FRAME.SelectedText , "ShopDescFont", w/2 , _hMod * 50, Color(255,255,255, FRAME.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		draw.SimpleText( FRAME.SelectedDesc , "ShopDescFont", w/2 , _hMod * 75, Color(255,255,255, FRAME.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		draw.SimpleText( "Inventory" , "Trebuchet24", w/2 + _wMod * 200 , _hMod * 50, Color(255,255,255, FRAME.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		draw.SimpleText( LocalPlayer():getRPName() .. " $" .. self.SelfOfferingMoney , "Trebuchet24", _wMod * 225 , _hMod * 25, Color(255,255,255, FRAME.Alpha ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT )
		if !self.IsP2Confirmed then
		
			draw.SimpleText( _player:getRPName() .. " (Unconfirmed)", "Trebuchet24",_wMod * 225 , _hMod * 450, Color(255,255,255, FRAME.Alpha ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT )
		
		else
		
			draw.SimpleText( _player:getRPName() .. " (Confirmed)", "Trebuchet24",_wMod * 225 , _hMod * 450, Color(255,255,255, FRAME.Alpha ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT )
		
		end
		
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

	
	local _Player2List = vgui.Create( "DScrollPanel" , FRAME )
	_Player2List:SetSize( FRAME:GetWide()*0.3 - 40 , FRAME:GetTall()*0.5 - _hMod * 75)
	_Player2List:SetPos(_wMod *  30 , _hMod * 100 + FRAME:GetTall()*0.5 - _hMod * 75)
	local _Player2Grid = vgui.Create( "DGrid", _Player2List )
	_Player2Grid:SetCols( 4 )
	_Player2Grid:SetColWide( _wMod * 95 )
	_Player2Grid:SetRowHeight( 95 * _hMod  )
	FRAME._Player2Grid = _Player2Grid
	
	
	local _Player1List = vgui.Create( "DScrollPanel" , FRAME )
	_Player1List:SetSize( FRAME:GetWide()*0.3 - 40 , FRAME:GetTall()*0.5 - _hMod * 75)
	_Player1List:SetPos(_wMod *  30 , _hMod * 50 )
	local _Player1Grid = vgui.Create( "DGrid", _Player1List )
	_Player1Grid:SetCols( 4 )
	_Player1Grid:SetColWide( 95 * _wMod )
	_Player1Grid:SetRowHeight( 95 * _hMod )
	FRAME._Player1Grid = _Player1Grid
	
	lastTouch = 0;
	local MAX_SLOTS = fsrp.config.InventoryWSlots * fsrp.config.InventoryYSlots; 
	
	local _Player1Inv = vgui.Create( "DScrollPanel" , FRAME )
	_Player1Inv:SetSize( FRAME:GetWide()/3 - 35 , FRAME:GetTall() - _hMod * 75)
	_Player1Inv:SetPos( FRAME:GetWide()/1.5 + 10 , _hMod * 50 )
	local _Player1InvGrid = vgui.Create( "DGrid", _Player1Inv )
	_Player1InvGrid:SetCols( 4 )
	_Player1InvGrid:SetColWide( 95 * _wMod )
	_Player1InvGrid:SetRowHeight( 95 * _hMod )
	FRAME._Player1InvGrid = _Player1InvGrid
	LocalPlayer()._Player2Grid = _Player2Grid
	LocalPlayer()._Player1InvGrid = _Player1InvGrid
	LocalPlayer()._Player1Grid = _Player1Grid
	
	_ConfirmButton = vgui.Create( "DButton" , FRAME )
	_ConfirmButton:SetSize( _wMod * 150, _hMod * 30 )
	_ConfirmButton:SetText("")
	_ConfirmButton:SetPos( FRAME:GetWide() / 2 - _wMod * 160, FRAME:GetTall() - _hMod * 100)
	
	_CloseButton = vgui.Create( "DButton" , FRAME )
	_CloseButton:SetSize( _wMod * 150, _hMod * 30 )
	_CloseButton:SetText("")
	_CloseButton:SetPos( FRAME:GetWide() / 2 , FRAME:GetTall() - _hMod * 100)
	function _CloseButton:OnMousePressed( k )
	
	
		LocalPlayer():setFlag("restrictInv", false)
		LocalPlayer()._Player2Grid = nil
		LocalPlayer()._Player1InvGrid = nil
		LocalPlayer()._Player1Grid = nil
	
		net.Start("sendTradeEnd")
		net.SendToServer()
		FRAME:Remove();
	
	end 
	
	function _CloseButton:Paint( w , h )
	
		surface.SetDrawColor( 128 ,128,128,FRAME.Alpha   )
		surface.DrawRect( 0, 0, w, h )
		
		draw.SimpleText( "Close Trade" , "Trebuchet24", w/2,h/2, Color(255,255,255, FRAME.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

				
	end
	_ConfirmButton.IsConfirmed = false;
	function _ConfirmButton:OnMousePressed( k )
	
	
		LocalPlayer():setFlag("restrictInv", false)
		net.Start("sendTradeConfirmation")
			net.WriteBool( !self.IsConfirmed );			
		net.SendToServer()
	
	
	end 
	function _ConfirmButton:Paint( w , h )
		if self.IsConfirmed == false then
		
			surface.SetDrawColor( 255 ,0,0,FRAME.Alpha   )
		
		else
		
			surface.SetDrawColor( 0 ,255,0,FRAME.Alpha )
		
		end
		
		surface.DrawRect( 0, 0, w, h )
		
		draw.SimpleText( "Confirm Trade" , "Trebuchet24", w/2,h/2, Color(255,255,255, FRAME.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

				
	end
	FRAME.ConfirmButton = _ConfirmButton
	
	for i = 1, MAX_SLOTS do
	
		
		butCache = vgui.Create("DButton", _Player1Inv )
		butCache.ID = i;
		butCache.InventorySlotCache = LoadStringToInventory(LocalPlayer():getFlag("inventory", nil ))

		butCache.TargetMDL = FRAMEmdl
		
		butCache:SetSize( buttonSize,buttonSize)
		butCache:SetTextColor( Color( 255 ,255 ,255 , FRAME.Alpha ) )
		butCache:SetToolTip( "Left Click to put it in your trades." )

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
		function butCache:OnMousePressed( k )
		
			//if self:IsDown() && lastTouch < CurTime() then
				//lastTouch = CurTime() + 0.1
				if !self.InventorySlotCache[self.ID] || !self.InventorySlotCache[self.ID].ID then return end
				local _Item = ITEMLIST[self.InventorySlotCache[self.ID].ID];
				local _amount = false;
			
				if k ==MOUSE_RIGHT then
					if self.InventorySlotCache[self.ID].Amount >= 5 then
					
						_amount = true;
					
					end
					
				end
				if _Item.RestrictPlayerTrade then return end
				/*
				net.Start("sendIllegalSellRequestToServer")
					net.WriteInt( _Item.ID , 16 )
					net.WriteInt( self.ID , 8 )
					net.WriteBool( _amount )
				net.SendToServer()
				*/
				net.Start("sendTradeItemToBasket")
					net.WriteInt( self.ID, 16 )
					net.WriteBool( _amount )
				net.SendToServer()
				
				timer.Simple( 1, function()
					
					if !FRAME then return end
					
					if FRAME._Player1InvGrid then
					
						for k , v in pairs( FRAME._Player1InvGrid:GetChildren() ) do
							
							
							v:SetItemTable()
							
						end
						
					end
					
					if FRAME._Player2Grid then
						
						for k , v in pairs( FRAME._Player2Grid:GetChildren() ) do
							
							
							v:SetItemTable()
							
							
						end
					
					end
					
					if FRAME._Player1Grid then
						
						for k , v in pairs( FRAME._Player1Grid:GetChildren() ) do
							
							
							v:SetItemTable()
							
							
						end
						
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
		butCacheLabelTest.InventorySlotCache = LoadStringToInventory(LocalPlayer():getFlag("inventory", nil ))
		butCacheLabelTest:MoveToFront()
		butCacheLabelTest:SetMouseInputEnabled( false )
		function butCacheLabelTest:Paint( w, h )
			if self.InventorySlotCache && self.InventorySlotCache[self.ID] && self.InventorySlotCache[self.ID].ID then
			
				draw.SimpleText( self.InventorySlotCache[self.ID].Amount .. "x" , "Trebuchet24", 12.5, 10, Color(255,255,255, FRAME.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			
			end	
		end
				
		_Player1InvGrid:AddItem( butCache )
		
	end	
	
	for i = 1, fsrp.config.TradeSlots do
	
		
		butCache = vgui.Create("DButton", _Player2List )
		butCache.ID = i;
		butCache.InventorySlotCache = _player:getFlag("tradeItems", {});

		butCache.TargetMDL = FRAMEmdl
		
		butCache:SetSize( buttonSize,buttonSize)
		butCache:SetTextColor( Color( 255 ,255 ,255 , FRAME.Alpha ) )
		butCache:SetToolTip( "Inspect this to your liking." )

		local butCacheLabelTest = vgui.Create( "DPanel", butCache)
		function butCache:SetItemTable( )
				
			self.InventorySlotCache =_player:getFlag("tradeItems", {});
			butCacheLabelTest.InventorySlotCache =_player:getFlag("tradeItems", {});
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
				if _Item.RestrictPlayerTrade then return end
				/*
				net.Start("sendIllegalSellRequestToServer")
					net.WriteInt( _Item.ID , 16 )
					net.WriteInt( self.ID , 8 )
					net.WriteBool( _amount )
				net.SendToServer()
				*/
				
				timer.Simple( 1, function()
					
					if !FRAME then return end
					
					for k , v in pairs( FRAME._Player1InvGrid:GetChildren() ) do
						
						
						v:SetItemTable()
						
						
					end
					for k , v in pairs( FRAME._Player2Grid:GetChildren() ) do
						
						
						v:SetItemTable()
						
						
					end
					for k , v in pairs( FRAME._Player1Grid:GetChildren() ) do
						
						
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
		butCacheLabelTest.InventorySlotCache = _player:getFlag("tradeItems", {});
		butCacheLabelTest:MoveToFront()
		butCacheLabelTest:SetMouseInputEnabled( false )
		function butCacheLabelTest:Paint( w, h )
			if self.InventorySlotCache && self.InventorySlotCache[self.ID] && self.InventorySlotCache[self.ID].ID then
			
				draw.SimpleText( "\t\t"..self.InventorySlotCache[self.ID].Amount .. "x" , "Trebuchet24", 12.5, 10, Color(255,255,255, FRAME.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			
			end	
		end
				
		_Player2Grid:AddItem( butCache )
		
	end
	
	for i = 1, fsrp.config.TradeSlots do
	
		
		butCache = vgui.Create("DButton", _Player1List )
		butCache.ID = i;
		butCache.InventorySlotCache = LocalPlayer():getFlag("tradeItems", {});

		butCache.TargetMDL = FRAMEmdl
		
		butCache:SetSize( buttonSize,buttonSize)
		butCache:SetTextColor( Color( 255 ,255 ,255 , FRAME.Alpha ) )
		butCache:SetToolTip( "Left Click to retrieve the item from your bucket." )

		local butCacheLabelTest = vgui.Create( "DPanel", butCache)
		function butCache:SetItemTable( )
				
			self.InventorySlotCache =LocalPlayer():getFlag("tradeItems", {});
			butCacheLabelTest.InventorySlotCache = LocalPlayer():getFlag("tradeItems", {});
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
				if _Item.RestrictPlayerTrade then return end
				/*
				net.Start("sendIllegalSellRequestToServer")
					net.WriteInt( _Item.ID , 16 )
					net.WriteInt( self.ID , 8 )
					net.WriteBool( _amount )
				net.SendToServer()
				*/
				net.Start("retrieveBucketTradeItem")
					net.WriteInt( self.ID , 16 )
				net.SendToServer()
				
				timer.Simple( 1, function()
					
					if !FRAME then return end
					
					for k , v in pairs( FRAME._Player1InvGrid:GetChildren() ) do
						
						
						v:SetItemTable()
						
						
					end
					for k , v in pairs( FRAME._Player2Grid:GetChildren() ) do
						
						
						v:SetItemTable()
						
						
					end
					for k , v in pairs( FRAME._Player1Grid:GetChildren() ) do
						
						
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
		butCacheLabelTest.InventorySlotCache = LocalPlayer():getFlag("tradeItems", {});
		butCacheLabelTest:MoveToFront()
		butCacheLabelTest:SetMouseInputEnabled( false )
		function butCacheLabelTest:Paint( w, h )
			if self.InventorySlotCache && self.InventorySlotCache[self.ID] && self.InventorySlotCache[self.ID].ID then
			
				draw.SimpleText( "\t\t"..self.InventorySlotCache[self.ID].Amount .. "x" , "Trebuchet24", 12.5, 10, Color(255,255,255, FRAME.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			
			end	
		end
				
		_Player1Grid:AddItem( butCache )
		
	end
	
	/*
	for k , v in pairs( _ourShopInfo ) do
		local ListItem = ITEMLIST[v];
		
		local Mdl = vgui.Create("DModelPanel", _Player2Grid )
		local nbutCache = vgui.Create("DButton", Mdl )
		nbutCache.ItemID = v;
		nbutCache:SetText( ITEMLIST[v].Name )
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
					
				for k , v in pairs( _Player2Grid:GetChildren() ) do
					
					
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
				FRAME.SelectedText = ListItem.Name .. " (Buy for $" .. ListItem.Cost .. ")";
				FRAME.SelectedDesc = ListItem.Description
			end
		
			draw.SimpleText( "$" .. ListItem.Cost , "Trebuchet24", 12.5, 10, Color(255,255,255, FRAME.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

		end 
		table.insert( LocalPlayer().shopilPanelShopIcons, invMdl );
		_Player2Grid:AddItem( Mdl )
		
		
	end
	*/
	LocalPlayer().FRAME = FRAME;
end
