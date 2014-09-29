disableSerialization;

Z_traderData = (_this select 3); // gets the trader data ( menu_Functionary1 )

if( isNil "Z_traderData" || count (Z_traderData) == 0)exitWith{
cutText [format["There went something wrong."], "PLAIN DOWN"];
};

if(isNil "Z_AdvancedTradingInit")then{

Z_SellableArray = [];
Z_SellArray = [];
Z_vehicle = objNull;
	
// initiate the functions for advanced trading -- easier for the people :) otherwise it would be in compiles.
Z_clearLists = {
	lbClear 7401;
    lbClear 7402;
};

Z_getBackpackItems = {
	call Z_clearLists;
	Z_SellingFrom = 0;
	Z_SellableArray = [];
	Z_SellArray = [];
	_backpack = unitBackpack player;
	systemChat str(typeOf _backpack);
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
			_normalWeaps set [count(_normalMags),_x];
			_counter = _counter + 1;
			};
		}forEach _kinds2;
				
		[_normalMags,_normalWeaps, typeOf _backpack] call	Z_checkArrayInConfig;	
	}else{
		_ctrltext = format["Are you trying to fool me?"];
		ctrlSetText [7413, _ctrltext];
		
		_ctrltext = format["I do not see any backpack on your back ?!"];
		ctrlSetText [7412, _ctrltext];
	};
};

Z_getVehicleItems = {
	Z_vehicle = objNull;
	call Z_clearLists;
	Z_SellingFrom = 1;
	Z_SellableArray = [];
	Z_SellArray = [];
	_vehicle = objNull;
	_ownsCar = false;
	
	_list = (position player) nearEntities [["Land", "Air", "Sea"], 50];
	{if(local _x && !isPlayer _x)then{_vehicle = _x};}count _list;
	systemChat (typeOf _vehicle);
	
	if(!isNull _vehicle)then{
		Z_vehicle = _vehicle;
		_mags = getMagazineCargo _vehicle;
		_weaps = getWeaponCargo _vehicle;
		
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
			_normalWeaps set [count(_normalMags),_x];
					_counter = _counter + 1;
			};
		}forEach _kinds2;
		
		
		[_normalWeaps,_normalMags, typeOf _vehicle] call	Z_checkArrayInConfig;
	}else{
		_ctrltext = format["So you better start looting!"];
		ctrlSetText [7413, _ctrltext];
		
		_ctrltext = format["I do not see any vehicle where you were driver from ?!"];
		ctrlSetText [7412, _ctrltext];
	};	
};

Z_getGearItems = {
	call Z_clearLists;
	Z_SellingFrom = 2;
	Z_SellArray = [];
	Z_SellableArray = [];
	 _mags = magazines player;
	 _weaps = weapons player;
	[_weaps,_mags,"your gear"] call	Z_checkArrayInConfig;			
};

Z_checkArrayInConfig = {
	_weaps = _this select 0;
	_mags = _this select 1;
	_extraText = _this select 2;
	_all = _weaps + _mags ;
	_total = count(_all);
	_arrayOfTraderCat = Z_traderData;
	_totalPrice = 0;
	if(_total > 0)then{
		{
			_y = _x;				
			{	
					_cat =  format["Category_%1",(_arrayOfTraderCat select _forEachIndex select 1)];
					systemChat _cat;
					systemChat _y;
					_excists = false;
					if(isClass(missionConfigFile >> "CfgTraderCategory"  >> _cat >> _y ))then{
					_excists = isClass(missionConfigFile >> "CfgTraderCategory"  >> _cat >> _y );		
					};					
				if(_excists)exitWith{
					_pic = "";
					_text = "";
					_type = getText(missionConfigFile >> "CfgTraderCategory"  >> _cat  >> _y >> "type");
					_sell = getArray(missionConfigFile >> "CfgTraderCategory"  >> _cat  >> _y >> "sell");									
					if(_type == "trade_items")then{
						_pic = getText (configFile >> 'CfgMagazines' >> _y >> 'picture');
						_text = getText (configFile >> 'CfgMagazines' >> _y >> 'displayName');
					}else{
						_pic = getText (configFile >> 'CfgWeapons' >> _y >> 'picture');
						_text = getText (configFile >> 'CfgWeapons' >> _y >> 'displayName');
					};												
					Z_SellableArray set [count(Z_SellableArray) , [_y,_type,_sell select 0,_text,_pic]];
					_totalPrice = _totalPrice + (_sell select 0);				
				};					
			}forEach _arrayOfTraderCat;				
		}count _all;	
						
		_ctrltext = format["I would pay %1 %2 you for all those items.", _totalPrice,CurrencyName];
		ctrlSetText [7413, _ctrltext];		
		_ctrltext = format["I accept %1 items from %2.", count(Z_SellableArray) , _extraText];
		ctrlSetText [7412, _ctrltext];	
		call Z_fillSellList;
	};		
};

Z_calcPrice = {
	_sellPrice = 0;
	{  		
		_sellPrice = _sellPrice +  (_x select 2);
	}count Z_SellArray;
		_ctrltext = format["%1 %2", _sellPrice , CurrencyName];
		ctrlSetText [7403, _ctrltext];	
};

Z_fillSellList = {
	
	{
		_index = lbAdd [7401,  _x select 3];
		lbSetPicture [7401, _index, _x select 4 ];
	}count Z_SellableArray;
};

Z_fillSellingList = {
	{  		
		_index = lbAdd [7402, _x select 3];
		lbSetPicture [7402, _index,  _x select 4];
	}count Z_SellArray;
};

Z_pushItemToList = {
	_index = _this select 0;
	lbDelete [7401, _index];
	systemChat str(_index);
	_temp = Z_SellableArray select _index;
	_item = [_temp select 0,_temp select 1 ,_temp select 2,_temp select 3, _temp select 4  ];
	Z_SellArray = Z_SellArray + [_item];
	Z_SellableArray = Z_SellableArray set [_index,"deleted"];
	Z_SellableArray = Z_SellableArray - ["deleted"];
	_index2 = lbAdd [7402, _item select 3];
	lbSetPicture [7402, _index2, _item select 4];
	call Z_calcPrice;
};

Z_removeItemFromList = {
	_index = _this select 0;
	lbDelete [7402, _index];
	systemChat str(_index);
	_temp = Z_SellArray select _index;
	_item = [_temp select 0,_temp select 1 ,_temp select 2,_temp select 3, _temp select 4  ];
	Z_SellableArray = Z_SellableArray +  [_item];
	Z_SellArray = Z_SellArray set [_index,"deleted"];
	Z_SellArray = Z_SellArray - ["deleted"];
	_index2 = lbAdd [7401,  _item select 3];
	lbSetPicture [7401, _index2, _item select 4];
	call Z_calcPrice;	
};

Z_pushAllToList = {
	Z_SellArray = Z_SellArray + Z_SellableArray;
	Z_SellableArray = [];
	call Z_clearLists;
	call Z_fillSellList;
	call Z_fillSellingList;
	call Z_calcPrice;
};

Z_removeAllToList = {
	Z_SellableArray = Z_SellableArray + Z_SellArray;
	Z_SellArray = [];
	call Z_clearLists;
	call Z_fillSellList;
	call Z_fillSellingList;
	call Z_calcPrice;
};

Z_SellItems = {
	_index = count (Z_SellArray) - 1;	
	_money = 0;
	_tempArray = Z_SellArray;
	if(_index > -1)then{
		{ // removing from backpack gear or vehicle gear or personal gear		
			_result = false;
			_type = _x select 1;
			_name = _x select 0;
			_price = _x select 2;
			//backpack
			if(Z_SellingFrom == 0)then{
			
				if(_type == "trade_items")then{		
				_outcome = [unitBackpack player,_name] call CBA_fnc_removeMagazineCargo;
				}else{
				_outcome = [unitBackpack player,_name] call CBA_fnc_removeWeaponCargo;
				};
				if(_outcome )then{
					_result = true;
				};
			};
			//vehicle
			if(Z_SellingFrom == 1)then{				
				
				if(_type == "trade_items")then{		
				_outcome = [Z_vehicle,_name] call CBA_fnc_removeMagazineCargo;		
				}else{
				_outcome = [Z_vehicle,_name] call CBA_fnc_removeWeaponCargo;		
				};				
				if(_outcome )then{
					_result = true;
				};
			};
			//gear
			if(Z_SellingFrom == 2)then{
				_outcome = [player,_name,1] call BIS_fnc_invRemove;
				if(_outcome == 1)then{
					_result = true;
				};
			};
			if!(_result) exitWith {
			
			}; // failsafe, didnt remove the item !!
			
			_money = _money + _price;
			Z_SellArray = Z_SellArray set [_index,objNull];		
			lbDelete [7402, _index];
			_index = _index - 1;
		}count _tempArray;
		Z_SellArray = Z_SellArray - [objNull];
	};	
	[player,_money] call SC_fnc_addCoins;		
   	call Z_getGearItems;	
};

/* ----------------------------------------------------------------------------
Function: CBA_fnc_removeMagazineCargo

Description:
    Function to remove specific items from local cargo space.
    
    * Use <CBA_fnc_removeMagazineCargoGlobal> if you want to remove the item in global mission space.

Parameters:
    _unit - the vehicle providing cargo space [Object]
    _item - classname of item to remove [String]
    _count - number of items to remove [Number] (Default: 1)

Returns:
    true on success, false otherwise (error or no such item in cargo)

Examples:
   (begin example)
   _success = [myCoolWeaponBox, "SmokeShell"] call CBA_fnc_removeMagazineCargo; // remove 1 Smokegrenade locally from the box
   _success = [myCoolWeaponBox, "HandGrenade_West", 2] call CBA_fnc_removeMagazineCargo; // remove 2 Handgrenades locally from the box
   (end)

Author:
    silencer.helling3r 2012-12-22
---------------------------------------------------------------------------- */
CBA_fnc_removeMagazineCargo = {
	private ["_unit", "_item", "_count", "_i", "_unit_allItems", "_unit_allItems_types", "_unit_allItems_count", "_item_type", "_item_count", "_returnVar"];
	
	// Parameter handling
	_unit = _this select 0;
	_item = _this select 1;
	_count = 1;
	if (count _this == 2) then {
		_count = _this select 2;
	};
	if (_count <= 0) exitWith { false;}; // params check
	_count = round _count; // ensure proper count
	
	_unit_allItems = getMagazineCargo _unit; // returns array containing two arrays: [[type1, typeN, ...],[count1, countN, ...]]
	_unit_allItems_types = _unit_allItems select 0;
	_unit_allItems_count = _unit_allItems select 1;
	
	// Clear cargo space and readd the items as long its not the type in question.
	// If it is the requested class, we cannot just substract items because of the count parameter.
	returnVar = false;
	clearMagazineCargo _unit;
	for [{_i=0}, {_i<(count _unit_allItems_types)}, {_i=_i+1}] do {
		_item_type = _unit_allItems_types select _i;
		_item_count = _unit_allItems_count select _i;
		if (_item_type == _item) then {
			// process removal
			returnVar = true;
			
			_item_count = _item_count - _count;
			if (_item_count > 0) then {
				// add with new count
				_unit addMagazineCargo [_item_type, _item_count];
			} else {
				// don't add item anymore as we removed all of them
			};
		} else {
			// just readd item
			_unit addMagazineCargo [_item_type, _item_count];
		};
	};
	
	returnVar;
};


/* ----------------------------------------------------------------------------
Function: CBA_fnc_removeMagazineCargoGlobal

Description:
    Function to remove specific items from global cargo space.
    
    * Use <CBA_fnc_removeMagazineCargo> if you want to remove the item in local mission space only.

Parameters:
    _unit - the vehicle providing cargo space [Object]
    _item - classname of item to remove [String]
    _count - number of items to remove [Number] (Default: 1)

Returns:
    true on success, false otherwise (error or no such item in cargo)

Examples:
   (begin example)
   _success = [myCoolWeaponBox, "SmokeShell"] call CBA_fnc_removeMagazineCargoGlobal; // remove 1 Smokegrenade globally from the box
   _success = [myCoolWeaponBox, "HandGrenade_West", 2] call CBA_fnc_removeMagazineCargoGlobal; // remove 2 Handgrenades globally from the box
   (end)

Author:
    silencer.helling3r 2012-12-22
---------------------------------------------------------------------------- */
CBA_fnc_removeMagazineCargoGlobal = {
	private ["_unit", "_item", "_count", "_i", "_unit_allItems", "_unit_allItems_types", "_unit_allItems_count", "_item_type", "_item_count", "_returnVar"];
	
	// Parameter handling
	_unit = _this select 0;
	_item = _this select 1;
	_count = 1;
	if (count _this == 2) then {
		_count = _this select 2;
	};
	if (_count <= 0) exitWith { false;}; // params check
	_count = round _count; // ensure proper count
	
	_unit_allItems = getMagazineCargo _unit; // returns array containing two arrays: [[type1, typeN, ...],[count1, countN, ...]]
	_unit_allItems_types = _unit_allItems select 0;
	_unit_allItems_count = _unit_allItems select 1;
	
	// Clear cargo space and readd the items as long its not the type in question.
	// If it is the requested class, we cannot just substract items because of the count parameter.
	returnVar = false;
	clearMagazineCargoGlobal _unit;
	for [{_i=0}, {_i<(count _unit_allItems_types)}, {_i=_i+1}] do {
		_item_type = _unit_allItems_types select _i;
		_item_count = _unit_allItems_count select _i;
		if (_item_type == _item) then {
			// process removal
			returnVar = true;
			
			_item_count = _item_count - _count;
			if (_item_count > 0) then {
				// add with new count
				_unit addMagazineCargoGlobal [_item_type, _item_count];
			} else {
				// don't add item anymore as we removed all of them
			};
		} else {
			// just readd item
			_unit addMagazineCargoGlobal [_item_type, _item_count];
		};
	};
	
	returnVar;
};

/* ----------------------------------------------------------------------------
Function: CBA_fnc_removeWeaponCargo

Description:
    Function to remove specific items from local cargo space.
    
    * Use <CBA_fnc_removeWeaponCargoGlobal> if you want to remove the item in global mission space.

Parameters:
    _unit - the vehicle providing cargo space [Object]
    _item - classname of item to remove [String]
    _count - number of items to remove [Number] (Default: 1)

Returns:
    true on success, false otherwise (error or no such item in cargo)

Examples:
   (begin example)
   _success = [myCoolWeaponBox, "Binocular"] call CBA_fnc_removeWeaponCargo; // remove 1 Binocular locally from the box
   _success = [myCoolWeaponBox, "M14", 2] call CBA_fnc_removeWeaponCargo; // remove 2 M14 locally from the box
   (end)

Author:
    silencer.helling3r 2012-12-22
---------------------------------------------------------------------------- */
CBA_fnc_removeWeaponCargo = {
	private ["_unit", "_item", "_count", "_i", "_unit_allItems", "_unit_allItems_types", "_unit_allItems_count", "_item_type", "_item_count", "_returnVar"];
	
	// Parameter handling
	_unit = _this select 0;
	_item = _this select 1;
	_count = 1;
	if (count _this == 2) then {
		_count = _this select 2;
	};
	if (_count <= 0) exitWith { false;}; // params check
	_count = round _count; // ensure proper count
	
	_unit_allItems = getWeaponCargo _unit; // returns array containing two arrays: [[type1, typeN, ...],[count1, countN, ...]]
	_unit_allItems_types = _unit_allItems select 0;
	_unit_allItems_count = _unit_allItems select 1;
	
	// Clear cargo space and readd the items as long its not the type in question.
	// If it is the requested class, we cannot just substract items because of the count parameter.
	returnVar = false;
	clearWeaponCargo _unit;
	for [{_i=0}, {_i<(count _unit_allItems_types)}, {_i=_i+1}] do {
		_item_type = _unit_allItems_types select _i;
		_item_count = _unit_allItems_count select _i;
		if (_item_type == _item) then {
			// process removal
			returnVar = true;
			
			_item_count = _item_count - _count;
			if (_item_count > 0) then {
				// add with new count
				_unit addWeaponCargo [_item_type, _item_count];
			} else {
				// don't add item anymore as we removed all of them
			};
		} else {
			// just readd item
			_unit addWeaponCargo [_item_type, _item_count];
		};
	};
	
	returnVar;
};

/* ----------------------------------------------------------------------------
Function: CBA_fnc_removeWeaponCargoGlobal

Description:
    Function to remove specific items from global cargo space.
    
    * Use <CBA_fnc_removeWeaponCargo> if you want to remove the item in local mission space only.

Parameters:
    _unit - the vehicle providing cargo space [Object]
    _item - classname of item to remove [String]
    _count - number of items to remove [Number] (Default: 1)

Returns:
    true on success, false otherwise (error or no such item in cargo)

Examples:
   (begin example)
   _success = [myCoolWeaponBox, "Binocular"] call CBA_fnc_removeWeaponCargoGlobal; // remove 1 Binocular globally from the box
   _success = [myCoolWeaponBox, "M14", 2] call CBA_fnc_removeWeaponCargoGlobal; // remove 2 M14 globally from the box
   (end)

Author:
    silencer.helling3r 2012-12-22
---------------------------------------------------------------------------- */
CBA_fnc_removeWeaponCargoGlobal = {
	private ["_unit", "_item", "_count", "_i", "_unit_allItems", "_unit_allItems_types", "_unit_allItems_count", "_item_type", "_item_count", "_returnVar"];
	
	// Parameter handling
	_unit = _this select 0;
	_item = _this select 1;
	_count = 1;
	if (count _this == 2) then {
		_count = _this select 2;
	};
	if (_count <= 0) exitWith { false;}; // params check
	_count = round _count; // ensure proper count
	
	_unit_allItems = getWeaponCargo _unit; // returns array containing two arrays: [[type1, typeN, ...],[count1, countN, ...]]
	_unit_allItems_types = _unit_allItems select 0;
	_unit_allItems_count = _unit_allItems select 1;
	
	// Clear cargo space and readd the items as long its not the type in question.
	// If it is the requested class, we cannot just substract items because of the count parameter.
	returnVar = false;
	clearWeaponCargoGlobal _unit;
	for [{_i=0}, {_i<(count _unit_allItems_types)}, {_i=_i+1}] do {
		_item_type = _unit_allItems_types select _i;
		_item_count = _unit_allItems_count select _i;
		if (_item_type == _item) then {
			// process removal
			returnVar = true;
			
			_item_count = _item_count - _count;
			if (_item_count > 0) then {
				// add with new count
				_unit addWeaponCargoGlobal [_item_type, _item_count];
			} else {
				// don't add item anymore as we removed all of them
			};
		} else {
			// just readd item
			_unit addWeaponCargoGlobal [_item_type, _item_count];
		};
	};
	
	returnVar;
};


Z_AdvancedTradingInit = true;

};

createDialog "AdvancedTrading";
call Z_getGearItems; 