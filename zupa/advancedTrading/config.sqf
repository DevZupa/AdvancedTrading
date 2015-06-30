// initiate the functions and variables for advanced trading -- easier for the people :) otherwise it would be in compiles or different file.
Z_SellableArray = [];
Z_SellArray = [];
Z_BuyArray = [];
Z_BuyingArray = [];
Z_vehicle = objNull;
Z_VehicleDistance = 30;
Z_MoneyVariable = "cashMoney"; // Change this to whichever currency You are using.
Z_NormalCurrency = false; // No effect yet. Not supported yet

if(isNil 'CurrencyName')then{
	CurrencyName = 'Coins';
};