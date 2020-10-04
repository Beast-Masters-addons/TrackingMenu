local lu = require('luaunit')
loadfile('wow_functions.lua')()
loadfile('../addon/TrackingApi.lua')()

_G['test'] = {}
local test = _G['test']
test.TrackingApi = _G['TrackingApi']

--TrackingApi:BuildSpellList()


function test:testGetTrackingInfo()
    setTestClass('Hunter')
    self.TrackingApi:BuildSpellList()
    local name = GetTrackingInfo(1)
    lu.assertEquals(name, 'Track Beasts')
end

function test:testGetNumTrackingTypes()
    setTestClass('Hunter')
    self.TrackingApi:BuildSpellList()
    local num = GetNumTrackingTypes()
    lu.assertEquals(num, 3)
end

function test:testSetTracking()
    setTestClass('Hunter')
    self.TrackingApi:BuildSpellList()
    SetTracking(2)
    lu.assertEquals(_G['lastSpellName'], 'Track Humanoids')
end

function test:testGetTrackingTexture()
    _G['currentTrackingTexture'] = 135942
    lu.assertEquals(GetTrackingTexture(), 135942)
end

function test:testGetCurrentTrackingNone()
    _G['currentTrackingTexture'] = nil
    local name, icon, spell = self.TrackingApi:GetCurrentTracking()
    lu.assertEquals(name, nil)
    lu.assertEquals(icon, nil)
    lu.assertEquals(spell, nil)
end

function test:testGetCurrentHunterTracking()
    setTestClass('Hunter')
    self.TrackingApi:BuildSpellList()
    _G['currentTrackingTexture'] = 135942
    local name, icon, spell= self.TrackingApi:GetCurrentTracking()
    lu.assertEquals(name, 'Track Humanoids')
    lu.assertEquals(icon, 135942)
    lu.assertEquals(spell, 19883)
end

function test:testGetCurrentTracking()
    setTestClass('Druid')
    self.TrackingApi:BuildSpellList()
    _G['currentTrackingTexture'] = 133939
    local name, icon, spell= self.TrackingApi:GetCurrentTracking()
    lu.assertEquals(name, 'Find Herbs')
    lu.assertEquals(icon, 133939)
    lu.assertEquals(spell, 2383)
end

function test:testIsCurrentTracking()
    self.TrackingApi:BuildSpellList()
    _G['currentTrackingTexture'] = 135942
    lu.assertEquals(self.TrackingApi:IsCurrentTracking(19883), true)
end

os.exit( lu.LuaUnit.run() )
