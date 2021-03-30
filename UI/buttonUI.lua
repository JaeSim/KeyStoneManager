local addonName, LiteKeyStoneManager = ...;

chatflag = 0
clearflag = 0


function createsButton()
	--Button--
	buttonSizeX = 60
	buttonSizeY = 20
	updateButton = CreateFrame("Button", "updateButton", uiFrame, "GameMenuButtonTemplate")
	updateButton:SetText("Update")
	updateButton:SetSize(buttonSizeX, buttonSizeY)
	updateButton:SetPoint("TOP", -30 , -5) 
	updateButton:SetScript("OnClick", LiteKeyStoneManager.OnClick_UpdateButton) 

	chatButton = CreateFrame("Button", "chatButton", uiFrame, "GameMenuButtonTemplate")
	chatButton:SetText("Chat")
	chatButton:SetSize(buttonSizeX, buttonSizeY)
	chatButton:SetPoint("TOP", 30, -5) 
	chatButton:SetScript("OnClick", toggleChatFrame) 

	clearButton = CreateFrame("Button", "clearButton", uiFrame, "UIPanelButtonGrayTemplate")
	clearButton:SetText("Clear")
	clearButton:SetSize(buttonSizeX, buttonSizeY)
	clearButton:SetPoint("BOTTOMRIGHT", -5, 5) 
	clearButton:SetScript("OnClick", toggleClearFrame) 
	
	closeButton2 = CreateFrame("Button", "closeButton2", uiFrame, "GameMenuButtonTemplate")
	closeButton2:SetText("Close")
	closeButton2:SetSize(buttonSizeX, buttonSizeY)
	closeButton2:SetPoint("BOTTOM", 0, 5) 
	closeButton2:SetScript("OnClick", toggleUI) 
	
	closeButton = CreateFrame("Button", "closeButton", uiFrame, "UIPanelCloseButton")
	closeButton:SetText("X")
	closeButton:SetSize(30, 30)
	closeButton:SetPoint("TOPRIGHT", 0,0) 
	closeButton:SetScript("OnClick", toggleUI) 
	
	tempTable = LiteKeyStoneManager.widthInfo.widths
	for k, v in pairs(tempTable) do
		if v < 40 then
		    LiteKeyStoneManager.widthInfo.widths[k] = 40
		end
	end
			
	-- lable button
	local commonPosy = -25
	local buttonArray = {}
	nameButton = CreateFrame("Button", "nameButton", uiFrame, "UIPanelButtonGrayTemplate,BackdropTemplate")
	nameButton:SetText("이름")
	nameButton:SetSize(30, 20)
	nameButton:SetPoint("TOPLEFT", 10 ,commonPosy) 
	nameButton:SetScript("OnClick", function()
		if ksmDb.config.clickedButton == 1 then
			ksmDb.config.clickedButtonToggle = 1 -ksmDb.config.clickedButtonToggle
		end
		ksmDb.config.clickedButton = 1
		reDrawUI()
		--print(ksmDb.config.clickedButtonToggle)
	end) 
	buttonArray[1] = nameButton
	
	itemLevelButton = CreateFrame("Button", "itemLevelButton", uiFrame, "UIPanelButtonGrayTemplate,BackdropTemplate")
	itemLevelButton:SetText("템렙")
	itemLevelButton:SetSize(30, 20)
	itemLevelButton:SetPoint("TOPLEFT", 10 + LiteKeyStoneManager.widthInfo.widths["nameLen"] ,commonPosy) 
	itemLevelButton:SetScript("OnClick", function()
		if ksmDb.config.clickedButton == 2 then
			ksmDb.config.clickedButtonToggle = 1 -ksmDb.config.clickedButtonToggle
		end
		ksmDb.config.clickedButton = 2
		reDrawUI()
	end) 
	buttonArray[2] = itemLevelButton
	
	dgnameButton = CreateFrame("Button", "dgnameButton", uiFrame, "UIPanelButtonGrayTemplate,BackdropTemplate")
	dgnameButton:SetText("던전")
	dgnameButton:SetSize(30, 20)
	dgnameButton:SetPoint("TOPLEFT", 10 + LiteKeyStoneManager.widthInfo.widths["nameLen"] 
	+ LiteKeyStoneManager.widthInfo.widths["itemLevelLen"],commonPosy) 
	dgnameButton:SetScript("OnClick", function()
		if ksmDb.config.clickedButton == 3 then
			ksmDb.config.clickedButtonToggle = 1 -ksmDb.config.clickedButtonToggle
		end
		ksmDb.config.clickedButton = 3
		reDrawUI()
	end) 
	buttonArray[3] = dgnameButton
	
	dglevelButton = CreateFrame("Button", "dglevelButton", uiFrame, "UIPanelButtonGrayTemplate,BackdropTemplate")
	dglevelButton:SetText("단수")
	dglevelButton:SetSize(30, 20)
	dglevelButton:SetPoint("TOPLEFT", 10 + LiteKeyStoneManager.widthInfo.widths["nameLen"] 
	+ LiteKeyStoneManager.widthInfo.widths["itemLevelLen"] 
	+ LiteKeyStoneManager.widthInfo.widths["dgnameLen"],commonPosy) 
	dglevelButton:SetScript("OnClick", function()
		if ksmDb.config.clickedButton == 4 then
			ksmDb.config.clickedButtonToggle = 1 -ksmDb.config.clickedButtonToggle
		end
		ksmDb.config.clickedButton = 4
		reDrawUI()
	end) 
	buttonArray[4] = dglevelButton
		
	parkLevelButton = CreateFrame("Button", "parkLevelButton", uiFrame, "UIPanelButtonGrayTemplate,BackdropTemplate")
	parkLevelButton:SetText("주차")
	parkLevelButton:SetSize(30, 20)
	parkLevelButton:SetPoint("TOPLEFT", 10 + LiteKeyStoneManager.widthInfo.widths["nameLen"] 
	+ LiteKeyStoneManager.widthInfo.widths["itemLevelLen"] 
	+ LiteKeyStoneManager.widthInfo.widths["dgnameLen"] 
	+ LiteKeyStoneManager.widthInfo.widths["dglevelLen"],commonPosy) 
	parkLevelButton:SetScript("OnClick", function()
		if ksmDb.config.clickedButton == 5 then
			ksmDb.config.clickedButtonToggle = 1 -ksmDb.config.clickedButtonToggle
		end
		ksmDb.config.clickedButton = 5
		reDrawUI()
	end) 
	buttonArray[5] = parkLevelButton
	
	--clicked button
	buttonArray[ksmDb.config.clickedButton]:SetBackdrop( {
		bgFile = [[Interface\Common\dark-goldframe-button]],
		insets = { left = 0, right = 0, top = 0, bottom = 0}
	})
	
	buttonArray[ksmDb.config.clickedButton]:SetNormalTexture(nil)
	
	if chatflag == 1 then
		createChatFrame()
	end
	if clearflag == 1 then
		createClearFrame()
	end
end

function toggleChatFrame()
    chatflag = 1 - chatflag
	if chatflag == 1 then 
		createChatFrame()
	elseif chatflag == 0 then
		chatFrame:Hide()
	end
end

function createChatFrame()
	chatFrame = CreateFrame("Frame", "chatFrame", chatButton, "BackdropTemplate")
	
	chatFrame:SetSize(100, 150)
	
	chatFrame:SetPoint("BOTTOMLEFT", 20, 5)
	chatFrame:SetBackdrop( {
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		tile = true,
		tilesize = 5,
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		edgeSize = 10,
		insets = { left = 4, right = 3, top = 4, bottom = 3}
		} )
	chatFrame:SetBackdropColor(0.2,0.2,0.2,0.7)
	
	cancelButton = CreateFrame("Button", "cancelButton", chatFrame, "GameMenuButtonTemplate")
	cancelButton:SetText("CANCEL")
	cancelButton:SetSize(80, 20)
	cancelButton:SetPoint("BOTTOM", 0, 5) 
	cancelButton:SetScript("OnClick", toggleChatFrame) 
	
	local strarray = { "일반", "파티" , "인스" ,"길드" }
	local chattypearry = { "SAY", "PARTY", "RAID", "GUILD" }
	local chatbuttons = {}
	
	
	for i =1 , 4, 1 do
		sayButton = CreateFrame("Button", "sayButton", chatFrame, "GameMenuButtonTemplate")
		local displaytext = "["..i.."] "..strarray[i]
		local info = ChatTypeInfo[chattypearry[i]]
		displaytext = format("|cff%02x%02x%02x%s|r", info.r*255, info.g*255, info.b*255, displaytext)
		sayButton:SetText(displaytext)
		sayButton:SetSize(80, 20)
		local ypos = 20 + (i * -25)
		sayButton:SetPoint("TOP", 0, ypos) 
		sayButton:SetScript("OnClick", function() 
		    LiteKeyStoneManager.OnClick_ChatButton(chattypearry[i]) 
			toggleChatFrame()
		end)	
		sayButton:SetNormalTexture("Interface\\Common\\dark-goldframe-button")
		chatButton[i] = sayButton
	end	
end

function toggleClearFrame()
    clearflag = 1 - clearflag
	if clearflag == 1 then 
		createClearFrame()
	elseif clearflag == 0 then
		clearFrame:Hide()
	end
end

function createClearFrame() 
	clearFrame = CreateFrame("Frame", "clearFrame", clearButton, "BackdropTemplate")
	clearFrame:SetSize(250, 60)
	clearFrame:SetPoint("BOTTOMLEFT", 20, 5)
	clearFrame:SetBackdrop( {
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		tile = true,
		tilesize = 5,
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		edgeSize = 10,
		insets = { left = 4, right = 3, top = 4, bottom = 3}
		} )
	clearFrame:SetBackdropColor(0.2,0.2,0.2,0.7)
	
	confirmYesButton = CreateFrame("Button", "confirmYesButton", clearFrame, "UIPanelButtonGrayTemplate")
	confirmYesButton:SetText("YES")
	confirmYesButton:SetSize(80, 20)
	confirmYesButton:SetPoint("BOTTOM", -40, 5) 
	confirmYesButton:SetScript("OnClick", function() 
	    LiteKeyStoneManager.clearc()
		toggleClearFrame()
	end) 
	
	confirmNoButton = CreateFrame("Button", "confirmNoButton", clearFrame, "GameMenuButtonTemplate")
	confirmNoButton:SetText("NO")
	confirmNoButton:SetSize(80, 20)
	confirmNoButton:SetPoint("BOTTOM", 40, 5) 
	confirmNoButton:SetScript("OnClick", toggleClearFrame) 
	
	local clearText = CreateFrame("Frame", nil, clearFrame)
	clearText:SetWidth(1) 
	clearText:SetHeight(1) 
	clearText:SetPoint("TOP", 0,-10)
	clearText.text = clearText:CreateFontString(nil,"ARTWORK") 
	clearText.text:SetFont([[Fonts\2002.TTF]], 13, "OUTLINE")
	clearText.text:SetPoint("TOP")
	clearText.text:SetJustifyH("LEFT"); -- Left or Right
	clearText.text:SetJustifyV("TOP"); -- Top or Bottom
	clearText.text:SetText("Do you want to erase all data?")
end