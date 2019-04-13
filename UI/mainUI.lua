local addonName, KeyStoneManager = ...;
-- Minimap button 
local minibtn = CreateFrame("Button", nil, Minimap)
minibtn:SetFrameLevel(8)
minibtn:SetSize(32,32)
minibtn:SetMovable(true)

local uiflag = 0

ksmDb = KeyStoneManager.defaultsDb

minibtn:SetNormalTexture("Interface/COMMON/Indicator-Yellow.png")
minibtn:SetPushedTexture("Interface/COMMON/Indicator-Yellow.png")
minibtn:SetHighlightTexture("Interface/COMMON/Indicator-Yellow.png")
local myIconPos = 0

-- Minimap button postion..
local function UpdateMapBtn()
    local Xpoa, Ypoa = GetCursorPosition()
    local Xmin, Ymin = Minimap:GetLeft(), Minimap:GetBottom()
    Xpoa = Xmin - Xpoa / Minimap:GetEffectiveScale() + 70
    Ypoa = Ypoa / Minimap:GetEffectiveScale() - Ymin - 70
    myIconPos = math.deg(math.atan2(Ypoa, Xpoa))
    minibtn:ClearAllPoints()
    minibtn:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 52 - (80 * cos(myIconPos)), (80 * sin(myIconPos)) - 52)
end
 
-- Minimap button left clicked
minibtn:RegisterForDrag("LeftButton")
minibtn:SetScript("OnDragStart", function()
    minibtn:StartMoving()
    minibtn:SetScript("OnUpdate", UpdateMapBtn)
end)
 
minibtn:SetScript("OnDragStop", function()
    minibtn:StopMovingOrSizing();
    minibtn:SetScript("OnUpdate", nil)
    UpdateMapBtn();
end)
 
-- Minimap Set position
minibtn:ClearAllPoints();
minibtn:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 52 - (80 * cos(myIconPos)),(80 * sin(myIconPos)) - 52)
  

-- Minimap Control clicks
minibtn:SetScript("OnClick", function()
    uiflag = 1 - uiflag
	if uiflag == 1 then 
		    -- create UI frame
		-- Todo: get size from configuration.
		-- Todo: get position from configuration.
		
		uiFrameSizeX = 200
		uiFrameSizeY = 180
		uiFrame = CreateFrame("Frame", "uiFrame", UIParent)
		
		uiFrame:SetSize(uiFrameSizeX, uiFrameSizeY)
		ksmDb = keystone_table
		
		if ksmDb.config.uiPositionL == nil or ksmDb.config.uiPositionB == nil then
			uiFrame:SetPoint("CENTER")
			ksmDb.config.uiPositionL = uiFrame:GetLeft()
			ksmDb.config.uiPositionB = uiFrame:GetBottom()
		end 
		
		uiFrame:SetPoint("BOTTOMLEFT", ksmDb.config.uiPositionL, ksmDb.config.uiPositionB)
		uiFrame:SetBackdrop( {
			bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
			tile = true,
			tilesize = 5,
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			edgeSize = 10,
			insets = { left = 4, right = 3, top = 4, bottom = 3}
			} )
		uiFrame:SetBackdropColor(0.2,0.2,0.2,0.7)

		uiFrame:SetMovable(true)
		uiFrame:EnableMouse(true)
		uiFrame:RegisterForDrag("LeftButton")
		uiFrame:SetScript("OnDragStart", function()
			uiFrame:StartMoving()
		end)
		
		uiFrame:SetScript("OnDragStop", function(self)
			uiFrame:StopMovingOrSizing();
			ksmDb.config.uiPositionL = self:GetLeft()
			ksmDb.config.uiPositionB = self:GetBottom()
		end)

		buttonSizeX = 60
		buttonSizeY = 20
		updateButton = CreateFrame("Button", "updateButton", uiFrame, "OptionsButtonTemplate")
		updateButton:SetText("Update")
		updateButton:SetSize(buttonSizeX, buttonSizeY)
		updateButton:SetPoint("BOTTOM", 0 - buttonSizeX - 5 , 5) 
		updateButton:SetScript("OnClick", KeyStoneManager.OnClick_UpdateButton) 
		
		clearButton = CreateFrame("Button", "clearButton", uiFrame, "OptionsButtonTemplate")
		clearButton:SetText("Clear")
		clearButton:SetSize(buttonSizeX, buttonSizeY)
		clearButton:SetPoint("BOTTOM", 0, 5) 
		clearButton:SetScript("OnClick", KeyStoneManager.clearc) 
		
		chatButton = CreateFrame("Button", "chatButton", uiFrame, "OptionsButtonTemplate")
		chatButton:SetText("Chat")
		chatButton:SetSize(buttonSizeX, buttonSizeY)
		chatButton:SetPoint("BOTTOM", 0 + buttonSizeX + 5, 5) 
		chatButton:SetScript("OnClick", nil) 
	elseif uiflag == 0 then
		--updateButton:Hide()
		uiFrame:Hide()
		--KeyStoneManager.clearc()
	end

end)

