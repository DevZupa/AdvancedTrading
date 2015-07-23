# Advanced Trading

Alternative selling/buying system. (You can run the default and this next to each other without any problem. Which is recommended for vehicle buying & selling).

## Alpha version 2.0.

#### Supported:

* Config traders
* Single Currency & Default Currency
* Selling/Buying everything from and to Gear/Vehicle/Backpack

#### Not supported

* No database traders (database traders make your server slow)
* No ability to buy or sell vehicles.

#### What was added to 2.0

* Default Currency Supported
* Item Filter
* Info display of selected Item
* Buying to gear and backpack

## Description

Sell and buy directly from and to backpack, gear or the your current vehicle in the vicinity where you were driver from. Decide which items you sell. Traders will only make it possible to trade the items they accept ( goes fully automatic, so only items they accept will be listed on the left).

You push items to the right to sell or buy.

## Safety measurements

Double checks what was deleted from backpacks/vehicles so that people can not cheat.
Can only sell from your vehicle were u was the last driver from (in x meter radius)

## Update 1.0 - 2.0 instructions

1. Delete your old folder
2. Paste the new folder
3. Edit the config.sqf to match your server
4. Done

## Install instructions

1. In your fn_selfactions.sqf

Place:

```sqf
_buyV = player addAction ["<t color='#0059FF'>Advanced Trading</t>", "zupa\advancedTrading\init.sqf",(_traderMenu select 0), 999, true, false, "",""];
s_player_parts set [count s_player_parts,_buyV];
```

above (look at the comment)

```sqf
// Database menu
_buy = player addAction [localize "STR_EPOCH_PLAYER_289", "\z\addons\dayz_code\actions\show_dialog.sqf",(_traderMenu select 0), 999, true, false, "",""];
s_player_parts set [count s_player_parts,_buy];
```

2. in description.ext, add the following on the bottom

```C++
#include "zupa\advancedTrading\ZSCdefines.hpp" // if u don't have it from ZSC
#include "zupa\advancedTrading\advancedTrading.hpp"
```

Add the following exceptions to your antihack if needed

```
AdvancedTrading
711197
```

3. Edit the config.sqf to reflect your server.

##Images

![alt text](http://i.imgur.com/dH1V6hH.jpg "Screenshot 1")

![alt text](http://i.imgur.com/5xa90aA.jpg "Screenshot 2")
