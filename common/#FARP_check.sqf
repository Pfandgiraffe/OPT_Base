/*
	FARP Check

	Author: schmingo (OPT MOD Team)

	v2015-03-25 | this script is part of OperationPandoraTrigger ArmA3 script collection
*/


//rewrite by psycho
#include "setup.sqf"
if (!local player) exitWith {};
params ["_FARPobject","_FARPcaller","_actionID","_argument"];

_serviceTrigger = switch (_argument) do {
	case ("opt_csat_1") : {opt_csat_1_service};
	case ("opt_csat_2") : {opt_csat_2_service};	
	case ("opt_nato_1") : {opt_nato_1_service};
	case ("opt_nato_2") : {opt_nato_2_service};
};

#ifdef __ONLY_PIO_CAN_BUILD_FARPS__
if (typeOf _FARPcaller in tcb_engineers || {tcb_b_check_pio == 0}) then {
#else
if (_FARPcaller isKindOf "CAManBase") then {
#endif
	if(alive _FARPobject) then {
	_playerside = switch (side _FARPcaller) do {
		case west: {west};
		case east: {east};
	};
	_FARPpos = getPos _FARPobject;
	_checkservicepoints = _FARPpos nearObjects ["Land_HelipadCivil_F", 30];
	if (count _checkservicepoints > 0) then {
		{ deleteVehicle _x} forEach _checkservicepoints;
	};
	["buildFARP", [_FARPpos,_FARPobject,_argument]] call tcb_fnc_NetCallEventCTS;
	
	_serviceTrigger setPos getPos _FARPobject;
	_serviceTrigger setPos (_FARPobject modelToWorld [-10,-2]);
	
	hint "Das FARP wurde aufgestellt";
	} else {
		hint "Das FARP ist nicht mehr funktionsfähig";
		_FARPobject removeAction _actionID;
		_serviceTrigger setPos [0,0,0];
	};
} else {
	["<t size='0.8' shadow='1' color='#ffffff'>Du bist kein Pionier</t>", (safeZoneX - 0.2), (safeZoneY + 0.3), 3, 1, 0, 1] spawn BIS_fnc_dynamicText;
};