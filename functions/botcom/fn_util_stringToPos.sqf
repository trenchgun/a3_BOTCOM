/*
	Author: user "Grumpy Old Man" from Bohemia Interactive Forums

	Description:
	Converts a grid string into a position.

	Parameter(s):
		0: STRING - in the format "XXXYYY"

	Returns:
	ARRAY - in the format [XXXX, YYYY, 0]
*/

_grid = param [0, "000000", [""]];

_count = count _grid;
_half = _count / 2;
_multis = [1,10,100];
_counts = [10, 8, 6];
_multi = _multis select (_counts find _count);
_posX = (parseNumber (_grid select [0, _half])) * _multi;
_posY = (parseNumber (_grid select [_half, _half + _half])) * _multi;
[_posX, _posY, 0]