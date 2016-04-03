// by psycho
if (!isServer) exitWith {};
waitUntil {time > 1};

_allFlagPoles = [];
_allFlagPoles = OPT_CSAT_FLAGs + OPT_NATO_FLAGs;

{
	_flag = _x;
	_m_name = str(_flag) + str(_forEachIndex);
	_m_pos = getPos _flag;
	_marker = createMarker [_m_name, _m_pos];
	_marker setMarkerShape "ELLIPSE";
	
	_var = format ["%1",_flag];
	_side = _flag getVariable [_var, Nil];
	if (!isNil {_side}) then {
		_color = if (_side == west) then {"ColorBlufor"} else {"ColorOpfor"};
		_marker setMarkerColor _color;
	} else {
		_marker setMarkerColor "ColorBlack";
	};
	_marker setMarkerSize [5,5];
	_marker setMarkerBrush "SOLID";
	_marker setMarkerAlpha 1;
	_flag setVariable ["opt_flagMarker", _marker];
} forEach _allFlagPoles;
