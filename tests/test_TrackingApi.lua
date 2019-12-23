local lu = require('luaunit')
loadfile('wow_functions.lua')()
loadfile('../addon/TrackingApi.lua')()

_G['test'] = {}
local test = _G['test']
test.TrackingApi = _G['TrackingApi']

--TrackingApi:BuildSpellList()


function test:testGetTrackingInfo()
    self.TrackingApi:BuildSpellList()
    local name = GetTrackingInfo(1)
    lu.assertEquals(name, 'Track Beasts')
end

function test:testGetNumTrackingTypes()
    self.TrackingApi:BuildSpellList()
    local num = GetNumTrackingTypes()
    lu.assertEquals(num, 2)
end

function test:testSetTracking()
    self.TrackingApi:BuildSpellList()
    SetTracking(2)
    lu.assertEquals(_G['lastSpellName'], 'Track Humanoids')
end

os.exit( lu.LuaUnit.run() )