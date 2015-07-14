_player = _this select 0;
_toPay = _this select 1;
_moneyInfo = _this select 2;
_totalWorth = _moneyInfo select 4;
_moneyInGear = _moneyInfo select 1;
_moneyInBackpack = _moneyInfo select 2;
_moneyInVehicle = _moneyInfo select 3;

{
  //delete all money
}count _moneyInGear;

{
  //delete all money
}count _moneyInBackpack;

{
  //delete all money
}count _moneyInVehicle;

[_toPay, _totalWorth] call Z_returnChange;
