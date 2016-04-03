private ["_ea", "_p", "_pa", "_obj", "_tt", "_islocal", "_isgrp"];
_tt = _this select 1;
_obj = if (typeName _tt == "ARRAY") then {_tt select 0} else {_tt};
if (isNil "_obj" || {isNull _obj}) exitWith {};
_islocal = if (typeName _obj != "GROUP") then {
	_isgrp = false;
	local _obj
} else {
	_isgrp = true;
	local (leader _obj)
};
if (_islocal) then {
	_ea = x_event_holderSTO getVariable (_this select 0);
	if (!isNil "_ea") then {
		_pa = _this select 1;
		if (!isNil "_pa") then {
			{_pa call _x} forEach _ea;
		} else {
			{call _x} forEach _ea;
		};
	};
} else {
	x_nsto = _this;
	if (isServer) then {
		_owner = if (!_isgrp) then {
			owner _obj
		} else {
			owner (leader _obj)
		};
		_owner publicVariableClient "x_nsto";
	} else { // not needed... redundant, who cares
		publicVariableServer "x_nsto";
	};
};