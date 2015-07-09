/**
*	call Z_calcPrice
*
*	Calculate the total price for single currency.
**/

#include "defines.sqf";

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