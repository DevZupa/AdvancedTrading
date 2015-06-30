#Advanced Trading

Alternative selling/buying system. ( you can run default and this next to eachtoher without any problem. Which is recommended anyways).

##Alpha Version 1.0 Realeased.
 
First version will support only the following:

* Config traders
* Single Currency ( ZSC 3.0, Souls Hive 2.0, For 999 change the variable name in the sets at the top.).
* Selling/Buying From Gear/Vehicle/Backpack
* Extra features will be added later on.
 
#### The following is currently NOT supported.
 
* No buying of anything to backpack currently.
* No buying of Backs/weapons into your gear.
* No bying of any vehicles
* All the rest is ready.
 
##Description

Sell directly from backpack, gear or the vehicle ( close) where you were driver from. Decide which items you sell. Traders will only make it possible to trade the items they accept ( goes fully automatic, so only items they accept will be listed on the left).
 
You push items to the right to sell, only the items on the right will get sold.
 
##Safety meassurements
 
Double checks what was deleted from backpacks/vehicles so that people can not cheat.
Can only sell from your backpack and the vehicle were u was the last driver from ( in 30m radius)

##Install Instructions
 
1. In your fn_selfactions.sqf

Place:
```sqf
_buyV = player addAction ["<t color='#0059FF'>Advanced Trading</t>", "zupa\advancedTrading\init.sqf",(_traderMenu select 0), 999, true, false, "",""];
s_player_parts set [count s_player_parts,_buyV];
```

above

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

Screenshots:

![alt text](http://i.imgur.com/7xKeniR.jpg "Screenshot 1")

![alt text](http://i.imgur.com/PUoRqYz.jpg "Screenshot 2")
 
 
 
 
 