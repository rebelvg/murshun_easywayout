murshun_easywayout_fnc_canSuicide = {
    params ["_unit"];

    murshun_easywayout_enable &&
    _unit == vehicle _unit &&
    !(_unit getVariable ["murshun_easywayout_inProgress", false]) &&
    stance _unit == "STAND" &&
    currentWeapon _unit == handgunWeapon _unit &&
    handgunWeapon _unit != ""
};

murshun_easywayout_fnc_suicide = {
    params ["_unit"];

    if (!(local _unit)) exitWith {};
    if (!(isPlayer _unit)) exitWith {};
    if (stance _unit != "STAND") exitWith {};
    if (handgunWeapon _unit == "") exitWith {};

    if (_unit getVariable ["murshun_easywayout_inProgress", false]) exitWith {};
    _unit setVariable ["murshun_easywayout_inProgress", true];

    private _animation = murshun_easywayout_animationsArray call BIS_fnc_selectRandom;

    [[_unit, _animation], "switchMove"] call BIS_fnc_MP;

    _unit selectWeapon handgunWeapon _unit;

    private _pfhId = [{
        params ["_args", "_handle"];
        _args params ["_unit"];

        if (currentWeapon _unit != handgunWeapon _unit) then {
            _unit selectWeapon handgunWeapon _unit;
        };
    }, 0, [_unit]] call CBA_fnc_addPerFrameHandler;

    private _magsArray = magazinesAmmo _unit;

    {
        _unit removeMagazine (_x select 0);
    } forEach _magsArray;

    if (_animation == "murshun_ActsPercMstpSnonWpstDnon_suicide1B") then {
        sleep 3.9;
    };

    if (_animation == "murshun_ActsPercMstpSnonWpstDnon_suicide2B") then {
        sleep 4.1;
    };

    {
        _unit addMagazine _x;
    } forEach _magsArray;

    private _ehFiredIndex = player addEventHandler ["Fired", {
        params ["_unit", "_weapon"];

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

    [_pfhId] call CBA_fnc_removePerFrameHandler;

    if (alive _unit && !(_unit getVariable ["ACE_isUnconscious", false])) then {
        [[_unit, "AmovPercMstpSlowWpstDnon"], "switchMove"] call BIS_fnc_MP;
    };

    _unit setVariable ["murshun_easywayout_inProgress", false];
};

murshun_easywayout_fnc_suicide_AI = {
    params ["_unit"];

    if (!(local _unit)) exitWith {};
    if (isPlayer _unit) exitWith {};
    if (handgunWeapon _unit == "") exitWith {};

    if (_unit getVariable ["murshun_easywayout_inProgress", false]) exitWith {};
    _unit setVariable ["murshun_easywayout_inProgress", true];

    private _animation = murshun_easywayout_animationsArray call BIS_fnc_selectRandom;

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

if (isNil "murshun_easywayout_enable") then {
    if (isMultiplayer) then {
        murshun_easywayout_enable = false;
    } else {
        murshun_easywayout_enable = true;
    };
};
