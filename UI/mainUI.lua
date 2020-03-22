local addonName, LiteKeyStoneManager = ...;

local uiflag = 0

ksmDb = LiteKeyStoneManager.defaultsDb

-- Minimap Control clicks
function toggleUI() 
	if uiFrame ~= nil then
		local isVisible = uiFrame:IsVisible()
		-- For escape key case, it should be toggled again
		if isVisible == false and uiflag == 1 then
			uiflag = 0
		end
	end
	
	uiflag = 1 - uiflag

	if uiflag == 1 then 
	    C_MythicPlus.RequestRewards()
		UpdateUI()
		uiFrame:Show()
	elseif uiflag == 0 then
		uiFrame:Hide()
		chatflag = 0
		clearflag = 0
	end
end

function reDrawUI()
    uiFrame:Hide()
	UpdateUI()
	uiFrame:Show()
end

function UpdateUI()
	-- create UI frame
	-- Todo: get size from configuration.
	if (uiflag == 1) then 
		local isVisible = false
		if uiFrame ~= nil then
			isVisible = uiFrame:IsVisible()
			uiFrame:Hide()
		end
		uiFrameSizeX = 280
		uiFrameSizeY = 220
		uiFrame = CreateFrame("Frame", "uiFrame", UIParent)
		tinsert(UISpecialFrames, "uiFrame")
		uiFrame:SetSize(uiFrameSizeX, uiFrameSizeY)
		uiFrame:Hide()
		
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
		--TEXT --
		

		Node = LiteKeyStoneManager:GetSortedNode()
		
		local nameFull = "" local itemlevelFull = "" local dgnameFull = "" local dglevelFull = "" local parkLevelFull = ""
		for _, node in ipairs(Node) do
			nameFull = nameFull .. format('|c%s%s|r\n', RAID_CLASS_COLORS[node.cl].colorStr, node.name)
			itemlevelFull = itemlevelFull .. format('|c%s%d|r\n', select(4,GetItemQualityColor(4)), node.itemlevel)
			dgnameFull = dgnameFull .. format('|c%s%s|r\n', select(4,GetItemQualityColor(4)), node.dgname)
			dglevelFull = dglevelFull .. format('|c%s%d|r\n', select(4,GetItemQualityColor(4)), node.dglevel)
			
			if (node.parkLevel == 0) then
				parkLevelFull = parkLevelFull .. format('NO\n')
			else
				parkLevelFull = parkLevelFull .. format('|c%s%d|r\n', select(4,GetItemQualityColor(2)),node.parkLevel)
			end
		end
		
		local commonPosy = -50
		local nameFame = CreateFrame("Frame", nil, uiFrame)
		nameFame:SetWidth(1) 
		nameFame:SetHeight(1) 
		nameFame:SetPoint("TOPLEFT", 10,commonPosy)
		nameFame.text = nameFame:CreateFontString(nil,"ARTWORK") 
		nameFame.text:SetFont([[Fonts\2002.TTF]], 13, "OUTLINE")
		nameFame.text:SetPoint("TOPLEFT")
		nameFame.text:SetJustifyH("LEFT"); -- Left or Right
		nameFame.text:SetJustifyV("TOP"); -- Top or Bottom
		nameFame.text:SetText(nameFull)
		local nameLen = 100
		
		local itemLevel = CreateFrame("Frame", nil, uiFrame)
		itemLevel:SetWidth(1) 
		itemLevel:SetHeight(1) 
		itemLevel:SetPoint("TOPLEFT", 10 + nameLen ,commonPosy)
		itemLevel.text = itemLevel:CreateFontString(nil,"ARTWORK") 
		itemLevel.text:SetFont([[Fonts\2002.TTF]], 13, "OUTLINE")
		itemLevel.text:SetPoint("TOPLEFT")
		itemLevel.text:SetJustifyH("LEFT"); -- Left or Right
		itemLevel.text:SetJustifyV("TOP"); -- Top or Bottom
		itemLevel.text:SetText(itemlevelFull)

		local dgname = CreateFrame("Frame", nil, uiFrame)
		dgname:SetWidth(1) 
		dgname:SetHeight(1) 
		dgname:SetPoint("TOPLEFT", 10 + nameLen + 40,commonPosy)
		dgname.text = dgname:CreateFontString(nil,"ARTWORK") 
		dgname.text:SetFont([[Fonts\2002.TTF]], 13, "OUTLINE")
		dgname.text:SetPoint("TOPLEFT")
		dgname.text:SetJustifyH("LEFT"); -- Left or Right
		dgname.text:SetJustifyV("TOP"); -- Top or Bottom
		dgname.text:SetText(dgnameFull)
		
		local dglevel = CreateFrame("Frame", nil, uiFrame)
		dglevel:SetWidth(1) 
		dglevel:SetHeight(1) 
		dglevel:SetPoint("TOPLEFT", 10 + nameLen + 40 + 40,commonPosy)
		dglevel.text = dglevel:CreateFontString(nil,"ARTWORK") 
		dglevel.text:SetFont([[Fonts\2002.TTF]], 13, "OUTLINE")
		dglevel.text:SetPoint("TOPLEFT")
		dglevel.text:SetJustifyH("RIGHT"); -- Left or Right
		dglevel.text:SetJustifyV("TOP"); -- Top or Bottom
		dglevel.text:SetText(dglevelFull)
		
		local parkLevel = CreateFrame("Frame", nil, uiFrame)
		parkLevel:SetWidth(1) 
		parkLevel:SetHeight(1) 
		parkLevel:SetPoint("TOPLEFT", 10 + nameLen + 40 + 40 + 40,commonPosy)
		parkLevel.text = parkLevel:CreateFontString(nil,"ARTWORK") 
		parkLevel.text:SetFont([[Fonts\2002.TTF]], 13, "OUTLINE")
		parkLevel.text:SetPoint("TOPLEFT")
		parkLevel.text:SetJustifyH("RIGHT"); -- Left or Right
		parkLevel.text:SetJustifyV("TOP"); -- Top or Bottom
		parkLevel.text:SetText(parkLevelFull)
		
		-- refer buttonUI.lua
		createsButton()
		
		if isVisible == true then
			uiFrame:Show()
		end
	end
end

minimap_config = {
	MinimapPos = 45
}

function LiteKeyStoneManager_MinimapButton_Reposition()
	LiteKeyStoneManager_MinimapButton:SetPoint("TOPLEFT","Minimap","TOPLEFT",52-(80*cos(minimap_config.MinimapPos)),(80*sin(minimap_config.MinimapPos))-52)
end

function LiteKeyStoneManager_MinimapButton_DraggingFrame_OnUpdate()
	local xpos,ypos = GetCursorPosition()
	local xmin,ymin = Minimap:GetLeft(), Minimap:GetBottom()

	xpos = xmin-xpos/UIParent:GetScale()+70
	ypos = ypos/UIParent:GetScale()-ymin-70

	minimap_config.MinimapPos = math.deg(math.atan2(ypos,xpos))
	LiteKeyStoneManager_MinimapButton_Reposition()
end