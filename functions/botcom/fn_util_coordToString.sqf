/*
	Author: Garrett Finn

	Description:
	Converts a position array to a gridspace string.

	Parameter(s):
		0: ARRAY - in the format [XXX, YYY]

	Returns:
	STRING - in the format "XXXYYY"
*/

params ["_coord"];

_xcoord = _coord select 0;
_ycoord = _coord select 1;

_xstr = str _xcoord;
_ystr = str _ycoord;

if (_xcoord < 100) then
{
	_xstr = "0" + (str _xcoord);
};
if (_xcoord < 10) then
{
	_xstr = "00" + (str _xcoord);
};

if (_xcoord < 100) then
{
	_ystr = "0" + (str _ycoord);
};
if (_ycoord < 10) then
{
	_ystr = "00" + (str _ycoord);
};

_return = format ["%1%2", _xstr, _ystr];
_return