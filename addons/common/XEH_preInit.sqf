#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.hpp"

GVAR(ACE_Loaded) = isClass (configFile >> "CfgPatches" >> "ace_common");
GVAR(CUP_Loaded) = isClass (configFile >> "CfgPatches" >> "cup_common"); // Probably something else, not "cup_common"
GVAR(RHS_Loaded) = isClass (configFile >> "CfgPatches" >> "rhs_common"); // Same here

if (isServer) then {
    GVAR(musicEH) = -1;
    GVAR(musicPlaying) = false;
    GVAR(musicQueue) = [];

    GVAR(cities) = call FUNC(getAllMapCities);
};

ADDON = true;
