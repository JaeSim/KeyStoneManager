local addonName, KeyStoneManager = ...;
-- Minimap button 
local minibtn = CreateFrame("Button", nil, Minimap)
minibtn:SetFrameLevel(8)
minibtn:SetSize(32,32)
minibtn:SetMovable(true)

local uiflag = 0

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
    -- create UI frame
	local uiFrame = CreateFrame("Frame")
    uiflag = 1 - uiflag
	if uiflag == 1 then 
		print("create button")
		updateButton = CreateFrame("Button", "updateButton", UIParent, "OptionsButtonTemplate")
		updateButton:SetText("U") 
		updateButton:SetPoint("CENTER") 
		
		updateButton:SetScript("OnClick", KeyStoneManager.OnClick_UpdateButton) 
	elseif uiflag == 0 then
		print("delete button")
		updateButton:Hide()
		KeyStoneManager.clearc()
	end

end)

