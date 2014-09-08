AdvancedTradeMenu
=================

Add's gear and crew to the list


Install notes:
==============

1) Place the "zupa" folder in your mission pbo. 

2) Change in your compiles.sqf:

a) IF you have Database traders:

```
call compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\player_traderMenuHive.sqf";
```

To

```
call compile preprocessFileLineNumbers "zupa\AdvancedTradeMenu\player_traderMenuHive.sqf";
```

b) IF you have Hive traders:

```
call compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\player_traderMenuConfig.sqf";
```

To

```
call compile preprocessFileLineNumbers "zupa\AdvancedTradeMenu\player_traderMenuConfig.sqf";
```

c) If you use single Currency

```
call compile preprocessFileLineNumbers "gold\player_traderMenu.sqf";
```

To

```
call compile preprocessFileLineNumbers "zupa\AdvancedTradeMenu\player_traderMenuSC.sqf";
```

DONE

Zupa
====