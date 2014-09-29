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
		
		class RscShortcutButton_AT3: RscShortcutButton
		{
			idc = -1;
			text = "Backpack";
			x = 0.31 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.08 * safezoneW;
			onButtonClick = "call Z_getBackpackItems;";
		};
		
		class RscShortcutButton_AT4: RscShortcutButton
		{
			idc = -1;
			text = "Vehicle";
			x = 0.41 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.08 * safezoneW;
			onButtonClick = "call Z_getVehicleItems;";
		};
		
		class RscShortcutButton_AT5: RscShortcutButton
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
		class RscShortcutButton_AT12: RscShortcutButton
		{
			idc = -1;
			text = "Add";
			x = 0.33 * safezoneW + safezoneX;
			y = 0.70 * safezoneH + safezoneY;
			w = 0.08 * safezoneW;
			onButtonClick = "[(lbCurSel 7401)] call Z_pushItemToList;";
		};
		class RscShortcutButton_AT13: RscShortcutButton
		{
			idc = -1;
			text = "Remove";
			x = 0.47 * safezoneW + safezoneX;
			y = 0.70 * safezoneH + safezoneY;
			w = 0.08 * safezoneW;
			onButtonClick = "[(lbCurSel 7402)] call Z_removeItemFromList;";
		};	
		
		class RscShortcutButton_AT14: RscShortcutButton
		{
			idc = 7004;
			text = "Add All";
			x = 0.33 * safezoneW + safezoneX;
			y = 0.75 * safezoneH + safezoneY;
			w = 0.11 * safezoneW;
			onButtonClick = "call Z_pushAllToList;";
		};
		class RscShortcutButton_AT15: RscShortcutButton
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
			class RscShortcutButton_AT16: RscShortcutButton
		{
			idc = -1;
			text = "Sell";
			x = 0.47 * safezoneW + safezoneX;
			y = 0.81 * safezoneH + safezoneY;
			w = 0.08 * safezoneW;

			onButtonClick = "call Z_SellItems;";
		};		
		class RscShortcutButton_AT17: RscShortcutButton
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
