/*
	Mission Timeout (Countdown to Missionstart)

	Author: schmingo (OPT MOD Team)

	v2015-03-06 | this script is part of OperationPandoraTrigger ArmA3 script collection
*/

// changed by psycho
private ["_remaining", "_ref", "_timeout", "_msg1", "_msg2"];

_timeout = _this select 0;
_msg1 = "Die Waffenruhe endet in:";
_msg2 = "Die Waffenruhe ist beendet!";
_ref = time;

if (MissionStarted) exitWith {};
waitUntil {time > 1};

if (isServer) then {
	["opt_logEvent", format ["########## Startbudget: (NATO %1 | CSAT %2) ##########", opt_west_budget, opt_east_budget]] call tcb_fnc_NetCallEvent;
};

"opt_timeoutMsg" addPublicVariableEventHandler {[] call opt_showCountdown};

if (isnil "opt_timeFormat") then {
	opt_timeFormat = {
		private ["_minutes", "_seconds"];

		_minutes = 0;
		_seconds = 0;
		_seconds = _this;
		
		if (_seconds > 59) then {
			_minutes = floor (_seconds / 60);
			_seconds = _seconds - (_minutes * 60);
		};
		if (_seconds < 10) then {
			_seconds = format ["0%1", _seconds];
		};
		if (_minutes < 10) then {
			_minutes = format ["0%1", _minutes];
		};
		[_minutes, _seconds]
	};
};

if (isnil "opt_showCountdown") then {
	opt_showCountdown = {
		hintsilent opt_timeoutMsg;
		if (_timeout < 1 || MissionStarted) then {
			["<t size='0.8' shadow='1' color='#ffffff'>Mission gestartet!</t>", (safeZoneX - 0.2), (safeZoneY + 0.3), 3, 1, 0, 2] spawn BIS_fnc_dynamicText;
			player enableSimulation true;
		};
	};
};

if (isServer) then {
	while {_timeout > 0 && (!MissionStarted)} do {
		_remaining = _timeout call opt_timeFormat;
		opt_timeoutMsg = format ["%1\n\n%2:%3",_msg1, (_remaining select 0), (_remaining select 1)];
		publicVariable "opt_timeoutMsg";
		playTime = (OPT_PLAYTIME*60) - time;
		
		if (local player) then {[] call opt_showCountdown};
		_timeout = _timeout - 1;
		uisleep 1;

		if (_timeout < 1) then {MissionStarted = true; publicVariable "MissionStarted";};
	};
};

if (isServer) then {
	opt_timeoutMsg = _msg2;
	publicVariable "opt_timeoutMsg";
	if (local player) then {[] call opt_showCountdown};
};

/*
if (local player) then {[] call opt_showCountdown};

waitUntil {sleep 1; MissionStarted};
["<t size='0.8' shadow='1' color='#ffffff'>Mission gestartet!</t>", (safeZoneX - 0.2), (safeZoneY + 0.3), 3, 1, 0, 2] spawn BIS_fnc_dynamicText;
player enableSimulation true;
*/