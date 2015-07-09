
_selection = Z_SellingFrom;
_return = false;
_toBuyWeaps = _this select 0;
_toBuyMags = _this select 1;
_toBuyBags = _this select 2;
_toolsToBuy = _this select 3;
_sidearmToBuy = _this select 4;
_primaryToBuy = _this select 5;

if(_selection == 2) then{ //gear
	_allowedMags = 20 - count(magazines player);
	_allowedPrimary = 1;
	_allowedSidearm = 1;
	_allowedBackpacks = 1;	

	_parentClasses =  [(configFile >> "CfgWeapons" >> (_x select 0)),true] call BIS_fnc_returnParents;
	
	_check1 = false;
	_check2 = false;
	_check3 = false;

	if( _allowedWeapons >= _toBuyWeaps)then{
		_check1 = true;
	}else{
		systemChat format["You can only buy %1 weapons in your gear.",_allowedWeapons];
	};
	if( _allowedMags >= _toBuyMags)then{
		_check2 = true;
	}else{
		systemChat format["You can only buy %1 magazines  in your gear.",_allowedMags];
	};		
	if( _allowedBackpacks >= _toBuyBags)then{
		_check3 = true;
	}else{
		systemChat format["You can only buy %1 backpacks  in your gear.",_allowedBackpacks];
	};
	
	if(_check1 && _check2 && _check3)then{
		_return = true;
	};
	
};		
if(_selection == 1) then{ //vehicle
	_allowedMags = 0;
	_allowedWeapons = 0;
	_allowedBackpacks = 0;
	if ( !isNull Z_vehicle) then {   
	
		_mags = getMagazineCargo Z_vehicle;
		_weaps = getWeaponCargo Z_vehicle;
		_bags = getBackpackCargo Z_vehicle;
		
		_normalMags = [];
		_normalWeaps = [];
		_normalBags = [];
		
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
		
		_kinds3 = _bags select 0;
		_ammmounts3 = _bags select 1;
		{
			_counter = 0 ;
			while{	_counter < ( 	_ammmounts3 select _forEachIndex)}do{
				_normalBags set [count(_normalBags),_x];
				_counter = _counter + 1;
			};
		}forEach _kinds3;
	
				
		_allowedWeapons = getNumber (configFile >> 'CfgVehicles' >> (typeOf Z_vehicle) >> 'transportMaxWeapons') - count(_normalWeaps);
		_allowedMags = getNumber (configFile >> 'CfgVehicles' >> (typeOf Z_vehicle) >> 'transportMaxMagazines') - count(_normalMags);
		_allowedBackpacks = getNumber (configFile >> 'CfgVehicles' >> (typeOf Z_vehicle) >> 'transportmaxbackpacks ') - count(_normalBags);
	}else{
		systemChat format["%1", typeName "Z_vehicle"];
	};	
	
	_check1 = false;
	_check2 = false;
	_check3 = false;

	if( _allowedWeapons >= (_toBuyWeaps + _toolsToBuy)then{
		_check1 = true;
	}else{
		systemChat format["You can only buy %1 weapons in your vehicle.",_allowedWeapons];
	};
	if( _allowedMags >= _toBuyMags)then{
		_check2 = true;
	}else{
		systemChat format["You can only buy %1 magazines in your vehicle.",_allowedMags];
	};			
	if( _allowedBackpacks >= _toBuyBags)then{
		_check3 = true;
	}else{
		systemChat format["You can only buy %1 backpacks in your vehicle.",_allowedBackpacks];
	};
	
	if(_check1 && _check2 && _check3)then{
		_return = true;
	};					
};		
if(_selection == 0) then{ //backpack
	_allowedWeapons = 0;
	_allowedMags = 0;
	_allowedBackpacks = 0;
	_backpack = unitBackpack player;
	if (!isNil "_backpack") then {   
		_allowedWeapons = getNumber (configFile >> 'CfgVehicles' >> (typeOf _backpack) >> 'transportMaxWeapons');
		_allowedMags = getNumber (configFile >> 'CfgVehicles' >> (typeOf _backpack) >> 'transportMaxMagazines');
		_allowedBackpacks = 0;
	};		
	
	_check1 = false;
	_check2 = false;
	_check3 = false;
	_check4 = false;

	if( _allowedWeapons >= _toBuyWeaps)then{
		_check1 = true;
	};
	if( _allowedMags >= _toBuyMags)then{
		_check2 = true;
	};			
	if( _allowedBackpacks >= _toBuyBags)then{
		_check3 = true;
	};									
	if(_check1 && _check2 && _check3 && _check4)then{
		_return = true;			
	};	
	
	systemChat format["Buying to backpack is currently disabled for security reasons"];
};

_return