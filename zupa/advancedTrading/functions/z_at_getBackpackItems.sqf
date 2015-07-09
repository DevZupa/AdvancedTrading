/**
*	call Z_getBackpackItems
*
*	Gets all your items stored in your backpack and innitiates the selling list.
**/
#include "defines.sqf";	
call Z_clearLists;
Z_SellableArray = [];
Z_SellArray = [];
_backpack = unitBackpack player;
if (!isNil "_backpack") then {    				
	_mags = getMagazineCargo _backpack;
	_weaps = getWeaponCargo _backpack;		
	_normalMags = [];
	_normalWeaps = [];			
	_kinds = _mags select 0;
	_ammmounts = _mags select 1;
	{
		_counter = 0 ;
		while{	_counter < ( 	_ammmounts select _forEachIndex)}do{
		_normalMags set [count(_normalMags),_x];
		_counter = _counter + 1;
		};
	}forEach _kinds;
	
	_kinds2 = _weaps select 0;
	_ammmounts2 = _weaps select 1;
	{
		_counter = 0 ;
		while{	_counter < ( 	_ammmounts2 select _forEachIndex)}do{
		_normalWeaps set [count(_normalWeaps),_x];
		_counter = _counter + 1;
		};
	}forEach _kinds2;

	[_normalMags,_normalWeaps, typeOf _backpack] call Z_checkArrayInConfig;	
}else{
	_ctrltext = format["I'm not stupid."];
	ctrlSetText [Z_AT_TRADERLINE2, _ctrltext];
	
	_ctrltext = format["You are not wearing a backpack."];
	ctrlSetText [Z_AT_TRADERLINE1, _ctrltext];
};