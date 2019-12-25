#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Function initializes given city with module, civilians and vehicles.
 *
 * Arguments:
 * 0: City to initialize <CONFIG/LOCATION>
 *
 * Return Value:
 * 0: City namespace <CBA_NAMESPACE>
 *
 * Example:
 * [[player] call afsk_common_fnc_nearestLocation] call afsk_common_fnc_initCity
 *
 * Public: No
 */

params ["_cityLocation"];

if (_cityLocation isEqualType configNull) then {
    _cityLocation = [getArray (_cityLocation >> 'position'), 10] call EFUNC(common,nearestLocation);
};


// Create city namespace
private _cityNamespace = true call CBA_fnc_createNamespace;
GVAR(citiesLocations) setVariable [className _cityLocation, _cityNamespace, true];
_cityNamespace setVariable [QGVAR(Location), _cityLocation, true];
_cityNamespace setVariable [QGVAR(Name), [_cityLocation] call FUNC(getCityName), true];
private _cityPosition = (position _cityLocation);
_cityPosition set [2, 0]; // Location position has negative third coordinate
_cityNamespace setVariable [QGVAR(Position), _cityPosition, true];
_cityNamespace setVariable [QGVAR(CiviliansList), []];

private _cityType = [_cityLocation] call EFUNC(common,getLocationType);

// Init civilians
[_cityNamespace, _cityType] call FUNC(initCityCivilians);

// Init vehicles
_cityNamespace