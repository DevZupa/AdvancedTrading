disableSerialization;

Z_traderData = (_this select 3); // gets the trader data ( e.g menu_Functionary1 )

if( isNil "Z_traderData" || count (Z_traderData) == 0)exitWith{
	cutText [format["There went something wrong."], "PLAIN DOWN"];
};

if(isNil "Z_AdvancedTradingInit")then{

	#include "config.sqf";

	/* Configs that needs to be defined but not changed in config file */
	Z_Selling = true;
	Z_SellingFrom = 2;
	Z_vehicle = objNull;
	Z_OriginalSellableArray = [];
	Z_SellableArray = [];
	Z_SellArray = [];
	Z_OriginalBuyableArray = [];
	Z_BuyableArray = [];
	Z_BuyingArray = [];

	if( isNil 'CurrencyName' && Z_SingleCurrency )then{
		CurrencyName = 'Coins'; // fallback 
	};
	if (!Z_SingleCurrency) then { 
		CurrencyName = '';
	};

	/*
	*	Gets the worth value of all the money items.
	*
	*
	*/
	Z_getDefaultCurrencyWorth = {

	};

	/* end script config */

    /*
    * Author: Killzone_Kid
    *
    * Description:
    * Find a string within a string (case insensitive)
    *
    * Parameter(s):
    * _this select 0: <string> string to be found
    * _this select 1: <string> string to search in
    *
    * Returns:
    * Boolean (true when string is found)
    *
    * How to use:
    * _found = ["needle", "Needle in Haystack"] call KK_fnc_inString;
    */
	KK_fnc_inString = {
        private ["_needle","_haystack","_needleLen","_hay","_found"];
        _needle = [_this, 0, "", [""]] call BIS_fnc_param;
        _haystack = toArray ([_this, 1, "", [""]] call BIS_fnc_param);
        _needleLen = count toArray _needle;
        _hay = +_haystack;
        _hay resize _needleLen;
        _found = false;
        for "_i" from _needleLen to count _haystack do {
            if (toString _hay == _needle) exitWith {_found = true};
            _hay set [_needleLen, _haystack select _i];
            _hay set [0, "x"];
            _hay = _hay - ["x"]
        };
        _found
    };

	/**
	*	[_text] call Z_filleTradeTitle
	*
	*	@param String _this select 0 (_text) -> The text you want in the label.
	*
	*	Changes the indication of where you are selling/buying from in the trade window.
	**/
	Z_filleTradeTitle = {
		_text = _this select 0;
		ctrlSetText [Z_AT_CONTAINERINDICATOR, _text];
	};

	/**
	*	call Z_clearLists
	*
	*	Clears the visual listbox of items you were going to sell and could be selled.
	**/
	Z_clearLists = {
		lbClear Z_AT_SELLABLELIST;
		lbClear Z_AT_SELLINGLIST;
	};
	
	/**
    *	call Z_clearSellableList
    *
    *	Clears the visual listbox of items you were going to sell.
    **/
	Z_clearSellableList = {
    		lbClear Z_AT_SELLABLELIST;
    };

	/**
	*	call Z_clearBuyList
	*
	*	Clears the visual listbox of items you could buy.
	**/
	Z_clearBuyList = {
	  lbClear Z_AT_BUYABLELIST;
	};

	/**
	*	call Z_clearBuyingList
	*
	*	Clears the visual listbox of items you were going to buy.
	**/
	Z_clearBuyingList = {
	  lbClear Z_AT_BUYINGLIST;
	};

	/**
	*	[_selectedList, _selectedIndex ]call Z_clearBuyingList
	*
	*	Innitiates the item info to be displayed by getting the right item out of the corresponding list based on your sellection.
	**/
	Z_getItemInfo = {
		private ['_item','_selectedList','_selectedIndex'];

		_selectedList = _this select 0;
		_selectedIndex = _this select 1;

		_item = [];	
		
		if(_selectedIndex >= 0) then {
			switch(_selectedList) do {
				case 'sellable': {
					_item = Z_SellableArray select _selectedIndex;
				};
				case 'selling': {
					_item = Z_SellArray select _selectedIndex;
				};
				case 'buyable': {
					_item = Z_BuyableArray select _selectedIndex;	
				};
				case 'buying': {
					_item = Z_BuyingArray select _selectedIndex;
				};
			};
		};

		if( count _item > 0) then {
			[_item] call Z_getItemConfig;
		};

	};

	Z_getItemConfig = {
		private ['_item', '_type'];
		_item = _this select 0;
		_type = _item select 1;

		switch (true) do {
			case (_type == "trade_items") :
			{
				[_item] call Z_displayItemInfo;
			};
			case (_type == "trade_weapons") :
			{
				[_item] call Z_displayWeaponInfo;
			};
			case (_type == "trade_backpacks") :
			{	
				[_item] call Z_displayBackpackInfo;
			};
			case (_type == "trade_vehicles") :
			{
				[_item] call Z_displayVehicleInfo;
			};
			default {
				(findDisplay Z_AT_DIALOGWINDOW displayCtrl Z_AT_ITEMINFO) ctrlSetStructuredText "<t color='#ffffff'>No info found</t>";
			}
		};
	};

	Z_displayItemInfo = {
		private ['_item'];
		_item = _this select 0;

		// [_y,_type,_sell select 0,_text,_pic, _forEachIndex, _buy select 0];

		_picture = _item select 4;
		_class = _item select 0;
		_display = _item select 3;
		_buyPrice = 0;
		_sellPrice = 0;
		if(Z_Selling)then{
			_buyPrice = _item select 6; _buyCurrency = _item select 8;
			_sellPrice = _item select 2; _sellCurrency = _item select 7;
		}else{
			_buyPrice = _item select 2; _buyCurrency = _item select 7;
			_sellPrice = _item select 6; _sellCurrency = _item select 8;
		};

		_formattedText = format [
			"<img image='%1'  size='3' align='center'/><br />" + 
			"<t color='#33BFFF'>Name: </t><t color='#ffffff'>%2</t><br />" +
			"<t color='#33BFFF'>Class: </t><t color='#ffffff'>%3</t><br />" +
			"<t color='#33BFFF'>Sell: </t><t color='#ffffff'>%5 %7</t><br />" +
			"<t color='#33BFFF'>Buy: </t><t color='#ffffff'>%6 %7</t><br />" 
			, _picture, _display, _class, '', _sellPrice, _buyPrice, CurrencyName	
		];

		(findDisplay Z_AT_DIALOGWINDOW displayCtrl Z_AT_ITEMINFO) ctrlSetStructuredText parseText _formattedText;
	};
	Z_displayWeaponInfo = {
		_item = _this select 0;
		_picture = _item select 4;
		_class = _item select 0;
		_display = _item select 3;
		_buyPrice = 0;
		_sellPrice = 0;

		if(Z_Selling)then{
			_buyPrice = _item select 6; 
			_buyCurrency = _item select 8;
			_sellPrice = _item select 2; 
			_sellCurrency = _item select 7;
		}else{
			_buyPrice = _item select 2; 
			_buyCurrency = _item select 7;
			_sellPrice = _item select 6; 
			_sellCurrency = _item select 8;
		};

		_magazines = [];
		if( isArray (configFile >> 'CfgWeapons' >> _class >> 'magazines')) then {
			_magazines = getArray (configFile >> 'CfgWeapons' >> _class >> 'magazines');
		};
		_magText = "";

		{
			if( _forEachIndex > 0) then {
				_magText = _magText + ', ' + _x;
			} else {
				_magText = _magText + _x;
			};
		
		}foreach _magazines;

		_formattedText = format [
			"<img image='%1' size='3'  align='center' /><br />" + 
			"<t color='#33BFFF'>Name: </t><t color='#ffffff'>%2</t><br />" +
			"<t color='#33BFFF'>Class: </t><t color='#ffffff'>%3</t><br />" +
			"<t color='#33BFFF'>Sell: </t><t color='#ffffff'>%5 %7</t><br />" +
			"<t color='#33BFFF'>Buy: </t><t color='#ffffff'>%6 %7</t><br />" + 
			"<t color='#33BFFF'>Mags: </t><br /><t color='#ffffff' size='0.5'>%4</t>" 
			, _picture, _display, _class, _magText, _sellPrice, _buyPrice, CurrencyName 	
		];

		(findDisplay Z_AT_DIALOGWINDOW displayCtrl Z_AT_ITEMINFO) ctrlSetStructuredText parseText _formattedText;

	};
	Z_displayBackpackInfo = {
			_item = _this select 0;

			_picture = _item select 4;
			_class = _item select 0;
			_display = _item select 3;
			
			_transportMaxWeapons = 0;
			_transportMaxMagazines = 0; 

			_buyPrice = 0;
			_sellPrice = 0;
			if(Z_Selling)then{
				_buyPrice = _item select 6; 
				_buyCurrency = _item select 8;
				_sellPrice = _item select 2;
				_sellCurrency = _item select 7;
			}else{
				_buyPrice = _item select 2; 
				_buyCurrency = _item select 7;
				_sellPrice = _item select 6; 
				_sellCurrency = _item select 8;
			};

			if ( isText (configFile >> 'CfgVehicles' >> _class >> 'transportMaxWeapons')) then {
				_transportMaxWeapons = getText (configFile >> 'CfgVehicles' >> _class >> 'transportMaxWeapons');
			};
			
			if ( isText (configFile >> 'CfgVehicles' >> _class >> 'transportMaxMagazines')) then {
				_transportMaxMagazines  = getText (configFile >> 'CfgVehicles' >> _class >> 'transportMaxMagazines');
			};
			

			_formattedText = format [
			"<img image='%1'  size='3'  align='center'/><br />" + 
			"<t color='#33BFFF'>Name: </t><t color='#ffffff'>%2</t><br />" +
			"<t color='#33BFFF'>Class: </t><t color='#ffffff'>%3</t><br />" +
			"<t color='#33BFFF'>Sell: </t><t color='#ffffff'>%5 %7</t><br />" +
			"<t color='#33BFFF'>Buy: </t><t color='#ffffff'>%6 %7</t><br />" + 
			"<t color='#33BFFF'>Mags: </t><t color='#ffffff'>%8</t><br />" +
			"<t color='#33BFFF'>Weaps:</t><t color='#ffffff'>%9</t><br />" 
			, _picture, _display, _class, 'lazy', _sellPrice, _buyPrice, CurrencyName, _transportMaxWeapons,_transportMaxMagazines	
			];

			(findDisplay Z_AT_DIALOGWINDOW displayCtrl Z_AT_ITEMINFO) ctrlSetStructuredText parseText _formattedText;
	};

	Z_displayVehicleInfo = {
		private ['_item', '_type'];
			_item = _this select 0;

			_picture = _item select 4;
			_class = _item select 0;
			_display = _item select 3;

			_fuelCapacity = nil;
			_maxSpeed = nil;
			_armor = nil;
			_seats = nil;
			_weapons = nil;

			_transportMaxWeapons = 0;
			_transportMaxMagazines = 0; 
			_transportmaxBackpacks = 0;

			_buyPrice = 0;
			_sellPrice = 0;
			if(Z_Selling)then{
				_buyPrice = _item select 6; _buyCurrency = _item select 8;
				_sellPrice = _item select 2; _sellCurrency = _item select 7;
			}else{
				_buyPrice = _item select 2; _buyCurrency = _item select 7;
				_sellPrice = _item select 6; _sellCurrency = _item select 8;
			};

			if ( isText (configFile >> 'CfgVehicles' >> _class >> 'transportMaxWeapons')) then {
				_transportMaxWeapons = getText (configFile >> 'CfgVehicles' >> _class >> 'transportMaxWeapons');
			};
			
			if ( isText (configFile >> 'CfgVehicles' >> _class >> 'transportMaxMagazines')) then {
				_transportMaxMagazines  = getText (configFile >> 'CfgVehicles' >> _class >> 'transportMaxMagazines');
			};

			if ( isText (configFile >> 'CfgVehicles' >> _class >> 'transportmaxBackpacks')) then {
				_transportmaxBackpacks  = getText (configFile >> 'CfgVehicles' >> _class >> 'transportmaxBackpacks');
			};

			_formattedText = format [
			"<img image='%1' size='3' /><br />" + 
			"<t color='#33BFFF'>Name: </t><t color='#ffffff'>%2</t><br />" +  
			"<t color='#33BFFF'>Class: </t><t color='#ffffff'>%3</t><br />" +
			"<t color='#33BFFF'>Sell: </t><t color='#ffffff'>%5 %7</t><br />" +
			"<t color='#33BFFF'>Buy: </t><t color='#ffffff'>%6 %7</t><br />" + 
			"<t color='#33BFFF'>Mags: </t><t color='#ffffff'>%8</t><br />" +
			"<t color='#33BFFF'>Weaps: </t><t color='#ffffff'>%9</t><br />" +
			"<t color='#33BFFF'>Backs: </t><t color='#ffffff'>%4</t><br />" 
			, _picture, _display, _class, _transportmaxBackpacks, _sellPrice, _buyPrice, CurrencyName, _transportMaxWeapons,_transportMaxMagazines	
			];

			(findDisplay Z_AT_DIALOGWINDOW displayCtrl Z_AT_ITEMINFO) ctrlSetStructuredText parseText _formattedText;
	};

	/**
	*	call Z_getContainer
	*
	*	Switches between selling and buying and the item container (gear/vehicle/bakcpack) and initiates item loading.
	**/
	Z_getContainer = {
		(findDisplay Z_AT_DIALOGWINDOW displayCtrl Z_AT_SLOTSDISPLAY) ctrlSetText format["Free Slots: 0 / 0 / 0"];
		Z_clearBuyingList;
		Z_clearLists;
		Z_SellableArray = [];
		Z_SellArray = [];
		Z_BuyingArray = [];
		
		_lbIndex = _this select 0;

		if(Z_Selling)then{
			switch (_lbIndex) do {
				case 0: { 
					["Selling from backpack."] call Z_filleTradeTitle;
					Z_SellingFrom = 0;
					call Z_getBackpackItems; 
				};
				case 1: { 
					["Selling from vehicle."] call Z_filleTradeTitle;
					Z_SellingFrom = 1;
					call Z_getVehicleItems; 
				};
				case 2: { 
					["Selling from gear."] call Z_filleTradeTitle;
					Z_SellingFrom = 2;
					call Z_getGearItems; 
				};
			};
		}else{
			_ctrltext = format[" "];
			ctrlSetText [Z_AT_TRADERLINE2, _ctrltext];
			
			_ctrltext = format["These are all the items I'm selling."];
			ctrlSetText [Z_AT_TRADERLINE1, _ctrltext];
			switch (_lbIndex) do {
			
				case 0: { 
					Z_SellingFrom = 0;
					["Buying in backpack."] call Z_filleTradeTitle;
					[0] call Z_calculateFreeSpace;
				};
				case 1: { 
					Z_SellingFrom = 1;
					["Buying in vehicle."] call Z_filleTradeTitle;
					_canBuyInVehicle = call Z_checkCloseVehicle;
					if(_canBuyInVehicle)then{
						[1] call Z_calculateFreeSpace; 
					}else{
						systemChat format["Get in driver seat to be able to trade to your vehicle."];						
						(findDisplay Z_AT_DIALOGWINDOW displayCtrl Z_AT_SLOTSDISPLAY) ctrlSetText format["Free Slots: %1 / %2 / %3",0,0,0];
					};
				};
				case 2: {
					Z_SellingFrom = 2;				
					["Buying in gear."] call Z_filleTradeTitle;
					[2] call Z_calculateFreeSpace;
				};
			};
		};
	};

	/**
	*	call Z_getBackpackItems
	*
	*	Gets all your items stored in your backpack and innitiates the selling list.
	**/
	Z_getBackpackItems = {
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
	};

	/**
	*	call Z_getBackpackItems
	*
	*	Gets all your items stored in your vehicle and innitiates the selling list.
	**/
	Z_getVehicleItems = {
		Z_vehicle = objNull;
		call Z_clearLists;
		Z_SellableArray = [];
		Z_SellArray = [];
		_vehicle = objNull;
		
		_list = nearestObjects [(getPosATL player), ["AllVehicles"], Z_VehicleDistance];	
		{	
			if(!isNull _x && local _x && !isPlayer _x && alive _x && !(_x isKindOf "zZombie_base"))then{
				systemChat format["Selected %1",typeOf _x];
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
			ctrlSetText [Z_AT_TRADERLINE2, _ctrltext];
			
			_ctrltext = format["I do not see any vehicle."];
			ctrlSetText [Z_AT_TRADERLINE1, _ctrltext];
		};	
	};

	/**
	*	call Z_getBackpackItems
	*
	*	Gets all your items stored in your gear and innitiates the selling list.
	**/
	Z_getGearItems = {
		call Z_clearLists;
		Z_SellArray = [];
		Z_SellableArray = [];
		 _mags = magazines player;
		 _weaps = weapons player;
		[_weaps,_mags,"your gear"] call	Z_checkArrayInConfig;			
	};

	/**
	*	call Z_filterList
	*
	*   @param String _this select 0 (_query) -> the current string in the filter input
	*
	*	Filters the buyable or sellable list on your input.
	**/
	Z_filterList = {
		if(count _this > 0) then {
			_query = _this select 0;  // the search string.
			if(Z_Selling)then {
				if(isNil '_query' || _query == "") then {
					_newSellArray = [];
					{
					  if( _x find Z_SellArray < 0) then {
					  	_newSellArray set [count(_newSellArray), _x];	
					  };
					} forEach Z_OriginalSellableArray;

					Z_SellableArray	= [] + _newSellArray;

					call Z_clearSellableList;
					call Z_fillSellList;
				}else {
					_newSellArray = [];
					{
					  if(( [_query,(_x select 0)] call KK_fnc_inString) || ([_query,(_x select 3)] call KK_fnc_inString) ) then {
					  	if( _x find Z_SellArray < 0 ) then {
					  		_newSellArray set [count(_newSellArray), _x];	
					  	};
					  };
					} forEach Z_OriginalSellableArray;	
					Z_SellableArray = [] + _newSellArray;
					call Z_clearSellableList;
					call Z_fillSellList;
				};				
			}else {
				if(isNil '_query' || _query == "") then {
					Z_BuyableArray = [] + Z_OriginalBuyableArray;
					call Z_clearBuyList;
					call Z_fillBuyableList;
				}else {
					_newBuyArray = [];
					{
					  if(( [_query,(_x select 0)] call KK_fnc_inString) || ([_query,(_x select 3)] call KK_fnc_inString) ) then {
					  	_newBuyArray set [count(_newBuyArray), _x];	
					  };
					} forEach Z_OriginalBuyableArray;	
					Z_BuyableArray =  [] + _newBuyArray;
					call Z_clearBuyList;
					call Z_fillBuyableList;	
				};	
			};
		};		
	};

	/**
	*	[_weaps,_mags,_extraText]call Z_checkArrayInConfig
	*
	*   @param Array of Strings _this select 0 (_weaps) -> all weapons/items in the container
	*   @param Array of Strings _this select 1 (_mags) -> all magazines in the container
	*	@param String 			_this select 2 (_extraText) -> Indicator what container you are trading from
	*
	*	Fills up the sell or buy list if the item has a valid config.
	**/
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
					_excists = isClass(missionConfigFile >> "CfgTraderCategory"  >> _cat >> _y );

					if(_excists)exitWith{
						_pic = "";
						_text = "";
						_type = getText(missionConfigFile >> "CfgTraderCategory"  >> _cat  >> _y >> "type");
						_sell = getArray(missionConfigFile >> "CfgTraderCategory"  >> _cat  >> _y >> "sell");									
						_buy = getArray(missionConfigFile >> "CfgTraderCategory"  >> _cat  >> _y >> "buy");
						switch (true) do {
							case (_type == "trade_items") :
							{
								_pic = getText (configFile >> 'CfgMagazines' >> _y >> 'picture');
								_text = getText (configFile >> 'CfgMagazines' >> _y >> 'displayName');
							};
							case (_type == "trade_weapons") :
							{
								_pic = getText (configFile >> 'CfgWeapons' >> _y >> 'picture');
								_text = getText (configFile >> 'CfgWeapons' >> _y >> 'displayName');
							};
							case (_type == "trade_backpacks") :
							{
								_pic = getText (configFile >> 'CfgVehicles' >> _y >> 'picture');
								_text = getText (configFile >> 'CfgVehicles' >> _y >> 'displayName');
							};
						};
										
						if( isNil '_text')then{_text = _y;};

						_buyCurrency = CurrencyName;
						_sellCurrency = CurrencyName;

						if(!Z_SingleCurrency) then {
							_buyCurrency = 	_buy select 1;
							_sellCurrency = _sell select 1,
						};

						Z_SellableArray set [count(Z_SellableArray) , [_y,_type,_sell select 0,_text,_pic, _forEachIndex, _buy select 0, _sellCurrency, _buyCurrency, 0 ,_cat]];
                       _totalPrice = _totalPrice + (_sell select 0);				
					};					
				}forEach _arrayOfTraderCat;				
			}count _all;	

			Z_OriginalSellableArray = [] + Z_SellableArray;
					
			_backUpText = _extraText;

			if(Z_SellingFrom != 2)then{
				_extraText = getText (configFile >> 'CfgVehicles' >> _extraText >> 'displayName');
			};
			if (isNil '_extraText')then{
				_extraText = _backUpText;
			};
			
			if (Z_SingleCurrency) then {
				_ctrltext = format["I would offer %1 %2.", _totalPrice,CurrencyName];
				ctrlSetText [Z_AT_TRADERLINE2, _ctrltext];	
			} else {
				ctrlSetText [Z_AT_TRADERLINE2, ''];	
			};

			_ctrltext = format["I accept %1 items from %2.", count(Z_SellableArray) , _extraText];
			ctrlSetText [Z_AT_TRADERLINE1, _ctrltext];	

			call Z_fillSellList;
		};		
	};

	/**
	*	call Z_calcPrice
	*
	*	Calculate the total price for single currency.
	**/
	Z_calcPrice = {
		_sellPrice = 0;
		if(Z_Selling)then{	
			{  		
				_sellPrice = _sellPrice +  (_x select 2);
			}count Z_SellArray;
		}else{
			{
				_sellPrice = _sellPrice +  ((_x select 2) * (_x select 9));
			}count Z_BuyingArray;
		};
		_ctrltext = format["%1 %2", _sellPrice , CurrencyName];
		ctrlSetText [Z_AT_PRICEDISPLAY, _ctrltext];	
	};

	/**
	*	call Z_fillSellList
	*
	*	Visualy fills in the listbox of items that can be sold.
	**/
	Z_fillSellList = {
		
		{
			_index = lbAdd [Z_AT_SELLABLELIST,  _x select 3];
			lbSetPicture [Z_AT_SELLABLELIST, _index, _x select 4 ];
		}count Z_SellableArray;
	};

	/**
	*	call Z_fillSellingList
	*
	*	Visualy fills in the listbox of items currently being sold.
	**/
	Z_fillSellingList = {
		{  		
			_index = lbAdd [Z_AT_SELLINGLIST, _x select 3];
			lbSetPicture [Z_AT_SELLINGLIST, _index,  _x select 4];
		}count Z_SellArray;
	};

	Z_pushItemToList = {
		_index = _this select 0;
		if(!isNil"_index" && _index > -1)then {
			lbDelete [Z_AT_SELLABLELIST, _index];
			_temp = Z_SellableArray select _index;
			//_item = [_temp select 0,_temp select 1 ,_temp select 2,_temp select 3, _temp select 4  ];
			Z_SellArray set [count(Z_SellArray),_temp];
			Z_SellableArray set [_index,"deleted"];
			Z_SellableArray = Z_SellableArray - ["deleted"];
			_index2 = lbAdd [Z_AT_SELLINGLIST, _temp select 3];
			lbSetPicture [Z_AT_SELLINGLIST, _index2, _temp select 4];
			call Z_calcPrice;
		};
	};

	Z_removeItemFromList = {
		_index = _this select 0;
		if(!isNil"_index" && _index > -1)then {
			lbDelete [Z_AT_SELLINGLIST, _index];
			_temp = Z_SellArray select _index;
			//_item = [_temp select 0,_temp select 1 ,_temp select 2,_temp select 3, _temp select 4  ];
			Z_SellableArray set [count(Z_SellableArray),_temp];
			Z_SellArray set [_index,"deleted"];
			Z_SellArray = Z_SellArray - ["deleted"];
			_index2 = lbAdd [Z_AT_SELLABLELIST,  _temp select 3];
			lbSetPicture [Z_AT_SELLABLELIST, _index2, _temp select 4];
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

	Z_SellItems = 								compile preprocessFileLineNumbers (Z_AT_FolderLocation + "\functions\z_at_sellItems.sqf");
 
	Z_BuyItems = 								compile preprocessFileLineNumbers (Z_AT_FolderLocation + "\functions\z_at_buyItems.sqf");
 
	ZUPA_fnc_removeWeaponsAndMagazinesCargo = 	compile preprocessFileLineNumbers (Z_AT_FolderLocation + "\functions\zupa_fnc_removeWeaponsAndMagazinesCargo.sqf");

	Z_ChangeBuySell = 							compile preprocessFileLineNumbers (Z_AT_FolderLocation + "\functions\z_at_changeBuySell.sqf");

	Z_removeAllFromBuyingList = 				compile preprocessFileLineNumbers (Z_AT_FolderLocation + "\functions\z_at_removeAllFromBuyingList.sqf");

	Z_removeItemFromBuyingList = 				compile preprocessFileLineNumbers (Z_AT_FolderLocation + "\functions\z_at_removeItemFromBuyingList.sqf");

	Z_toBuyingList = 							compile preprocessFileLineNumbers (Z_AT_FolderLocation + "\functions\z_at_toBuyingList.sqf");

	Z_calcBuyableList = 						compile preprocessFileLineNumbers (Z_AT_FolderLocation + "\functions\z_at_calcBuyableList.sqf");

	Z_fillBuyableList = 						compile preprocessFileLineNumbers (Z_AT_FolderLocation + "\functions\z_at_fillBuyableList.sqf");

	Z_fillBuyingList = 							compile preprocessFileLineNumbers (Z_AT_FolderLocation + "\functions\z_at_fillBuyingList.sqf");

	Z_calculateFreeSpace = 						compile preprocessFileLineNumbers (Z_AT_FolderLocation + "\functions\z_at_calculateFreeSpace.sqf");
	
	Z_checkCloseVehicle =  						compile preprocessFileLineNumbers (Z_AT_FolderLocation + "\functions\z_at_checkCloseVehicle.sqf");
	
	Z_allowBuying =  							compile preprocessFileLineNumbers (Z_AT_FolderLocation + "\functions\z_at_allowBuying.sqf");

	Z_AdvancedTradingInit = true;

};

createDialog "AdvancedTrading";

(findDisplay Z_AT_DIALOGWINDOW displayCtrl Z_AT_REMOVESELLITEMBUTTON) ctrlSetText " < "; 
(findDisplay Z_AT_DIALOGWINDOW displayCtrl Z_AT_REMOVEALLSELLITEMBUTTON) ctrlSetText " << ";
(findDisplay Z_AT_DIALOGWINDOW displayCtrl Z_AT_REMOVEBUYITEMBUTTON) ctrlSetText " < ";
(findDisplay Z_AT_DIALOGWINDOW displayCtrl Z_AT_REMOVEALLBUYITEMBUTTON) ctrlSetText " << ";
{ctrlShow [_x,false];} forEach [Z_AT_BUYINGAMOUNT,Z_AT_BUYBUTTON,Z_AT_SLOTSDISPLAY,Z_AT_BUYINGLIST,Z_AT_BUYABLELIST,Z_AT_BUYBUTTON,Z_AT_ADDBUYITEMBUTTON,Z_AT_REMOVEBUYITEMBUTTON,Z_AT_REMOVEALLBUYITEMBUTTON,Z_AT_SLOTSDISPLAY]; // hide	- double hide ( first one didn't work it seems.
call Z_getGearItems; 
