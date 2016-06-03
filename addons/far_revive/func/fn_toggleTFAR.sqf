_canUse = _this select 0;
if (_canUse) then {
	player setVariable ["tf_globalVolume", 1];
	player setVariable ["tf_voiceVolume", 1, true];
	player setVariable ["tf_unable_to_use_radio", false];
} else {
	player setVariable ["tf_globalVolume", 0.4];
	player setVariable ["tf_voiceVolume", 0, true];
	player setVariable ["tf_unable_to_use_radio", true];
};

true