/*
	Author: Garrett Finn

	Description:
	Draws a line on the map from a unit to a given position

	Parameter(s):
		0: UNIT - start point of line
		1: POSITION - end point of line

	Returns:
	n/a
*/

params ["_start", "_end"];

(findDisplay 12 displayCtrl 51) ctrlAddEventHandler ["Draw","
	(_this select 0) drawLine [
		getPos _start,
		getPos _end,
		[0,0,1,1]
	];
"];