// initiate the functions and variables for advanced trading -- easier for the people :) otherwise it would be in compiles or different file.
Z_OriginalSellableArray = [];
Z_SellableArray = [];
Z_SellArray = [];

Z_OriginalBuyableArray = [];
Z_BuyableArray = [];
Z_BuyingArray = [];

Z_vehicle = objNull;
Z_VehicleDistance = 30;

Z_NormalCurrency = false; // No effect yet. Not supported yet

// When normal currency is false
Z_MoneyVariable = "cashMoney"; // Change this to whichever currency You are using.
if(isNil 'CurrencyName')then{
	CurrencyName = 'Coins';
};


// displays

