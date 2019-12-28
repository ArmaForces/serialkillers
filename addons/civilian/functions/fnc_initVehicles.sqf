#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function initializes empty civilian vehicles on the map.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * None
 *
 * Public: No
 */

private _i = GVAR(emptyVehiclesLimit);

private _cities = +GVAR(cities);
private _weights = [];

// Create weights array for cities
{
    private _cityType = _x getVariable QGVAR(cityType);
    _cityWeight = switch (_cityType) do {
        case "NameCityCapital": {GVAR(weightCapital)};
        case "NameCity": {GVAR(weightCity)};
        case "NameVillage": {GVAR(weightVillage)};
        default {GVAR(weightRural)};
    };
    _weights pushBack (_cityWeight);
} forEach _cities;

// Add entry for non city area
_cities pushBack "RuralArea";
_weights pushBack GVAR(weightRural);

// Retrieve all civilian car types from config
private _civilianCarTypes = "( (getNumber (_x >> 'scope') >= 2)
                                    && {
                                        getText (_x >> 'vehicleClass') in ['Car']
                                        && {getNumber (_x >> 'side') == 3}
                                    })" configClasses (configFile >> "CfgVehicles");

while {_i > 0} do {
    private _city = _cities selectRandomWeighted _weights;
    private _carType = selectRandom _civilianCarTypes;
    private _pos = if (_city isEqualTo "RuralArea") then {
        [_carType, true] call FUNC(getRandomPos);
    } else {
        private _pos = [_city, _carType, true] call FUNC(getCityRandomPos);
        if (_pos isEqualTo []) then {
            _pos = [_city, _carType] call FUNC(getCityRandomPos);
        };
        _pos
    };
    if (!(_pos isEqualTo [])) then {
        [_carType, _pos] call FUNC(createVehicle);
        _i = _i - 1;
    };
};
