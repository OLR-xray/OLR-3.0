#pragma once

class CInventory;
#include "UIScriptWnd.h"
#include "UIStatic.h"
#include "UIStatic.h"

#include "UIProgressBar.h"

#include "UIPropertiesBox.h"
#include "UIOutfitSlot.h"

#include "UIOutfitInfo.h"
#include "UIItemInfo.h"
#include "ui3dstatic.h"

//#undef INV_NEW_SLOTS_SYSTEM

#if defined(INV_NEW_SLOTS_SYSTEM)
	#include "UISleepWnd.h"
#endif

#include "../inventory_space.h"


class CArtefact;
class CUI3tButton;
class CUIDragDropListEx;
class CUICellItem;

class CUIInventoryWnd: public CUIDialogWnd
{
private:
	typedef CUIDialogWnd	inherited;
	bool					m_b_need_reinit;
public:
							CUIInventoryWnd				();
	virtual					~CUIInventoryWnd			();

	virtual void			Init						();

	void					InitInventory				();
	void					InitInventory_delayed		();
	virtual bool			StopAnyMove					()					{return false;}

	virtual void			SendMessage					(CUIWindow *pWnd, s16 msg, void *pData);
	virtual bool			OnMouse						(float x, float y, EUIMessages mouse_action);
	virtual bool			OnKeyboard					(int dik, EUIMessages keyboard_action);


	IC CInventory*			GetInventory				()					{return m_pInv;}

	virtual void			Update						();
	virtual void			Draw						();
	
	virtual void			Show						();
	virtual void			Hide						();

	void					AddItemToBag				(PIItem pItem);
	
	IRender_Visual*			OutfitStaticVisual			() {
		return UIOutfitBackground?UIOutfitBackground->Visual():NULL;
	}
	void					OutfitStaticUpdate			();
	void					OutfitStaticDestroy			() {
		if (UIOutfitBackground) UIOutfitBackground->Destroy();
	}

	
protected:
	enum eInventorySndAction{	eInvSndOpen	=0,
								eInvSndClose,
								eInvItemToSlot,
								eInvItemToBelt,
								eInvItemToRuck,
								eInvProperties,
								eInvDropItem,
								eInvAttachAddon,
								eInvDetachAddon,
								eInvItemUse,
								eInvSndMax};

	ref_sound					sounds					[eInvSndMax];
	void						PlaySnd					(eInventorySndAction a);

	CUIStatic					UIBeltSlots;
	CUIStatic					UIBack;
	CUIStatic*					UIRankFrame;
	CUIStatic*					UIRank;

	CUIStatic					UIBagWnd;
	CUIStatic					UIMoneyWnd;
	CUIStatic					UIDescrWnd;

	CUIFrameWindow				UIPersonalWnd;

	CUI3tButton*				UIExitButton;

	CUIStatic					UIStaticBottom;
	CUIStatic					UIStaticTime;
	CUIStatic					UIStaticTimeString;

	CUIStatic					UIStaticPersonal;
		
	CUIDragDropListEx*			m_pUIBagList;
	CUIDragDropListEx*			m_pUIBeltList;
	CUIDragDropListEx*			m_pUIPistolList;
	CUIDragDropListEx*			m_pUIAutomaticList;

#if defined(INV_NEW_SLOTS_SYSTEM)	
	CUISleepWnd					UISleepWnd;
	CUIDragDropListEx*			m_pUIKnifeList;
	CUIDragDropListEx*			m_pUIBinocularList;
	CUIDragDropListEx*			m_pUITorchList;
	
#	if !defined(OLR_SLOTS)
	CUIDragDropListEx*			m_pUIDetectorList;
	CUIDragDropListEx*			m_pUIPDAList;
	CUIDragDropListEx*			m_pUIHelmetList;
	CUIDragDropListEx*			m_pUISlotQuickAccessList_0;
	CUIDragDropListEx*			m_pUISlotQuickAccessList_1;
	CUIDragDropListEx*			m_pUISlotQuickAccessList_2;
	CUIDragDropListEx*			m_pUISlotQuickAccessList_3;
#	endif
	
	CUIProgressBar				UIProgressBarSatiety;
	CUIProgressBar				UIProgressBarPower;
#endif
	CUIDragDropListEx*			m_slots_array [SLOTS_TOTAL];  // alpet: для индексированного доступа

	CUIOutfitDragDropList*		m_pUIOutfitList;
	CUI3dStatic* 				UIOutfitBackground;

	
	void						ClearAllLists				();
	void						BindDragDropListEnents		(CUIDragDropListEx* lst);
	
	EListType					GetType						(CUIDragDropListEx* l);
	CUIDragDropListEx*			GetSlotList					(u32 slot_idx);

	bool		xr_stdcall		OnItemDrop					(CUICellItem* itm);
	bool		xr_stdcall		OnItemStartDrag				(CUICellItem* itm);
	bool		xr_stdcall		OnItemDbClick				(CUICellItem* itm);
	bool		xr_stdcall		OnItemSelected				(CUICellItem* itm);
	bool		xr_stdcall		OnItemRButtonClick			(CUICellItem* itm);


	CUIStatic					UIProgressBack;
	CUIStatic					UIProgressBack_rank;
	CUIProgressBar				UIProgressBarHealth;	
	CUIProgressBar				UIProgressBarPsyHealth;
	CUIProgressBar				UIProgressBarRadiation;
	CUIProgressBar				UIProgressBarRank;

	CUIPropertiesBox			UIPropertiesBox;
	
	//информация о персонаже
	CUIOutfitInfo				UIOutfitInfo;
	CUIItemInfo					UIItemInfo;

	CInventory*					m_pInv;

	CUICellItem*				m_pCurrentCellItem;

	bool						DropItem					(PIItem itm, CUIDragDropListEx* lst);
	bool						TryUseItem					(PIItem itm);
	//----------------------	-----------------------------------------------
	void						SendEvent_Item2Slot			(PIItem	pItem);
	void						SendEvent_Item2Belt			(PIItem	pItem);
	void						SendEvent_Item2Ruck			(PIItem	pItem);
	void						SendEvent_Item_Drop			(PIItem	pItem);
	void						SendEvent_Item_Eat			(PIItem	pItem);
	void						SendEvent_ActivateSlot		(PIItem	pItem);

	//---------------------------------------------------------------------

	void						ProcessPropertiesBoxClicked	();
	void						ActivatePropertiesBox		();

	void						DropCurrentItem				(bool b_all);
	void						EatItem						(PIItem itm);
	
	bool						ToSlot						(CUICellItem* itm, bool force_place);
	bool						ToBag						(CUICellItem* itm, bool b_use_cursor_pos);
	bool						ToBelt						(CUICellItem* itm, bool b_use_cursor_pos);


	void						AttachAddon					(PIItem item_to_upgrade);
	void						DetachAddon					(const char* addon_name);

	void						SetCurrentItem				(CUICellItem* itm);
	CUICellItem*				CurrentItem					();
	

	TIItemContainer				ruck_list;
	u32							m_iCurrentActiveSlot;
public:
	PIItem						CurrentIItem();
	
	void Draw3DStatic() {
		UIItemInfo.Draw3DStatic();
		if (this->IsShown()) {
			if (UIOutfitBackground) UIOutfitBackground->Draw_();
		}
	}

};

#if defined(INV_NEW_SLOTS_SYSTEM) && !defined(OLR_SLOTS)
extern bool is_quick_slot(u32, CInventoryItem*, CInventory*);
#endif
