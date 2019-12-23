BOOKTYPE_SPELL = "spell"

local spellBook = {}
spellBook[42] = { "Disengage", "Rank 1", 781, 132294}
spellBook[43] = { "Freezing Trap", "Rank 1", 1499, 135834}
spellBook[44] = { "Immolation Trap", "Rank 1", 13795}
spellBook[45] = { "Raptor Strike", "Rank 1", 2973}
spellBook[46] = { "Raptor Strike", "Rank 2", 14260}
spellBook[47] = { "Raptor Strike", "Rank 3", 14261}
spellBook[48] = { "Track Beasts", "", 1494, 132238}
spellBook[49] = { "Track Humanoids", "", 19883, 135942}
spellBook[50] = { "Wing Clip", "Rank 1", 2974, 132309}

function UnitClass(_)
    return "Hunter", "HUNTER", 3
end

function GetSpellTabInfo(tab)
    if tab == 4 then
        return "Survival", 132215, 41, 9, false, 0, false
    end
end

function GetSpellTexture(spellId)
    local textures = {}
    textures[781] = 132294

    if not textures[spellId] then
        error('Texture not found for spell', spellId)
        return
    end
    return textures[spellId]
end

function GetSpellBookItemTexture(slotIndex, _)
    return spellBook[slotIndex][4]
end

function GetSpellBookItemName(slotIndex, _)
    return spellBook[slotIndex][1], spellBook[slotIndex][2], spellBook[slotIndex][3]
end

function GetSpellBookItemInfo(index, bookType)
    local spell = spellBook[index]
    return bookType, spell[3]
end

function GetTrackingTexture()
    return _G['currentTrackingTexture']
end

function CastSpellByName(spellName)
    _G['lastSpellName'] = spellName
end