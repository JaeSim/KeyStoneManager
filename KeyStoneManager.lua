local addonName, KeyStoneManager = ...;

local PlayerName = GetUnitName("player")
local localizedClass, englishClass, classIndex = UnitClass("player")

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
	node = {}
};

function KeyStoneManager:OnClick_UpdateButton(self)
	--SendChatMessage("한글","SAY") 
	print("You clicked me!")
	updateKeyStoneDb()
end

function initialize() 

end

local function OnEvent(self, event, msg, _, _, _, lootingUser)
	-- SendChatMessage("접속","SAY") 
	print("enter world!")
    if (event =="PLAYER_LOGIN") then
		initialize()
		updateKeyStoneDb()
  
	elseif (event =="CHAT_MSG_LOOT") then -- 아이템을 획득하면,
		local _, _, itemID = strsplit(":", msg) 
		print("쐐기돌 획득-!")
		-- local ItemName = GetItemInfo(itemID) 
		if (PlayerName == lootingUser) and (138019 == itemID) then 
			updateKeyStoneDb()
      end
   end
end

function updateKeyStoneDb()
	FindCurrentKeystone()
end

MyAddonFrame = CreateFrame("Frame", nil, UIParent) 
MyAddonFrame:SetScript("OnEvent",OnEvent) 
MyAddonFrame:RegisterEvent("PLAYER_LOGIN")
MyAddonFrame:RegisterEvent("CHAT_MSG_LOOT")

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
                    bagID = bag
                    slotNum = slot
                    local itemLink = GetContainerItemLink(bag, slot)
					
                    local info = ParseKey(itemLink)
					local overall, equipped = GetAverageItemLevel()
					
					if not keystone_table or type(keystone_table) ~= 'table' then 
					    keystone_table = defaultsDb
					end
					
					keystone_table.node[PlayerName] = {
						name = PlayerName,
						cl = classIndex,
						itemlevel = equipped,
						dgname = dgNames[info.dgId+0],
						dglevel = info.keylevel,
					}
					for _, node in pairs(keystone_table.node) do
						print(format('%s %d  %s+%2d단', node.name, node.itemlevel, node.dgname, node.dglevel))
					end
					
                    exists = true
                    return itemLink
                    
                end
                if not exists then
                    -- clear
                end
            end   
        end
    end    
end

-- extract meaningful data from the keystone itemlink
function ParseKey(link)
	if not link then
		return nil
	end

	local parts = { strsplit(':', link) }
	local dgId = parts[3]
	local keylevel = parts[4]
	-- print(dgId) print(keylevel)
	-- print(dgNames[dgId+0])
	
	return {
		dgId = dgId,
		keylevel = keylevel
    }
end
