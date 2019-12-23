--Blizzard methods with custom frame name

function MiniMapTracking_Update()
    UIDropDownMenu_RefreshAll(TM_MiniMapTrackingDropDown);
end

function MiniMapTrackingDropDown_OnLoad(self)
    UIDropDownMenu_Initialize(self, TM_MiniMapTrackingDropDown_Initialize, "MENU");
    self.noResize = true;
end

function MiniMapTracking_SetTracking (_, id, _, on)
    SetTracking(id, on);
    UIDropDownMenu_Refresh(TM_MiniMapTrackingDropDown);
end

function MiniMapTrackingDropDownButton_IsActive(button)
    local _, _, active, _ = GetTrackingInfo(button.arg1);
    return active;
end

function MiniMapTrackingDropDown_IsNoTrackingActive()
    local active
    local count = GetNumTrackingTypes();
    for id=1, count do
        _, _, active, _  = GetTrackingInfo(id);
        if (active) then
            return false;
        end
    end
    return true;
end