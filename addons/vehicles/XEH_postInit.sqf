#include "script_component.hpp"

if (isServer) then {

    [QGVAR(carAlarm), FUNC(carAlarm)] call CBA_fnc_addEventHandler;
    [QGVAR(disableCarAlarm), FUNC(disableCarAlarm)] call CBA_fnc_addEventHandler;
};

if (hasInterface) then {
    [QGVAR(carAlarm), FUNC(carAlarm)] call CBA_fnc_addEventHandler;

    [QGVAR(alarmOff), {
        params ["_vehicle"];

        [_vehicle, true, GVAR(alarmDuration)] call FUNC(carAlarmLoop);

        // Delay notification
        [{
            _this call FUNC(carAlarmNotification);
        }, [_vehicle], GVAR(alarmCopsNotificationDelay)] call CBA_fnc_waitAndExecute;
    }] call CBA_fnc_addEventHandler;
};
