/**
*	call Z_getBackpackItems
*
*	Gets all your items stored in your gear and innitiates the selling list.
**/
private ["_mags","_weaps","_skin","_formattedText"];
#include "defines.sqf";
call Z_clearLists;
Z_SellArray = [];
Z_SellableArray = [];
 _mags = magazines player;
 _weaps = weapons player;

_skin = typeOf player;

systemChat _skin;

_pic = getText (configFile >> 'CfgVehicles' >> _skin >> 'picture');

_formattedText = format [
	"<img image='%1'  size='3' align='center'/>"
	, _pic
];

(findDisplay Z_AT_DIALOGWINDOW displayCtrl Z_AT_CONTAINERINFO) ctrlSetStructuredText parseText _formattedText;

[_weaps,_mags,"your gear"] call	Z_checkArrayInConfig;
