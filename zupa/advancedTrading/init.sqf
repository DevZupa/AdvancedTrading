disableSerialization;

Z_traderData = (_this select 3); // gets the trader data ( menu_Functionary1 )

Selling = true;

if( isNil "Z_traderData" || count (Z_traderData) == 0)exitWith{
cutText [format["There went something wrong."], "PLAIN DOWN"];
};

if(isNil "Z_AdvancedTradingInit")then{

Z_SellableArray = [];
Z_SellArray = [];
Z_BuyArray = [];
Z_BuyingArray = [];
Z_vehicle = objNull;

Z_filleTradeTitle = {
	_text = _this select 0;
	ctrlSetText [7408, _text];
};

// initiate the functions for advanced trading -- easier for the people :) otherwise it would be in compiles.
Z_clearLists = {
	lbClear 7401;
    lbClear 7402;
	
};

Z_clearBuyList = {
  lbClear 7421;
};

Z_clearBuyingList = {
  lbClear 7422;
};

Z_getContainer = {
	Z_clearBuyingList;
	Z_clearLists;
	Z_SellableArray = [];
	Z_SellArray = [];
	Z_BuyingArray = [];
	
	_lbIndex= _this select 0;

	if(Selling)then{
		switch (_lbIndex) do {
			case 0: { 
				["Selling from backpack."] call Z_filleTradeTitle;
				call Z_getBackpackItems; 
			};
			case 1: { 
				["Selling from vehicle."] call Z_filleTradeTitle;
				call Z_getVehicleItems; 
			};
			case 2: { 
				["Selling from gear."] call Z_filleTradeTitle;
				call Z_getGearItems; 
			};
		};
	}else{
		switch (_lbIndex) do {
			case 0: { 
				["Buying in backpack."] call Z_filleTradeTitle;
				
			};
			case 1: { 
				["Buying in vehicle."] call Z_filleTradeTitle;
				 
			};
			case 2: { 
				["Buying in gear."] call Z_filleTradeTitle;
				
			};
		};
	
	};

};

Z_getBackpackItems = {
	call Z_clearLists;
	Z_SellingFrom = 0;
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
	
		[_normalMags,_normalWeaps, typeOf _backpack] call	Z_checkArrayInConfig;	
	}else{
		_ctrltext = format["I'm not stupid.."];
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
	
	_list = nearestObjects [(getPosATL player), ["AllVehicles"], 30];	
	{
		systemChat (str(typeOf _x) + str(local _x));
		if(!isNull _x && local _x && !isPlayer _x && alive _x && !(_x isKindOf "zZombie_base"))then{
			_vehicle = _x;
		};
	}count _list;
	
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
				_normalWeaps set [count(_normalWeaps),_x];
				_counter = _counter + 1;
			};
		}forEach _kinds2;
		
		
		[_normalWeaps,_normalMags, typeOf _vehicle] call Z_checkArrayInConfig;
	}else{
		_ctrltext = format["Get in driver seat first!"];
		ctrlSetText [7413, _ctrltext];
		
		_ctrltext = format["I do not see any vehicle owned by you."];
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
						
		if(Z_SellingFrom != 2)then{
			_extraText = getText (configFile >> 'CfgVehicles' >> _extraText >> 'displayName');
		};
		_ctrltext = format["I would pay %1 %2 to you for all those items.", _totalPrice,CurrencyName];
		ctrlSetText [7413, _ctrltext];		
		_ctrltext = format["I accept %1 items from %2.", count(Z_SellableArray) , _extraText];
		ctrlSetText [7412, _ctrltext];	
		call Z_fillSellList;
	};		
};

Z_calcPrice = {
	_sellPrice = 0;
	if(Selling)then{	
		{  		
			_sellPrice = _sellPrice +  (_x select 2);
		}count Z_SellArray;
	}else{
		{
			_sellPrice = _sellPrice +  ((_x select 2) * (_x select 5));
		}count Z_BuyingArray;
	};
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
	if(!isNil"_index" && _index > -1)then {
		lbDelete [7401, _index];
		systemChat format["Selected from pos %1",_index];
		_temp = Z_SellableArray select _index;
		_item = [_temp select 0,_temp select 1 ,_temp select 2,_temp select 3, _temp select 4  ];
		Z_SellArray set [count(Z_SellArray),_item];
		Z_SellableArray set [_index,"deleted"];
		Z_SellableArray = Z_SellableArray - ["deleted"];
		_index2 = lbAdd [7402, _item select 3];
		lbSetPicture [7402, _index2, _item select 4];
		systemChat format["Added to pos %1",_index2];
		call Z_calcPrice;
	};
};

Z_removeItemFromList = {
	_index = _this select 0;
	if(!isNil"_index" && _index > -1)then {
		lbDelete [7402, _index];
		systemChat format["Selected from pos %1",_index];
		_temp = Z_SellArray select _index;
		_item = [_temp select 0,_temp select 1 ,_temp select 2,_temp select 3, _temp select 4  ];
		Z_SellableArray set [count(Z_SellableArray),_item];
		Z_SellArray set [_index,"deleted"];
		Z_SellArray = Z_SellArray - ["deleted"];
		_index2 = lbAdd [7401,  _item select 3];
		lbSetPicture [7401, _index2, _item select 4];
		systemChat format["Added to pos %1",_index2];
		call Z_calcPrice;	
	};
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
	_tempArray = Z_SellArray;
	if(_index > -1)then{
		systemChat "Init Trading";	
		_outcome = [];
		_weaponsArray = [];
		_itemsArray = [];	
		_weaponsCheckArray = [];
		_itemsCheckArray = [];
		{ 		
			_type = _x select 1;
			_name = _x select 0;						
			if(_type == "trade_items")then{		
				_itemsArray set [count(_itemsArray),_name];
				_itemsCheckArray set [count(_itemsArray),_x];
			}else{
				_weaponsArray set [count(_weaponsArray),_name];
				_weaponsCheckArray set [count(_weaponsArray),_x];
			};			
		}count _tempArray;
		
		closeDialog 2;
				
		if(Z_SellingFrom == 0)then{
			_outcome = [unitBackpack player,_itemsArray,_weaponsArray] call ZUPA_fnc_removeWeaponsAndMagazinesCargo;
		};
		if(Z_SellingFrom == 1)then{	
			_outcome = [Z_vehicle,_itemsArray,_weaponsArray] call ZUPA_fnc_removeWeaponsAndMagazinesCargo;		
		};
							
		//gear
		if(Z_SellingFrom == 2)then{
		_wA = [];
		_mA = [];
		{
			_localResult = [player,(_x select 0),1] call BIS_fnc_invRemove;
			if( _localResult != 1)then{
				if(_x select 1 == "trade_items")then{
					_mA set [count(_mA),0];
				}else{
					_wA set [count(_wA),0];
				};
			}else{
				if(_x select 1 == "trade_items")then{
					_mA set [count(_mA),1];
				}else{
					_wA set [count(_wA),1];
				};
			};
			
		}count _tempArray;
			
		_outcome set [0,_mA];	
		_outcome set [1,_wA];	
		};
			
		_money = 0;	
		{
			_money = _money + ( (_itemsCheckArray select _forEachIndex select 2) * _x) ;	
		}forEach (_outcome select 0);
		{
			_money = _money + ( (_weaponsCheckArray select _forEachIndex select 2) * _x) ;	
		}forEach (_outcome select 1);
		
		if(typeName _money == "SCALAR")then{
			[player,_money] call SC_fnc_addCoins;	
			systemChat "added" + str(_money);			
		}else{
		systemChat "Money is not a number";			
		};		
						
	}else{
		systemChat "No Items to Sell";
	};	
	
		
};

/* ----------------------------------------------------------------------------
Examples:
   _result = [_backpack, ["SmokeShell","M16_AMMO"],["M16","M16","M240"]] call ZUPA_fnc_removeWeaponsAndMagazinesCargo; 
   _result == [[1,0,0,1,1,1,0],[1,0,0,1]]; // 1 = success, 0 = fail ( not in cargo)
   
Author:
   Zupa 2014-09-30
---------------------------------------------------------------------------- */
ZUPA_fnc_removeWeaponsAndMagazinesCargo = {
	private ["_unit", "_items","_weaps","_normalItems","_normalWeaps", "_count", "_i", "_unit_allItems", "_unit_allItems_types", "_unit_allItems_count", "_item_type", "_item_count", "__returnVar"];
	_unit = _this select 0;
	_items = _this select 1; 
	_weaps = _this select 2; 
	_normalItems = [];
	_normalWeaps = [];
	_unit_allItems = getMagazineCargo _unit; //  [[type1, typeN, ...],[count1, countN, ...]]
	_unit_allItems_types = _unit_allItems select 0;
	_unit_allItems_count = _unit_allItems select 1;	
	_unit_allWeaps = getWeaponCargo _unit; 
	_unit_allWeaps_types = _unit_allWeaps select 0;
	_unit_allWeaps_count = _unit_allWeaps select 1;	
	clearMagazineCargo _unit;	
	clearWeaponCargo _unit;
	{
		_counter = 0 ;
		while{	_counter < ( _unit_allItems_count select _forEachIndex)}do{
		_normalItems set [count(_normalItems),_x];
				_counter = _counter + 1;
		};
	}forEach _unit_allItems_types;				
	{
		_counter = 0 ;
		while{	_counter < ( _unit_allWeaps_count select _forEachIndex)}do{
		_normalWeaps set [count(_normalWeaps),_x];
				_counter = _counter + 1;
		};
	}forEach _unit_allWeaps_types;			
	_returnVar = [];	
	_returnMag = [];	
	_returnWeap = [];
	
	{		
		_inCargo = _normalItems find _x;
		if(_inCargo > -1)then{
			_normalItems set [_inCargo, "soldItem"];
			_returnMag set [count(_returnMag),1];
		}else{
			_returnMag set [count(_returnMag),0];	
		};
	}count _items;	
	_normalItems = _normalItems - ["soldItem"];
	{				
		_unit addMagazineCargo [_x, 1];				
	}count _normalItems;	
	
	{		
		_inCargo = _normalWeaps find _x;
		if(_inCargo > -1)then{
			_normalWeaps set [_inCargo, "soldItem"];
			_returnWeap set [count(_returnWeap),1];
		}else{
			_returnWeap set [count(_returnWeap),0];	
		};
	}count _weaps;	
	_normalWeaps = _normalWeaps - ["soldItem"];
	{				
		_unit addWeaponCargo [_x, 1];				
	}count _normalWeaps;
			
	_returnVar set [0,_returnMag];
	_returnVar set [1,_returnWeap];
	_returnVar;
};

Z_ChangeBuySell = {
	
	_dialog = findDisplay 711197;
	
	Selling = !Selling;
	
	if(Selling)then{	
		(_dialog displayCtrl 7416) ctrlSetText "Buy";
		{ctrlShow [_x,true];} forEach [7401,7402,7435,7430,7431,7432,7433]; // show
		{ctrlShow [_x,false];} forEach [7421,7422,7436,7440,7441,7442,7443,7404]; // hide
				
	}else{
		(_dialog displayCtrl 7416) ctrlSetText "Sell";
		{ctrlShow [_x,true];} forEach [7421,7422,7436,7440,7441,7442,7443,7404]; // show
		{ctrlShow [_x,false];} forEach [7401,7402,7435,7430,7431,7432,7433]; // hide	
		call Z_fillBuyList;
	};
	
	[2] call Z_getContainer; // default gear

	
	
};

Z_BuyItems = {

};

Z_removeAllFromBuyingList = {
	Z_clearBuyingList;
	Z_BuyingArray = [];
};

Z_removeItemFromBuyingList = {
	_index = _this select 0;
	if(!isNil"_index" && _index > -1)then {
		lbDelete [7422, _index];
		Z_BuyingArray set [_index,"deleted"];
		Z_BuyingArray = Z_BuyingArray - ["deleted"];		
		call Z_calcPrice;	
	};
};

Z_toBuyingList = {
	_index = _this select 0;
	_amount = parseNumber(_this select 1);		
	if(!isNil"_index" && _index > -1 && (typeName _amount == "SCALAR") && _amount > 0 )then {
		systemChat format["Selected from pos %1",_index];
		_temp = Z_BuyArray select _index;
		_item = [_temp select 0,_temp select 1 ,_temp select 2,_temp select 3, _temp select 4, _amount ];
		Z_BuyingArray set [count(Z_BuyingArray),_item];		
		_index2 = lbAdd [7422, format["%1x: %2",_item select 5,_item select 3];
		lbSetPicture [7422, _index2, _item select 4];
		systemChat format["Added to pos %1",_index2];
		call Z_calcPrice;
	};	
};

Z_fillBuyList = {
		call Z_clearBuyList;
		call Z_clearBuyingList;
		Z_BuyArray = [];
		Z_BuyingArray = [];
		_arrayOfTraderCat = Z_traderData;	
		_counter = 0;
		{	
					_cat =  format["Category_%1",(_arrayOfTraderCat select _forEachIndex select 1)];
					
					_cfgtraders = missionConfigFile >> "CfgTraderCategory"  >> _cat;
					for "_i" from 0 to (count _cfgtraders)-1 do
					{					
						_y  = _cfgtraders select _i;
							
						_type =  getText(missionConfigFile >> "CfgTraderCategory"  >> _cat  >> _y >> "type");
						_buy = getArray(missionConfigFile >> "CfgTraderCategory"  >> _cat  >> _y >> "sell");
						_pic = "";
						_text = "";	
						if(_type == "trade_items")then{
							_pic = getText (configFile >> 'CfgMagazines' >> _y >> 'picture');
							_text = getText (configFile >> 'CfgMagazines' >> _y >> 'displayName');
						}else{
							_pic = getText (configFile >> 'CfgWeapons' >> _y >> 'picture');
							_text = getText (configFile >> 'CfgWeapons' >> _y >> 'displayName');
						};							
						Z_BuyArray set [count(Z_BuyArray) , [_y,_type,_buy select 0,_text,_pic]];
						_totalPrice = _totalPrice + (_buy select 0);	
											
					};																	
		}forEach _arrayOfTraderCat;	
		call Z_fillBuylList;
		call Z_calcPrice;
};

Z_fillBuylList = {	
	{
		_index = lbAdd [7421,  _x select 3];
		lbSetPicture [7421, _index, _x select 4 ];
	}count Z_BuyArray;
};

Z_fillBuyingList = {
	{  		
		_index = lbAdd [7422, _x select 3];
		lbSetPicture [7422, _index,  _x select 4];
	}count Z_BuyingArray;
};

Z_AdvancedTradingInit = true;

};

createDialog "AdvancedTrading";

_dialog = findDisplay 711197;
(_dialog displayCtrl 7432) ctrlSetText " < ";
(_dialog displayCtrl 7433) ctrlSetText " << ";
(_dialog displayCtrl 7442) ctrlSetText " < ";
(_dialog displayCtrl 7443) ctrlSetText " << ";
call Z_getGearItems; 