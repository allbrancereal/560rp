
local globalPropertyFrame;
local buttonColor = Color( 128,128,128,255)
local buttonPressed = Color( 25,25,25,255)

function draw.Circle( x, y, radius, seg )
	local cir = {}

	table.insert( cir, { x = x, y = y, u = 0.5, v = 0.5 } )
	for i = 0, seg do
		local a = math.rad( ( i / seg ) * -360 )
		table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
	end

	local a = math.rad( 0 ) -- This is needed for non absolute segment counts
	table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )

	surface.DrawPoly( cir )
end

for i=20 , 50 do
	surface.CreateFont("OpenSans"..i, {font='Open Sans', size=i, weight=100, antialias=true, additive=false})
end

local SCREEN_W, SCREEN_H = 2560, 1440;

local _w, _h = ScrW( ), ScrH( );

local _wMod, _hMod = _w / SCREEN_W, _h / SCREEN_H;

function PropertyInfoPanel( id )

	local Property = fsrp.PropertyTable[id];
	local fancyText = {
			"Cost",
			"$",
			"Category",
			"Description",
			"Amount of Doors",
		}
	local Frame;
	Frame = vgui.Create("DFrame")
	Frame:SetSize(ScrW() * 0.5, ScrH() * 0.5)
	Frame:Center()
	Frame:SetTitle("")
	
	Frame:ShowCloseButton(false)
	Frame:MakePopup()
	Frame.TabAlpha = 0;
	Frame.DoBeginning = true;
	
	Frame.Paint = function( self, w , h ) 
		
		if self.DoBeginning then
		
			self.TabAlpha = Lerp( 0.01 ,  self.TabAlpha , 255 )
			
			if self.TabAlpha >= 254 then
			
				self.DoBeginning = false
				
			end
			
		end
		
		// Spinning / Sizing Circles
		surface.SetDrawColor( 255, 255, 255, 255 )
		draw.Circle( 25,h/2, math.Clamp( 200*math.sin( (CurTime()*.1) ), 100, 500 ), 50+(.5*math.sin( CurTime() ) )* 20  )
		draw.Circle( w-25,h/2, math.Clamp( 200*math.sin( (CurTime()*.1) ), 100, 500 ), 50+(.5*math.sin( CurTime() ) )* 20  )
		
		// Background
		surface.SetDrawColor( 56, 56, 56, 128 )
		surface.DrawRect( 0, 0, w, h )
		surface.SetDrawColor( 56, 56, 56, 128 )
		surface.DrawRect(5, 5, w-10, h-10 )
	
		// Property Name
		draw.SimpleTextOutlined(Property.Name, "OpenSans28", w/2, h * .1, Color(255, 255, 255, self.TabAlpha), 1, 1, 1, Color(0, 0, 0, self.TabAlpha));
		
			
		// Bank Text
		draw.SimpleTextOutlined("Bank Listing", "Trebuchet20", (w/4*3), h * .2, Color(255, 255, 255, self.TabAlpha), 1, 1, 1, Color(0, 0, 0, self.TabAlpha));
		
		// Online Text
		draw.SimpleTextOutlined("Online Listing", "Trebuchet20", w/4 , h * .2, Color(255, 255, 255, self.TabAlpha), 1, 1, 1, Color(0, 0, 0, self.TabAlpha));
		
		// Online Info
		draw.SimpleTextOutlined("Cost", "OpenSans20", w/4 * .9 , h * .325, Color(255, 255, 255, self.TabAlpha), 2, 1, 1, Color(0, 0, 0, self.TabAlpha));
		draw.SimpleTextOutlined("$" .. (Property.Cost *1.5) , "OpenSans20", w/4 * 1.25 , h * .325, Color(255, 255, 255, self.TabAlpha), 3, 1, 1, Color(0, 0, 0, self.TabAlpha));
		draw.SimpleTextOutlined("Category", "OpenSans20", w/4 * .9 , h * .375, Color(255, 255, 255, self.TabAlpha), 2, 1, 1, Color(0, 0, 0, self.TabAlpha));
		draw.SimpleTextOutlined(Property.Category , "OpenSans20", w/4 * 1.25 , h * .375, Color(255, 255, 255, self.TabAlpha), 3, 1, 1, Color(0, 0, 0, self.TabAlpha));
		draw.SimpleTextOutlined("Cost Per Door", "OpenSans20", w/4 * .9  , h * .425, Color(255, 255, 255, self.TabAlpha), 2, 1, 1, Color(0, 0, 0, self.TabAlpha));
		draw.SimpleTextOutlined( math.Round((Property.Cost*1.5)/#Property.Doors, 2) , "OpenSans20", w/4 * 1.25 , h * .425, Color(255, 255, 255, self.TabAlpha), 3, 1, 1, Color(0, 0, 0, self.TabAlpha));
		draw.SimpleTextOutlined("Amount of Doors", "OpenSans20",  w/4 * .9  , h * .575, Color(255, 255, 255, self.TabAlpha), 2, 1, 1, Color(0, 0, 0, self.TabAlpha));
		draw.SimpleTextOutlined((#Property.Doors) , "OpenSans20", w/4 * 1.25 , h * .575, Color(255, 255, 255, self.TabAlpha), 3, 1, 1, Color(0, 0, 0, self.TabAlpha));
		//Bank Info
		
		draw.SimpleTextOutlined("Cost", "OpenSans20",  (3*w/4)* .975 , h * .325, Color(255, 255, 255, self.TabAlpha), 2, 1, 1, Color(0, 0, 0, self.TabAlpha));
		draw.SimpleTextOutlined("$" .. (Property.Cost) , "OpenSans20",  (3*w/4)* 1.075 , h * .325, Color(255, 255, 255, self.TabAlpha), 3, 1, 1, Color(0, 0, 0, self.TabAlpha));
		
		draw.SimpleTextOutlined("Category", "OpenSans20",   (3*w/4)*  .975  , h * .375, Color(255, 255, 255, self.TabAlpha), 2, 1, 1, Color(0, 0, 0, self.TabAlpha));
		draw.SimpleTextOutlined(Property.Category , "OpenSans20", (3*w/4) * 1.075 , h * .375, Color(255, 255, 255, self.TabAlpha), 3, 1, 1, Color(0, 0, 0, self.TabAlpha));
		
		draw.SimpleTextOutlined("Cost Per Door", "OpenSans20",  (3*w/4)* .975 , h * .425, Color(255, 255, 255, self.TabAlpha), 2, 1, 1, Color(0, 0, 0, self.TabAlpha));
		draw.SimpleTextOutlined( math.Round((Property.Cost)/#Property.Doors, 2) , "OpenSans20",  (3*w/4) * 1.075 , h * .425, Color(255, 255, 255, self.TabAlpha), 3, 1, 1, Color(0, 0, 0, self.TabAlpha));
		
		draw.SimpleTextOutlined("Amount of Doors", "OpenSans20",   (3*w/4)*  .975 , h * .575, Color(255, 255, 255, self.TabAlpha), 2, 1, 1, Color(0, 0, 0, self.TabAlpha));
		draw.SimpleTextOutlined((#Property.Doors) , "OpenSans20",  (3*w/4) * 1.075 , h * .575, Color(255, 255, 255, self.TabAlpha), 3, 1, 1, Color(0, 0, 0, self.TabAlpha));
		
		surface.SetDrawColor( 255, 255, 255, self.TabAlpha )
		// Underline Property Name
		surface.DrawLine( 0, h*.15, w, h*.15 )
		
		surface.SetDrawColor( 255, 255, 255, self.TabAlpha * 0.0784313725)
		
		surface.DrawLine(  w/4 , h*.25,  w/4 , h* ( (0.30)+ 0.05 * 8 ))
		
		surface.DrawLine(  (w/4*3) , h*.25,  (w/4*3) ,   h* ( (0.30)+ 0.05 * 8 ))
		
		
		for i = 0, 8 do
			
			surface.DrawLine(   w/4-  _wMod * 150 , h* ( (0.30)+ 0.05 * i ),  w/4 +  _wMod * 150,  h* ( 0.30+ 0.05 * i )  )
			surface.DrawLine(  (w/4*3)-  _wMod * 150 , h* ( (0.30)+ 0.05 * i ),  (w/4*3) +  _wMod * 150,  h* ( 0.30+ 0.05 * i )  )
			
		end
		
		// Purchase Ways Boxes		
		// Online
		surface.SetDrawColor( 25, 25, 25, 128 )
		surface.DrawRect( _wMod * 10+ w/4- _wMod * 150 , _hMod * 10+ h*.25,  _wMod * 280, _hMod * 330 )
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.DrawOutlinedRect(  w/4-  _wMod * 150 , h*.25,  _wMod * 300, _hMod * 350 )
		
		
		// Bank
		surface.SetDrawColor( 25, 25, 25, 128 )
		surface.DrawRect(  _wMod * 10+  (w/4*3)-  _wMod * 150 , _hMod * 10+ h * .25 , _wMod * 280, _hMod * 330 )
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.DrawOutlinedRect( (w/4*3)-  _wMod * 150 , h * .25 , _wMod * 300, _hMod * 350 )
		
	end
	
	
	local closebut = vgui.Create("DButton",Frame)
	closebut:SetPos( Frame:GetWide() * .925 , _hMod *  10 )
	closebut:SetSize( _wMod * 50, _hMod *  25 )
	closebut:SetText("X")
	closebut.Pressed = false;
	
	function closebut:Paint(w,h)
		if closebut.Pressed == true then
		
			surface.SetDrawColor( buttonPressed )
			
		else
		
			surface.SetDrawColor( buttonColor )
		
		end
		
		surface.DrawOutlinedRect(  0,0,w,h )
	
	end
	function closebut:OnMousePressed()
		closebut.Pressed= true;
		
		
	end
	
	function closebut:OnMouseReleased()
		
		closebut.Pressed = false;
		
		Frame:Remove();
		globalPropertyFrame = nil;
		
	end	
	
	
	
	local buyPropertyBank = vgui.Create("DButton",Frame)
	buyPropertyBank:SetPos( _wMod * 880, Frame:GetTall() - _hMod * 150)
	buyPropertyBank:SetSize(_wMod *  150, _hMod * 100 )
	buyPropertyBank:SetText("Visit The Bank!")
	buyPropertyBank.Pressed = false;
	buyPropertyBank.Frame = Frame
	buyPropertyBank.TabAlpha = 0;
	buyPropertyBank.DoBeginning = true;
	
	buyPropertyBank.RelativeColor = Color(225,225,225,255  );
	buyPropertyBank.Unhovered = Color(225,225,225,255 );
	buyPropertyBank.HoveredColor	= Color( 100, 100 , 100,255);
	buyPropertyBank.PressedColor = Color( 56, 56 , 56 ,255 );
	function buyPropertyBank:Think()
	
					if self:IsHovered() then
					
						self.RelativeColor = lerpColor( 0.05, self.RelativeColor , self.HoveredColor )
					
					elseif self:IsDown() then
					
						
						self.RelativeColor = lerpColor( 0.05, self.RelativeColor , self.PressedColor )
					
						
					elseif !self:IsHovered() then
					
						self.RelativeColor = lerpColor( 0.05, self.RelativeColor , self.Unhovered )
				
					
					end
					
	end
	
	function buyPropertyBank:Paint(w,h)
		
		
		if self.DoBeginning then
		
			self.TabAlpha = Lerp( 0.05 ,  self.TabAlpha , 255 )
			
			if self.TabAlpha >= 254 then
			
				self.DoBeginning = false
				
			end
			
		end
		
					
					//draw.RoundedBoxEx(0,0,0,w,h,Color(0,0,0,Frame.TabAlpha / 3 ),true,true)	
					draw.RoundedBoxEx(0,5,5,w-10,h-10, self.RelativeColor ,true,true)	
				
	end
	function buyPropertyBank:OnMousePressed()
		buyPropertyBank.Pressed= true;
		
		
	end
	
	function buyPropertyBank:OnMouseReleased()
		
		buyPropertyBank.Pressed = false;
		LocalPlayer():Notify("You can not buy a property with this price unless you visit the bank!")
		
	end	
	local buyProperty = vgui.Create("DButton",Frame)
	buyProperty:SetPos(  _wMod * 240, Frame:GetTall() - _hMod * 150)
	buyProperty:SetSize(_wMod *  150, _hMod * 100 )
	buyProperty:SetText("Purchase Property")
	buyProperty.Pressed = false;
	buyProperty.TabAlpha = 0;
	buyProperty.DoBeginning = true;
	
	buyProperty.Frame = Frame
	buyProperty.RelativeColor = Color(225,225,225 ,255);
	buyProperty.Unhovered = Color(225,225,225 ,255 );
	buyProperty.HoveredColor	= Color( 100, 100 , 100,255);
	buyProperty.PressedColor = Color( 56, 56 , 56,255  );
	
	function buyProperty:Think()
	

		if self.DoBeginning then
		
			self.TabAlpha = Lerp( 0.05 ,  self.TabAlpha , 255 )
			
			if self.TabAlpha >= 254 then
			
				self.DoBeginning = false
				
			end
			
		end
					if self:IsHovered() then
					
						self.RelativeColor = lerpColor( 0.05, self.RelativeColor , self.HoveredColor )
					
						
					
					
					elseif self:IsDown() then
					
						self.RelativeColor = lerpColor( 0.05, self.RelativeColor , self.PressedColor )
						
					elseif !self:IsHovered() then
					
						self.RelativeColor = lerpColor( 0.05, self.RelativeColor , self.Unhovered )
					
					end
					
	end
	function buyProperty:Paint(w,h)
		
					//draw.RoundedBoxEx(0,0,0,w,h,Color(0,0,0,Frame.TabAlpha / 3 ),true,true)	
					draw.RoundedBoxEx(0,5,5,w-10,h-10, self.RelativeColor ,true,true)	
				
		
	
	end
	function buyProperty:OnMousePressed()
		buyProperty.Pressed= true;
		
		
	end
	buyProperty.ID = id;
	function buyProperty:OnMouseReleased()
		
		buyProperty.Pressed = false;
		if LocalPlayer():canAffordBank( fsrp.PropertyTable[buyProperty.ID].Cost ) then
			
			globalPropertyFrame = nil;
			net.Start("buyPropertyFromClient")
					net.WriteInt( buyProperty.ID ,8)
			net.SendToServer()
			Frame:Remove();
		else
		
			return LocalPlayer():Notify("It seems that I cannot afford this.($"..fsrp.PropertyTable[buyProperty.ID].Cost .. ")" )
			
		end
		
	end	
	
	
	globalPropertyFrame = Frame;
	
	
	
end
function IsPropertyFrameUp()

	return globalPropertyFrame;
	
end

function RemovePropertyInfo()

	globalPropertyFrame:Remove()
	
end