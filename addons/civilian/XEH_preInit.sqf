#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.hpp"

GVAR(cities) = [];
GVAR(civilians) = [];
GVAR(civiliansCount) = 100 + floor (random (101));

{
    GVAR(cities) pushBack ([_x] call FUNC(initCity));
} forEach EGVAR(common, cities);

ADDON = true;
