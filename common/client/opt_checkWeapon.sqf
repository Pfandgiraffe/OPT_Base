/*
	Check player weapons and optics

	Author: schmingo (OPT MOD Team)

	v2015-04-24 | this script is part of OperationPandoraTrigger ArmA3 script collection
*/

if (local player) then {

	if (player isKindOf "OPT_Maintainer") exitWith {};

	private ["_Leaders","_Snipers","_Recons","_Rocketmen","_SoldatMG","_SoldatSMG","_Pilot","_Crew","_opticsSoldat","_opticsLeader","_opticsSniper","_opticsRecon","_opticPilot","_opticCrew","_MXweapons","_Launchers","_sanitaeter","_operator","_playerType","_opticsType","_primaryWeaponArray","_defaultPrimaryWeapon","_newPrimaryWeaponArray","_newPrimaryWeapon"];

	waitUntil {alive player};

	_Leaders 	= [	"OPT_NATO_Truppfuehrer", 
					"OPT_CSAT_Truppfuehrer", 
					"OPT_NATO_Beobachter", 
					"OPT_CSAT_Beobachter", 
					"OPT_NATO_Aufklaerung_Truppfuehrer", 
					"OPT_CSAT_Aufklaerung_Truppfuehrer", 
					"OPT_NATO_Gruppenfuehrer", 
					"OPT_CSAT_Gruppenfuehrer"];

	_Snipers	= [	"OPT_NATO_Scharfschuetze",
					"OPT_NATO_Scharfschuetze_2",
					"OPT_CSAT_Scharfschuetze",
					"OPT_CSAT_Scharfschuetze_2"];
					
	_Recons 	= [	"OPT_NATO_Aufklaerung_Scharfschutze",
					"OPT_NATO_Aufklaerung_Scharfschutze_2",
					"OPT_CSAT_Aufklaerung_Scharfschutze",
					"OPT_CSAT_Aufklaerung_Scharfschutze_2"];

	_Rocketmen	= [	"OPT_NATO_Luftabwehrspezialist",
					"OPT_CSAT_Luftabwehrspezialist",
					"OPT_NATO_PA_Schuetze",
					"OPT_CSAT_PA_Schuetze",
					"OPT_NATO_PA_Schuetze_Heavy",
					"OPT_CSAT_PA_Schuetze_Heavy",
					"OPT_NATO_Aufklaerung_Spaeher_AT",
					"OPT_CSAT_Aufklaerung_Spaeher_AT"];

	_SoldatMG   = [ "OPT_CSAT_MG_Schuetze","OPT_NATO_MG_Schuetze"];

	_SoldatSMG  = [ "OPT_CSAT_SMG_Schuetze","OPT_NATO_SMG_Schuetze"];
	
	_Pilot      = [ "OPT_CSAT_Pilot","OPT_NATO_Pilot"];
	
	_Crew       = [ "OPT_CSAT_Besatzungsmitglied","OPT_NATO_Besatzungsmitglied"];

	//_opticsSoldat = ["optic_Aco", "optic_ACO_grn", "optic_Holosight", "optic_Arco", "optic_Hamr", "optic_MRCO"];
	//_opticsSoldatMG = ["optic_Aco", "optic_ACO_grn", "optic_Holosight"];
	//_opticsSoldatSMG = ["optic_Aco", "optic_ACO_grn", "optic_Holosight"];
	//_opticsLeader = ["optic_Aco", "optic_ACO_grn", "optic_Holosight", "optic_Arco", "optic_Hamr", "optic_MRCO"];
	//_opticsSniper = ["optic_Aco", "optic_ACO_grn", "optic_Holosight", "optic_Arco", "optic_Hamr", "optic_MRCO", "optic_DMS","optic_LRPS","optic_KHS_blk","optic_KHS_hex","optic_AMS"];
	//_opticsRecon  = ["optic_Aco", "optic_ACO_grn", "optic_Holosight", "optic_Arco", "optic_Hamr", "optic_MRCO", "optic_DMS","optic_KHS_blk","optic_KHS_hex","optic_AMS"];
	//_opticsPilot = ["optic_Aco_smg", "optic_ACO_grn_smg", "optic_Holosight_smg"];
	//_opticsCrew = ["optic_Aco_smg", "optic_ACO_grn_smg", "optic_Holosight_smg"];

	_MXweapons 	= ["MX", "MXC", "MXM"];		

	_Launchers	= [	"OPT_launch_RPG32_F",
					"OPT_launch_NLAW_M_F",
					"OPT_launch_NLAW_F", 
					"OPT_launch_B_Titan_F",
					"OPT_launch_O_Titan_F",
					"OPT_launch_O_Titan_short_F",
					"OPT_launch_B_Titan_short_F"];

	_sanitaeter = [	"OPT_NATO_Sanitaeter",
					"OPT_CSAT_Sanitaeter"];

	_operator 	= [	"OPT_NATO_Operator",
					"OPT_CSAT_Operator",
					"OPT_NATO_Offizier",
					"OPT_CSAT_Offizier"];

	_playerType = typeOf player;

	// Get the right optics list
	//if ((_playerType in _Leaders) or (_playerType in _Snipers) or (_playerType in _Recons) or (_playerType in _SoldatMG) or (_playerType in _SoldatSMG) or (_playerType in _Pilot) or (_playerType in _Crew)) then {
		//if (_playerType in _Leaders) 	then { _opticsType = _opticsLeader; };
		//if (_playerType in _Snipers) 	then { _opticsType = _opticsSniper; };
		//if (_playerType in _Recons) 	then { _opticsType = _opticsRecon; };
		//if (_playerType in _SoldatMG) 	then { _opticsType = _opticsSoldatMG; };
		//if (_playerType in _SoldatSMG) 	then { _opticsType = _opticsSoldatSMG; };
		//if (_playerType in _Pilot) 		then { _opticsType = _opticsPilot; };
		//if (_playerType in _Crew) 		then { _opticsType = _opticsCrew; };
	//} else {
		//_opticsType = _opticsSoldat;
	//};
	
	// Extract primary weapon
	_primaryWeaponArray		=  [(primaryWeapon player), "_"] call CBA_fnc_split; // "arifle_MX_ACO_pointer_F" or "OPT_arifle_MX_ACO_pointer_F"
	if (_primaryWeaponArray select 0 == "OPT") then {
		_defaultPrimaryWeapon = _primaryWeaponArray select 2;
	} else {
		_defaultPrimaryWeapon = _primaryWeaponArray select 1;
	};


	// Functions
	fn_wrongWeapon = {
					titleText ["Regelverstoß - Es ist deiner Klasse nicht erlaubt diese Waffe zu tragen","BLACK FADED", 5];
					logEntry = [profileName, 1];
					publicVariableServer "logEntry";
					removeAllItems player;
					removeAllAssignedItems player;
					removeAllWeapons player;
					removeBackpack player;
					removeVest player;
					removeUniform player;
					removeHeadgear player;
					uiSleep 5;
					player setDamage 1;
					// old revive
					//player call btc_qr_fnc_resp; 
					//[player] spawn SRS_fnc_knockOut;
					titleText ["", "PLAIN"];	};	

	//fn_wrongScope = {
					//titleText ["Regelverstoß - Es ist deiner Klasse nicht erlaubt diese Optik zu verwenden","BLACK FADED", 5];
					//logEntry = [profileName, 2];
					//publicVariableServer "logEntry";
					//removeAllItems player;
					//removeAllAssignedItems player;
					//removeAllWeapons player;
					//removeBackpack player;
					//removeVest player;
					//removeUniform player;
					//removeHeadgear player;
					//uiSleep 5;
					//player setDamage 1;
					// old revive
					//player call btc_qr_fnc_resp; 
					//[player] spawn SRS_fnc_knockOut;
					//titleText ["", "PLAIN"];
					//};

	// Loop
	// for "_i" from 0 to 1 step 0 do {

	//while {alive player} do {
		//sleep 35;

		//if (primaryWeapon player != "") then {
			// Optics Check
			//if (primaryWeaponItems player select 2 != "") then {
				//if !((primaryWeaponItems player select 2) in _opticsType) then { [] spawn fn_wrongScope; };
			//};
			
			// PrimaryWeapon Check
			_newPrimaryWeaponArray 	=  [(primaryWeapon player), "_"] call CBA_fnc_split;
			
			if (_newPrimaryWeaponArray select 0 == "OPT") then {
				_newPrimaryWeapon = _newPrimaryWeaponArray select 2;
			} else {
				_newPrimaryWeapon = _newPrimaryWeaponArray select 1;
			};

			if (_newPrimaryWeapon  != _defaultPrimaryWeapon) then {
				if (_defaultPrimaryWeapon in _MXweapons) then {
					if !(_newPrimaryWeapon in _MXweapons) then { [] spawn fn_wrongWeapon; };
				} else {
					[] spawn fn_wrongWeapon;
				};
			};
		};

		// Check for Medikit
		if !(_playerType in _sanitaeter) then {
			{player removeItems _x;} foreach ["Medikit"];
		};

		// Check for UAVTerminal
		if !(_playerType in _operator) then {
			{player unassignItem _X; player removeItems _x;} foreach ["B_UavTerminal"];
			{player unassignItem _X; player removeItems _x;} foreach ["O_UavTerminal"];
		};

		// Check for Launchers
		if !(_playerType in _Rocketmen) then {
			{
			  if (_x in _Launchers) then { [] spawn fn_wrongWeapon; };
			} forEach weapons player;
		};		
	};
};