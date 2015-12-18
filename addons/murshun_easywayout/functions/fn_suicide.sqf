murshun_hintsArray = ["What are you waiting for? Christmas?", "Chickened out?", "Just... Do It.", "Do it already!", format ["%1, wake up.", profileName]];
murshun_animationsArray = ["murshun_ActsPercMstpSnonWpstDnon_suicide1B", "murshun_ActsPercMstpSnonWpstDnon_suicide2B"];

murshun_suicideInProgress = false;

if (isNil "murshun_easywayout_canSuicide") then {
if (isMultiplayer) then {
murshun_easywayout_canSuicide = false;
} else {
murshun_easywayout_canSuicide = true;
};
};

murshun_setAceDamage_fnc = {
_unit = _this select 0;

_prevBodyPartsDamageBasic = _unit getVariable ["ace_medical_bodyPartStatus", []];
_prevBodyPartsDamageAdvanced = _unit getVariable ["ace_medical_openWounds", []];

_prevBodyPartsDamageBasic set [0, 1];
_prevBodyPartsDamageAdvanced = _prevBodyPartsDamageAdvanced + [[1,5,0,1,0.05]];

if (ace_medical_level == 1) then {
_unit setVariable ["ace_medical_bodyPartStatus", _prevBodyPartsDamageBasic, true];
} else {
_unit setVariable ["ace_medical_openWounds", _prevBodyPartsDamageAdvanced, true];
};
_unit setVariable ["ace_medical_pain", 1, true];
};

murshun_suicide_fnc = {
_unit = _this select 0;

if ((local _unit) && !(isPlayer _unit)) exitWith {
[_unit] spawn murshun_suicide_AI_fnc;
};

_handgun = handgunWeapon _unit;
if (_handgun == "") exitWith {
["You'll need a handgun to do that, silly.", 2.5, _unit] spawn ace_common_fnc_displayTextStructured;
};

_animation = murshun_animationsArray call BIS_fnc_selectRandom;

[[_unit, _animation], "switchMove"] call BIS_fnc_MP;
murshun_suicideInProgress = true;

_unit selectWeapon handgunWeapon _unit;

["handgunCheckEh", "onEachFrame", {
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

{
_unit addMagazine _x;
} foreach _magsArray;

_ehFiredIndex = _unit addEventHandler ["Fired", {
_unit = _this select 0;
_weapon = _this select 1;

if (_weapon == handgunWeapon _unit) then {
_unit setHitPointDamage ["hitHead", 1];
[_unit] spawn murshun_setAceDamage_fnc;

cutText ["", "BLACK FADED", 3];
};

}];

sleep 1;

_unit removeEventHandler ["Fired", _ehFiredIndex];
};

if (_animation == "murshun_ActsPercMstpSnonWpstDnon_suicide2B") then {
sleep 4.1;

{
_unit addMagazine _x;
} foreach _magsArray;

_ehFiredIndex = _unit addEventHandler ["Fired", {
_unit = _this select 0;
_weapon = _this select 1;

if (_weapon == handgunWeapon _unit) then {
_unit setHitPointDamage ["hitHead", 1];
[_unit] spawn murshun_setAceDamage_fnc;

cutText ["", "BLACK FADED", 3];
};

}];

sleep 1.4;

_unit removeEventHandler ["Fired", _ehFiredIndex];
};

["handgunCheckEh", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;

murshun_suicideInProgress = false;

if (alive _unit && !(_unit getVariable ["ACE_isUnconscious", false])) then {
[[_unit, "AmovPercMstpSlowWpstDnon"], "switchMove"] call BIS_fnc_MP;
[(murshun_hintsArray call BIS_fnc_selectRandom), 2.5, _unit] spawn ace_common_fnc_displayTextStructured;
} else {
sleep 5;

cutText ["", "BLACK IN", 3];
};
};

murshun_suicide_AI_fnc = {
_unit = _this select 0;

_handgun = handgunWeapon _unit;
if (_handgun == "") exitWith {};

_animation = murshun_animationsArray call BIS_fnc_selectRandom;

[[_unit, _animation], "switchMove"] call BIS_fnc_MP;

_unit selectWeapon handgunWeapon _unit;

if (_animation == "murshun_ActsPercMstpSnonWpstDnon_suicide1B") then {
sleep 3.9;

sleep 0.5;
_unit forceWeaponFire [handgunWeapon _unit, "Single"];
[_unit] spawn murshun_setAceDamage_fnc;
};

if (_animation == "murshun_ActsPercMstpSnonWpstDnon_suicide2B") then {
sleep 4.1;

sleep 0.5;
_unit forceWeaponFire [handgunWeapon _unit, "Single"];
[_unit] spawn murshun_setAceDamage_fnc;
};
};

_action = ["murshun_suicide", "Commit Suicide", "murshun_easywayout\easywayout.paa", {[player] spawn murshun_suicide_fnc}, {player == vehicle player && murshun_easywayout_canSuicide && !murshun_suicideInProgress && alive player && ((player getVariable ["ace_sitting_isSitting", false]) isEqualTo false)}] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "ACE_Equipment"], _action] call ace_interact_menu_fnc_addActionToObject;
