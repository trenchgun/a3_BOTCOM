/*
	Author: Garrett Finn

	Description:
	picks a random entry from a given array of positions

	Parameter(s):
		0: ARRAY - list of positions

	Returns:
	POSITION
*/

params ["_positionList"];

_coord = selectRandom _positionList;
_grid = _coord call BOTCOM_fnc_util_coordToString;
_pos = _grid call BOTCOM_fnc_util_stringToPos;
_return = _pos;