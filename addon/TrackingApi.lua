--Add API methods not available in classic

TrackingApi = {}
TrackingApi.TrackingSpells = {}
TrackingApi.TrackingSpellIcons = {}
TrackingApi.TrackingSpellsNum = {}

function TrackingApi:BuildSpellList(keywords)
    local count = 0
	local tracked
	if not keywords then
		keywords = {'Track', 'Find'}
	end
	for tab=1,4 do
		local _, _, offset, numSpells = GetSpellTabInfo(tab);

		for i = offset + 1, offset + numSpells do
			local spellIcon = GetSpellBookItemTexture(i, BOOKTYPE_SPELL);

			local spellName = GetSpellBookItemName(i, BOOKTYPE_SPELL);
			local _, spellId = GetSpellBookItemInfo(i, BOOKTYPE_SPELL)

			for _, keyword in ipairs(keywords) do
				tracked = spellName:match(keyword..' (%a+)')
				if tracked then
					break
				end
			end

			if tracked then
				self.TrackingSpells[spellId] = { id=spellId, name=spellName, icon= spellIcon }
				table.insert(self.TrackingSpellsNum, { id=spellId, name=spellName, icon= spellIcon })
				self.TrackingSpellIcons[spellIcon] = spellId
				count = count + 1
			end
		end
	end
    self.NumTrackingTypes = count
    return self.TrackingSpells
end

function TrackingApi:GetCurrentTracking()
    local icon = GetTrackingTexture()
    if not icon then
        return
    end
    local spellId = self.TrackingSpellIcons[icon]
    local spell = self.TrackingSpells[spellId]
    return spell['name'], spell['icon'], spell['id']
end

function TrackingApi:IsCurrentTracking(spellId)
    local _, _, currentId = self:GetCurrentTracking()
    if currentId == spellId then
        return true
    else
        return false
    end
end

function GetTrackingInfo(id)
    local spell = TrackingApi.TrackingSpellsNum[id]
    local active = TrackingApi:IsCurrentTracking(spell['id'])
    return spell['name'], spell['icon'], active, "spell", -1
end

function GetNumTrackingTypes()
    return TrackingApi.NumTrackingTypes
end

function SetTracking(id, _)
    local spell = TrackingApi.TrackingSpellsNum[id]
    CastSpellByName(spell['name'])
end