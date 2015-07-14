_player = _this select 0;
_toPay = _this select 1;
_moneyInfo = _this select 2;
_totalWorth = _moneyInfo select 4;
_moneyInGear = _moneyInfo select 1;
_moneyInBackpack = _moneyInfo select 2;
_moneyInVehicle = _moneyInfo select 3;

{
  [_player, _x ,1] call BIS_fnc_invRemove;
}count _moneyInGear;

if ( count _moneyInBackpack > 0 ) then {
  [unitBackpack _player, _moneyInGear, []] call ZUPA_fnc_removeWeaponsAndMagazinesCargo;
};
if ( !isNull 'Z_vehicle' && count _moneyInVehicle > 0 ) then {
  [Z_vehicle, _moneyInVehicle, []] call ZUPA_fnc_removeWeaponsAndMagazinesCargo;
};

[_toPay, _totalWorth] call Z_returnChange;
