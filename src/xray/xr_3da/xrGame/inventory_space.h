#pragma once
#include "../../build_config_defines.h"

//#undef INV_NEW_SLOTS_SYSTEM

const u32 CMD_START = 1 << 0;
const u32 CMD_STOP = 1 << 1;

const u32 NO_ACTIVE_SLOT = 0xffffffff;
const u32 KNIFE_SLOT = 0; //
const u32 PISTOL_SLOT = 1;
const u32 RIFLE_SLOT = 2;
const u32 GRENADE_SLOT = 3;
const u32 APPARATUS_SLOT = 4; //
const u32 BOLT_SLOT = 5;
const u32 OUTFIT_SLOT = 6;
const u32 PDA_SLOT = 7;
const u32 DETECTOR_SLOT = 8;
const u32 TORCH_SLOT = 9; // 
const u32 ARTEFACT_SLOT = 10;

#if defined(INV_NEW_SLOTS_SYSTEM) && !defined(OLR_SLOTS)
const u32 HELMET_SLOT = 11;
const u32 SLOT_QUICK_ACCESS_0 = 12;
const u32 SLOT_QUICK_ACCESS_1 = 13;
const u32 SLOT_QUICK_ACCESS_2 = 14;
const u32 SLOT_QUICK_ACCESS_3 = 15;
const u32 SLOTS_TOTAL = 16;
   // alpet: ограничение по вхождению предмета
const u32 SLOT_QUICK_CELLS_X = 1;
const u32 SLOT_QUICK_CELLS_Y = 1;
#else
const u32 SLOTS_TOTAL = 11;
#endif

const u32 RUCK_HEIGHT = 280;
const u32 RUCK_WIDTH = 7;

class CInventoryItem;
class CInventory;

typedef CInventoryItem*				PIItem;
typedef xr_vector<PIItem>			TIItemContainer;


enum EItemPlace {			
	eItemPlaceUndefined,
	eItemPlaceSlot,
	eItemPlaceBelt,
	eItemPlaceRuck
};

extern u32	INV_STATE_LADDER;
extern u32	INV_STATE_CAR;
extern u32	INV_STATE_BLOCK_ALL;
extern u32	INV_STATE_INV_WND;
extern u32	INV_STATE_BUY_MENU;
