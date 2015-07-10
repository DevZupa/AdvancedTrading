_magazinesToBuy = 0;
_weaponsToBuy = 0;
_backpacksToBuy = 0;
_toolsToBuy = 0;
_sidearmToBuy = 0;
_primaryToBuy = 0;

_priceToBuy = 0;

{
	if( _x select 1 == "trade_weapons")then{
		_parentClasses =  [(configFile >> "CfgWeapons" >> (_x select 0)),true] call BIS_fnc_returnParents;
		if( 'ItemCore' in _parentClasses || 'Binocular' in _parentClasses) then {
			_toolsToBuy = _toolsToBuy + (_x select 9);
		} else {
			_weaponsToBuy = _weaponsToBuy + (_x select 9);
			if('PistolCore' in _parentClasses)then {
				_sidearmToBuy = _sidearmToBuy + (_x select 9);
			} else {
				_primaryToBuy = _primaryToBuy + (_x select 9);
			};
		};
		_priceToBuy	= _priceToBuy + ((_x select 9)*(_x select 2));	
	};
	if( _x select 1 == "trade_items")then{
		_magazinesToBuy = _magazinesToBuy + (_x select 9) ;
		_priceToBuy	= _priceToBuy + ((_x select 9)*(_x select 2));
	};
	if( _x select 1 == "trade_backpacks")then{
		_backpacksToBuy = _backpacksToBuy + (_x select 9) ;
		_priceToBuy	= _priceToBuy + ((_x select 9)*(_x select 2));
	};	
} count Z_BuyingArray;

_canBuy = [_weaponsToBuy,_magazinesToBuy,_backpacksToBuy,_toolsToBuy, _sidearmToBuy, _primaryToBuy] call Z_allowBuying;

_myMoney = player getVariable[Z_MoneyVariable,0];

if(_myMoney >= _priceToBuy) then {
    
	if(_canBuy) then {	
	systemChat format["Start Buying for %1 %2",_priceToBuy,CurrencyName];
	
	closeDialog 2;
	
		if(Z_SellingFrom == 0) then {//backpack
		systemChat format["Adding %1 Items in backpack",count (Z_BuyingArray)];
			{
				if( _x select 1 == "trade_weapons")then{
					(unitBackpack player) addWeaponCargoGlobal [_x select 0, _x select 9];
					diag_log format ["%1 x %2 added", _x select 0, _x select 9];							
				};
				if( _x select 1 == "trade_items")then{
					(unitBackpack player) addMagazineCargoGlobal  [_x select 0, _x select 9];	
					diag_log format ["%1 x %2 added", _x select 0, _x select 9];	
				};					
			} count Z_BuyingArray;			
		};
		
		if(Z_SellingFrom == 1)then{//vehicle
			{
				systemChat format["Adding %1 Items in %2",count (Z_BuyingArray), typeOf Z_vehicle];
				if( _x select 1 == "trade_weapons")then{
					Z_vehicle addWeaponCargoGlobal [_x select 0, _x select 9];	
					diag_log format ["%1 x %2 added", _x select 0, _x select 9];								
				};
				if( _x select 1 == "trade_items")then{
					Z_vehicle addMagazineCargoGlobal [_x select 0, _x select 9];
					diag_log format ["%1 x %2 added", _x select 0, _x select 9];			
				};	
				if( _x select 1 == "trade_backpacks")then{
					Z_vehicle addBackpackCargoGlobal [_x select 0, _x select 9];	
					diag_log format ["%1 x %2 added", _x select 0, _x select 9];	
				};	
			} count Z_BuyingArray;	
		};
		
		if(Z_SellingFrom == 2)then{//gear	
			systemChat format["Adding %1 Items in gear",count (Z_BuyingArray)];
			{
				if( _x select 1 == "trade_weapons")then{
					_count = 0;
					while(_count < _x select 9)do{
						player addWeapon (_x select 0);	
						diag_log format ["%1 added", _x select 0];	
						_count = _count + 1;
					};							 
				};
				if( _x select 1 == "trade_items")then{
					_count = 0;						
					 while{_count < _x select 9}do{
						player addMagazine (_x select 0);	
						diag_log format ["%1 added", _x select 0];	
						_count = _count + 1;
					};	
				};					
			} count Z_BuyingArray;										
		};	
		systemChat format["removing %1 coins ",_priceToBuy];
		[player,_priceToBuy] call SC_fnc_removeCoins;	
		systemChat format["removed %1 coins ",_priceToBuy];				
	};				
}else{
	systemChat format["You need %1 %2 to buy all these items.",_priceToBuy,CurrencyName];
};