/*
	Author: Garrett Finn

	Description:
	assigns the given squad a waypoint

	Parameter(s):
		0: ARRAY - list of units that need an assignment
		1: ARRAY - array of positions
		2: BOOLEAN - debug mode
	Returns:
	n/a
*/

params ["_force", "_map", "_dbg"];

{
	_count = 0;
	_grid = [[], "none"];
	while {_count < 1} do {
		_grid = selectRandom (selectRandom _map);
		if ((_grid select 1) != "WATER") then {
			_count = 1;
		};
	};
	_pos = _grid select 0;
	
	if (_dbg) then {
		_marker = createMarker [groupID _x, _pos];
		_marker setMarkerType "hd_dot";
		_marker setMarkerColor "colorBLUFOR";
		_name = ((format ["%1", _x]) splitString " ") select 1;
		_marker setMarkerText format ["%1 WP", _name];
	};
	_wp = _x addWaypoint [_pos, -1];
	_wp setWaypointType "MOVE";
} forEach _force;

