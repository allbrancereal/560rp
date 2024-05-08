include("shared.lua")

local _acts = {
	"becon",
	"cheer",
	"agree",
	"wave",
};
local _lastAct = 0;

function ENT:Think()

	if self:getFlag("ownedBy", "") == LocalPlayer():SteamID() && _lastAct < CurTime() then
		
		LocalPlayer():ConCommand("act " .. _acts[math.random(#_acts)] );
		self:NextThink(15)

		_lastAct = CurTime()+15

	end
	
end

function ENT:Draw()
	self.Entity:DrawModel()
	self:Draw2DRepresentation()
end
surface.CreateFont("ShopTitleFont",{font = "Helvetica",size = ScreenScale(6),weight = 100,antialias = true})
surface.CreateFont("ShopMsgFont",{font = "Arial",size =ScreenScale(4),weight = 100,antialias = true})

function ENT:Draw2DRepresentation()

	local ang = LocalPlayer():EyeAngles()
	local posTru = self:GetPos() + self:GetAngles():Up() * 90 + self:GetAngles():Forward() * 25
	//local pos = self:GetPos() + ang:Up() * 1 + ang:Forward() * 1
	ang:RotateAroundAxis(ang:Forward(),90)
	ang:RotateAroundAxis(ang:Right(),90)
	
	local dist = self:GetPos():Distance(LocalPlayer():GetPos());
		
	local Alpha = 255;
					
	if (dist >= 300) then
		local moreDist = 550 - dist; 
		local percOff = moreDist / 250;
				
		self.Alpha = math.Clamp(255 * percOff,0,255);
	end
			
	local _ang = self:GetAngles();
	_ang:RotateAroundAxis(_ang:Forward(),90)
	_ang:RotateAroundAxis(_ang:Right(),-90)
	

	if LocalPlayer():GetPos():Distance( self:GetPos() ) < 1000 then
		local _equa = 5* math.sin(CurTime() );
		
		local _owner = player.GetBySteamID((self:getFlag("ownedBy","")) )

		local _locked = "";

		if self:getFlag("stallLock", false) == true then
			_locked = '[LOCKED] '
		end
		local _ownerTx = "Unamed Stall";

		if _owner then
			_ownerTx = _locked .. _owner:getFirstName() .. "'s Stall!"
		end
		local _msg = self:getFlag("stallMessage","");
		local _line2 = "";
		local _line1 = string.sub(_msg,1,40);
		if string.len(_msg) > 40 then
			_line2 = string.sub(_msg,41,72);
		end 
		cam.Start3D2D( posTru ,  Angle(_ang,_ang,0) , 0.5 )		

			draw.SimpleText( _ownerTx , "ShopTitleFont", 0, -25, Color(255,255,255,self.Alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			draw.SimpleText( _line1 , "ShopMsgFont", 0, 0, Color(255,255,255,self.Alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			draw.SimpleText( _line2 , "ShopMsgFont", 0, 10, Color(255,255,255,self.Alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
							
		cam.End3D2D()
		
	end
	
end

local SCREEN_W, SCREEN_H = 2560, 1440;

local _w, _h = ScrW( ), ScrH( );

local _wMod, _hMod = _w / SCREEN_W, _h / SCREEN_H;

if ScrW() == 3840 then
	_wMod=_w/2560//
	_hMod=_h/1444//
end
surface.CreateFont("CashRegisterTitle",{font = "Helvetica",size = ScreenScale(10),weight = 100,antialias = true})
surface.CreateFont("ConfirmationPanelButton",{font = "Helvetica",size = ScreenScale(12),weight = 100,antialias = true})
surface.CreateFont("CashRegisterSmall",{font = "Helvetica",size = ScreenScale(6),weight = 800,antialias = true})
surface.CreateFont("CashRegisterSmall_4k",{font = "Helvetica",size = ScreenScale(4),weight = 800,antialias = true})

local function lerpColor( _delta, _from , _to  )

	if _delta > 1 || _delta < 0 then return end
	
	local _retTbl = {}
	
	_retTbl.r	= _from.r + ( _to.r - _from.r ) * _delta;
	_retTbl.g	= _from.g + ( _to.g - _from.g ) * _delta;
	_retTbl.b	= _from.b + ( _to.b - _from.b ) * _delta;
		
	if _from.a && _to.a then
		_retTbl.a	= _from.a + ( _to.a - _from.a ) * _delta;
	end
	
	
	
	return _retTbl;
	
end

local gradientu = Material( 'vgui/gradient-u' ) -- cache before use!
local gradientd = Material( 'vgui/gradient-d' ) -- cache before use!
local function CashRegisterMenu( entInd )

	LocalPlayer():setFlag("restrictInv", true) 
	local ent = ents.GetByIndex( entInd );
	if ent == NULL then return end
	local _itemTb = {};
	//for i=1, (fsrp.config.ShopItemsPerColumn*fsrp.config.ShopItemColumns) do
		//_itemTb[i] = {1,100,1};
	//end 
	local _items = ent:getFlag("shopItems", _itemTb);
	//PrintTable(_itemTb);
	local BackDrop = vgui.Create( "DFrame" )
	BackDrop:Dock(FILL)
	BackDrop:Center()
	BackDrop:SetTitle("")
	BackDrop:ShowCloseButton(false)
	BackDrop:MakePopup()
	BackDrop.Alpha = 0;
	BackDrop.Alpha2 = 0;
	BackDrop.DoBeginning = true;
	BackDrop.FinBeginning = false;
	BackDrop.DoBeginning2 = false;
	BackDrop.OnClose = function( self )

		LocalPlayer():setFlag("restrictInv", false) 
		LocalPlayer().Stall = nil
		self.Ent = nil;
	end
	BackDrop.InventoryItemInformation = vgui.Create("DPanel", BackDrop)
	BackDrop.Ent = ent;
	function BackDrop:Paint( w , h )
	
		if self.DoBeginning && !self.FinBeginning then
		
			self.Alpha = Lerp( 0.1 , self.Alpha , 255 ) 
			
			if self.Alpha > 254 then
			
				self.DoBeginning = false;
			
			end
			
		end
		
		if !self.DoBeginning && !self.FinBeginning then
		
			self.DoBeginning2 = true
			self.FinBeginning = true;
		
		end
		
		if self.DoBeginning2 then
				
			self.Alpha2 = Lerp( 0.1 , self.Alpha2 , 255 ) 
			
			if self.Alpha2 > 254 then
			
				self.DoBeginning2 = false;
			
			end
			
		end
		
		surface.SetDrawColor( 56 ,56 ,56  , self.Alpha /2 ) 
		surface.DrawRect( 0,0, w , h )

		local x, y = self:GetPos()

		render.RenderView( {
			origin = ent:GetPos() + ent:GetForward()*100 + ent:GetUp() * 75,
			angles = ent:GetAngles()- Angle(-30,180,0),
			x = _wMod*0,y=_hMod*5,
			w = _wMod*300, h = _hMod*300,
		} )
		/*
		render.RenderView( {
			origin = ent:GetPos(),
			angles = ent:GetAngles(),
			x = _wMod*0,y=_hMod*5,
			w = _wMod*300, h = _hMod*300,
		} )
		render.RenderView( {
			origin = ent:GetPos(),
			angles = ent:GetAngles(),
			x = _wMod*0,y=_hMod*5,
			w = _wMod*300, h = _hMod*300,
		} )
		*/
	end

	local Frame = vgui.Create( "DPanel",BackDrop )
	Frame:SetSize( _wMod * 1000, _hMod * 800 )
	//if ScrW() == 3840 then
		//Frame:SetPos( (_wMod*(ScrW()/2))- (_wMod*500), ((ScrH()/2)*_hMod) - (_hMod*400))
	
	//else
		local FrameW = 800
		//if ScrW() == 3840 then
			//FrameW = 1440
		//end
		Frame:SetPos( _wMod*FrameW,_hMod*340)
	//end
	
	//Frame:MakePopup()
	//Frame:ShowCloseButton( false )
	BackDrop.Frame = Frame;
	Frame.Alpha = 0;
	Frame.Alpha2 = 0;
	Frame.DoBeginning = true;
	Frame.FinBeginning = false;
	Frame.DoBeginning2 = false;
	//Frame:SetTitle( "" )
	Frame.Owner = "";
	Frame.Locked = false;
	BackDrop.stallStatus = ent:getFlag("stallStatus",0);
	BackDrop.Locked = false
	function BackDrop:UpdateProperties( status , newlock)
		BackDrop.stallStatus =status;

		Frame.stallStatus = status;
		if ent:getFlag("ownedBy", "") == LocalPlayer():SteamID() then
			
			Frame.LockButton.stallStatus = status;
			Frame.ModifyButton.stallStatus = status;
			Frame.LockButton.Locked = newlock;
			Frame.ModifyButton.Locked = newlock;

		end
		
		Frame:SetRowEditDisabled( (status == 1) )
		
		BackDrop.Locked =newlock;

		Frame.Locked = newlock;
	end
	Frame.stallStatus = 0;
	Frame.OnRemove = function(self)

		net.Start( "cashRegister" )
			net.WriteInt(0,8);
		net.SendToServer(  ) 
		if BackDrop.ConfirmationPanel then
			BackDrop.ConfirmationPanel:Remove()
		end

		BackDrop:Close()
	end
	function Frame:Paint( w , h )
	
		if self.DoBeginning && !self.FinBeginning then
		
			self.Alpha = Lerp( 0.1 , self.Alpha , 255 ) 
			
			if self.Alpha > 254 then
			
				self.DoBeginning = false;
			
			end
			
		end
		
		if !self.DoBeginning && !self.FinBeginning then
		
			self.DoBeginning2 = true
			self.FinBeginning = true;
		
		end
		
		if self.DoBeginning2 then
				
			self.Alpha2 = Lerp( 0.1 , self.Alpha2 , 255 ) 
			
			if self.Alpha2 > 254 then
			
				self.DoBeginning2 = false;
			
			end
			
		end
		
		surface.SetDrawColor( 56 ,56 ,56  , self.Alpha ) 
		surface.DrawRect( 0,0, w , h )
		
		surface.SetDrawColor( 107,33 , 76, self.Alpha2 ) 		
		surface.SetMaterial(gradientu)
		surface.DrawTexturedRect( _wMod * 10, _hMod * 10, w  - _wMod * 20, h - _hMod * 320 )
		surface.SetMaterial(gradientd)
		//surface.SetDrawColor( 2, 153 , 57, self.Alpha2 ) 
		surface.DrawTexturedRect( _wMod * 10, h - _hMod * 330 , w  - _wMod * 20, _hMod * 320  )
		draw.NoTexture()

		surface.SetDrawColor(255,255,255,Frame.Alpha2)
		local _hAdju = ScrW() == 3840 && 50 || _hMod*65
		surface.DrawLine( _wMod * 20 , _hMod * _hAdju , w - _wMod * 20 , _hMod * _hAdju)
		surface.DrawLine( _wMod * 20 , _hMod * _hAdju+1 , w - _wMod * 20 , _hMod * _hAdju+1)
		//surface.DrawLine( _wMod * 20 , _hMod * _hAdju+2 , w - _wMod * 20 , _hMod * _hAdju+2)
		local _statusText = "Closed";
		if BackDrop.Locked == true then
			_statusText = "Locked From Inside."
		elseif BackDrop.stallStatus == 1 then
			_statusText = "Open For Business!"
		end
		draw.SimpleText( self.Owner .. "Stall -\t" .. _statusText, "CashRegisterTitle" , _wMod*25, _hMod * 12.5 , Color( 255 ,255 ,255 , Frame.Alpha2 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT ) 
		
	end

	if ent:getFlag("ownedBy", "" ) == LocalPlayer():SteamID() then
		Frame.ModifyButton = vgui.Create("DButton", Frame)
		Frame.ModifyButton:SetPos(Frame:GetWide()- (_wMod*275),_hMod*12.5)
		Frame.ModifyButton:SetSize(_wMod*135,_hMod*42)
		Frame.ModifyButton:SetText("")
		Frame.ModifyButton.Locked = false;
		Frame.ModifyButton.stallStatus = 0;
		function Frame.ModifyButton:Paint(w,h)

			surface.SetDrawColor( 56,56, 56 , Frame.Alpha2 )
			surface.DrawRect( 0,0,w, h )
			surface.SetDrawColor( 255,255, 255 , Frame.Alpha2 )
			
			surface.DrawRect((_wMod*4),(_hMod*4),w-(_wMod*8),h- (_hMod*8 ))

			local _text = "Open Stall";
			if self.stallStatus == 1 then
				_text = "Modify Stall"
			end
			local _font = "CashRegisterSmall";
			if ScrW() == 3840 then
				_font = "CashRegisterSmall_4k";
			end
			draw.SimpleText( _text ,_font ,w/2,h/2 , Color( 128 ,128 ,128 , Frame.Alpha2 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) 
			
		end

		Frame.LockButton = vgui.Create("DButton", Frame)
		Frame.LockButton:SetPos(Frame:GetWide()- (_wMod*400),_hMod*12.5)
		Frame.LockButton:SetSize(_wMod*135,_hMod*42)
		Frame.LockButton.Locked = false;
		Frame.LockButton:SetText("")
		function Frame.LockButton:OnMousePressed(k)
			if Frame.stallStatus == 0 then return end
			
			net.Start("cashRegister")
				net.WriteInt(3,8)
				net.WriteInt(2,3)// Toggle Lock The Stall
			net.SendToServer()

		end
		function Frame.ModifyButton:OnMousePressed(k)
			
			net.Start("cashRegister")
				net.WriteInt(3,8)
				net.WriteInt(1,3)// Toggle Modify The Stall
			net.SendToServer()

		end
		Frame.LockButton.stallStatus = 0;
	
		function Frame.LockButton:Paint(w,h)

			surface.SetDrawColor( 56,56, 56 , Frame.Alpha2 )
			surface.DrawRect( 0,0,w, h )

			local _text = "Lock";
			if self.Locked == true then
				_text = "Unlock"
				surface.SetDrawColor( 255,255, 255 , Frame.Alpha2 )
			elseif self.stallStatus == 0 then
				surface.SetDrawColor( 128,128, 128 , Frame.Alpha2 )
			else
				surface.SetDrawColor( 255,255, 255 , Frame.Alpha2 )
			end
			surface.DrawRect((_wMod*4),(_hMod*4),w-(_wMod*8),h- (_hMod*8 ))

			local _font = "CashRegisterSmall";
			if ScrW() == 3840 then
				_font = "CashRegisterSmall_4k";
			end
			draw.SimpleText(_text, _font ,w/2,h/2 , Color( 128 ,128 ,128 , Frame.Alpha2 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) 
			
		end
	end
	
	Frame.CloseButton = vgui.Create("DButton", Frame)
	Frame.CloseButton:SetPos(Frame:GetWide()- (_wMod*150),_hMod*12.5)
	Frame.CloseButton:SetSize(_wMod*135,_hMod*42)
	Frame.CloseButton:SetText("")
	function Frame.CloseButton:Paint(w,h)

		surface.SetDrawColor( 56,56, 56 , Frame.Alpha2 )
		surface.DrawRect( 0,0,w, h )
		local _Col = Color( 128 ,128 ,128 , Frame.Alpha2 );
		if LocalPlayer():SteamID()==ent:getFlag("ownedBy","") then
			
			
			if Frame.stallStatus != 1 && Frame.Locked != true  then
				surface.SetDrawColor( 255,255, 255 , Frame.Alpha2 )
			else
				surface.SetDrawColor( 128,128, 128 , Frame.Alpha2 )
				_Col = Color(128,128,128,Frame.Alpha2)
			end
		
		else
				surface.SetDrawColor( 255,255, 255 , Frame.Alpha2 )

		end
		
		surface.DrawRect((_wMod*4),(_hMod*4),w-(_wMod*8),h- (_hMod*8 ))
			local _font = "CashRegisterSmall";
			if ScrW() == 3840 then
				_font = "CashRegisterSmall_4k";
			end
		draw.SimpleText( "Close Stall",_font,w/2,h/2 , _Col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) 
		
	end

	function Frame.CloseButton:OnMousePressed()
		if LocalPlayer():SteamID()==ent:getFlag("ownedBy","")  && (Frame.stallStatus != 0 || Frame.Locked == true) then return LocalPlayer():Notify("You can't close your stall while its open/locked!") end
		Frame:Remove()
	end	
	Frame.Rows = {};

	function Frame:ClearRows()

		if #Frame.Rows > 0 then
			
			for k , v in pairs( Frame.Rows ) do
				
				if ispanel(v) then
					v:Remove()
				end

			end

		end
		self:UpdateShopItems()
	end
	
	function Frame:SetRowEditDisabled( newDisabled )

		if #Frame.Rows > 0 then
			
			for k , v in pairs( Frame.Rows ) do
				
				if ispanel(v) then
					if v.EditBuyButton then
						
						v.EditBuyButton:SetDisabled(newDisabled)

					end

				end

			end

		end
	end
	
	BackDrop.InventoryItemInformation.Model = vgui.Create( "DModelPanel", BackDrop.InventoryItemInformation )
	FRAMEmdl = BackDrop.InventoryItemInformation.Model

	function Frame:UpdateShopItems()

		_items = BackDrop.Ent:getFlag("shopItems", _itemTb);
		//PrintTable(_items)
		if player.GetBySteamID(ent:getFlag("ownedBy", "")) then
			self.Owner = player.GetBySteamID(ent:getFlag("ownedBy", "")):getFirstName() .. "'s " || "";
		end
		if #Frame.Rows >0 then
			for k , v in pairs( Frame.Rows ) do 
				v:Remove()
			end
		end
		Frame.Rows = {};
		local CountedAmount = 1;
		for k=1, fsrp.config.ShopItemColumns do
				
			local ShopColumn = vgui.Create( "DPanel", Frame )
			ShopColumn:SetPos( _wMod * (40 + ((k-1)*(450))+ ((k-1)*(20)) ), _hMod * 75 )
			ShopColumn:SetSize( _wMod * 450 , _hMod * 400)
			ShopColumn.Number = k;

			//table.insert(SHOP_ITEM_COLUMNS, ShopColumn);
			function ShopColumn:Paint( w , h )

				//surface.SetDrawColor( 255, 255, 255 , Frame.Alpha2 )
				//surface.DrawRect( 0,0 ,w , h )

			end

			ShopColumn.ScrollPanel = vgui.Create("DScrollPanel", ShopColumn)
			ShopColumn.ScrollPanel:Dock(FILL)

			for x=1, fsrp.config.ShopItemsPerColumn do

				ShopColumn.ScrollPanel.Row = vgui.Create("DButton",ShopColumn.ScrollPanel);
				//ShopColumn.ScrollPanel.Row:SetSize( _wMod*95,_hMod*95)

				local _row = ShopColumn.ScrollPanel.Row;
				_row:Dock(TOP)

				//_row:DockPadding(0,(_hMod*5),0,(_hMod*5))
				_row:SetTall(_hMod*80)
				_row:SetWide(ShopColumn:GetWide())
				_row.Index = CountedAmount;
				_row.IndexSlot = _items[_row.Index]//_items[_row.Index]
				CountedAmount = CountedAmount+1;
				_row.Price = 0;
				_row.ID = 0;
				_row.Amount = 1;
				if istable(_row.IndexSlot) then
					_row.ID = _row.IndexSlot.ID;
					_row.Amount = _row.IndexSlot.Amount;
					_row.Price = _row.IndexSlot.Price;
				end
				_row:SetText("")
				_row.PressedColor = Color(56,56,56,Frame.Alpha2)
				_row.HoveredColor = Color(75,75,75,Frame.Alpha2)
				_row.NormalColor = Color(255,255,255,Frame.Alpha2)
				_row.CurrentColor = Color(0,0,0,Frame.Alpha2);
				_row.Pressed = false;
				_row.TargetMDL = FRAMEmdl;
				function _row:OnMousePressed(k)

					self.Pressed = true;

				end
				function _row:OnMouseReleased(k)

					for k , v in pairs(Frame.Rows) do
						v.Pressed = false;
					end

					if ent:getFlag("stallStatus",0) == 0 then return end
					if ent:getFlag("ownedBy","") == LocalPlayer():SteamID() then return end
					
					if self:IsHovered() && self.IndexSlot then
						
						BackDrop:MakeEditPanel(BackDrop,self.Index,{self.IndexSlot.Amount,self.IndexSlot.Price, true},function(_foundRow,_amount,_price)
								
							net.Start("cashRegister")
								net.WriteInt( 7, 8)
								net.WriteInt(self.Index,16)
							net.SendToServer()

						end)

					end

				end

				function _row:Think()
					if self.IndexSlot && self.IndexSlot.ID && self:IsHovered() then

						if BackDrop && BackDrop.InventoryItemInformation && BackDrop.InventoryItemInformation.InvPanel && BackDrop.InventoryItemInformation.Model &&  BackDrop.InventoryItemInformation.Model:GetModel() != ITEMLIST[self.IndexSlot.ID].Model then
													
							local _id = self.IndexSlot.ID;
							local _item = ITEMLIST[_id];
							
							BackDrop.InventoryItemInformation.InvPanel.SelectedText = _item.Name .. " ($" .. _item.Cost .. ")";
							BackDrop.InventoryItemInformation.InvPanel.SelectedDesc = _item.Description;
						
							BackDrop.InventoryItemInformation.Model:SetModel(_item.Model)
							BackDrop.InventoryItemInformation.Model:SetCamPos(_item.CamPos)
							BackDrop.InventoryItemInformation.Model:SetLookAt(_item.LookAt)

						end
						
					end
				end
				
				function _row:Paint(w,h)

					if input.IsMouseDown(MOUSE_LEFT) && self:IsHovered() then
						surface.SetDrawColor( 165, 128, 128 , Frame.Alpha2 )

					elseif self:IsHovered() then

						surface.SetDrawColor( 165, 165, 128 , Frame.Alpha2 )
						
					else
						surface.SetDrawColor( 128, 128, 128 , Frame.Alpha2 )

					end
					
					surface.DrawRect( 0,0 ,w , h-(_hMod*5) )
					
					surface.SetDrawColor( 255,255, 255 , Frame.Alpha2 )
					surface.DrawRect( 0, 0, (_row:GetWide()), _hMod*32 )

					surface.SetDrawColor( 73,76, 153 , Frame.Alpha2 )
					surface.DrawRect( _wMod*2, _hMod*2, (_row:GetWide()-_row:GetTall()) - _wMod*4, _hMod*30 )
					local _font = "CashRegisterSmall";
					if ScrW() == 3840 then
						_font = "CashRegisterSmall_4k";
					end
					if ITEMLIST[_row.ID] then
						local _item = ITEMLIST[_row.ID];
						local _price = _row.IndexSlot.Price || 0;
						local _am = _row.IndexSlot.Amount || 0;

						draw.SimpleText( _item.Name,_font , _wMod* (w/2- _row:GetTall()), _hMod * 3 , Color( 255 ,255 ,255 , Frame.Alpha2 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT ) 
					
						draw.SimpleText( "$" .. math.ceil(_price) , _font , _wMod* 345,_hMod*40 , Color( 255 ,255 ,255 , Frame.Alpha2 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_RIGHT ) 
						
						draw.SimpleText( "# Units: " .. math.ceil(_am) , _font , _wMod* 5, _hMod * 40 , Color( 255 ,255 ,255 , Frame.Alpha2 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT ) 
					else

						draw.SimpleText( "No Item", _font , _wMod* (w/2- _row:GetTall()), _hMod * 3, Color( 255 ,255 ,255 , Frame.Alpha2 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT ) 
						draw.SimpleText( "$0",_font, _wMod* 350,_hMod*40 , Color( 255 ,255 ,255 , Frame.Alpha2 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_RIGHT ) 
						
						draw.SimpleText( "# Units: 0" , _font , _wMod*5, _hMod * 40 , Color( 255 ,255 ,255 , Frame.Alpha2 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT ) 
				
					end

				end

				local _owner = ent:getFlag("ownedBy", "")

				if _owner == LocalPlayer():SteamID() then

					_row.EditBuyButton = vgui.Create("DButton", _row)
					_row.EditBuyButton:SetSize(_wMod*32,_hMod*32)
					_row.EditBuyButton:SetText("")
					_row.EditBuyButton.Image = Material( "icon16/email_edit.png" );
					_row.EditBuyButton.CapturingInventoryItem = false;
					_row.EditBuyButton.Index = _row.Index
					_row.EditBuyButton.row = _row

					function _row.EditBuyButton:Paint(w,h)

						surface.SetDrawColor( 56,56, 56 , Frame.Alpha2 )
						surface.DrawRect( 0,0,_wMod*32, _hMod*32 )
						if (self:GetDisabled() == true || self.CapturingInventoryItem == true) || self:IsHovered() && !input.IsMouseDown(MOUSE_LEFT) then
							surface.SetDrawColor( 128,128, 128 , Frame.Alpha2 )
						else
							surface.SetDrawColor( 255,255, 255 , Frame.Alpha2 )
						end
						surface.DrawRect(_wMod*1,_hMod*1,_wMod*30, _hMod*30 )
						surface.SetMaterial(self.Image )
						surface.DrawTexturedRect(_wMod*3.5,_hMod*3.5,_wMod*25, _hMod*25 )

					end
					function _row.EditBuyButton:OnMousePressed(k)
						if self:GetDisabled() == true then return end
						if Frame.stallStatus != 0 then return end
						if ent:getFlag("ownedBy","") != LocalPlayer():SteamID() then return end
						
						local _found = 0;
						for k , v in pairs( Frame.Rows) do 
							if v && v.EditBuyButton && v.EditBuyButton.CapturingInventoryItem == true  then
								v.EditBuyButton:SetDisabled(false)
								v.EditBuyButton.CapturingInventoryItem = false;
								_found = _found + 1;
							end
						end
						local _foundCapture = false;

						if self.CapturingInventoryItem == true then
							
							self.CapturingInventoryItem = false
							if BackDrop.InventoryBackground._Player1InvGrid then
												
								for k , v in pairs( BackDrop.InventoryBackground._Player1InvGrid:GetChildren() ) do
														
									v:SetDisabled(true)
												
								end
													
							end
							return
						end

						if BackDrop.InventoryBackground._Player1InvGrid then
											
							for k , v in pairs( BackDrop.InventoryBackground._Player1InvGrid:GetChildren() ) do
													
								v:SetDisabled(true)
											
							end
												
						end

						if _found > 1 then
							return
						end
						/*

						for k , v in pairs( Frame.Rows ) do 
							if v && v.EditBuyButton then
								
								if v.CapturingInventoryItem == true then
									_foundCapture = true;
								end

							end

						end
						*/
						//if _foundCapture then return end
						local Menu = DermaMenu() 
						Menu:SetPos(gui.MousePos())
						Menu.Row = _row
						if Menu.Row.IndexSlot && Menu.Row.IndexSlot.ID then
							local _RemOption = Menu:AddOption( "Remove", function()
							
								net.Start("cashRegister")
									net.WriteInt(6,8)
									net.WriteInt(self.Index,8)
									net.WriteInt(self.row.IndexSlot.Amount,32)
									net.WriteInt(Menu.Row.Price,32)
								net.SendToServer()

								if BackDrop.InventoryBackground._Player1InvGrid then
											
									for k , v in pairs( BackDrop.InventoryBackground._Player1InvGrid:GetChildren() ) do
													
										v:SetDisabled(true)
											
									end
												
								end
							end )
							_RemOption:SetIcon("icon16/pencil_delete.png")
							Menu:AddSpacer()
						end
					
						local _EditOption = Menu:AddOption( "Edit" , function()

							if Menu.Row.IndexSlot && Menu.Row.IndexSlot.ID then

								BackDrop:MakeEditPanel(BackDrop,Menu.Row.Index,{Menu.Row.IndexSlot.Amount,Menu.Row.IndexSlot.Price},function(_foundRow,_amount,_price)
								
									net.Start("cashRegister")
										net.WriteInt(6,8)
										net.WriteInt(_foundRow,8)
										net.WriteInt(_amount,32)
										net.WriteInt(_price,32)
									net.SendToServer()
								
									if BackDrop.InventoryBackground._Player1InvGrid then
												
										for k , v in pairs( BackDrop.InventoryBackground._Player1InvGrid:GetChildren() ) do
														
											v:SetDisabled(false)
												
										end
													
									end
								end)

								BackDrop.PopupEdit = vgui.Create("DFrame")

								

							else

								self.CapturingInventoryItem = true;

								if BackDrop.InventoryBackground._Player1InvGrid then
											
									for k , v in pairs( BackDrop.InventoryBackground._Player1InvGrid:GetChildren() ) do
													
										v:SetDisabled(false)
											
									end
												
								end
							
							end
							
						end)

						_EditOption:SetIcon("icon16/pencil_add.png")
						
						Menu:Open()
						/*
						self.CapturingInventoryItem = true;

						if BackDrop.InventoryBackground._Player1InvGrid then
									
							for k , v in pairs( BackDrop.InventoryBackground._Player1InvGrid:GetChildren() ) do
											
								v:SetDisabled(false)
									
							end
										
						end
						*/
					end

				end
				
				_row.ModelIcon = vgui.Create("DPanel", _row )
				_row.ModelIcon:SetWide(_row:GetTall());
				_row.ModelIcon:SetTall(_row:GetTall());
				_row.ModelIcon:SetPos(_row:GetWide()- (_row:GetTall()), 0) ;
				_row.ModelIcon:SetVisible(true);
				_row.ModelIcon.ParentRow = _row;
				_row.ModelIcon:SetText("");

				function _row.ModelIcon:Paint(w,h)

					surface.SetDrawColor( 255,255,255,Frame.Alpha2 )
					surface.DrawRect( 0,0 ,w , h-(_hMod*5) )

				end			
				_row.ModelIcon:DockPadding((_hMod*5),(_hMod*5),(_hMod*5),(_hMod*5))
				_row.ModelIcon:MoveToBefore()
				_row.ModelIcon.Model = vgui.Create("DModelPanel", _row.ModelIcon)
				_row.ModelIcon.Model:Dock(FILL)
				function _row.ModelIcon.Model:LayoutEntity( Entity )  Entity:SetModelScale(1) return end

				function _row:RefreshItem(  )

					if istable( _row.IndexSlot ) then
						
						local _ItemID = _row.IndexSlot.ID;
						local _Price = _row.IndexSlot.Amount;
						local _Amount = _row.IndexSlot.Price;

						if !ITEMLIST[_ItemID] then return end

						local _ItemInList = ITEMLIST[_ItemID];

						self.Price = _Price;
						self.ID = _ItemID;
						self.Amount = _Amount;

						if _ItemInList.Model then
							self.ModelIcon:SetVisible(true);
							self.ModelIcon.Model:SetModel(_ItemInList.Model);
							if _ItemInList.CamPos then
								self.ModelIcon.Model:SetCamPos(_ItemInList.CamPos);
							end
							if _ItemInList.LookAt then
								self.ModelIcon.Model:SetLookAt(_ItemInList.LookAt);
							end
							
						end

					end

				end// _row:Refresh();
				_row:RefreshItem(  );
				table.insert(Frame.Rows , _row);
			end

		end

	end
	

	Frame:UpdateShopItems();
	Frame.ChatBorder = vgui.Create("DPanel", Frame)
	Frame.ChatBorder:SetSize( Frame:GetWide() - _wMod*40 , _hMod*250 )
	//Frame.ChatBorder:SetPos( _wMod * 20 , ( Frame:GetTall() - ( _hMod * 215 ) ) )
	Frame.ChatBorder:Dock(BOTTOM)
	Frame.ChatBorder:DockMargin(10,10,10,10)

	Frame.AnnouncementBar = vgui.Create("DPanel", Frame )
	Frame.AnnouncementBar:SetSize( Frame:GetWide() - _wMod*40 , _hMod*42 )
	//Frame.ChatBorder:SetPos( _wMod * 20 , ( Frame:GetTall() - ( _hMod * 215 ) ) )
	Frame.AnnouncementBar:Dock(BOTTOM)
	Frame.AnnouncementBar:DockMargin(10,10,10,0)
	Frame.AnnouncementBar.Text = ent:getFlag("stallMessage", "Test");

	if LocalPlayer():SteamID() == ent:getFlag("ownedBy","") then
		
		
		Frame.AnnouncementBar.AnnouncementEdit = vgui.Create("DButton", Frame.AnnouncementBar)
		//Frame.AnnouncementBar.AnnouncementEdit:SetSize(_wMod*60,_hMod*56)
		
		//Frame.AnnouncementBar.AnnouncementEdit:Dock(LEFT)
		Frame.AnnouncementBar.AnnouncementEdit:SetPos(0,0)

		Frame.AnnouncementBar.AnnouncementEdit:SetText("")
		Frame.AnnouncementBar.AnnouncementEdit:SetTall(_hMod*42)
		Frame.AnnouncementBar.AnnouncementEdit:SetWide(_wMod*42)
		Frame.AnnouncementBar.AnnouncementEdit.Image = Material( "icon16/email_edit.png" );
		Frame.AnnouncementBar.Entry = vgui.Create("DTextEntry", Frame.AnnouncementBar)
		Frame.AnnouncementBar.Entry:Dock(FILL)
		Frame.AnnouncementBar.Entry:DockMargin(32,0,0,0)
		Frame.AnnouncementBar.Entry:SetText( Frame.AnnouncementBar.Text )
		Frame.AnnouncementBar.Entry:SetVisible(false)
		Frame.AnnouncementBar.AnnouncementEdit.OnMousePressed = function( self , k )

			Frame.AnnouncementBar.Entry:SetVisible(true)
			Frame.AnnouncementBar.Entry:RequestFocus()

		end
		
		Frame.AnnouncementBar.Entry.OnEnter = function(self)

			net.Start("cashRegister")
				net.WriteInt(4,8)
				net.WriteString(string.sub(self:GetValue(),1,72))
			net.SendToServer()

			self:SetVisible(false)
		end
		
		Frame.AnnouncementBar.Entry.OnMousePressed = function(self)

			self:SetText("")
		end
		

		function Frame.AnnouncementBar.AnnouncementEdit:Paint(w,h)

			surface.SetDrawColor( 56,56, 56 , Frame.Alpha2 )
			surface.DrawRect( 0,0,w, h )
			if self:IsHovered() && !input.IsMouseDown(MOUSE_LEFT) then
				surface.SetDrawColor( 128,128, 128 , Frame.Alpha2 )
			else
				surface.SetDrawColor( 255,255, 255 , Frame.Alpha2 )
			end
			surface.DrawRect( 1,1,w-2, h-2 )
			surface.SetMaterial(self.Image )
			surface.DrawTexturedRect(2,2,w-4,h-4)

		end
	end
	function BackDrop:UpdateAnnouncementText(tx)
		Frame.AnnouncementBar.Text = tx;
		Frame.AnnouncementBar.Entry:SetText(tx);
		Frame.AnnouncementBar.Entry:SetVisible(false)
	end	 
	function Frame.AnnouncementBar:Paint(w,h)

		surface.SetDrawColor( 255,255, 255 , Frame.Alpha2 )
		surface.DrawRect( 0,0,w,h )		
		local _font = "CashRegisterSmall";
			if ScrW() == 3840 then
				_font = "CashRegisterSmall_4k";
			end

		local _line1 = string.sub( Frame.AnnouncementBar.Text,1,40);
		local _line2 = "";
		draw.SimpleText(_line1 ,_font, w/2,_hMod*9, Color( 56 ,56 ,56 , Frame.Alpha2 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) 
		
		if string.len(self.Text) > 40 then
			_line2 = string.sub( Frame.AnnouncementBar.Text,41,72) || "";
			draw.SimpleText( _line2 ,_font, w/2,h/2+(_hMod*10), Color( 56 ,56 ,56 , Frame.Alpha2 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) 
		end 

				
	end


	function Frame.ChatBorder:Paint(w,h)

		surface.SetDrawColor( 255, 255, 255 , Frame.Alpha2 )
		surface.DrawRect( 0,0 ,w , h )

	end
	Frame.ChatRecord = {};
	function BackDrop:AddChatRecord( _authcol, _textcol, _authorname, _authorstring )

		if Frame && Frame.ChatRecord then
			table.insert( Frame.ChatRecord, {CurTime(),_authorname, _authcol, string.Left(_authorstring,72),_textcol })
		end

	end
	
	function Frame:UpdateChat()

		Frame.ChatBorder.ChatVisual = vgui.Create("DPanel", Frame.ChatBorder)
		local _StallChat = Frame.ChatBorder.ChatVisual;
		_StallChat:Dock(FILL)
		local chatBox = { Record = Frame.ChatRecord , LinesToShow = 7};

		local ChatEntry = vgui.Create( "DTextEntry", _StallChat ) -- create the form as a child of frame
		ChatEntry:SetPos( _wMod*10, _hMod*207.5 )
		ChatEntry:SetSize( Frame.ChatBorder:GetWide()- (_wMod*20) , _hMod*35 )
		ChatEntry:SetText( "Chat" )
		ChatEntry.OnEnter = function( self )
			//chat.AddText( self:GetValue() )	-- print the form's text as server text
			if self:GetValue() == "" then return TextEntryLoseFocus() end
			net.Start("cashRegister")
				net.WriteInt(2,8)
				net.WriteString(self:GetValue())
			net.SendToServer()
			self:SetText("")
		end
		ChatEntry:SetFont( "ChatFont" )
		function ChatEntry:OnChange(text)
			//chat.AddText( self:GetValue() )	-- print the form's text as server text
			
			if string.len(self:GetValue()) > 72 then
				self:SetText(string.Left(self:GetValue(),72))
				TextEntryLoseFocus()
			end
		end
		ChatEntry.OnMousePressed = function( self )
			//chat.AddText( self:GetValue() )	-- print the form's text as server text
			
			if self:GetValue() == "Chat" then
				self:SetText("")
			end
		end
		function _StallChat:Paint(w,h)
			local border = 0;
			local availableWidth = _StallChat:GetWide();
			local widthPer = (_wMod * 100);
			local heightPer = widthPer * .33;
			
			// Chat 
			local xBuffer =_wMod * 100;
			local ChatFont = "ChatFont"
			
			surface.SetFont(ChatFont);
			local _, y = surface.GetTextSize("what");
			local startY = _StallChat:GetTall() - border * 10 - heightPer - y - 8+ _hMod * 35;
			
			if (#chatBox.Record > 0) then
				for i = math.Clamp(#chatBox.Record - chatBox.LinesToShow, 1, #chatBox.Record), #chatBox.Record do
					local tab = chatBox.Record[i];
					
					if (chatBox.IsOpen || tab[1] + 15 >= CurTime()) then
						local Alpha = 255;
						
						if (!chatBox.IsOpen && tab[1] + 10 < CurTime()) then
							local TimeLeft = tab[1] + 15 - CurTime();
							Alpha = (255 / 5) * TimeLeft;
						end

						local posX, posY = xBuffer, startY - y * (1.5 + (#chatBox.Record - i));
						
						if tab[3] then
							local col = Color(tab[3].r, tab[3].g, tab[3].b, Alpha);
							
							draw.SimpleText(string.sub(tab[2],1,10) .. ": ", ChatFont, posX + 1, posY + 1, Color(0, 0, 0, Alpha), 2);
							//draw.SimpleText(tab[2] .. ": ", ChatFont, posX + 1, posY + 1, Color(0, 0, 0, Alpha), 2);
							
							if (tab[6]) then
								local Cos = math.abs(math.sin(CurTime() * 2));
								
								draw.SimpleTextOutlined(string.sub(tab[2],1,10)  .. ": ", ChatFont, posX, posY, col, 2, 0, 1, Color(Cos * tab[6].r, Cos * tab[6].g, Cos * tab[6].b, math.Clamp(Alpha * Cos, 0, 255)));
								//draw.SimpleTextOutlined(tab[2] .. ": ", ChatFont, posX, posY, col, 2, 0, 1, Color(Cos * tab[6].r, Cos * tab[6].g, Cos * tab[6].b, math.Clamp(Alpha * Cos, 0, 255)));
							else
								draw.SimpleText(string.sub(tab[2],1,10)  .. ": ", ChatFont, posX, posY, col, 2);
								//draw.SimpleText(tab[2] .. ": ", ChatFont, posX, posY, col, 2);
							end
						end
						
						local col = Color(tab[5].r, tab[5].g, tab[5].b, Alpha);
						draw.SimpleText(tab[4], ChatFont, posX + 1, posY + 1, Color(0, 0, 0, Alpha));
						//draw.SimpleText(tab[4], ChatFont, posX + 1, posY + 1, Color(0, 0, 0, Alpha));
						draw.SimpleText(tab[4], ChatFont, posX, posY, col);
						//draw.SimpleText(tab[4], ChatFont, posX, posY, col);
					end
				end
			end
		end
		
	end
	
	Frame:UpdateChat()

	
	local _fx, _fy = Frame:GetPos()
	
	BackDrop.InventoryItemInformation:SetPos( 0,_hMod*340 )
	BackDrop.InventoryItemInformation:SetSize(_fx, (_hMod*800))
	// BackDrop.InventoryItemInformation.Model = vgui.Create( "DModelPanel", BackDrop.InventoryItemInformation )
	// FRAMEmdl = BackDrop.InventoryItemInformation.Model
	FRAMEmdl:SetSize(_wMod*750, _hMod*750)
	FRAMEmdl:SetModel("models/Error.mdl");
	//FRAMEmdl:Dock(LEFT)
	FRAMEmdl:MoveToBack()
	local buttonSize = _wMod * 104;	
	//if ScrW() == 3840 then
		//buttonSize = _wMod*194
	//end
	FRAMEmdl:Center()
	local _InvPanel = vgui.Create("DPanel", BackDrop)
	//_InvPanel:Dock(RIGHT)
	BackDrop.InventoryItemInformation.InvPanel = _InvPanel
	_InvPanel:SetPos( Frame:GetWide()+_fx,_hMod*340 )
	_InvPanel:SetTall( (_hMod*800))
	_InvPanel:SetWide(ScrW() - (Frame:GetWide()+_fx))
	_InvPanel.Paint = function(self,w,h) 

			surface.SetDrawColor( 0,0, 0 , BackDrop.Alpha2 )
			surface.DrawRect( 0,0,w,h )
			surface.SetDrawColor( 56,56, 56 , BackDrop.Alpha2 )
			surface.DrawRect( _wMod*2,_hMod*2,w-(_wMod*4),h- (_hMod*4) )

	end
	_InvPanel.SelectedText = "";
	_InvPanel.SelectedDesc = "";
	BackDrop.InventoryBackground = _InvPanel;

	BackDrop.InventoryItemInformation.InvPanel= _InvPanel;
	FRAMEmdl.Information = vgui.Create("DPanel", FRAMEmdl);
	FRAMEmdl.Information:Dock(FILL)
	FRAMEmdl.Information.InvPanel= _InvPanel;
	
	function FRAMEmdl.Information:Paint(w,h)

		local _font = "CashRegisterSmall";
			if ScrW() == 3840 then
				_font = "CashRegisterSmall_4k";
			end
		draw.SimpleText( self.InvPanel.SelectedText ,_font , _wMod*20,_hMod*50 , Color( 255 ,255 ,255 , BackDrop.Alpha2 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT ) 
		draw.SimpleText( self.InvPanel.SelectedDesc, _font ,_wMod*10,_hMod*85 , Color( 255 ,255 ,255 , BackDrop.Alpha2 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT ) 
	end
			

	function BackDrop.InventoryItemInformation:Paint(w,h)

			surface.SetDrawColor( 0,0, 0 , BackDrop.Alpha2 )
			surface.DrawRect( 0,0,w,h )
			surface.SetDrawColor( 56,56, 56 , BackDrop.Alpha2 )
			surface.DrawRect( _wMod*2,_hMod*2,w-(_wMod*4),h- (_hMod*4) )

	end
			
	local _Player1Inv = vgui.Create( "DScrollPanel" , _InvPanel)
	//_Player1Inv:SetSize(_wMod*500,ScrH())
	//_Player1Inv:SetPos( _InvPanel:GetWide()/1.5 + 10 , _hMod * 50 )
	_Player1Inv:Dock(FILL)
	local _Player1InvGrid = vgui.Create( "DGrid", _Player1Inv )
	_Player1InvGrid:Dock(FILL)
	_Player1InvGrid:SetCols( 7 )
	_Player1InvGrid:SetColWide( buttonSize  + (_wMod*2))
	_Player1InvGrid:SetRowHeight( buttonSize + (_hMod*2) )
	_InvPanel._Player1InvGrid = _Player1InvGrid
	function BackDrop:UpdateInventoryItems()

		if _InvPanel._Player1InvGrid then
					
			for k , v in pairs( _InvPanel._Player1InvGrid:GetChildren() ) do
							
							
				v:SetItemTable()
					
			end
						
		end

	end

	local MAX_SLOTS = fsrp.config.InventoryWSlots * fsrp.config.InventoryYSlots; 
	for i = 1, MAX_SLOTS do
	
		butCache = vgui.Create("DButton", _Player1Inv )
		butCache.ID = i;
		butCache.InventorySlotCache = LoadStringToInventory(LocalPlayer():getFlag("inventory", nil ))

		butCache.TargetMDL = FRAMEmdl
		butCache:SetText("")
		
		butCache:SetSize( buttonSize,buttonSize)
		butCache:SetTextColor( Color( 255 ,255 ,255 , _InvPanel.Alpha ) )
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

				self.mdl:SetMouseInputEnabled(false)
				//local iSeq = self.mdl.Entity:LookupSequence('ragdoll')
			
				//self.mdl.Entity:ResetSequence(iSeq)
				

				//self:MoveToFront()
				end
			end
		end
		//butCache:SetItemTable()
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
				
				
				if ent:getFlag("ownedBy","") != LocalPlayer():SteamID() then return LocalPlayer():Notify("You may not modify someone elses stall.") end
				local _foundRow;
				for k , v in pairs( Frame.Rows ) do 
					if v && v.EditBuyButton then
						
						if v.EditBuyButton.CapturingInventoryItem == true then
							// Send the StallSlot & Inventory Slot
							//LocalPlayer():Notify("Found stall slot to capture us, sending to stall.")
							
							_foundRow = k;

							v.EditBuyButton.CapturingInventoryItem = false;
						end

					end

				end

				if self:GetDisabled() == true || _foundRow == nil then 
					return
				else
					if _InvPanel._Player1InvGrid then
						
						for k , v in pairs( _InvPanel._Player1InvGrid:GetChildren() ) do
										
							v:SetDisabled(true)
								
						end
									
					end

					if _foundRow != nil then

						BackDrop:CreateConfirmationPanel(BackDrop,{self.ID,_foundRow},function( ID, _foundRow, _amount, _price )
						
							net.Start("cashRegister")
								net.WriteInt(5,8)
								net.WriteInt(ID,16)
								net.WriteInt(_foundRow,8)
								net.WriteInt(_amount,32)
								net.WriteInt(_price,32)
							net.SendToServer()

						end )
						

					end
					
					timer.Simple( 1, function()
						
						if !_InvPanel then return end
						if LocalPlayer().Stall && IsValid(LocalPlayer().Stall) then
						
							BackDrop:UpdateInventoryItems();
						
						end
						
					end )
				end
			//end
			
		end
		
		butCache:SetDisabled(true)
		function butCache:Paint( w, h )
		
			if self.InventorySlotCache[self.ID]	then
			
			local _Item = ITEMLIST[self.InventorySlotCache[self.ID].ID];
				
				if self:GetDisabled() == true then
										
					surface.SetDrawColor( 255 ,0 ,0 ,Frame.Alpha  )
					surface.DrawOutlinedRect( 0, 0, w, h )
					

				elseif _Item.RestrictPlayerTrade then
					
					
					surface.SetDrawColor( 255 ,0 ,0 ,Frame.Alpha  )
					surface.DrawOutlinedRect( 0, 0, w, h )
					
					
					
				else
					
						surface.SetDrawColor( 255 ,255 ,255,Frame.Alpha   )
						
						surface.DrawOutlinedRect( 0, 0, w, h )
					
				
				
				end
				
				//draw.SimpleText( self.InventorySlotCache[self.ID].Amount .. "x" , "Trebuchet20", 12.5, 10, Color(255,255,255, FRAME.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				
				if self:IsHovered() && self.TargetMDL:GetModel() != ITEMLIST[self.InventorySlotCache[self.ID].ID].Model then
					
					
					self.TargetMDL:SetModel( _Item.Model )
					self.TargetMDL:SetCamPos( _Item.CamPos )
					self.TargetMDL:SetLookAt( _Item.LookAt )
					_InvPanel.SelectedText = _Item.Name .. " ($" .. _Item.Cost .. ")";
					_InvPanel.SelectedDesc = _Item.Description;

				end
				
			else
			
					surface.SetDrawColor( 128 ,128,128,Frame.Alpha   )
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
			
				draw.SimpleText( self.InventorySlotCache[self.ID].Amount .. "x" , "Trebuchet24", 12.5, 10, Color(255,255,255, _InvPanel.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			
			end	
		end
				
		_Player1InvGrid:AddItem( butCache )
		
	end	
	BackDrop:UpdateInventoryItems()

	//BackDrop:CreateConfirmationPanel({self.ID,_foundRow},function( ID, _foundRow, _amount )
	function BackDrop:CreateConfirmationPanel(BackDrop,PassThroughInformation, callback)//function( ID, _foundRow, _amount )

		BackDrop.ConfirmationPanel = vgui.Create("DFrame")

		BackDrop.ConfirmationPanel:SetSize(_wMod*300, _hMod*300)
		BackDrop.ConfirmationPanel:Center()
		BackDrop.ConfirmationPanel:MakePopup()
		BackDrop.ConfirmationPanel:MoveToFront()
		BackDrop.ConfirmationPanel:SetTitle("")
		BackDrop.ConfirmationPanel:ShowCloseButton(true)
		BackDrop.ConfirmationPanel.TargetBackDrop = BackDrop
		BackDrop.ConfirmationPanel._callbackFunc = callback;
		BackDrop.ConfirmationPanel.Alpha = 0;
		BackDrop.ConfirmationPanel.Alpha2 = 0;
		BackDrop.ConfirmationPanel.DoBeginning = true;
		BackDrop.ConfirmationPanel.FinBeginning = false;
		BackDrop.ConfirmationPanel.DoBeginning2 = false;
		local ConPanel = BackDrop.ConfirmationPanel;
		BackDrop.ConfirmationPanel.Counter = 1;
		ConPanel.MoneyCounter = 0;
		function ConPanel:OnRemove()
			if !self.TargetBackDrop || !self.TargetBackDrop.ConfirmationPanel then return end
			
			self.TargetBackDrop.ConfirmationPanel = nil;

		end
			
		ConPanel.Entry = vgui.Create("DTextEntry", ConPanel)
		ConPanel.Entry:SetPos(_wMod*5, _hMod*40)
		ConPanel.Entry:SetSize(ConPanel:GetWide()-(_wMod*10), _hMod*30)
		ConPanel.Entry:SetText("Money Value");	
		ConPanel.Entry.OnEnter = function(self)

			if isnumber(tonumber(self:GetValue())) then
					
				ConPanel.MoneyCounter = self:GetValue();
						

			end
			self:SetText("");	
		end
		
		
		ConPanel.Entry.OnMousePressed = function(self)

			self:SetText("");	
		end
		
		function BackDrop.ConfirmationPanel:Paint( w , h )
		
			self:MoveToFront()
			if self.DoBeginning && !self.FinBeginning then
			
				self.Alpha = Lerp( 0.1 , self.Alpha , 255 ) 
				
				if self.Alpha > 254 then
				
					self.DoBeginning = false;
				
				end
				
			end
			
			if !self.DoBeginning && !self.FinBeginning then
			
				self.DoBeginning2 = true
				self.FinBeginning = true;
			
			end
			
			if self.DoBeginning2 then
					
				self.Alpha2 = Lerp( 0.1 , self.Alpha2 , 255 ) 
				
				if self.Alpha2 > 254 then
				
					self.DoBeginning2 = false;
				
				end
				
			end
			
			surface.SetDrawColor( 0 ,0 ,0  , self.Alpha ) 
			surface.DrawRect( 0,0, w , h )
			surface.SetDrawColor( 56 ,56 ,56  , self.Alpha ) 
			surface.DrawRect( _wMod*4,4*_hMod, w-(_wMod*8) , h-(_hMod*8) )
			surface.SetFont("ConfirmationPanelButton")
			local x, y = surface.GetTextSize("#".. self.Counter)
			local _lalpha =self.Alpha
			//local _ralpha = (BackDrop.ConfirmationPanel.Counter != 0) &&  0 || self.Alpha;
			draw.SimpleText( "#" .. self.Counter , "ConfirmationPanelButton", w/2, (h/2)-(_hMod*4), Color(255,255,255,_lalpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			draw.SimpleText( "$" .. self.MoneyCounter , "ConfirmationPanelButton", w/2, (h/3)-(_hMod*2), Color(255,255,255,_lalpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			
		end
		ConPanel.ClosePan = vgui.Create("DButton", BackDrop.ConfirmationPanel )
		
		ConPanel.ClosePan:SetPos(_wMod*5,_hMod*5)
		ConPanel.ClosePan:SetText("")
		ConPanel.ClosePan:SetTall(_hMod*30)
		ConPanel.ClosePan:SetWide(ConPanel:GetWide()-(_wMod*10))
		//ConPanel.IncrBut:Dock(RIGHT)
		ConPanel.ClosePan.Paint = function(self,w,h)
			if self:IsHovered() && !input.IsMouseDown(MOUSE_LEFT) then
				surface.SetDrawColor( 128 ,128 ,128  , ConPanel.Alpha ) 
			else
				surface.SetDrawColor( 255 ,255 ,255  , ConPanel.Alpha ) 
			end
			surface.DrawRect( 0,0, w , h )
		local _font = "CashRegisterSmall";
			if ScrW() == 3840 then
				_font = "CashRegisterSmall_4k";
			end
			draw.SimpleText( "Close" , _font, w/2, h/2, Color(56,56,56, _InvPanel.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			
		end 

		function ConPanel.ClosePan:OnMousePressed(k)

			ConPanel:Remove()

		end
		ConPanel.ConfirmPanel = vgui.Create("DButton", BackDrop.ConfirmationPanel )
		
		ConPanel.ConfirmPanel:SetPos(_wMod*5,ConPanel:GetTall()-(_hMod*34) )
		ConPanel.ConfirmPanel:SetText("")
		ConPanel.ConfirmPanel:SetTall(_hMod*30)
		ConPanel.ConfirmPanel:SetWide(ConPanel:GetWide()-(_wMod*10))
		//ConPanel.IncrBut:Dock(RIGHT)
		ConPanel.ConfirmPanel.Paint = function(self,w,h)
			if self:IsHovered() && !input.IsMouseDown(MOUSE_LEFT) then
				surface.SetDrawColor( 128 ,128 ,128  , ConPanel.Alpha ) 
			else
				surface.SetDrawColor( 255 ,255 ,255  , ConPanel.Alpha ) 
			end
			surface.DrawRect( 0,0, w , h )
		local _font = "CashRegisterSmall";
			if ScrW() == 3840 then
				_font = "CashRegisterSmall_4k";
			end
			draw.SimpleText( "Confirm" , _font, w/2, h/2, Color(56,56,56, _InvPanel.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			
		end 

		function ConPanel.ConfirmPanel:OnMousePressed(k)

			ConPanel._callbackFunc(PassThroughInformation[1],PassThroughInformation[2], ConPanel.Counter,ConPanel.MoneyCounter)
			timer.Simple(1, function()
				if !ConPanel || !ConPanel.TargetBackDrop || !ConPanel.TargetBackDrop.Frame then return end
				
				ConPanel.TargetBackDrop.Frame:UpdateInventoryItems()
				ConPanel.TargetBackDrop.Frame:UpdateShopItems()
			end)

			ConPanel:Remove()
		end
		
	//BackDrop:CreateConfirmationPanel({self.ID,_foundRow},function( ID, _foundRow, _amount )
	//function BackDrop:CreateConfirmationPanel(BackDrop,PassThroughInformation, callback)//function( ID, _foundRow, _amount )
		local _inventory = LoadStringToInventory( LocalPlayer():getFlag("inventory", "" ));
		if !_inventory[PassThroughInformation[1]] then ConPanel:Remove() end

		local _InvSlot = _inventory[PassThroughInformation[1]];
		local _Max = _InvSlot.Amount || 1;
		BackDrop.ConfirmationPanel.Counter = _Max;
		ConPanel.IncrMoneyBut = vgui.Create("DButton", BackDrop.ConfirmationPanel )
		
		ConPanel.IncrMoneyBut:SetPos(ConPanel:GetWide()-(_wMod*42), ConPanel:GetTall()/2-(_hMod*64))
		ConPanel.IncrMoneyBut:SetText("")
		ConPanel.IncrMoneyBut:SetTall(_hMod*32)
		ConPanel.IncrMoneyBut:SetWide(_hMod*32)
		//ConPanel.IncrBut:Dock(RIGHT)
		ConPanel.IncrMoneyBut.Counting=false;
		ConPanel.IncrMoneyBut.Paint = function(self,w,h)
			if self:IsHovered() && !input.IsMouseDown(MOUSE_LEFT) then
				surface.SetDrawColor( 128 ,128 ,128  , ConPanel.Alpha ) 
			else
				surface.SetDrawColor( 255 ,255 ,255  , ConPanel.Alpha ) 
			end
			surface.DrawRect( 0,0, w , h )
			if self.Counting then
				BackDrop.ConfirmationPanel.MoneyCounter = math.max(0,BackDrop.ConfirmationPanel.MoneyCounter+5);
			end
			draw.SimpleText( "+" , "ConfirmationPanelButton", w/2, h/2, Color(56,56,56, _InvPanel.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			
		end 
		function ConPanel.IncrMoneyBut:OnMousePressed(k) 
			if k == MOUSE_LEFT then
				self.Counting = true;
			else
				self.Counting = false;
			end
			
		end
		function ConPanel.IncrMoneyBut:OnMouseReleased(k)
			if k == MOUSE_LEFT then
				self.Counting = false;
			else
				self.Counting = true;
			end
		end
		ConPanel.DecMoneyBut = vgui.Create("DButton", BackDrop.ConfirmationPanel )
		
		ConPanel.DecMoneyBut:SetPos(_wMod*10, ConPanel:GetTall()/2-(_hMod*64))
		ConPanel.DecMoneyBut:SetText("")
		//ConPanel.DecBut:Dock(LEFT)
		ConPanel.DecMoneyBut:SetTall(_hMod*32)
		ConPanel.DecMoneyBut:SetWide(_hMod*32)
		ConPanel.DecMoneyBut.Counting=false;

		ConPanel.DecMoneyBut.Paint = function(self,w,h)
			if self:IsHovered() && !input.IsMouseDown(MOUSE_LEFT) then
				surface.SetDrawColor( 128 ,128 ,128  , ConPanel.Alpha ) 
			else
				surface.SetDrawColor( 255 ,255 ,255  , ConPanel.Alpha ) 
			end
			surface.DrawRect( 0,0, w , h )
			if self.Counting then
				BackDrop.ConfirmationPanel.MoneyCounter = math.max(0,BackDrop.ConfirmationPanel.MoneyCounter-5);
			end
			draw.SimpleText( "-" , "ConfirmationPanelButton", w/2, _hMod*9.5, Color(56,56,56, _InvPanel.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			
		end
		function ConPanel.DecMoneyBut:OnMousePressed(k)
			if k == MOUSE_LEFT then
				self.Counting = true;
			else
				self.Counting = false;
			end
		end
		
		function ConPanel.DecMoneyBut:OnMouseReleased(k)
			if k == MOUSE_LEFT then
				self.Counting = false;
			else
				self.Counting = true;
			end
		end

		ConPanel.IncrBut = vgui.Create("DButton", BackDrop.ConfirmationPanel )
		
		ConPanel.IncrBut:SetPos(ConPanel:GetWide()-(_wMod*42), ConPanel:GetTall()/2-(_hMod*18))
		ConPanel.IncrBut:SetText("")
		ConPanel.IncrBut:SetTall(_hMod*32)
		ConPanel.IncrBut:SetWide(_hMod*32)
		//ConPanel.IncrBut:Dock(RIGHT)
		ConPanel.IncrBut.Paint = function(self,w,h)
			if self:IsHovered() && !input.IsMouseDown(MOUSE_LEFT) then
				surface.SetDrawColor( 128 ,128 ,128  , ConPanel.Alpha ) 
			else
				surface.SetDrawColor( 255 ,255 ,255  , ConPanel.Alpha ) 
			end
			surface.DrawRect( 0,0, w , h )
			draw.SimpleText( "+" , "ConfirmationPanelButton", w/2, h/2, Color(56,56,56, _InvPanel.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			
		end 
		function ConPanel.IncrBut:OnMousePressed(k) 
			if BackDrop.ConfirmationPanel.Counter+1 >  _Max then
				BackDrop.ConfirmationPanel.Counter = 1
				return
			end
			BackDrop.ConfirmationPanel.Counter = math.min(_Max,(BackDrop.ConfirmationPanel.Counter+1))
		end
		ConPanel.DecBut = vgui.Create("DButton", BackDrop.ConfirmationPanel )
		
		ConPanel.DecBut:SetPos(_wMod*10, ConPanel:GetTall()/2-(_hMod*18))
		ConPanel.DecBut:SetText("")
		//ConPanel.DecBut:Dock(LEFT)
		ConPanel.DecBut:SetTall(_hMod*32)
		ConPanel.DecBut:SetWide(_hMod*32)

		ConPanel.DecBut.Paint = function(self,w,h)
			if self:IsHovered() && !input.IsMouseDown(MOUSE_LEFT) then
				surface.SetDrawColor( 128 ,128 ,128  , ConPanel.Alpha ) 
			else
				surface.SetDrawColor( 255 ,255 ,255  , ConPanel.Alpha ) 
			end
			surface.DrawRect( 0,0, w , h )
			draw.SimpleText( "-" , "ConfirmationPanelButton", w/2, _hMod*9.5, Color(56,56,56, _InvPanel.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			
		end
		function ConPanel.DecBut:OnMousePressed(k)
			if BackDrop.ConfirmationPanel.Counter-1 < 1 then
				BackDrop.ConfirmationPanel.Counter = _Max;
				return
			end
			BackDrop.ConfirmationPanel.Counter = math.max(1,(BackDrop.ConfirmationPanel.Counter-1))
		end


		ConPanel.MinBut = vgui.Create("DButton", BackDrop.ConfirmationPanel )
		
		ConPanel.MinBut:SetPos(_wMod*10, ConPanel:GetTall()/2+24)
		ConPanel.MinBut:SetText("")
		//ConPanel.DecBut:Dock(LEFT)
		ConPanel.MinBut:SetTall(_hMod*32)
		ConPanel.MinBut:SetWide(_wMod*100)

		ConPanel.MinBut.Paint = function(self,w,h)
			if self:IsHovered() && !input.IsMouseDown(MOUSE_LEFT) then
				surface.SetDrawColor( 128 ,128 ,128  , ConPanel.Alpha ) 
			else
				surface.SetDrawColor( 255 ,255 ,255  , ConPanel.Alpha ) 
			end
			surface.DrawRect( 0,0, w , h )
		local _font = "CashRegisterSmall";
			if ScrW() == 3840 then
				_font = "CashRegisterSmall_4k";
			end
			draw.SimpleText( "Min" , _font, w/2, h/2, Color(56,56,56, _InvPanel.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			
		end
		function ConPanel.MinBut:OnMousePressed(k)
			ConPanel.Counter = 1
		end


		ConPanel.MaxBut = vgui.Create("DButton", BackDrop.ConfirmationPanel )
		
		ConPanel.MaxBut:SetPos(ConPanel:GetWide()-(_wMod*110), ConPanel:GetTall()/2+24)
		ConPanel.MaxBut:SetText("")
		//ConPanel.DecBut:Dock(LEFT)
		ConPanel.MaxBut:SetTall(_hMod*32)
		ConPanel.MaxBut:SetWide(_wMod*100)

		ConPanel.MaxBut.Paint = function(self,w,h)
			if self:IsHovered() && !input.IsMouseDown(MOUSE_LEFT) then
				surface.SetDrawColor( 128 ,128 ,128  , ConPanel.Alpha ) 
			else
				surface.SetDrawColor( 255 ,255 ,255  , ConPanel.Alpha ) 
			end
			surface.DrawRect( 0,0, w , h )
		local _font = "CashRegisterSmall";
			if ScrW() == 3840 then
				_font = "CashRegisterSmall_4k";
			end
			draw.SimpleText( "Max" , _font, w/2, h/2, Color(56,56,56, _InvPanel.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			
		end
		function ConPanel.MaxBut:OnMousePressed(k)
			ConPanel.Counter = _Max
		end
		//callback(PassThroughInformation[1],PassThroughInformation[2],)

		return BackDrop.ConfirmationPanel;
	end
	
	function BackDrop:MakeEditPanel(BackDrop,row,PassThroughInformation, callback)//function( ID, _foundRow, _amount )

		BackDrop.ConfirmationPanel = vgui.Create("DFrame")

		BackDrop.ConfirmationPanel:SetSize(_wMod*300, _hMod*300)
		BackDrop.ConfirmationPanel:Center()
		BackDrop.ConfirmationPanel:MakePopup()
		BackDrop.ConfirmationPanel:MoveToFront()
		BackDrop.ConfirmationPanel:SetTitle("")
		BackDrop.ConfirmationPanel:ShowCloseButton(true)
		BackDrop.ConfirmationPanel.TargetBackDrop = BackDrop
		BackDrop.ConfirmationPanel._callbackFunc = callback;
		BackDrop.ConfirmationPanel.Alpha = 0;
		BackDrop.ConfirmationPanel.Alpha2 = 0;
		BackDrop.ConfirmationPanel.DoBeginning = true;
		BackDrop.ConfirmationPanel.FinBeginning = false;
		BackDrop.ConfirmationPanel.DoBeginning2 = false;
		local ConPanel = BackDrop.ConfirmationPanel;
		BackDrop.ConfirmationPanel.Counter = PassThroughInformation[1];
		ConPanel.MoneyCounter = PassThroughInformation[2];
		function ConPanel:OnRemove()
			if !self.TargetBackDrop || !self.TargetBackDrop.ConfirmationPanel then return end
			
			self.TargetBackDrop.ConfirmationPanel = nil;

		end
			
		ConPanel.Entry = vgui.Create("DTextEntry", ConPanel)
		ConPanel.Entry:SetPos(_wMod*5, _hMod*40)
		ConPanel.Entry:SetSize(ConPanel:GetWide()-(_wMod*10), _hMod*30)
		ConPanel.Entry:SetText("Money Value");	
		ConPanel.Entry.OnEnter = function(self)

			if isnumber(tonumber(self:GetValue())) then
					
				ConPanel.MoneyCounter = self:GetValue();
						

			end
			self:SetText("");	
		end
	
		ConPanel.Entry.OnMousePressed = function(self)

			self:SetText("");	
		end
			
		
		function BackDrop.ConfirmationPanel:Paint( w , h )
			
			self:MoveToFront()

			if self.DoBeginning && !self.FinBeginning then
			
				self.Alpha = Lerp( 0.1 , self.Alpha , 255 ) 
				
				if self.Alpha > 254 then
				
					self.DoBeginning = false;
				
				end
				
			end
			
			if !self.DoBeginning && !self.FinBeginning then
			
				self.DoBeginning2 = true
				self.FinBeginning = true;
			
			end
			
			if self.DoBeginning2 then
					
				self.Alpha2 = Lerp( 0.1 , self.Alpha2 , 255 ) 
				
				if self.Alpha2 > 254 then
				
					self.DoBeginning2 = false;
				
				end
				
			end
			
			surface.SetDrawColor( 0 ,0 ,0  , self.Alpha ) 
			surface.DrawRect( 0,0, w , h )
			surface.SetDrawColor( 56 ,56 ,56  , self.Alpha ) 
			surface.DrawRect( _wMod*4,4*_hMod, w-(_wMod*8) , h-(_hMod*8) )
			surface.SetFont("ConfirmationPanelButton")
			local x, y = surface.GetTextSize("#".. self.Counter)
			local _lalpha =self.Alpha
			//local _ralpha = (BackDrop.ConfirmationPanel.Counter != 0) &&  0 || self.Alpha;

			local _pre1 , _pre2 = "", "";
			if !PassThroughInformation[3] || PassThroughInformation && PassThroughInformation[3] == true then
				_pre1 = "Units: "
				_pre2 = "Price: "
			end
		
			draw.SimpleText( _pre1 .. "#" .. self.Counter , "ConfirmationPanelButton", w/2, (h/2)-(_hMod*4), Color(255,255,255,_lalpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			draw.SimpleText( _pre2 .. "$" .. self.MoneyCounter , "ConfirmationPanelButton", w/2, (h/3)-(_hMod*2), Color(255,255,255,_lalpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			
		end
		ConPanel.ClosePan = vgui.Create("DButton", BackDrop.ConfirmationPanel )
		
		ConPanel.ClosePan:SetPos(_wMod*5,_hMod*5)
		ConPanel.ClosePan:SetText("")
		ConPanel.ClosePan:SetTall(_hMod*30)
		ConPanel.ClosePan:SetWide(ConPanel:GetWide()-(_wMod*10))
		//ConPanel.IncrBut:Dock(RIGHT)
		ConPanel.ClosePan.Paint = function(self,w,h)
			if self:IsHovered() && !input.IsMouseDown(MOUSE_LEFT) then
				surface.SetDrawColor( 128 ,128 ,128  , ConPanel.Alpha ) 
			else
				surface.SetDrawColor( 255 ,255 ,255  , ConPanel.Alpha ) 
			end
			surface.DrawRect( 0,0, w , h )
		local _font = "CashRegisterSmall";
			if ScrW() == 3840 then
				_font = "CashRegisterSmall_4k";
			end
			draw.SimpleText( "Close" , _font, w/2, h/2, Color(56,56,56, _InvPanel.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			
		end 

		function ConPanel.ClosePan:OnMousePressed(k)

			ConPanel:Remove()

		end
		ConPanel.ConfirmPanel = vgui.Create("DButton", BackDrop.ConfirmationPanel )
		
		ConPanel.ConfirmPanel:SetPos(_wMod*5,ConPanel:GetTall()-(_hMod*34) )
		ConPanel.ConfirmPanel:SetText("")
		ConPanel.ConfirmPanel:SetTall(_hMod*30)
		ConPanel.ConfirmPanel:SetWide(ConPanel:GetWide()-(_wMod*10))
		//ConPanel.IncrBut:Dock(RIGHT)
		ConPanel.ConfirmPanel.Paint = function(self,w,h)
			if self:IsHovered() && !input.IsMouseDown(MOUSE_LEFT) then
				surface.SetDrawColor( 128 ,128 ,128  , ConPanel.Alpha ) 
			else
				surface.SetDrawColor( 255 ,255 ,255  , ConPanel.Alpha ) 
			end
			surface.DrawRect( 0,0, w , h )
		local _font = "CashRegisterSmall";
			if ScrW() == 3840 then
				_font = "CashRegisterSmall_4k";
			end
			draw.SimpleText( "Confirm" , _font, w/2, h/2, Color(56,56,56, _InvPanel.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			
		end 

		function ConPanel.ConfirmPanel:OnMousePressed(k)

			ConPanel._callbackFunc(row, ConPanel.Counter,ConPanel.MoneyCounter)
			timer.Simple(1, function()
				if !ConPanel || !ConPanel.TargetBackDrop || !ConPanel.TargetBackDrop.Frame then return end
				
				ConPanel.TargetBackDrop.Frame:UpdateInventoryItems()
				ConPanel.TargetBackDrop.Frame:UpdateShopItems()
			end)

			ConPanel:Remove()
		end
		
	//BackDrop:CreateConfirmationPanel({self.ID,_foundRow},function( ID, _foundRow, _amount )
	//function BackDrop:CreateConfirmationPanel(BackDrop,PassThroughInformation, callback)//function( ID, _foundRow, _amount )

		local _Max = PassThroughInformation[1] || 1;

		BackDrop.ConfirmationPanel.Counter = _Max;
		ConPanel.IncrMoneyBut = vgui.Create("DButton", BackDrop.ConfirmationPanel )
		
		ConPanel.IncrMoneyBut:SetPos(ConPanel:GetWide()-(_wMod*42), ConPanel:GetTall()/2-(_hMod*64))
		ConPanel.IncrMoneyBut:SetText("")
		ConPanel.IncrMoneyBut:SetTall(_hMod*32)
		ConPanel.IncrMoneyBut:SetWide(_hMod*32)
		//ConPanel.IncrBut:Dock(RIGHT)
		ConPanel.IncrMoneyBut.Counting=false;
		ConPanel.IncrMoneyBut.Paint = function(self,w,h)
			if self:IsHovered() && !input.IsMouseDown(MOUSE_LEFT) then
				surface.SetDrawColor( 128 ,128 ,128  , ConPanel.Alpha ) 
			else
				surface.SetDrawColor( 255 ,255 ,255  , ConPanel.Alpha ) 
			end
			surface.DrawRect( 0,0, w , h )
			if self.Counting then
				BackDrop.ConfirmationPanel.MoneyCounter = math.max(0,BackDrop.ConfirmationPanel.MoneyCounter+5);
			end
			draw.SimpleText( "+" , "ConfirmationPanelButton", w/2, h/2, Color(56,56,56, _InvPanel.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			
		end 
		function ConPanel.IncrMoneyBut:OnMousePressed(k) 
			if k == MOUSE_LEFT then
				self.Counting = true;
			else
				self.Counting = false;
			end
			
		end
		function ConPanel.IncrMoneyBut:OnMouseReleased(k)
			if k == MOUSE_LEFT then
				self.Counting = false;
			else
				self.Counting = true;
			end
		end
		ConPanel.DecMoneyBut = vgui.Create("DButton", BackDrop.ConfirmationPanel )
		
		ConPanel.DecMoneyBut:SetPos(_wMod*10, ConPanel:GetTall()/2-(_hMod*64))
		ConPanel.DecMoneyBut:SetText("")
		//ConPanel.DecBut:Dock(LEFT)
		ConPanel.DecMoneyBut:SetTall(_hMod*32)
		ConPanel.DecMoneyBut:SetWide(_hMod*32)
		ConPanel.DecMoneyBut.Counting=false;

		ConPanel.DecMoneyBut.Paint = function(self,w,h)
			if self:IsHovered() && !input.IsMouseDown(MOUSE_LEFT) then
				surface.SetDrawColor( 128 ,128 ,128  , ConPanel.Alpha ) 
			else
				surface.SetDrawColor( 255 ,255 ,255  , ConPanel.Alpha ) 
			end
			surface.DrawRect( 0,0, w , h )
			if self.Counting then
				BackDrop.ConfirmationPanel.MoneyCounter = math.max(0,BackDrop.ConfirmationPanel.MoneyCounter-5);
			end
			draw.SimpleText( "-" , "ConfirmationPanelButton", w/2, _hMod*9.5, Color(56,56,56, _InvPanel.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			
		end
		function ConPanel.DecMoneyBut:OnMousePressed(k)
			if k == MOUSE_LEFT then
				self.Counting = true;
			else
				self.Counting = false;
			end
		end
		
		function ConPanel.DecMoneyBut:OnMouseReleased(k)
			if k == MOUSE_LEFT then
				self.Counting = false;
			else
				self.Counting = true;
			end
		end

		ConPanel.IncrBut = vgui.Create("DButton", BackDrop.ConfirmationPanel )
		
		ConPanel.IncrBut:SetPos(ConPanel:GetWide()-(_wMod*42), ConPanel:GetTall()/2-(_hMod*18))
		ConPanel.IncrBut:SetText("")
		ConPanel.IncrBut:SetTall(_hMod*32)
		ConPanel.IncrBut:SetWide(_hMod*32)
		//ConPanel.IncrBut:Dock(RIGHT)
		ConPanel.IncrBut.Paint = function(self,w,h)
			if self:IsHovered() && !input.IsMouseDown(MOUSE_LEFT) then
				surface.SetDrawColor( 128 ,128 ,128  , ConPanel.Alpha ) 
			else
				surface.SetDrawColor( 255 ,255 ,255  , ConPanel.Alpha ) 
			end
			surface.DrawRect( 0,0, w , h )
			draw.SimpleText( "+" , "ConfirmationPanelButton", w/2, h/2, Color(56,56,56, _InvPanel.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			
		end 
		function ConPanel.IncrBut:OnMousePressed(k) 
			if BackDrop.ConfirmationPanel.Counter+1 >  _Max then
				BackDrop.ConfirmationPanel.Counter = 1
				return
			end
			BackDrop.ConfirmationPanel.Counter = math.min(_Max,(BackDrop.ConfirmationPanel.Counter+1))
		end
		ConPanel.DecBut = vgui.Create("DButton", BackDrop.ConfirmationPanel )
		
		ConPanel.DecBut:SetPos(_wMod*10, ConPanel:GetTall()/2-(_hMod*18))
		ConPanel.DecBut:SetText("")
		//ConPanel.DecBut:Dock(LEFT)
		ConPanel.DecBut:SetTall(_hMod*32)
		ConPanel.DecBut:SetWide(_hMod*32)

		ConPanel.DecBut.Paint = function(self,w,h)
			if self:IsHovered() && !input.IsMouseDown(MOUSE_LEFT) then
				surface.SetDrawColor( 128 ,128 ,128  , ConPanel.Alpha ) 
			else
				surface.SetDrawColor( 255 ,255 ,255  , ConPanel.Alpha ) 
			end
			surface.DrawRect( 0,0, w , h )
			draw.SimpleText( "-" , "ConfirmationPanelButton", w/2, _hMod*9.5, Color(56,56,56, _InvPanel.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			
		end
		function ConPanel.DecBut:OnMousePressed(k)
			if BackDrop.ConfirmationPanel.Counter-1 < 1 then
				BackDrop.ConfirmationPanel.Counter = _Max;
				return
			end
			BackDrop.ConfirmationPanel.Counter = math.max(1,(BackDrop.ConfirmationPanel.Counter-1))
		end


		ConPanel.MinBut = vgui.Create("DButton", BackDrop.ConfirmationPanel )
		
		ConPanel.MinBut:SetPos(_wMod*10, ConPanel:GetTall()/2+24)
		ConPanel.MinBut:SetText("")
		//ConPanel.DecBut:Dock(LEFT)
		ConPanel.MinBut:SetTall(_hMod*32)
		ConPanel.MinBut:SetWide(_wMod*100)

		ConPanel.MinBut.Paint = function(self,w,h)
			if self:IsHovered() && !input.IsMouseDown(MOUSE_LEFT) then
				surface.SetDrawColor( 128 ,128 ,128  , ConPanel.Alpha ) 
			else
				surface.SetDrawColor( 255 ,255 ,255  , ConPanel.Alpha ) 
			end
			surface.DrawRect( 0,0, w , h )
		local _font = "CashRegisterSmall";
			if ScrW() == 3840 then
				_font = "CashRegisterSmall_4k";
			end
			draw.SimpleText( "Min" , _font, w/2, h/2, Color(56,56,56, _InvPanel.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			
		end
		function ConPanel.MinBut:OnMousePressed(k)
			ConPanel.Counter = 1
		end


		ConPanel.MaxBut = vgui.Create("DButton", BackDrop.ConfirmationPanel )
		
		ConPanel.MaxBut:SetPos(ConPanel:GetWide()-(_wMod*110), ConPanel:GetTall()/2+24)
		ConPanel.MaxBut:SetText("")
		//ConPanel.DecBut:Dock(LEFT)
		ConPanel.MaxBut:SetTall(_hMod*32)
		ConPanel.MaxBut:SetWide(_wMod*100)

		ConPanel.MaxBut.Paint = function(self,w,h)
			if self:IsHovered() && !input.IsMouseDown(MOUSE_LEFT) then
				surface.SetDrawColor( 128 ,128 ,128  , ConPanel.Alpha ) 
			else
				surface.SetDrawColor( 255 ,255 ,255  , ConPanel.Alpha ) 
			end
			surface.DrawRect( 0,0, w , h )
		local _font = "CashRegisterSmall";
			if ScrW() == 3840 then
				_font = "CashRegisterSmall_4k";
			end
			draw.SimpleText( "Max" , _font, w/2, h/2, Color(56,56,56, _InvPanel.Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			
		end
		function ConPanel.MaxBut:OnMousePressed(k)
			ConPanel.Counter = _Max
		end
		//callback(PassThroughInformation[1],PassThroughInformation[2],)
	
		if !PassThroughInformation[3] || PassThroughInformation && PassThroughInformation[3] == true then
			ConPanel.IncrMoneyBut:SetVisible(false)
			ConPanel.DecMoneyBut:SetVisible(false)
			ConPanel.IncrBut:SetVisible(false)
			ConPanel.DecBut:SetVisible(false)
			ConPanel.MaxBut:SetVisible(false)
			ConPanel.MinBut:SetVisible(false)
			ConPanel.Entry:SetVisible(false)
		end

	
		return BackDrop.ConfirmationPanel;
	end
	/*
	local StoreItems = vgui.Create( "DPanel", Frame )
	StoreItems:SetPos( Frame:GetWide() /2 + _wMod * 10 , _hMod * 75 )
	StoreItems:SetSize( _wMod * 450 , _hMod * 400)

	function StoreItems:Paint( w , h )

		surface.SetDrawColor( 255, 255, 255 , Frame.Alpha2 )
		surface.DrawRect( 0,0 ,w , h )

	end 
	*/

	/*
	local StoreItemScroll = vgui.Create( "DScrollPanel" , StoreItems )
	StoreItemScroll:SetSize( StoreItems:GetWide() , StoreItems:GetTall() )

	local StoreItemGrid = vgui.Create( "DGrid", StoreItemScroll )
	StoreItemGrid:SetCols( 4 )
	StoreItemGrid:SetColWide( 95 * _wMod )
	StoreItemGrid:SetRowHeight( 95 * _hMod )
	
	StoreItemScroll:Add( StoreItemGrid )
	local MAX_SLOTS = fsrp.config.InventoryWSlots * fsrp.config.InventoryYSlots; 
	
	
	for i = 1, MAX_SLOTS do
	
		local _dButton = vgui.Create( "DButton" , StoreItemScroll )
		function _dButton:Paint( w, h )
		
			surface.SetDrawColor( 0,0,0 )
			surface.DrawRect( 0,0,w,h )

		end
	
		_dButton:Dock(TOP)

		StoreItemGrid:Add( _dButton )

	end	
	*/
	
	
	/*
				local _item = vgui.Create( "DButton" , foundItemsScroll )
				_item:Dock( TOP )

				_item:SetTall( _hMod * 250 ) 

				_itemModel = vgui.Create( "DModelPanel", _item )
				_itemModel:Dock( FILL )
				_itemModel:SetModel( ITEMLIST[_id].Model )
				_itemModel:SetCamPos( ITEMLIST[_id].CamPos )
				_itemModel:SetLookAt( ITEMLIST[_id].LookAt )
				_itemModel:SetMouseInputEnabled( false )
				foundItemsScroll:Add( _item )
				_item.EntId = v:EntIndex()
				function _item:OnMousePressed( k )

					net.Start( "itemInQuestion" )
						net.WriteInt( self.EntId , 16 )
					net.SendToServer( )

				end
				
			end
			*/

			return BackDrop;
end 
hook.Add("OnTextEntryLoseFocus", "OnLoseFocusStall", function(panel)
	if LocalPlayer().Stall &&  LocalPlayer().Stall.Frame &&  LocalPlayer().Stall.Frame.AnnouncementBar && LocalPlayer().Stall.Frame.AnnouncementBar.Entry && panel == LocalPlayer().Stall.Frame.AnnouncementBar.Entry then
		LocalPlayer().Stall.Frame.AnnouncementBar.Entry:SetVisible(false)
	end
end)
net.Receive( "cashRegister", function( _l , _p )

	local _p = LocalPlayer();
	local _e = net.ReadInt( 8 );

	if _e == 1 || _e == 0 then
		local _index = net.ReadInt( 16 );
		local _ent = ents.GetByIndex(_index)
		if _e == 1 then
			
			_ent:setFlag("ownedBy",_p:SteamID() )

		end

		if LocalPlayer().Stall then
			LocalPlayer().Stall:Remove()
			LocalPlayer().Stall = nil
			return
		else
			LocalPlayer().Stall = CashRegisterMenu( _index);

		end


	elseif _e == 2 then
		
		//net.WriteColor(_colorAuthor)
		//net.WriteColor(_colorText)
		//net.WriteString( _p:SteamID() )
		//net.WriteString( _String )
		
		local _colorAuth = net.ReadColor()
		local _colorText = net.ReadColor()
		local _authorID = net.ReadString()
		local _authorString = net.ReadString()
		local _author = player.GetBySteamID(_authorID);

		if LocalPlayer().Stall && _author then
			LocalPlayer().Stall:AddChatRecord( _colorAuth,_colorText,_author:getFirstName(), _authorString)
		end

	elseif _e == 3 then
		
		if LocalPlayer().Stall then
			LocalPlayer().Stall:UpdateProperties(net.ReadInt(2),net.ReadBool());
		end

	elseif _e == 4 then
		if LocalPlayer().Stall then
			LocalPlayer().Stall:Remove()
			LocalPlayer().Stall = nil
		end

	elseif _e == 5 then
		
		if LocalPlayer().Stall then
			
			LocalPlayer().Stall:UpdateAnnouncementText(net.ReadString())

		end

	elseif _e == 6 then
		local _tb = net.ReadTable();
		local _ind = net.ReadInt(16);

		if ents.GetByIndex(_ind) then
			ents.GetByIndex(_ind):setFlag("shopItems",_tb);
		end

		if LocalPlayer().Stall then
			if LocalPlayer().Stall.Frame then
				LocalPlayer().Stall.Frame:UpdateShopItems()
			end
			LocalPlayer().Stall:UpdateInventoryItems()
		end
		
	end

end )

