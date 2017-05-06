#include "CfgPatches.hpp"

class CfgMovesBasic;
class CfgMovesMaleSdr: CfgMovesBasic
{
    class States
    {
        class AmovPercMstpSrasWpstDnon;
        class murshun_ActsPercMstpSnonWpstDnon_suicide1B: AmovPercMstpSrasWpstDnon
        {
            looped = 0;
            file = "\murshun_easywayout\animations\murshun_ActsPercMstpSnonWpstDnon_sebevrazda1B";
            speed = 0.143541;
            showHandGun = 1;
            head = "headNo";
            enableOptics = 0;
            forceAim = 1;
            blockMobileSwitching = 1;
            variantsPlayer[] = {};
            variantsAI[] = {};
            canBlendStep = 0;
            minPlayTime = 1;
        };
        class murshun_ActsPercMstpSnonWpstDnon_suicide2B: murshun_ActsPercMstpSnonWpstDnon_suicide1B
        {
            file = "\murshun_easywayout\animations\murshun_ActsPercMstpSnonWpstDnon_sebevrazda2B";
            speed = 0.124481;
        };
    };
};

class CfgFunctions
{
    class murshun_easywayout
    {
        class functions
        {
            file = "murshun_easywayout\functions";
            class preInit {preInit = 1;};
            class postInit {postInit = 1;};
        };
    };
};
