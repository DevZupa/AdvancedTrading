

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
			w = 0.4125 * safezoneW;
			h = 0.70 * safezoneH;
			colorBackground[] = {0,0,0,0.8};
		};	
		
	class RscText_AT2: RscTextT
		{
			idc = -1;
			text = "Advanced Trading";
			x = 0.30 * safezoneW + safezoneX;
			y = 0.15 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.05 * safezoneH;		
			colorBackground[] = {0,0,0,0.8};	
			colorText[] = {1,1,1,1};			
		};
		
		class Zupa_Container_Combo: RscCombo
		{
			idc = 7404;
			text = "Gear"; 
			x = 0.31;
			y = 0.15;
			onLBSelChanged = "call Z_getContainer;";	
		};
		
		class Zupa_Method_Combo: RscCombo
		{
			idc = 7405;
			text = "Selling"; 
			x = 0.51;
			y = 0.15;
			onLBSelChanged = "";	
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
			idc = -1;
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
		class Zupa_RscButtonMenu_AT12: Zupa_RscButtonMenu
		{
			idc = -1;
			text =  " > ";
			x = 0.46 * safezoneW + safezoneX;
			y = 0.41 * safezoneH + safezoneY;
			w = 0.08 * safezoneW;
			onButtonClick = "[(lbCurSel 7401)] call Z_pushItemToList;";
		};
		
		class Zupa_RscButtonMenu_AT14: Zupa_RscButtonMenu
		{
			idc = -1;
			text = " >> ";
			x = 0.46 * safezoneW + safezoneX;
			y = 0.49 * safezoneH + safezoneY;
			w = 0.08 * safezoneW;
			onButtonClick = "call Z_pushAllToList;";
		};
		
		class Zupa_RscButtonMenu_AT13: Zupa_RscButtonMenu
		{
			idc = 7414;
			text = " < ";
			x = 0.46 * safezoneW + safezoneX;
			y = 0.57 * safezoneH + safezoneY;
			w = 0.08 * safezoneW;
			onButtonClick = "[(lbCurSel 7402)] call Z_removeItemFromList;";
		};	
		

		class Zupa_RscButtonMenu_AT15: Zupa_RscButtonMenu
		{
			idc = 7415;
			text = " << ";
			x = 0.46 * safezoneW + safezoneX;
			y = 0.65 * safezoneH + safezoneY;
			w = 0.08 * safezoneW;
			onButtonClick = "call Z_removeAllToList;";
		};	
		class RscText_AT18: RscTextT
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
			idc = -1;
			text = "Sell";
			x = 0.55 * safezoneW + safezoneX;
			y = 0.77 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;

			onButtonClick = "call Z_SellItems;";
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