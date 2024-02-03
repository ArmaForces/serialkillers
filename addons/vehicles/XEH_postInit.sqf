#include "script_component.hpp"

if (isServer) then {
    [QEGVAR(police,policeStationInitialized), {
        params ["_policeStation"];
        // Register as blacklisted area for civilian vehicle spawn
        GVAR(vehicleBlacklistedAreas) pushBackUnique _policeStation;
    }] call CBA_fnc_addEventHandler;

    [FUNC(initVehicles)] call CBA_fnc_execNextFrame;
};

if (hasInterface) then {
    [QGVAR(carAlarm), FUNC(carAlarm)] call CBA_fnc_addEventHandler;

    [QGVAR(alarmOff), {
        params ["_vehicle"];

        [QEGVAR(common,showSideChatMsg), [WEST, [_vehicle] call FUNC(vehicleStolenMsg)]] call CBA_fnc_localEvent;
        [_vehicle, true, 120] call FUNC(carAlarmLoop);
    }] call CBA_fnc_addEventHandler;
};
