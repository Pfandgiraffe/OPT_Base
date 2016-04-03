/*
	Countdown Timer

	Author: schmingo (OPT MOD Team)

	v2014-11-21 | this script is part of OperationPandoraTrigger ArmA3 script collection
*/

//changed by psycho
private ["_breaker","_ticker"];
if (isMultiplayer && !isServer) exitWith {};
//"Timer" setMarkerText format ["%1 Minuten", playTime];
//uiSleep 10;

"Timer" setMarkerAlpha 0;
"CSAT" setMarkerAlpha 0;
"NATO" setMarkerAlpha 0;

waitUntil {MissionStarted};
["opt_logEvent", "########## Mission wurde gestartet ##########"] call tcb_fnc_NetCallEvent;

// calculate first time the dominator (it's needed if assynchrone number of flags are defined)
[civilian, objNull] call opt_fnc_setFlagOwner;

_breaker = false;
_ticker = 0;

for "_i" from (playTime) to 0 step -1 do {
	playTime = (OPT_PLAYTIME*60) - time;
	_ticker = _ticker + 1;

	// every 60 seconds: locking for domination, sync time to clients and transmit public vars
	if (_ticker >= 60) then {
		publicVariable "playTime";
		opt_serverTime = time;
		["opt_serverTime", opt_serverTime] call tcb_fnc_NetCallEvent;
		_time = [playTime / 60,"HH"]call bis_fnc_TimeToString;
		//"Timer" setMarkerText format ["%1 Minuten", _time];
		_ticker = 0;

		if (opt_dominator != "none") then {
			if (toUpper(opt_dominator) == "CSAT") then {
				EastPoints = EastPoints + 1;
				publicVariable "EastPoints";
				//"CSAT" setMarkerText format ["%1 Punkte", EastPoints];
				systemChat "CSAT: +1 Punkt";
				["opt_logEvent", format ["########## Punkte: CSAT +1 (NATO %1 | CSAT %2) ##########", WestPoints, EastPoints]] call tcb_fnc_NetCallEvent;
			} else {
				WestPoints = WestPoints + 1;
				publicVariable "WestPoints";
				//"NATO" setMarkerText format ["%1 Punkte", WestPoints];
				systemChat "NATO: +1 Punkt";
				["opt_logEvent", format ["########## Punkte: NATO +1 (NATO %1 | CSAT %2) ##########", WestPoints, EastPoints]] call tcb_fnc_NetCallEvent;
			};
			_breaker = false;
		} else {
			if (!_breaker) then {
				["opt_logEvent", format ["########## no Domination (NATO %1 | CSAT %2) ##########", WestPoints, EastPoints]] call tcb_fnc_NetCallEvent;
				_breaker = true;
			};
		};
	};
	uiSleep 1;
};

publicVariable "playTime";

["opt_logEvent", "########## Missionzeit abgelaufen ##########"] call tcb_fnc_NetCallEvent;
["opt_logEvent", format ["########## Endbudget: (NATO %1 | CSAT %2) ##########", opt_west_budget, opt_east_budget]] call tcb_fnc_NetCallEvent;
["opt_logEvent", format ["########## Endpunktestand: (NATO %1 | CSAT %2) ##########", WestPoints, EastPoints]] call tcb_fnc_NetCallEvent;