/*
	Author: Garrett Finn

	Description:
	Builds an array representing the map used
	by BOTCOM to see the world.
	
	This function is currently unused, there was not a need for the bot to "see" the map in this way.
	I like the idea of the bot keeping a record of "friendly" vs "enemy" grid squares, but unsure how
	to implement it yet.

	Parameter(s):
		0: UNIT - name of the commander unit
		1: NUMBER - radius in grid squares (100m x 100m) that each unit can see.
		2: BOOL - debug enabled
		3: BOOL - verbose mode enabled

	Returns:
	ARRAY - list of positions in map
*/

params ["_commander", "_radiusAO", "_dbg", "_v"];

_size = 82;

// get positioin of commander
_comPos = getPos leader _commander;

// round position of commander to nearest 100m grid square
//_pos = [((_comPos select 0) mod 100), ((_comPos select 1) mod 100), 0];

_gridPos = mapGridPosition leader _commander;

// gridAO holds info about each gridsquare. [position(x,y), status, value]

//_initialCoord = _gridPos call BOTCOM_fnc_util_stringToCoord;
_initialCoord = [000, 000];

/*
_xcoord = (str _gridPos) select [1,3];
_ycoord = (str _gridPos) select [4,3];
_initialCoord = [_xcoord call BIS_fnc_parseNumber, _ycoord call BIS_fnc_parseNumber];
*/

_gridAO = [];
for [{_step = 0}, {_step < _size}, {_step = _step + 1}] do {
	_gridAO pushBack [];
};

if _v then {systemChat format ["Starting AO at grid: %1...", _initialCoord];};

for [{_ycoord = 0}, {_ycoord < _size}, {_ycoord = _ycoord + 1}] do {
	for [{_xcoord = 0}, {_xcoord < _size}, {_xcoord = _xcoord + 1}] do {
		_temp = [];
		_newCoord = [_xcoord, _ycoord];
		if _v then {systemChat format ["Gridsquare created at (%1, %2)", _newCoord select 0, _newCoord select 1];};
		
		_grid = _newCoord call BOTCOM_fnc_util_coordToString;
		_pos = _grid call BOTCOM_fnc_util_stringToPos;
		_pos = [(_pos select 0) + 50, (_pos select 1) + 50, 0];
		//_temp set [0, _pos];
		
		_temp = [_pos, "none"];
		if (_pos inArea OPFOR_trigger) then {
			_temp = [_pos, "OPFOR"]
		};
		if (surfaceIsWater _pos) then {
			_temp = [_pos, "WATER"];
		};
		
		(_gridAO select _ycoord) set [_xcoord, _temp];
	};
};

/*
for [{_ycoord = -_radiusAO}, {_ycoord <= _radiusAO}, {_ycoord = _ycoord + 1}] do
{
	if _v then {systemChat format ["Creating grid row #%1...", _ycoord];};
	for [{_xcoord = -_radiusAO}, {_xcoord <= _radiusAO}, {_xcoord = _xcoord + 1}] do 
	{
		_newCoord = [
		(_initialCoord select 0) + _xcoord,
		(_initialCoord select 1) + _ycoord
		];
		if _v then {systemChat format ["Gridsquare created at (%1, %2)", _newCoord select 0, _newCoord select 1];};
		//_gridAO pushBack _newCoord;
		((_gridAO select _xcoord) set [_ycoord, _newCoord];
	};
};
*/

systemChat "Created grid.";
if _v then {
	systemChat format ["Points: %1", _gridAO];
};

// map built
// convert AO to map

//_map = _gridAO;
//systemChat "Converting grid to map...";

/*
for [{_ycoord = 0}, {_ycoord < _size}, {_ycoord = _ycoord + 1}] do {
	for [{_xcoord = 0}, {_xcoord < _size}, {_xcoord = _xcood + 1}] do {
		_grid = ((_gridAO select _xcoord) select _ycoord);
		systemChat format ["_grid = %1", _grid];
		
		_grid = _grid call BOTCOM_fnc_util_coordToString;
		systemChat _grid;
		
		_pos = _grid call BOTCOM_fnc_util_stringToPos;
		_pos = [(_pos select 0) + 50, (_pos select 1) + 50, 0];
		systemChat format ["_pos = %1", _pos];
		
		((_map select _ycoord) select _xcoord) set [0, _pos];
		
		if (!(surfaceIsWater _pos)) then {
			if (_pos inArea OPFOR_trigger) then {
				((_map select _ycoord) select _xcoord) set [1, "OPFOR"];
			} else {
				((_map select _ycoord) select _xcoord) set [1, "none"];
			};
		};
	};
};
*/


/*
{
	// create temp array
	_temp = [];
	// convert from grid to position
	_grid = ((_x select _forEachIndex) select _forEachIndex) call BOTCOM_fnc_util_coordToString;
	_pos = _grid call BOTCOM_fnc_util_stringToPos;
	_pos = [(_pos select 0) + 50, (_pos select 1) + 50, 0];
	_temp set [0, _pos];
	// classify terrain type
	if (!(surfaceIsWater _pos)) then {
		
		if (_pos inArea OPFOR_trigger) then {
			_temp set [1, "OPFOR"];
			
		} else {
			_temp set [1, "none"];
		};
	
		_map pushBack _temp;
	};
	
} forEach _gridAO;
*/

systemChat "Map construction complete";
if _dbg then {systemChat "Drawing map...";};
if _dbg then {_gridAO spawn BOTCOM_fnc_dbg_drawMap;};

_return = _gridAO;
_return


