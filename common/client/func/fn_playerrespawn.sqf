//by psycho
#include "setup.sqf"
private ["_player_obj"];

_player_obj = _this select 0;

if (!isNil "tcb_gamemaster") then {
	if (!isNull tcb_gamemaster) then {
		["addToCurator", _player_obj] call tcb_fnc_netCallEventCTS;
		
		_old_objects = tcb_gamemaster getVariable "tcb_zeus";
		if (getplayerUID _player_obj == _old_objects select 1) then {
			[_player_obj, _old_objects select 0] call BIS_fnc_curatorRespawn;
		};
	};
};

_player_obj setVariable ["tf_unable_to_use_radio", false];
_player_obj setVariable ["tf_voiceVolume", 1.0, true];

//call opt_fnc_dynamicGroups;	//psycho, disabled cause is accecable via "T" or "U" key
[] spawn opt_checkWeapon;
//[] spawn opt_TFARfrequencies;	// do not overwrite personal frequency setup
[] spawn opt_tfarVehicleLr;
[player] spawn EtV_Actions;

[] spawn {
	titleCut ["","BLACK IN", 4];
	"dynamicblur" ppeffectenable true;
	"dynamicblur" ppeffectadjust [5];
	"dynamicblur" ppeffectcommit 0;
	"dynamicblur" ppeffectadjust [0];
	"dynamicblur" ppeffectcommit 5;
};

#ifdef __WEAPON_SAVER__
	[player, [missionNamespace, "tcb_inv"]] call BIS_fnc_loadInventory;
#endif

#ifdef __BREATH_VISIBLE__
[_player_obj, 0.03] execVM "common\client\foggy_breath.sqf";
#endif

#ifdef __PLAYER_GRAPHIC_SETTINGS__
player addAction ["Settings" call XGreyText, "dialogs\mission_settings\create.sqf", [], 0, false];
#endif

// vehicle flip
player addAction ["Fahrzeug aufrichten" call XTuerkiesText, "call opt_fnc_unFlip", [], 0, false, true, "", "[_this] call opt_fnc_flipCheck"];


#ifdef __NO_NVG__
player call tcb_fnc_removeNVG;
#endif

// reset earplug state
opt_EarPlugs = 1;
0 fadeSound 1;

if (dialog) then {
	[] spawn {
		while {dialog} do {
			closeDialog 5566;
			closeDialog 5651;
			closeDialog 0;
		};
	};
};

#ifdef __FLEXIBLE_RESPAWNTIME__
if (__RESPAWN_TYPE__ != 0 || __RESPAWN_TYPE__ != 1) then {
	tcb_next_delay = if (isNil "tcb_next_delay") then {(tcb_respawns + 1) * __RESPAWN_DELAY__} else {tcb_next_delay * 2};
	if (tcb_next_delay <= __FLEXIBLE_RESPAWNTIME__) then {
		setPlayerRespawnTime tcb_next_delay;
		#define __RESPAWN_DELAY__ tcb_next_delay
	} else {
		tcb_next_delay = __FLEXIBLE_RESPAWNTIME__;
		setPlayerRespawnTime tcb_next_delay;
		#define __RESPAWN_DELAY__ tcb_next_delay
	};
};
#endif