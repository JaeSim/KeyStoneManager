local addonName, KeyStoneManager = ...;

local PlayerName = GetUnitName("player")
local localizedClass, englishClass, classIndex = UnitClass("player")
local mythicApiFlag = true
local dgNames = {
	[244] = '아탈',
	[245] = '자유',
	[246] = '톨다',
	[247] = '왕노',
	[248] = '저택',
	[249] = '왕안',
	[250] = '세스',
	[251] = '썩굴',
	[252] = '폭사',
	[353] = '보랄',
};

local defaultsDb = {
	node = {},
	config = {
	    uiPositionL = nil,
		uiPositionB = nil,
	}
};

function KeyStoneManager:OnClick_UpdateButton(self)
	--SendChatMessage("한글","SAY") 
	updateKeyStoneDb()
	UpdateUI()
end

function KeyStoneManager:clearc(self)
	keystone_table.node = {}
	UpdateUI()
end

function initialize() 
	C_MythicPlus.RequestRewards()
end

local function OnEvent(self, event, msg, _, _, _, lootingUser)
	-- SendChatMessage("접속","SAY") 
    if (event =="PLAYER_LOGIN") then
		print("enter world!")
		initialize()
		--updateKeyStoneDb()
  
	elseif (event =="CHAT_MSG_LOOT") then -- 아이템을 획득하면,
		local _, _, itemID = strsplit(":", msg) 
		-- local ItemName = GetItemInfo(itemID) 
		if (PlayerName == lootingUser) and (138019 == itemID) then 
			print("쐐기돌 획득-!")
			updateKeyStoneDb()
        end
	elseif event == "CHALLENGE_MODE_MAPS_UPDATE" then
	    -- WOW API ISSUE . CHALLENGE_MODE_MAPS_UPDATE should be checked.
		if mythicApiFlag then   -- it is for do just only one
			mythicApiFlag = false
		elseif not mythicApiFlag then 
			return
		end
	    updateKeyStoneDb()
    end
end


function updateKeyStoneDb()
	FindCurrentKeystone()
	--https://www.wowinterface.com/forums/showthread.php?t=56454
	--for _, node in pairs(keystone_table.node) do
	--	print(format('%s %d  %s %2d단 주차- %2d', node.name, node.itemlevel, node.dgname, node.dglevel,
    --	                                          node.parkLevel))
	-- end

end

MyAddonFrame = CreateFrame("Frame", nil, UIParent) 
MyAddonFrame:SetScript("OnEvent",OnEvent) 
MyAddonFrame:RegisterEvent("PLAYER_LOGIN")
MyAddonFrame:RegisterEvent("CHAT_MSG_LOOT")
MyAddonFrame:RegisterEvent("CHALLENGE_MODE_MAPS_UPDATE")
	
function FindCurrentKeystone()
	-- print("findkeystone")
    local itemID = 138019
    local BFAkey = 158923
    local exists = false

    if UnitLevel("player") == 120 then
		--print("player 120")
        for bag = 0, NUM_BAG_SLOTS do
            for slot = 0, GetContainerNumSlots(bag) do
                if(GetContainerItemID(bag, slot) == itemID or GetContainerItemID(bag, slot) == BFAkey) then                    					
                    exists = true
                    break 
                end
                if not exists then
                    -- clear
                end
            end   
			if exists then
				break
			end
        end
    end
	
	if exists then 
		local mapId = C_MythicPlus.GetOwnedKeystoneChallengeMapID();
		local level = C_MythicPlus.GetOwnedKeystoneLevel();
		local park,_,_,_ = C_MythicPlus.GetWeeklyChestRewardLevel();
		
		local overall, equipped = GetAverageItemLevel()
		if not keystone_table or type(keystone_table) ~= 'table' then 
			keystone_table = defaultsDb
		end
		
		keystone_table.node[PlayerName] = {
			name = PlayerName,
			cl = englishClass,
			itemlevel = equipped,
			dgname = dgNames[mapId],
			dglevel = level,
			parkLevel = park
		}    
	end
end