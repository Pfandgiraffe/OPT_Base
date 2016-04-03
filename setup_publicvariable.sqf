// setup PublicVariable
// executed only from the Server one time
// define all public variables here


//["tcb_targets", 0] call tcb_fnc_NetSetJIP;

// defined trough vehiclePool
//{publicVariable _x} forEach ["opt_vehiclesNato", "opt_choppersNato", "opt_armoredNato", "opt_vehiclesCsat", "opt_choppersCsat", "opt_armoredCsat", "opt_suppliesNato", "opt_suppliesCsat"];

publicVariable "opt_west_budget";
publicVariable "opt_east_budget";

opt_serverTime = time;
EastPoints		= 0;
publicVariable "EastPoints";
WestPoints		= 0;
publicVariable "WestPoints";
playTime = OPT_PLAYTIME;
publicVariable "playTime";
Draw			= 0;
publicVariable "Draw";
WinEast			= 0;
publicVariable "WinEast";
WinWest			= 0;
publicVariable "WinWest";
currentdate = daytime;
publicVariable "currentdate";
MissionStarted = false;
publicVariable "MissionStarted";
opt_dominator = "none";
publicVariable "opt_dominator";


// define standard sector owner
{
	if (!isNil {_x}) then {
		if (_x != objNull) then {
			_x setVariable [format ["%1",_x], east, true];
		};
	};
} forEach OPT_CSAT_FLAGs;
{
	if (!isNil {_x}) then {
		if (_x != objNull) then {
			_x setVariable [format ["%1",_x], west, true];
		};
	};
} forEach OPT_NATO_FLAGs;