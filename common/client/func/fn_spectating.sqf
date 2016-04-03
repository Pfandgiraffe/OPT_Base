// by psycho
["Initialize",[player]] call BIS_fnc_EGSpectator;

sleep 0.2;
cutText ["to exit spectating mode press button for compass or reload","PLAIN DOWN"];


["stop_spect", "onEachFrame", {
	if (inputAction "compass" > 0 || {inputAction "ReloadMagazine" > 0}) then {
		["Terminate"] call BIS_fnc_EGSpectator;
		player allowDammage true;
		["stop_spect", "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
	};
}] call BIS_fnc_addStackedEventHandler;