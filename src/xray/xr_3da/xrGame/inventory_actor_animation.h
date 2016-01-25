#pragma once

#include "..\skeletonanimated.h"
#include "ui\UIInventoryWnd.h"
#include "UIGameSp.h"
#include "HUDManager.h"

static inline IRender_Visual* inv_visual() {
	auto game_sp = smart_cast<CUIGameSP*>(HUD().GetUI()->UIGame());
	return game_sp?(game_sp->InventoryMenu)->OutfitStaticVisual():NULL;
}

template<typename T> inline void inv_play_cycle(T value, BOOL bMixIn=TRUE, PlayCallback Callback=0, LPVOID CallbackParam=0, u8 channel = 0) {
	IRender_Visual* vis = inv_visual();
	if (vis) smart_cast<CKinematicsAnimated*>(vis)->PlayCycle(value, bMixIn, Callback, CallbackParam, channel);
}

