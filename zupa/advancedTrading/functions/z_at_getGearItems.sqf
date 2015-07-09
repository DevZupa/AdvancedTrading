/**
*	call Z_getBackpackItems
*
*	Gets all your items stored in your gear and innitiates the selling list.
**/
call Z_clearLists;
Z_SellArray = [];
Z_SellableArray = [];
 _mags = magazines player;
 _weaps = weapons player;
[_weaps,_mags,"your gear"] call	Z_checkArrayInConfig;