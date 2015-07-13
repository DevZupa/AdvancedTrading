private ['_worth', '_total_currency','_return','_part','_worth','_totalToPay'];

_totalToPay = _this;
_return = false;

_total_currency = 0;

{
  _part =  (configFile >> "CfgMagazines" >> _x);
  _worth =  (_part >> "worth");
  if isNumber (_worth) then {
    _total_currency = _total_currency + getNumber(_worth);
  };
} count (magazines player);

if( Z_AllowTakingMoneyFromBackpack ) then {
  _backpackPlayer = unitBackpack player;

  if (!isNull '_backpackPlayer') then {
    _mags = getMagazineCargo Z_vehicle;

    _kinds = _mags select 0;
    _ammmounts = _mags select 1;
    {
      _part =  (configFile >> "CfgMagazines" >> _x);
      _worth =  (_part >> "worth");

      if isNumber (_worth) then {
        _total_currency = _total_currency + ( getNumber(_worth) * (_ammmounts select _forEachIndex));
      };

    }forEach _kinds;
  };
};

if( Z_AllowTakingMoneyFromVehicle ) then {
    if (!isNull '_backpackPlayer') then {

      _mags = getMagazineCargo Z_vehicle;

      _kinds = _mags select 0;
      _ammmounts = _mags select 1;
      {
        _part =  (configFile >> "CfgMagazines" >> _x);
        _worth =  (_part >> "worth");

        if isNumber (_worth) then {
          _total_currency = _total_currency + ( getNumber(_worth) * (_ammmounts select _forEachIndex));
        };
      }forEach _kinds;
  };
};

if ( _totalToPay <= _total_currency) then {
  _return = true;
};

_return
