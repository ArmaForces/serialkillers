#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.hpp"

#include "initSettings.inc.sqf"

// Killswitch
if (!EGVAR(common,enabled)) exitWith {};

GVAR(killersRespawnMarker) = "";
GVAR(stashes) = [];

call FUNC(initConfig);

ADDON = true;
