﻿// by psycho
// track the mf flag

if (!local player) exitWith {};
params ["_flag","_caller","_id","_parr"];

_side = side _caller;
_var = format ["%1",_flag];

if (!MissionStarted) exitWith {
	["<t size='0.8' shadow='0' color='#ffffff'></t>", (safeZoneX - 0.15), (safeZoneY + 0.3), 3, 1, 0, 3] spawn BIS_fnc_dynamicText;  //Es herscht Waffenruhe! rausgemacht, wollen ja keinen text!
 };
 
 // check if overtime
 _syncedTime = time + opt_localServerTimeOffset;
 if (((OPT_PLAYTIME*60) - _syncedTime) <= 0) exitWith {
	["<t size='0.8' shadow='0' color='#ffffff'>Zeit abgelaufen! Flagge ziehen nicht mehr möglich.</t>", (safeZoneX + 0.0), (safeZoneY + 0.3), 3, 1, 0, 3] spawn BIS_fnc_dynamicText;
 };

_owner = _flag getVariable [_var, Nil];
//_owner = _flag getVariable [_parr, Nil];

if (isNil "_owner" || {_side == _owner}/* || {_parr == "dummy"} || {_parr == ""}*/) exitWith {
	["<t size='0.8' shadow='0' color='#ffffff'></t>", (safeZoneX - 0.15), (safeZoneY + 0.3), 3, 1, 0, 3] spawn BIS_fnc_dynamicText; //Zone wird bereits kontrolliert rausgemacht wollen ja keinen text!
};

["setNewFlagOwner", [_side,_flag,_parr]] call tcb_fnc_NetCallEventCTS;
if (_caller == player) then {["addScore",[_caller, 5]] call tcb_fnc_NetCallEventCTS};