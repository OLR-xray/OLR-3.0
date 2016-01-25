#ifndef __ACTOR_ANIMATION_H
#define __ACTOR_ANIMATION_H
#pragma once

// animation state constants
//-------------------------------------------------------------------------------
const int _Fwd = mcFwd;
const int _Back = mcBack;
const int _LStr = mcLStrafe;
const int _RStr = mcRStrafe;
const int _FwdLStr = mcFwd|mcLStrafe;
const int _FwdRStr = mcFwd|mcRStrafe;
const int _BackLStr = mcBack|mcLStrafe;
const int _BackRStr = mcBack|mcRStrafe;
	
const int _AFwd = mcAccel|mcFwd;
const int _ABack = mcAccel|mcBack;
const int _ALStr = mcAccel|mcLStrafe;
const int _ARStr = mcAccel|mcRStrafe;
const int _AFwdLStr = mcAccel|mcFwd|mcLStrafe;
const int _AFwdRStr = mcAccel|mcFwd|mcRStrafe;
const int _ABackLStr = mcAccel|mcBack|mcLStrafe;
const int _ABackRStr = mcAccel|mcBack|mcRStrafe;
// 
const int _Crch = mcCrouch;
const int _ACrch = mcCrouch|mcAccel;
const int _CrchFwd = mcCrouch|mcFwd;
const int _CrchBack = mcCrouch|mcBack;
const int _CrchLStr = mcCrouch|mcLStrafe;
const int _CrchRStr = mcCrouch|mcRStrafe;
const int _CrchFwdLStr = mcCrouch|mcFwd|mcLStrafe;
const int _CrchFwdRStr = mcCrouch|mcFwd|mcRStrafe;
const int _CrchBackLStr = mcCrouch|mcBack|mcLStrafe;
const int _CrchBackRStr = mcCrouch|mcBack|mcRStrafe;
const int _ACrchFwd = mcCrouch|mcAccel|mcFwd;
const int _ACrchBack = mcCrouch|mcAccel|mcBack;
const int _ACrchLStr = mcCrouch|mcAccel|mcLStrafe;
const int _ACrchRStr = mcCrouch|mcAccel|mcRStrafe;
const int _ACrchFwdLStr = mcCrouch|mcAccel|mcFwd|mcLStrafe;
const int _ACrchFwdRStr = mcCrouch|mcAccel|mcFwd|mcRStrafe;
const int _ACrchBackLStr = mcCrouch|mcAccel|mcBack|mcLStrafe;
const int _ACrchBackRStr = mcCrouch|mcAccel|mcBack|mcRStrafe;

const int _Jump = mcJump;
//-------------------------------------------------------------------------------

#endif //__ACTOR_ANIMATION_H

