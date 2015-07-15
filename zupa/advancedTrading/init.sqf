disableSerialization;

Z_traderData = (_this select 3); // gets the trader data ( e.g menu_Functionary1 )

if( isNil "Z_traderData" || count (Z_traderData) == 0)exitWith{
	cutText [format["There went something wrong selecting the trader."], "PLAIN DOWN"];
};

if(isNil "Z_AdvancedTradingInit")then{

	#include "config.sqf";
	#include "functions\defines.sqf";

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

	/* end script config */

	KK_fnc_inString =							compile preprocessFileLineNumbers (Z_AT_FolderLocation + "\functions\KK_fnc_inString.sqf");
	ZUPA_fnc_removeWeaponsAndMagazinesCargo = 	compile preprocessFileLineNumbers (Z_AT_FolderLocation + "\functions\zupa_fnc_removeWeaponsAndMagazinesCargo.sqf");

	Z_filleTradeTitle = 						compile preprocessFileLineNumbers (Z_AT_FolderLocation + "\functions\z_at_filleTradeTitle.sqf");
	Z_clearLists =								compile preprocessFileLineNumbers (Z_AT_FolderLocation + "\functions\z_at_clearLists.sqf");
	Z_clearSellableList =						compile preprocessFileLineNumbers (Z_AT_FolderLocation + "\functions\z_at_clearSellableList.sqf");
	Z_clearBuyList = 							compile preprocessFileLineNumbers (Z_AT_FolderLocation + "\functions\z_at_clearBuyList.sqf");
	Z_clearBuyingList = 						compile preprocessFileLineNumbers (Z_AT_FolderLocation + "\functions\z_at_clearBuyingList.sqf");
	Z_getItemInfo =								compile preprocessFileLineNumbers (Z_AT_FolderLocation + "\functions\z_at_getItemInfo.sqf");
	Z_getItemConfig =							compile preprocessFileLineNumbers (Z_AT_FolderLocation + "\functions\z_at_getItemConfig.sqf");
	Z_displayItemInfo = 						compile preprocessFileLineNumbers (Z_AT_FolderLocation + "\functions\z_at_displayItemInfo.sqf");
	Z_displayWeaponInfo = 						compile preprocessFileLineNumbers (Z_AT_FolderLocation + "\functions\z_at_displayWeaponInfo.sqf");
	Z_displayBackpackInfo = 					compile preprocessFileLineNumbers (Z_AT_FolderLocation + "\functions\z_at_displayBackpackInfo.sqf");
	Z_displayVehicleInfo = 						compile preprocessFileLineNumbers (Z_AT_FolderLocation + "\functions\z_at_displayVehicleInfo.sqf");
	Z_getContainer = 							compile preprocessFileLineNumbers (Z_AT_FolderLocation + "\functions\z_at_getContainer.sqf");
	Z_getBackpackItems = 						compile preprocessFileLineNumbers (Z_AT_FolderLocation + "\functions\z_at_getBackpackItems.sqf");
	Z_getVehicleItems = 						compile preprocessFileLineNumbers (Z_AT_FolderLocation + "\functions\z_at_getVehicleItems.sqf");
	Z_getGearItems = 							compile preprocessFileLineNumbers (Z_AT_FolderLocation + "\functions\z_at_getGearItems.sqf");
	Z_filterList =								compile preprocessFileLineNumbers (Z_AT_FolderLocation + "\functions\z_at_filterList.sqf");
	Z_checkArrayInConfig = 						compile preprocessFileLineNumbers (Z_AT_FolderLocation + "\functions\z_at_checkArrayInConfig.sqf");
	Z_calcPrice = 								compile preprocessFileLineNumbers (Z_AT_FolderLocation + "\functions\z_at_calcPrice.sqf");
	Z_fillSellList = 							compile preprocessFileLineNumbers (Z_AT_FolderLocation + "\functions\z_at_fillSellList.sqf");
	Z_fillSellingList = 						compile preprocessFileLineNumbers (Z_AT_FolderLocation + "\functions\z_at_fillSellingList.sqf");
	Z_pushItemToList = 							compile preprocessFileLineNumbers (Z_AT_FolderLocation + "\functions\z_at_pushItemToList.sqf");
	Z_removeItemFromList = 						compile preprocessFileLineNumbers (Z_AT_FolderLocation + "\functions\z_at_removeItemFromList.sqf");
	Z_pushAllToList = 							compile preprocessFileLineNumbers (Z_AT_FolderLocation + "\functions\z_at_pushAllToList.sqf");
	Z_removeAllToList = 						compile preprocessFileLineNumbers (Z_AT_FolderLocation + "\functions\z_at_removeAllToList.sqf");
	Z_SellItems = 								compile preprocessFileLineNumbers (Z_AT_FolderLocation + "\functions\z_at_sellItems.sqf");
	Z_BuyItems = 								compile preprocessFileLineNumbers (Z_AT_FolderLocation + "\functions\z_at_buyItems.sqf");
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
	Z_canAfford =  							compile preprocessFileLineNumbers (Z_AT_FolderLocation + "\functions\z_at_canAfford.sqf");
	Z_returnChange =  							compile preprocessFileLineNumbers (Z_AT_FolderLocation + "\functions\z_at_returnChange.sqf");
	Z_payDefault =  							compile preprocessFileLineNumbers (Z_AT_FolderLocation + "\functions\z_at_payDefault.sqf");
	Z_toggleCurrency = 					compile preprocessFileLineNumbers (Z_AT_FolderLocation + "\functions\z_at_toggleCurrency.sqf");

	Z_AdvancedTradingInit = true;
};

createDialog "AdvancedTrading";

if (Z_SingleCurrency) then {
	(findDisplay Z_AT_DIALOGWINDOW displayCtrl Z_AT_TOGGLECURRENCYLABEL) ctrlSetText "Single Currency";
} else {
	(findDisplay Z_AT_DIALOGWINDOW displayCtrl Z_AT_TOGGLECURRENCYLABEL) ctrlSetText "Default Currency";
};

(findDisplay Z_AT_DIALOGWINDOW displayCtrl Z_AT_REMOVESELLITEMBUTTON) ctrlSetText " < ";
(findDisplay Z_AT_DIALOGWINDOW displayCtrl Z_AT_REMOVEALLSELLITEMBUTTON) ctrlSetText " << ";
(findDisplay Z_AT_DIALOGWINDOW displayCtrl Z_AT_REMOVEBUYITEMBUTTON) ctrlSetText " < ";
(findDisplay Z_AT_DIALOGWINDOW displayCtrl Z_AT_REMOVEALLBUYITEMBUTTON) ctrlSetText " << ";
{ctrlShow [_x,false];} forEach [Z_AT_BUYINGAMOUNT,Z_AT_BUYBUTTON,Z_AT_SLOTSDISPLAY,Z_AT_BUYINGLIST,Z_AT_BUYABLELIST,Z_AT_BUYBUTTON,Z_AT_ADDBUYITEMBUTTON,Z_AT_REMOVEBUYITEMBUTTON,Z_AT_REMOVEALLBUYITEMBUTTON,Z_AT_SLOTSDISPLAY]; // hide	- double hide ( first one didn't work it seems.
call Z_getGearItems;
