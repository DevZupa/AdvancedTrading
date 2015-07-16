private ["_item","_picture","_class","_display","_buyPrice","_sellPrice","_magazines","_magText","_formattedText"];
#include "defines.sqf";

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

if (Z_SingleCurrency) then {
 	_sellCurrency = CurrencyName;
	_buyCurrency = CurrencyName;
};

_formattedText = format [
	"<img image='%1' size='3'  align='center' /><br />" +
	"<t color='#33BFFF'>Name: </t><t color='#ffffff'>%2</t><br />" +
	"<t color='#33BFFF'>Class: </t><t color='#ffffff'>%3</t><br />" +
	"<t color='#33BFFF'>Sell: </t><t color='#ffffff'>%5 %7</t><br />" +
	"<t color='#33BFFF'>Buy: </t><t color='#ffffff'>%6 %8</t><br />" +
	"<t color='#33BFFF'>Mags: </t><br /><t color='#ffffff' size='0.5'>%4</t>"
	, _picture, _display, _class, _magText, _sellPrice, _buyPrice, _sellCurrency, _buyCurrency
];

(findDisplay Z_AT_DIALOGWINDOW displayCtrl Z_AT_ITEMINFO) ctrlSetStructuredText parseText _formattedText;
