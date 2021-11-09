/*
	Author: Garrett Finn

	Description:
	Initializes BOTCOM

	Parameter(s):
		0: ARRAY - list of units to be controlled by the bot
		1: BOOLEAN - debug mode
		2: BOOLEAN - verbose mode

	Returns:
	n/a
*/

params ["_force", "_dbg", "_v"];

clearRadio;
systemChat format ["BOTCOM debug mode: %1", _dbg];
if (_v) then {systemChat "Verbose mode on."} else {systemChat "Verbose mode off."};



// build map *unused*
/*
systemChat "Constructing map...";
_map = [];
_map = [BOT_commander, 20, _dbg, _v] call BOTCOM_fnc_buildMap;

if _v then {systemChat format ["List of map points: %1", _map];};
if _v then {systemChat format ["List of units: %1", _force];};
*/



// create plan
_objectivePos = getMarkerPos "bot_attack_1";
_objectivePos2 = getMarkerPos "bot_attack_2";

_objList = [[_objectivePos, "ATTACK"], [_objectivePos2, "ATTACK"]];

/* test plans
_objListAlpha = [[_objectivePos, "ATTACK"], [_objectivePos2, "ATTACK"]];
_objListBravo = [[_objectivePos2, "ATTACK"], [_objectivePos, "ATTACK"]];
*/

_enemyForceUnknown = [];
{
	if (side _x != west) then {
		_enemyForceUnknown pushBack _x;
	};
} forEach allGroups;

// start running the HTN on all the squads
{
	_handle = [_x, _objList, _enemyForceUnknown, _force] execFSM "squadBehavior.fsm";
} forEach _force;

/* manual tests
_handle = [bot_alpha_1, _objListAlpha, _enemyForceUnknown, _force] execFSM "squadBehavior.fsm";
_handle = [bot_alpha_2, _objListAlpha, _enemyForceUnknown, _force] execFSM "squadBehavior.fsm";
_handle = [bot_alpha_3, _objListAlpha, _enemyForceUnknown, _force] execFSM "squadBehavior.fsm";
_handle = [bot_bravo_1, _objListBravo, _enemyForceUnknown, _force] execFSM "squadBehavior.fsm";
_handle = [bot_bravo_2, _objListBravo, _enemyForceUnknown, _force] execFSM "squadBehavior.fsm";
_handle = [bot_bravo_3, _objListBravo, _enemyForceUnknown, _force] execFSM "squadBehavior.fsm";
*/

/* test plan generation
[_force select 0, _objectivePos, "ATTACK", "LEFT"] call BOTCOM_fnc_generatePlan;
[_force select 1, _objectivePos, "ATTACK", "CENTER"] call BOTCOM_fnc_generatePlan;
[_force select 2, _objectivePos, "ATTACK", "LEFT"] call BOTCOM_fnc_generatePlan;
*/

/*
{
	[_x, _objectivePos, "ATTACK", (selectRandom ["RIGHT", "LEFT", "CENTER"])] call BOTCOM_fnc_generatePlan;
} forEach _force;
*/

// assign initial waypoints
//[_force, _map, _dbg] call BOTCOM_fnc_assignWaypoint;

// run plan