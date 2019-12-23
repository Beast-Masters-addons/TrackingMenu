--Add API methods not available in classic

TrackingApi = {}
TrackingApi.TrackingSpells = {}
TrackingApi.TrackingSpellIcons = {}
TrackingApi.TrackingSpellsNum = {}

function TrackingApi:BuildSpellList()
    local count = 0
    local _, _, offset, numSpells = GetSpellTabInfo(4);

    for i = offset + 1, offset + numSpells do
        local spellIcon = GetSpellBookItemTexture(i, BOOKTYPE_SPELL);

        local spellName = GetSpellBookItemName(i, BOOKTYPE_SPELL);
        local _, spellId = GetSpellBookItemInfo(i, BOOKTYPE_SPELL)

        local tracked = spellName:match('Track (%a+)')

        if tracked then
            self.TrackingSpells[spellId] = { id=spellId, name=spellName, icon= spellIcon }
            table.insert(self.TrackingSpellsNum, { id=spellId, name=spellName, icon= spellIcon })
            self.TrackingSpellIcons[spellIcon] = spellId
            count = count + 1
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

function GetTrackingSpellInfo(id)
    local spell = self.TrackingSpells[id]
    local _, _, currentId = self:GetCurrentTracking()
    local active
    if currentId == id then
        active = true
    else
        active = false
    end

    return spell['name'], spell['icon'], active
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