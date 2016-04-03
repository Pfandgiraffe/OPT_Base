// from AAS, changed by psycho

// positions for info display which includes:
#define HEADINGLABEL_X      0.25 	// score
#define PLAYERSLABEL_X      0.02 	// number of players
#define TIMERLABEL_X        0.47 	// time remaining
#define FRAMELABEL_X        0.28 	// avg frames
#define BUDGETLABEL_X        0.38 	// budget

#define HEADINGLABEL_Y      0.94	// score
#define PLAYERSLABEL_Y      0.94	// number of players
#define TIMERLABEL_Y        0.94	// time remaining
#define FRAMELABEL_Y        0.94	// avg frames
#define BUDGETLABEL_Y        0.94	// budget


disableSerialization;
_currentCutDisplay = uiNamespace getVariable "opt_HudDisplay";


//--------------------- get settings on whether to display extra labels --------------
	
_displayGeneralInfo = true;
//if (hudDisplayLevel == HUD_LEVEL_MINIMAL) then {_displayGeneralInfo = false};
	
//--------------------- update clock ---------------------------------------
	
_control = _currentCutDisplay displayCtrl 5090;

private "_timeStr";
if (MissionStarted) then {
	_syncedTime = time + opt_localServerTimeOffset;
	_timeLeft = [((OPT_PLAYTIME*60) - _syncedTime) / 60,"HH:MM"] call bis_fnc_TimeToString;
	if (((OPT_PLAYTIME*60) - _syncedTime) > 0) then {
		_timeStr = format ["Time: %1",_timeLeft];
	} else {
		_timeStr = "Time: 00:00";
	};
} else {
	_timeStr = "Time: -Waffenruhe-";
};
_control ctrlSetText _timeStr;
if (((OPT_PLAYTIME*60) - time) < 300) then {
	_control ctrlSetTextColor [0.9, 0.2, 0.2, 1];
};
_control ctrlShow _displayGeneralInfo;
_controlPos = ctrlPosition _control;
	
_controlPos set [0 , safeZoneW + safeZoneX - (1-TIMERLABEL_X)];
_controlPos set [1 , TIMERLABEL_Y - safeZoneY];
_control ctrlSetPosition _controlPos;
_control ctrlCommit 0;
	
waitUntil {ctrlCommitted _control};
	
//--------------------- update players ------------------------------------------
	
_playersStr = format ["Nato %1 vs. %2 Csat (%3 total)", playersNumber west, playersNumber east, (playersNumber west) + (playersNumber east)];
_control = _currentCutDisplay displayCtrl 5101;
_control ctrlSetText _playersStr;	
_control ctrlShow _displayGeneralInfo;
_controlPos = ctrlPosition _control;
_controlPos set [0 , 0 + safeZoneX + PLAYERSLABEL_X];
_controlPos set [1 , PLAYERSLABEL_Y - safeZoneY];

_control ctrlSetPosition _controlPos;
_control ctrlCommit 0;
waitUntil {ctrlCommitted _control};
	
//----------------------- update score --------------------------------------------

_scoreStr = format ["Score: NATO %1:%2 CSAT", WestPoints, EastPoints];
_control = _currentCutDisplay displayCtrl 5102;
_control ctrlSetText _scoreStr;	
_control ctrlShow _displayGeneralInfo;
_controlPos = ctrlPosition _control;
//_controlPos set[ 0 , safeZoneW + safeZoneX - 0.27];
_controlPos set [0 , safeZoneW + safeZoneX - (1-HEADINGLABEL_X)];
_controlPos set[ 1 , HEADINGLABEL_Y - safeZoneY ];
	
_control ctrlSetPosition _controlPos;
_control ctrlCommit 0;
waitUntil {ctrlCommitted _control};

//--------------------- update Frames ------------------------------------------
	
_frameStr = format ["Fps: %1", round (diag_fps)];
_control = _currentCutDisplay displayCtrl 5091;
_control ctrlSetText _frameStr;
_control ctrlShow _displayGeneralInfo;
_controlPos = ctrlPosition _control;
_controlPos set [0 , 0 + safeZoneX + FRAMELABEL_X];
_controlPos set [1 , FRAMELABEL_Y - safeZoneY];

_control ctrlSetPosition _controlPos;
_control ctrlCommit 0;
waitUntil {ctrlCommitted _control};

//--------------------- update Budget ------------------------------------------

_side_Budget = if (playerSide == west) then {opt_west_budget} else {opt_east_budget};
_control = _currentCutDisplay displayCtrl 5092;
if (_side_Budget < 400000) then {
	_control ctrlSetTextColor [0.9, 0.2, 0.2, 1];
};
_BudgetStr = if (_side_Budget > 999999) then {
	_side_Budget = _side_Budget / 1000000;
	format ["Budget: %1 Mio. €", str(_side_Budget)];	// psycho: budget muss numerisch reduziert werden um Darstellung aufrecht zu erhalten
} else {
	format ["Budget: %1 €", str(_side_Budget)];
};
_control ctrlSetText _BudgetStr;
_control ctrlShow _displayGeneralInfo;
_controlPos = ctrlPosition _control;
_controlPos set [0 , 0 + safeZoneX + BUDGETLABEL_X];
_controlPos set [1 , BUDGETLABEL_Y - safeZoneY];

_control ctrlSetPosition _controlPos;
_control ctrlCommit 0;
waitUntil {ctrlCommitted _control};
