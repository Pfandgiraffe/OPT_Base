// by psycho
// reset farp trigger if farp is destroyed

params ["_farp","_param"];

_serviceTrigger = switch (_param) do {
	case ("opt_csat_1") : {opt_csat_1_service};
	case ("opt_csat_2") : {opt_csat_2_service};
	case ("opt_csat_3") : {opt_csat_3_service};
	case ("opt_nato_1") : {opt_nato_1_service};
	case ("opt_nato_2") : {opt_nato_2_service};
	case ("opt_nato_3") : {opt_nato_3_service};
	case ("opt_nato_4") : {opt_nato_4_service};
	case ("opt_nato_5") : {opt_nato_5_service};
};

_serviceTrigger setPos [0,0,0];
removeAllActions _farp;

if (isServer) then {
	_txt = diag_log format ['########## Das FARP %1 wurde zerstoert ##########', _param];
	["opt_logEvent", _txt] call tcb_fnc_NetCallEvent;
};