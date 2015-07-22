/**
*	call Z_calcPrice
*
*	Calculate the total price for single currency.
**/

#include "defines.sqf";

_sellPrice = 0;

_ctrltext = "";

if(Z_Selling)then{
	{
		if(Z_SingleCurrency)then{
			_sellPrice = _sellPrice +  (_x select 2);
		} else {
			_sellPrice = _sellPrice +  ((_x select 2) * (_x select 11));
		};
	}count Z_SellArray;

	if(Z_SingleCurrency)then {
		_ctrltext = format["%1 %2", _sellPrice , CurrencyName];
	} else {
		_ctrltext = _sellPrice call Z_calcDefaultCurrency;
	};
} else{
	{
		if(Z_SingleCurrency)then{
			_sellPrice = _sellPrice +  ((_x select 2) * (_x select 9));
		} else {
			_sellPrice = _sellPrice +  ((_x select 2) * (_x select 11) * (_x select 9));
		};
	}count Z_BuyingArray;

	if(Z_SingleCurrency)then {
		_ctrltext = format["%1 %2", _sellPrice , CurrencyName];
	} else {
		_ctrltext = _sellPrice call Z_calcDefaultCurrency;
	};
};

ctrlSetText [Z_AT_PRICEDISPLAY, _ctrltext];
