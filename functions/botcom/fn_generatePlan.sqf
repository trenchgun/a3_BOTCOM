/*
	Author: Garrett Finn

	Description:
	Takes a group and an objective and creates a plan

	Parameter(s):
		0: GROUP - the group to be added to the BOT's forces
		1: POSITION - location of the objective
		2: STRING - type of objective
			- "ATTACK"
			- "DEFEND" 
			- "MOVE" *not implemented, ultimately unnessecary. Perhaps if I have time to expand scope, in order to account for AI being "staged" at support locations.*
		3: STRING - path modifier
			- "RIGHT"
			- "LEFT"
			- "CENTER"

	Returns:
	n/a
*/
params [
	["_group", grpNull, [grpNull]],
	["_destination", getPos (leader _group), [[], objNull]],
	["_type", "MOVE", [""]],
	["_modifier", "none", [""]]
];
_start = getPos leader _group;

// get direction and distance from unit to destination
_dir = _start getDir _destination;
_dist = _start distance _destination;

// estimate how many waypoints we need to ensure AI follows path.
_waypointNum = _dist / 100;
_waypointNum = round _waypointNum;

_initialDir = _dir;
_distanceMod = 1;

if (_waypointNum > 2) then {
	switch (_modifier) do {
		case "LEFT": {
			_modifier = selectRandom [-15, -20, -25, -30, -35, -40, -45];
			_initialDir = _initialDir + _modifier;
			_distanceMod = 1.5;
		};
		case "RIGHT": {
			_modifier = selectRandom [15, 20, 25, 30, 35, 40, 45];
			_initialDir = _initialDir + _modifier;
			_distanceMod = 1.5;
		};
		case "CENTER": {
			_modifier = selectRandom [15, 10, 5, 0, -5, -10, -15];
			_initialDir = _initialDir + _modifier;
			_distanceMod = 1;
		};
		default {
			_modifier = 0;
			_distanceMod = 1;
			_waypointNum = 1;
		};
	};
};

// start generating the plan
switch (_type) do {
	case "ATTACK": {
		if (_waypointNum > 1) then {
			_nextPos = _start getPos [100, _initialDir];
			_move = _group addWaypoint [_nextPos, -1];
			_move setWaypointType "MOVE";
			_group setCombatMode "RED";
			_waypointNum = _waypointNum - 1;
			_lastPos = _start;
			_currentPos = _nextPos;
			
			/* 
				TODO: take better account of terrain to plan routes.
				Currently draws a visually nice line to objective but not really meaningful.
				
				think how to make "tactical" route?
				- would need to index whole map (or at least the area of operations)
				- record height/terrain type/etc
				- revist fn_buildMap if I have the time
			*/
			while {_waypointNum > 1} do {
				scopeName "loop";
				_dir = _lastPos getDir _currentPos;
				_dirToDest = _currentPos getDir _destination;
				_avgDir = (_dir + _dirToDest) / 2;
				_modifier = selectRandom [15, 10, 5, 0, -5, -10, -15];
				_azth = _avgDir + _modifier;
				_nextPos = _currentPos getPos [100 * _distanceMod, _azth];
				if ((_nextPos distance _destination) > (_lastPos distance _destination)) then {
					breakOut "loop"; 
				};
				_move = _group addWaypoint [_nextPos, -1];
				_move setWaypointType "MOVE";
				
				_waypointNum = _waypointNum - 1;
				_lastPos = _currentPos;
				_currentPos = _nextPos;
			};
		};
		// set a S&D waypoint on _destination
		_move = _group addWaypoint [_destination, -1];
		_move setWaypointType "SAD";
	};
	case "DEFEND": {
		if (_waypointNum > 1) then {
			_nextPos = _start getPos [100, _initialDir];
			_move = _group addWaypoint [_nextPos, -1];
			_move setWaypointType "MOVE";
			_group setCombatMode "RED";
			_waypointNum = _waypointNum - 1;
			_lastPos = _start;
			_currentPos = _nextPos;
		};
		
		while {_waypointNum > 1} do {
			scopeName "loop";
			_dir = _lastPos getDir _currentPos;
			_dirToDest = _currentPos getDir _destination;
			_avgDir = (_dir + _dirToDest) / 2;
			_modifier = selectRandom [15, 10, 5, 0, -5, -10, -15];
			_azth = _avgDir + _modifier;
			_nextPos = _currentPos getPos [100 * _distanceMod, _azth];
			if ((_nextPos distance _destination) > (_lastPos distance _destination)) then {
				breakOut "loop"; 
			};
			_move = _group addWaypoint [_nextPos, -1];
			_move setWaypointType "MOVE";
			
			_waypointNum = _waypointNum - 1;
			_lastPos = _currentPos;
			_currentPos = _nextPos;
		};
		// set a loiter waypoint on _destination
		_move = _group addWaypoint [_destination, -1];
		_move setWaypointType "HOLD";
	};
	default {
		systemChat "Illegal waypoint created. This should not happen.";
	};
};
