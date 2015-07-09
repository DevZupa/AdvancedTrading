#include "defines.sqf";

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