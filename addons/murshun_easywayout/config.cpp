#include "CfgPatches.hpp"

class CfgMovesBasic;
class CfgMovesMaleSdr: CfgMovesBasic
{
	class States
	{
		class AadjPercMstpSrasWpstDDown_AmovPercMstpSrasWpstDnon;
		class murshun_ActsPercMstpSnonWpstDnon_suicide1A: AadjPercMstpSrasWpstDDown_AmovPercMstpSrasWpstDnon
		{
			looped = 0;
			file = "\murshun_easywayout\animations\murshun_ActsPercMstpSnonWpstDnon_sebevrazda1A";
			speed = 1.578947;
			head = "headNo";
		};
		class murshun_ActsPercMstpSnonWpstDnon_suicide2A: AadjPercMstpSrasWpstDDown_AmovPercMstpSrasWpstDnon
		{
			looped = 0;
			file = "\murshun_easywayout\animations\murshun_ActsPercMstpSnonWpstDnon_sebevrazda2A";
			speed = 1.25;
			head = "headNo";
		};
		class murshun_ActsPercMstpSnonWpstDnon_suicide1B: murshun_ActsPercMstpSnonWpstDnon_suicide1A
		{
			looped = 0;
			file = "\murshun_easywayout\animations\murshun_ActsPercMstpSnonWpstDnon_sebevrazda1B";
			speed = 0.143541;
			showHandGun = 1;
			head = "headNo";
		};
		class murshun_ActsPercMstpSnonWpstDnon_suicide2B: murshun_ActsPercMstpSnonWpstDnon_suicide2A
		{
			looped = 0;
			file = "\murshun_easywayout\animations\murshun_ActsPercMstpSnonWpstDnon_sebevrazda2B";
			speed = 0.124481;
			showHandGun = 1;
			head = "headNo";
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
			class init
			{
				postInit = 1;
			};
		};
	};
};
