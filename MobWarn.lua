MobWarn = CreateFrame("Frame", nil, UIParent)	
MobWarn:RegisterEvent("UPDATE_MOUSEOVER_UNIT")

local function color(deaths)
  if deaths >= 50 then
    return "f44336"
  elseif deaths >= 25 then
    return "ff8000"
  else
    return "ffff00"
  end
end

MobWarn:SetScript("OnEvent", function()
    local name = UnitName("mouseover")
    local deaths = MobWarn.mobs[name]    
    if deaths then
      GameTooltip:AddLine("|cff" .. color(deaths) .. "Players killed: " .. deaths .."|r")   
      GameTooltip:Show()
    end
end)