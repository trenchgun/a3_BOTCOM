//[blu_commander, 6] remoteExec ["BOTCOM_fnc_buildMap", player, false];

_force = [];

_force pushBack bot_alpha_1;
_force pushBack bot_alpha_2;
_force pushBack bot_alpha_3;
_force pushBack bot_bravo_1;
_force pushBack bot_bravo_2;
_force pushBack bot_bravo_3;



[_force, false, false] remoteExec ["BOTCOM_fnc_initBot", player, false];