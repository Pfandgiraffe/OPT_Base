/*
	FARP Servicepoint

	Author: schmingo (OPT MOD Team)
		Special thanks to LordMDB

	v2015-01-01 | this script is part of OperationPandoraTrigger ArmA3 script collection
*/

// rewrite by psycho
if (!isServer) exitWith {};
params ["_FARPpos","_FARPobject","_argument"];


_serviceTrigger = switch (_argument) do {
	case ("opt_csat_1") : {opt_csat_1_service};
	case ("opt_csat_2") : {opt_csat_2_service};	
	case ("opt_nato_1") : {opt_nato_1_service};
	case ("opt_nato_2") : {opt_nato_2_service};
};


_Servicepoint = "Land_HelipadCivil_F"  createVehicle [(_FARPpos select 0),(_FARPpos select 1)];
_Servicepoint setPos (_FARPobject modelToWorld [-10,-2]);


//opt_serviceTrigger = [getPos _Servicepoint,[8,8,0,false],["ANY","PRESENT",true], ["this && ((getPos (thisList select 0)) select 2 < 1) && speed (thisList select 0) < 1", "[(thislist select 0)] execVM 'common\x_reload_farp.sqf';", ""]] call tcb_fnc_CreateTrigger;
_serviceTrigger setPos getPos _Servicepoint;
	
sleep 0.5;
waitUntil {!(alive _FARPobject) || {(_FARPobject distance _Servicepoint) > 20}};

deleteVehicle _Servicepoint;
_serviceTrigger setPos [0,0,0];
deleteVehicle _serviceTrigger;