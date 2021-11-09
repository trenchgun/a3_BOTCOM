/*
	Author: Garrett Finn

	Description:
	debug method for displaying the Bot's vision of the map

	Parameter(s):
		0: ARRAY - list of positions in the MAP format

	Returns:
	POSITION
*/

params ["_map"];

//systemChat format ["drawing map of points: %1", _arr];

for [{_ycoord = 0}, {_ycoord < 82}, {_ycoord = _ycoord + 1}] do {
	for [{_xcoord = 0}, {_xcoord < 82}, {_xcoord = _xcoord + 1}] do {
		_item = (_map select _xcoord) select _ycoord;
		//systemChat format ["Entry: %1", _item];
		_pos =  _item select 0;
		_marker = createMarker [(format ["marker_%1%2", _xcoord, _ycoord]), _pos];
		_marker setMarkerShape "RECTANGLE";
		_marker setMarkerSize [50, 50];
		
		switch (_item select 1) do {
			case "OPFOR": {
				_marker setMarkerColor "ColorOPFOR";
				_marker setMarkerBrush "DiagGrid";
			};
			case "WATER": {
				_marker setMarkerColor "ColorBlue";
				_marker setMarkerBrush "Border";
			};
			default {
				_marker setMarkerColor "ColorUNKNOWN";
				_marker setMarkerBrush "Border";
			};
		};
	};
};
systemChat "Map coloring complete";