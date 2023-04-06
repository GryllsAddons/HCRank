MobRank = CreateFrame("Frame", nil, UIParent)
MobRank:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
MobRank:RegisterEvent("PLAYER_ENTERING_WORLD")
MobRank:RegisterEvent("PLAYER_LEVEL_UP")

local function colorRank(num)
  -- https://colorkit.co/gradient-palette/ff0000-f7ef00/?steps=4
  local color = "ffffff"
  if num >= 75 then
    color = "f7ef00"
  elseif num >= 50 then
    color = "faa000"    
  elseif num >= 25 then
    color = "fc5100"    
  elseif num >= 1 then
    color = "ff0000"
  end
  return color
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
      MobRank.loadMobs()
  end
end)