/*
	Author: Garrett Finn

	Description:
	Converts a gridspace string to position array.

	Parameter(s):
		0: STRING - in the format "XXXYYY"

	Returns:
	ARRAY - in the format [XXX, YYY]
*/

_grid = param [0, "000000", [""]];
// translate each portion of the Grid String into x and y coords
_xcoord = _grid select [0,3];
_ycoord = _grid select [4,3];

// build and return the array
_return = [_xcoord call BIS_fnc_parseNumber, _ycoord call BIS_fnc_parseNumber];
_return