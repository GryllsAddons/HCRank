MobRank = CreateFrame("Frame", nil, UIParent)
MobRank:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
MobRank:RegisterEvent("PLAYER_ENTERING_WORLD")
MobRank:RegisterEvent("PLAYER_LEVEL_UP")

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
        MobRank.mobs = {}
        MobRank.players = {}
    end

    MobRank.mobs_1020 = {}
    MobRank.mobs_2130 = {}
    MobRank.mobs_3140 = {}
    MobRank.mobs_4159 = {}
end

MobRank:SetScript("OnEvent", function()
  if (event == "UPDATE_MOUSEOVER_UNIT") then
    local name = UnitName("mouseover")
    local player = UnitIsPlayer("mouseover")
    local mob

    if player then
      mob = MobRank.players[name]
    else
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