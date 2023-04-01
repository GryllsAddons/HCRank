MobRank = CreateFrame("Frame", nil, UIParent)	
MobRank:RegisterEvent("UPDATE_MOUSEOVER_UNIT")

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
    local name = UnitName("mouseover")
    local mob = MobRank.mobs[name]
    if mob then
      local rank = MobRank.mobs[name]["Rank"]
      local kills = MobRank.mobs[name]["Kills"]
      local color = colorRank(rank)
      GameTooltip:AddLine("Players Killed: " .. kills)
      GameTooltip:AddLine("|cff" .. color .. "Mob Rank: " .. rank .. "|r")
      GameTooltip:Show()
    end
end)