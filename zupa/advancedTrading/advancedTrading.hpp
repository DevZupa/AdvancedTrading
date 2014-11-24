

class AdvancedTrading
{
	idd = 711197;
	onLoad = "uiNamespace setVariable ['AdvancedTrading', _this select 0]";
	class Controls {
		class RscText_AT1: RscTextT
		{
			idc = -1;
			x = 0.30 * safezoneW + safezoneX;
			y = 0.15 * safezoneH + safezoneY;
			w = 0.40 * safezoneW;
			h = 0.70 * safezoneH;
			colorBackground[] = {0,0,0,0.8};
		};	
		
	class RscText_AT2: RscTextT
		{
			idc = -1;
			text = "Advanced Trading";
			x = 0.30 * safezoneW + safezoneX;
			y = 0.15 * safezoneH + safezoneY;
			w = 0.40 * safezoneW;
			h = 0.05 * safezoneH;		
			colorBackground[] = {0,0,0,0.8};	
			colorText[] = {1,1,1,1};			
		};
		
		class RscText_Zupa_1: RscTextT
		{
			idc = 7408;
			text = "Selling from gear.";
			x = 0.31 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.38 * safezoneW;
			h = 0.05 * safezoneH;		
			colorText[] = {1,1,1,1};			
		};
		
		class Zupa_RscButtonMenu_Z1: Zupa_RscButtonMenu
		{
			idc = -1;
			text =  "Gear";
			x = 0.31 * safezoneW + safezoneX;
			y = 0.26 * safezoneH + safezoneY;
			w = 0.08 * safezoneW;
			onButtonClick = "[2] call Z_getContainer;";
		};
		
		class Zupa_RscButtonMenu_Z2: Zupa_RscButtonMenu
		{
			idc = -1;
			text =  "Backpack";
			x = 0.41 * safezoneW + safezoneX;
			y = 0.26 * safezoneH + safezoneY;
			w = 0.08 * safezoneW;
			onButtonClick = "[0] call Z_getContainer;";
		};
		
		class Zupa_RscButtonMenu_Z3: Zupa_RscButtonMenu
		{
			idc = -1;
			text =  "Vehicle";
			x = 0.51 * safezoneW + safezoneX;
			y = 0.26 * safezoneH + safezoneY;
			w = 0.08 * safezoneW;
			onButtonClick = "[1] call Z_getContainer;";
		};
		
		class Zupa_RscButtonMenu_Z4: Zupa_RscButtonMenu
		{
			idc = 7416;
			text =  "Buy";
			x = 0.61 * safezoneW + safezoneX;
			y = 0.26 * safezoneH + safezoneY;
			w = 0.08 * safezoneW;
			onButtonClick = "call Z_ChangeBuySell;";
		};
				
		class RscText_AT6: RscTextT
		{
			idc = 7412;
			text = "";
			x = 0.31 * safezoneW + safezoneX;
			y = 0.30 * safezoneH + safezoneY;
			w = 0.30 * safezoneW;
			h = 0.03 * safezoneH;
			colorText[] = {1,1,1,1};
		};
		
		class RscText_AT7: RscTextT
		{
			idc = 7413;
			text = "";
			x = 0.31 * safezoneW + safezoneX;
			y = 0.33 * safezoneH + safezoneY;
			w = 0.30 * safezoneW;
			h = 0.03 * safezoneH;
			colorText[] = {1,1,1,1};
		};
		
		
		class RscText_AT8: RscTextT
		{
			idc = -1;
			text = "Inventory";
			x = 0.31 * safezoneW + safezoneX;
			y = 0.38 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.03 * safezoneH;
			colorText[] = {1,1,1,1};
		};		
		class RscText_AT9: RscTextT
		{
			idc = 7409;
			text = "Selling";
			x = 0.55 * safezoneW + safezoneX;
			y = 0.38 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.03 * safezoneH;
			colorText[] = {1,1,1,1};
		};
		
		
		class RscListbox_AT10: RscListbox
		{
			idc = 7401;
			type = 5;		
			idcLeft = -1; 
            idcRight = -1;
			x = 0.31* safezoneW + safezoneX;
			y = 0.41 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.30 * safezoneH;
			soundSelect[] = {"",0.1,1};
			colorBackground[] = {0.1,0.1,0.1,0.8};
			onLBSelChanged = "[(lbCurSel 7401),true] call  Z_showPrice";
			
		};
		class RscListbox_AT11: RscListbox
		{
			idc = 7402;
			x = 0.55 * safezoneW + safezoneX;
			y = 0.41* safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.30 * safezoneH;
			soundSelect[] = {"",0.1,1};
			colorBackground[] = {0.1,0.1,0.1,0.8};
		};
		
		
		class RscListbox_AT20: RscListbox
		{
			idc = 7421;
			type = 5;		
			idcLeft = -1; 
            idcRight = -1;
			x = 0.31* safezoneW + safezoneX;
			y = 0.41 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.30 * safezoneH;
			soundSelect[] = {"",0.1,1};
			colorBackground[] = {0.1,0.1,0.1,0.8};
			onload = "ctrlShow [_this,false]";
			onLBSelChanged = "[(lbCurSel 7421),false] call  Z_showPrice";
		};
		class RscListbox_AT21: RscListbox
		{
			idc = 7422;
			x = 0.55 * safezoneW + safezoneX;
			y = 0.41* safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.30 * safezoneH;
			soundSelect[] = {"",0.1,1};
			colorBackground[] = {0.1,0.1,0.1,0.8};
			onload = "ctrlShow [_this,false]";
		};
		
		
		
		class Zupa_RscButtonMenu_AT12: Zupa_RscButtonMenu
		{
			idc = 7430;
			text =  " > ";
			x = 0.46 * safezoneW + safezoneX;
			y = 0.41 * safezoneH + safezoneY;
			w = 0.08 * safezoneW;
			onButtonClick = "[(lbCurSel 7401)] call Z_pushItemToList;";
		};
		
		class Zupa_RscButtonMenu_AT14: Zupa_RscButtonMenu
		{
			idc = 7431;
			text = " >> ";
			x = 0.46 * safezoneW + safezoneX;
			y = 0.49 * safezoneH + safezoneY;
			w = 0.08 * safezoneW;
			onButtonClick = "call Z_pushAllToList;";
		};
				
		class Zupa_RscButtonMenu_AT13: Zupa_RscButtonMenu
		{
			idc = 7432;
			text = " < ";
			x = 0.46 * safezoneW + safezoneX;
			y = 0.57 * safezoneH + safezoneY;
			w = 0.08 * safezoneW;
			onButtonClick = "[(lbCurSel 7402)] call Z_removeItemFromList;";
		};	
		

		class Zupa_RscButtonMenu_AT15: Zupa_RscButtonMenu
		{
			idc = 7433;
			text = " << ";
			x = 0.46 * safezoneW + safezoneX;
			y = 0.65 * safezoneH + safezoneY;
			w = 0.08 * safezoneW;
			onButtonClick = "call Z_removeAllToList;";
		};

// buying
		class Zupa_RscButtonMenu_ATT1: Zupa_RscButtonMenu

		{
			idc = 7440;
			text = " > ";
			x = 0.46 * safezoneW + safezoneX;
			y = 0.41 * safezoneH + safezoneY;
			w = 0.08 * safezoneW;
			onButtonClick = "[(lbCurSel 7421),(ctrlText 7441)] call Z_toBuyingList;";
			onload = "ctrlShow [_this,false]";
		};
		
	// textfield 7441
	
		class Zupa_Ammount_Edit : Zupa_RscEdit {	
			idc = 7441;
			colorText[] = {0.8784,0.8471,0.651,1};
			text = "1";
			sizeEx = 0.030;
			x = 0.46 * safezoneW + safezoneX;
			y = 0.49 * safezoneH + safezoneY;
			w = 0.08 * safezoneW;
			h = 0.03;
			onload = "ctrlShow [_this,false]";
		};
		
		class Zupa_RscButtonMenu_ATT3: Zupa_RscButtonMenu
		{
			idc = 7442;
			text = " < ";
			x = 0.46 * safezoneW + safezoneX;
			y = 0.57 * safezoneH + safezoneY;
			w = 0.08 * safezoneW;
			onButtonClick = "[(lbCurSel 7422)] call Z_removeItemFromBuyingList;";
			onload = "ctrlShow [_this,false]";
		};	
		

		class Zupa_RscButtonMenu_ATT4: Zupa_RscButtonMenu
		{
			idc = 7443;
			text = " << ";
			x = 0.46 * safezoneW + safezoneX;
			y = 0.65 * safezoneH + safezoneY;
			w = 0.08 * safezoneW;
			onButtonClick = "call Z_removeAllFromBuyingList;";
			onload = "ctrlShow [_this,false]";
		};
		
			
		class RscText_ATT8: RscTextT
		{
			idc = 7404;
			text = "Available Slots: 0/0";
			x = 0.55 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = 0.03 * safezoneH;
			colorText[] = {1,1,1,1};
			onload = "ctrlShow [_this,false]";
		};	
		
		class RscText_AT18: RscTextT
		{
			idc = 7410;
			text = "Price: 0 Coins";
			x = 0.55 * safezoneW + safezoneX;
			y = 0.72 * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = 0.03 * safezoneH;
			colorText[] = {1,1,1,1};
		};	

		
		class RscText_ATZ18: RscTextT
		{
			idc = 7403;
			text = "0 Coins";
			x = 0.55 * safezoneW + safezoneX;
			y = 0.72 * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = 0.03 * safezoneH;
			colorText[] = {1,1,1,1};
		};		
			class Zupa_RscButtonMenu_AT16: Zupa_RscButtonMenu
		{
			idc = 7435;
			text = "Sell";
			x = 0.55 * safezoneW + safezoneX;
			y = 0.77 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			onButtonClick = "//call Z_SellItems;";
		};	

		class Zupa_RscButtonMenu_AT27: Zupa_RscButtonMenu
		{
			idc = 7436;
			text = "Buy";
			x = 0.55 * safezoneW + safezoneX;
			y = 0.77 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			onload = "ctrlShow [_this,false]";
			onButtonClick = "//call Z_BuyItems;";
		
		};	
		
		class Zupa_RscButtonMenu_AT17: Zupa_RscButtonMenu
		{
			idc = -1;
			text = "Close";
			x = 0.31 * safezoneW + safezoneX;
			y = 0.77 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;		
			onButtonClick = "((ctrlParent (_this select 0)) closeDisplay 9000);";
		};		

	};
};


/*

class AdvancedTrading2
{
	idd = 711187;
	onLoad = "uiNamespace setVariable ['AdvancedTrading2', _this select 0]";
	class Controls {
		class RscText_AT1: RscTextT
		{
			idc = -1;
			x = 0.30 * safezoneW + safezoneX;
			y = 0.15 * safezoneH + safezoneY;
			w = 0.30 * safezoneW;
			h = 0.81 * safezoneH;
			colorBackground[] = {0,0,0,0.8};
		};	
		
	class RscText_AT2: RscTextT
		{
			idc = -1;
			text = "Advanced Trading";
			x = 0.30 * safezoneW + safezoneX;
			y = 0.15 * safezoneH + safezoneY;
			w = 0.30 * safezoneW;
			h = 0.05 * safezoneH;		
			colorBackground[] = {0,0,0,0.8};	
			colorText[] = {1,1,1,1};			
		};
		
		class Zupa_RscButtonMenu_AT3: Zupa_RscButtonMenu
		{
			idc = -1;
			text = "Backpack";
			x = 0.31 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.08 * safezoneW;
			onButtonClick = "call Z_getBackpackItems;";
		};
		
		class Zupa_RscButtonMenu_AT4: Zupa_RscButtonMenu
		{
			idc = -1;
			text = "Vehicle";
			x = 0.41 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.08 * safezoneW;
			onButtonClick = "call Z_getVehicleItems;";
		};
		
		class Zupa_RscButtonMenu_AT5: Zupa_RscButtonMenu
		{
			idc = -1;
			text = "Gear";
			x = 0.51 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.08 * safezoneW;
			onButtonClick = "call Z_getGearItems;";
		};
		class RscText_AT6: RscTextT
		{
			idc = 7412;
			text = "";
			x = 0.31 * safezoneW + safezoneX;
			y = 0.30 * safezoneH + safezoneY;
			w = 0.30 * safezoneW;
			h = 0.03 * safezoneH;
			colorText[] = {1,1,1,1};
		};
		
		class RscText_AT7: RscTextT
		{
			idc = 7413;
			text = "";
			x = 0.31 * safezoneW + safezoneX;
			y = 0.33 * safezoneH + safezoneY;
			w = 0.30 * safezoneW;
			h = 0.03 * safezoneH;
			colorText[] = {1,1,1,1};
		};
		
		
		class RscText_AT8: RscTextT
		{
			idc = -1;
			text = "You";
			x = 0.31 * safezoneW + safezoneX;
			y = 0.38 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.03 * safezoneH;
			colorText[] = {1,1,1,1};
		};		
		class RscText_AT9: RscTextT
		{
			idc = -1;
			text = "Offering";
			x = 0.45 * safezoneW + safezoneX;
			y = 0.38 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.03 * safezoneH;
			colorText[] = {1,1,1,1};
		};
		
		
		class RscListbox_AT10: RscListbox
		{
			idc = 7401;
			type = 5;
		
			idcLeft = -1; 
            idcRight = -1;
			x = 0.31* safezoneW + safezoneX;
			y = 0.41 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.30 * safezoneH;
			soundSelect[] = {"",0.1,1};
			colorBackground[] = {0.1,0.1,0.1,0.8};
		};
		class RscListbox_AT11: RscListbox
		{
			idc = 7402;
			x = 0.45 * safezoneW + safezoneX;
			y = 0.41* safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.30 * safezoneH;
			soundSelect[] = {"",0.1,1};
			colorBackground[] = {0.1,0.1,0.1,0.8};
		};
		class Zupa_RscButtonMenu_AT12: Zupa_RscButtonMenu
		{
			idc = -1;
			text = "Add";
			x = 0.33 * safezoneW + safezoneX;
			y = 0.70 * safezoneH + safezoneY;
			w = 0.08 * safezoneW;
			onButtonClick = "[(lbCurSel 7401)] call Z_pushItemToList;";
		};
		class Zupa_RscButtonMenu_AT13: Zupa_RscButtonMenu
		{
			idc = -1;
			text = "Remove";
			x = 0.47 * safezoneW + safezoneX;
			y = 0.70 * safezoneH + safezoneY;
			w = 0.08 * safezoneW;
			onButtonClick = "[(lbCurSel 7402)] call Z_removeItemFromList;";
		};	
		
		class Zupa_RscButtonMenu_AT14: Zupa_RscButtonMenu
		{
			idc = 7004;
			text = "Add All";
			x = 0.33 * safezoneW + safezoneX;
			y = 0.75 * safezoneH + safezoneY;
			w = 0.11 * safezoneW;
			onButtonClick = "call Z_pushAllToList;";
		};
		class Zupa_RscButtonMenu_AT15: Zupa_RscButtonMenu
		{
			idc = -1;
			text = "Remove All";
			x = 0.47 * safezoneW + safezoneX;
			y = 0.75 * safezoneH + safezoneY;
			w = 0.11* safezoneW;
			onButtonClick = "call Z_removeAllToList;";
		};	
		class RscText_AT18: RscTextT
		{
			idc = 7403;
			text = "0 Coins";
			x = 0.33 * safezoneW + safezoneX;
			y = 0.81 * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = 0.03 * safezoneH;
			colorText[] = {1,1,1,1};
		};		
			class Zupa_RscButtonMenu_AT16: Zupa_RscButtonMenu
		{
			idc = -1;
			text = "Sell";
			x = 0.47 * safezoneW + safezoneX;
			y = 0.81 * safezoneH + safezoneY;
			w = 0.08 * safezoneW;

			onButtonClick = "call Z_SellItems;";
		};		
		class Zupa_RscButtonMenu_AT17: Zupa_RscButtonMenu
		{
			idc = -1;
			text = "Close";
			x = 0.40 * safezoneW + safezoneX;
			y = 0.87 * safezoneH + safezoneY;
			w = 0.11 * safezoneW;

			onButtonClick = "((ctrlParent (_this select 0)) closeDisplay 9000);";
		};		

	};
};
*/