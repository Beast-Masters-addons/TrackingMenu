BOOKTYPE_SPELL = "spell"

local spellBook = {}
local tabs = {}
local testUnitClass

function setTestClass(class)
    testUnitClass = class
    local file_spells = string.format('test_data/spells_%s.lua', class)
    spellBook = loadfile(file_spells)()
    local file_tabs = string.format('test_data/tabs_%s.lua', class)
    tabs = loadfile(file_tabs)()
end

function UnitClass(_)
    if testUnitClass == 'Druid' then
        return "Druid", "DRUID", 11
    else
        return "Hunter", "HUNTER", 3
    end
end

--name, texture, offset, numEntries, isGuild, offspecID = GetSpellTabInfo(tabIndex)
function GetSpellTabInfo(tab)
    return tabs[tab][1], tabs[tab][2], tabs[tab][3], tabs[tab][4], tabs[tab][5], tabs[tab][6], tabs[tab][7]
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
    if not spellBook[slotIndex] then
        error('Invalid slotIndex: ' .. slotIndex)
        return
    end
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