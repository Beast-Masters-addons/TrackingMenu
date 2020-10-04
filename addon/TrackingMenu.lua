function TM_OnLoad(self)
	TrackingApi:BuildSpellList()
	MiniMapTrackingDropDown_OnLoad(self)
	TM_MiniMapTrackingDropDown_Initialize(TM_MiniMapTrackingDropDown, 1)
end

function TM_MiniMapTrackingDropDown_OnLoad(self)
	UIDropDownMenu_Initialize(self, TM_MiniMapTrackingDropDown_Initialize, "MENU");
	self.noResize = true;
end

function TM_MiniMapTrackingDropDown_Initialize(_, level)
	local name, texture, category, nested, numTracking;
	local count = GetNumTrackingTypes();
	local info;
	local _, class = UnitClass("player");

	if (level == 1) then
        --None button
		info = UIDropDownMenu_CreateInfo();
		info.text=MINIMAP_TRACKING_NONE;
		info.checked = MiniMapTrackingDropDown_IsNoTrackingActive;
		info.func = CancelTrackingBuff;
		info.icon = nil;
		info.arg1 = nil;
		info.isNotRadio = false;
		info.keepShownOnClick = true;
		UIDropDownMenu_AddButton(info, level);

		if (class == "HUNTER") then --only show hunter dropdown for hunters
			numTracking = 0;
			-- make sure there are at least two options in dropdown
			for id=1, count do
				_, _, _, category, nested = GetTrackingInfo(id);
				if (nested == HUNTER_TRACKING and category == "spell") then
					numTracking = numTracking + 1;
				end
			end
			if (numTracking > 1) then
				info.text = HUNTER_TRACKING_TEXT;
				info.func =  nil;
				info.notCheckable = true;
				info.keepShownOnClick = false;
				info.hasArrow = true;
				info.value = HUNTER_TRACKING;
				UIDropDownMenu_AddButton(info, level)
			end
		end
	end

	for id=1, count do
		name, texture, _, category = GetTrackingInfo(id);
		info = UIDropDownMenu_CreateInfo();
		info.text = name;
		info.checked = MiniMapTrackingDropDownButton_IsActive;
		info.func = MiniMapTracking_SetTracking;
		info.icon = texture;
		info.arg1 = id;
		info.isNotRadio = false;
		info.keepShownOnClick = true;
		if ( category == "spell" ) then
			info.tCoordLeft = 0.0625;
			info.tCoordRight = 0.9;
			info.tCoordTop = 0.0625;
			info.tCoordBottom = 0.9;
		else
			info.tCoordLeft = 0;
			info.tCoordRight = 1;
			info.tCoordTop = 0;
			info.tCoordBottom = 1;
		end
		UIDropDownMenu_AddButton(info, 1);
	end

end
