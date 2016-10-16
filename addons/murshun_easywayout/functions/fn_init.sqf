murshun_easywayout_fnc_suicide = {
	_unit = _this select 0;
	
	if (_unit != player) exitWith {};
	
	if (stance _unit != "STAND") exitWith {};
	
	if (handgunWeapon _unit == "") exitWith {};
	
	if (murshun_easywayout_inProgress) exitWith {};

	_animation = murshun_easywayout_animationsArray call BIS_fnc_selectRandom;

	[[_unit, _animation], "switchMove"] call BIS_fnc_MP;
	
	murshun_easywayout_inProgress = true;

	_unit selectWeapon handgunWeapon _unit;

	["murshun_easywayout_handgunCheckEh", "onEachFrame", {
		_unit = _this select 0;
		if (currentWeapon _unit != handgunWeapon _unit) then {
			_unit selectWeapon handgunWeapon _unit;
		};
	}, [_unit]] call BIS_fnc_addStackedEventHandler;
	
	_magsArray = magazinesAmmo _unit;
	
	{
		_unit removeMagazine (_x select 0);
	} foreach _magsArray;

	if (_animation == "murshun_ActsPercMstpSnonWpstDnon_suicide1B") then {
		sleep 3.9;
	};

	if (_animation == "murshun_ActsPercMstpSnonWpstDnon_suicide2B") then {
		sleep 4.1;
	};
	
	{
		_unit addMagazine _x;
	} foreach _magsArray;

	_ehFiredIndex = player addEventHandler ["Fired", {
		_unit = _this select 0;
		_weapon = _this select 1;

		if (_weapon == handgunWeapon _unit) then {
			_unit setHitPointDamage ["hitHead", 1];

			cutText ["", "BLACK FADED"];
		};
	}];
	
	if (_animation == "murshun_ActsPercMstpSnonWpstDnon_suicide1B") then {
		sleep 1;
	};
	
	if (_animation == "murshun_ActsPercMstpSnonWpstDnon_suicide2B") then {
		sleep 1.4;
	};

	player removeEventHandler ["Fired", _ehFiredIndex];

	["murshun_easywayout_handgunCheckEh", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;

	if (alive _unit && !(_unit getVariable ["ACE_isUnconscious", false])) then {
		[[_unit, "AmovPercMstpSlowWpstDnon"], "switchMove"] call BIS_fnc_MP;
	};
	
	murshun_easywayout_inProgress = false;
};

murshun_easywayout_fnc_suicide_AI = {
	_unit = _this select 0;
	
	if (!(local _unit)) exitWith {};

	if (handgunWeapon _unit == "") exitWith {};

	_animation = murshun_easywayout_animationsArray call BIS_fnc_selectRandom;

	[[_unit, _animation], "switchMove"] call BIS_fnc_MP;

	_unit selectWeapon handgunWeapon _unit;

	if (_animation == "murshun_ActsPercMstpSnonWpstDnon_suicide1B") then {
		sleep 4.4;
	};

	if (_animation == "murshun_ActsPercMstpSnonWpstDnon_suicide2B") then {
		sleep 4.6;
	};
	
	_unit forceWeaponFire [handgunWeapon _unit, "Single"];
	_unit setHitPointDamage ["hitHead", 1];
};

murshun_easywayout_animationsArray = ["murshun_ActsPercMstpSnonWpstDnon_suicide1B", "murshun_ActsPercMstpSnonWpstDnon_suicide2B"];

murshun_easywayout_inProgress = false;

if (isNil "murshun_easywayout_enable") then {
	if (isMultiplayer) then {
		murshun_easywayout_enable = false;
	} else {
		murshun_easywayout_enable = true;
	};
};

_action = ["murshun_suicide", "Commit Suicide", "murshun_easywayout\easywayout.paa", {[player] spawn murshun_easywayout_fnc_suicide}, {player == vehicle player && murshun_easywayout_enable && !murshun_easywayout_inProgress && stance player == "STAND" && currentWeapon player == handgunWeapon player && handgunWeapon player != ""}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "ACE_Equipment"], _action] call ace_interact_menu_fnc_addActionToObject;
