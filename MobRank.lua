MobRank = CreateFrame("Frame", nil, UIParent)
MobRank:RegisterEvent("PLAYER_ENTERING_WORLD")
MobRank:RegisterEvent("PLAYER_LEVEL_UP")
MobRank:RegisterEvent("UPDATE_MOUSEOVER_UNIT")

local function colorRank(rank)
  -- https://colorkit.co/gradient-palette/ff0000-f7ef00/?steps=4
  local color = "ffffff"
  if rank >= 75 then
    color = "f7ef00"
  elseif rank >= 50 then
    color = "faa000"    
  elseif rank >= 25 then
    color = "fc5100"    
  elseif rank >= 1 then
    color = "ff0000"
  end
  return color
end

local function LoadData()
  MobRank.Data()  
  local level = UnitLevel("player")
    if (level <= 20) then
        MobRank.mobs = MobRank.mobs_1020        
    elseif (level <= 30) then
        MobRank.mobs = MobRank.mobs_2130
    elseif (level <= 40) then
        MobRank.mobs = MobRank.mobs_3140
    elseif (level <= 59) then
        MobRank.mobs = MobRank.mobs_4159
    else
        MobRank.mobs = nil
    end

    MobRank.mobs_1020 = nil
    MobRank.mobs_2130 = nil
    MobRank.mobs_3140 = nil
    MobRank.mobs_4159 = nil
end

MobRank:SetScript("OnEvent", function()
  if (event == "UPDATE_MOUSEOVER_UNIT") then
    local name = UnitName("mouseover")
    local player = UnitIsPlayer("mouseover")
    local mob

    if player then
      mob = MobRank.players[name]
    elseif MobRank.mobs then
      mob = MobRank.mobs[name]
    end

    if mob then      
      local kills = mob["Kills"]
      local rank = mob["Rank"]
      local color = colorRank(rank)
      GameTooltip:AddLine("Players Killed: " .. kills)
      GameTooltip:AddLine("|cff" .. color .. "Mob Rank: " .. rank .. "|r")
      GameTooltip:Show()
    end
  else
    LoadData()
  end
end)

DEFAULT_CHAT_FRAME:AddMessage("|cfffc5100MobRank Loaded!|r")