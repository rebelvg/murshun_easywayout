_action = ["murshun_suicide", "Commit Suicide", "murshun_easywayout\easywayout.paa", {[player] spawn murshun_easywayout_fnc_suicide}, {[player] call murshun_easywayout_fnc_canSuicide}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "ACE_Equipment"], _action] call ace_interact_menu_fnc_addActionToObject;
