////////////////////////////////////////////////////////////////////////////
//	Module 		: eatable_item_object.cpp
//	Created 	: 24.03.2003
//  Modified 	: 29.01.2004
//	Author		: Yuri Dobronravin
//	Description : Eatable item object implementation
////////////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "eatable_item_object.h"
#include "entity_alive.h"
#include "ai_sounds.h"
#include "Actor.h"

#include "pch_script.h"
#include "game_object_space.h"
#include "script_callback_ex.h"
#include "script_game_object.h"


CEatableItemObject::CEatableItemObject(void) {
	m_class_name = get_class_name<CEatableItemObject>(this);
	m_eatStart = false;
	m_snd_eat_loaded = false;
}

CEatableItemObject::~CEatableItemObject(void) {
	if (m_snd_eat_loaded) {
		HUD_SOUND::DestroySound(m_sndEat);
	}
}

void CEatableItemObject::Load(LPCSTR section) {
	CEatableItem::Load(section);
	
	
	if (this->IsUseHud()) {
		inherited::Load(section);
	
		//загрузить анимации HUD-а
	
		animGet				(m_anim_idle, pSettings->r_string(*hud_sect,"anim_idle"));
		animGet				(m_anim_idle_sprint, pSettings->r_string(*hud_sect,"anim_idle_sprint"));
		animGet				(m_anim_idle_walk, pSettings->r_string(*hud_sect,"anim_idle_walk"));
		animGet				(m_anim_idle_walk_slow, pSettings->r_string(*hud_sect,"anim_idle_walk_slow"));
		animGet				(m_anim_hide, pSettings->r_string(*hud_sect,"anim_hide"));
		animGet				(m_anim_show, pSettings->r_string(*hud_sect,"anim_show"));
		animGet				(m_anim_eat, pSettings->r_string(*hud_sect,"anim_eat"));
	
		HUD_SOUND::LoadSound(
			section,
			"snd_eat",
			m_sndEat,
			ESoundTypes(SOUND_TYPE_ITEM_USING)
		);
		m_snd_eat_loaded = true;
		
		SetSlot(pSettings->r_u32(section,"slot"));
	}
	else {
		CInventoryItemObject::Load(section);
	}
	
}

DLL_Pure* CEatableItemObject::_construct() {
	CEatableItem::_construct	();
	inherited::_construct();
	return (this);
}

BOOL CEatableItemObject::net_Spawn(CSE_Abstract* DC) {
	BOOL res = inherited::net_Spawn(DC);
	CEatableItem::net_Spawn(DC);
	SetState					(eHidden);
	return (res);
}

void CEatableItemObject::net_Import(NET_Packet& P)  {	
	inherited::net_Import(P);
	CEatableItem::net_Import(P);
}

void CEatableItemObject::net_Export(NET_Packet& P)  {	
	inherited::net_Export(P);
	CEatableItem::net_Export(P);
}

bool CEatableItemObject::Useful() const {
	if (!inherited::Useful()) return false;
	return (CEatableItem::Useful());
}


#include "ui/UICellItemFactory.h"
#include "ui/UICellCustomItems.h"
#include "ui/UIDragDropListEx.h"
#include "InventoryOwner.h"
#include "Inventory.h"
#include "ui/UIInventoryUtilities.h"

void CEatableItemObject::UseBy(CEntityAlive* entity_alive) {
	R_ASSERT(CInventoryItem::object().H_Parent()->ID()==entity_alive->ID());
	entity_alive->conditions().ChangeHealth(m_fHealthInfluence);
	entity_alive->conditions().ChangePower(m_fPowerInfluence);
	entity_alive->conditions().ChangeSatiety(m_fSatietyInfluence);
	entity_alive->conditions().ChangeRadiation(m_fRadiationInfluence);
	entity_alive->conditions().ChangeBleeding(m_fWoundsHealPerc);
	
	entity_alive->conditions().SetMaxPower( entity_alive->conditions().GetMaxPower()+m_fMaxPowerUpInfluence );
	
	//уменьшить количество порций
	if(m_iPortionsNum > 0) {
		--(m_iPortionsNum);
	}
	else {
		m_iPortionsNum = 0;
	}

#if defined(EAT_PORTIONS_INFLUENCE)
	// Real Wolf: Уменьшаем вес и цену после использования.
	const char* sect = CInventoryItem::object().cNameSect().c_str();
	const float weight = READ_IF_EXISTS(pSettings, r_float, sect, "inv_weight", 0.0f);
	const float cost	= READ_IF_EXISTS(pSettings, r_float, sect, "cost", 0.0f);

	m_weight	-= weight / m_iStartPortionsNum;
	m_cost -= cost / m_iStartPortionsNum;
#endif

	/* Real Wolf: После использования предмета, удаляем его иконку и добавляем заново.
	Таким образом вызовется колбек на группировку, где пользователь решит, группировать или нет предмета. 13.08.2014.*/
	if (!Empty() && m_cell_item && m_cell_item->ChildsCount() ) {
		CUIDragDropListEx* owner = m_cell_item->OwnerList();
		CUICellItem* itm = m_cell_item->PopChild();
		owner->SetItem(itm);
		
	}
}

bool CEatableItemObject::Action(s32 cmd, u32 flags) {
	switch(cmd) {
		case kWPN_FIRE :
		case kWPN_ZOOM : {
			if (m_eatStart == false) {
				if (g_actor->GetHolderID() == u16(-1)) {
					if(flags&CMD_START) {
						m_eatStart = true;
						SwitchState(eEat);
						DisableSprint();
					}
					return true;
				}
			}
			return false;
		}
	}
	return (inherited::Action(cmd, flags));
}

void CEatableItemObject::GetBriefInfo(xr_string& str_name, xr_string& icon_sect_name, xr_string& str_count) {
	str_name = NameShort();
	string16 stmp = "";
	if (m_iStartPortionsNum == 1) {
		if (m_pCurrentInventory) {
			const u32 ThisCount= m_pCurrentInventory->dwfGetSameItemCount(*cNameSect(), true);
			sprintf_s(stmp, "%d", ThisCount);
		}
	}
	else {
		sprintf_s(stmp, "%d", m_iPortionsNum);
	}
	str_count = stmp;
	icon_sect_name = *cNameSect();
}


void CEatableItemObject::DestroyByEat(CEntityAlive* entity_alive) {
	if (Empty() && entity_alive->Local()) {
		this->DestroyByEat(entity_alive, CInventoryItem::object().ID());
		//Msg("ZAHAVALI destroy by eat");
		//g_actor->callback(GameObject::eOnEatHudItem)();  Actor()
		g_actor->callback(GameObject::eOnEatHudItem)();
	}
}

void CEatableItemObject::DestroyByEat(CEntityAlive* entity_alive, u16 id) {
	NET_Packet P;
	CGameObject::u_EventGen(P,GE_OWNERSHIP_REJECT,entity_alive->ID());
	P.w_u16(id);
	CGameObject::u_EventSend(P);
	
	CGameObject::u_EventGen(P,GE_DESTROY,id);
	CGameObject::u_EventSend(P);
}

void CEatableItemObject::Hide() {
	SwitchState(eHiding);
}

void CEatableItemObject::Show() {
	SwitchState(eShowing);
}

bool CEatableItemObject::Activate()  {
	Show();
	return true;
}

void CEatableItemObject::Deactivate()  {
	if (m_eatStart) return ;
	Hide();
}

#include "inventoryOwner.h"
#include "Entity_alive.h"
void CEatableItemObject::UpdateXForm() {
	if (Device.dwFrame != dwXF_Frame) {
		dwXF_Frame = Device.dwFrame;

		if (0==H_Parent()) return;

		// Get access to entity and its visual
		auto E = smart_cast<CEntityAlive*>(H_Parent());
        
		if (!E) return	;

		auto parent = smart_cast<const CInventoryOwner*>(E);
		if (parent && parent->use_simplified_visual()) return;

		VERIFY(E);
		auto V = smart_cast<CKinematics*>(E->Visual());
		VERIFY(V);

		// Get matrices
		int boneL, boneR, boneR2;
		E->g_WeaponBones(boneL,boneR,boneR2);

		boneL = boneR2;

		V->CalculateBones();
		Fmatrix& mL = V->LL_GetTransform(u16(boneL));
		Fmatrix& mR = V->LL_GetTransform(u16(boneR));

		// Calculate
		Fmatrix mRes;
		Fvector R,D,N;
		
		D.sub(mL.c,mR.c);
		D.normalize_safe();
		
		R.crossproduct(mR.j,D);
		R.normalize_safe();
		
		N.crossproduct(D,R);
		N.normalize_safe();
		
		mRes.set(R,N,D,mR.c);
		mRes.mulA_43(E->XFORM());
		
		XFORM().mul(mRes,offset());
	}
}

void CEatableItemObject::OnAnimationEnd(u32 state)  {
	switch (state) {
		case eHiding: {
			SwitchState(eHidden);
		} break;
		case eShowing: {
			SwitchState(eIdle);
		} break;
		case eEat: {
			if (Local()) {
				SwitchState(eHiding);
				m_eatStart = false;
				SetDefaultSprint();
				auto pEntityAliveParent = smart_cast<CEntityAlive*>(CInventoryItem::object().H_Parent());
				if (pEntityAliveParent) {
					this->UseBy(pEntityAliveParent);
					this->DestroyByEat(pEntityAliveParent);
				}
			}
		} break;
	};
}

void CEatableItemObject::OnStateSwitch(u32 S) {
	inherited::OnStateSwitch	(S);
	
	switch(S) {
		case eShowing: {
			m_pHUD->animPlay(random_anim(m_anim_show),		FALSE, this, S);
		} break;
		case eHiding: {
			m_pHUD->animPlay(random_anim(m_anim_hide),		FALSE, this, S);
		} break;
		case eEat: {
			Fvector pos;
			Center(pos);
			PlaySound(m_sndEat,pos);
			m_pHUD->animPlay(random_anim(m_anim_eat),	FALSE, this, S);
		} break;
		case eIdle: {
			PlayAnimIdle();
		} break;
	};
}

bool CEatableItemObject::TryPlayAnimIdle() {

	VERIFY(GetState() == eIdle);
	auto pActor = smart_cast<CActor*>(H_Parent());
	if (pActor) {
		CEntity::SEntityState st;
		pActor->g_State(st);
		if (st.bSprint) {
			if (m_anim_idle_sprint.size()) {
				m_pHUD->animPlay(random_anim(m_anim_idle_sprint), TRUE, NULL, GetState());
				return true;
			}
		}
		else if (st.bWalk) {
			MotionSVec* m = NULL;
			const bool is_slow = (st.bAccel || st.bCrouch);
			if (is_slow && m_anim_idle_walk_slow.size()) {
				m = &m_anim_idle_walk_slow;
			}
			else if (m_anim_idle_walk.size()) {
				m = &m_anim_idle_walk;
			}
			if (m!=NULL) {
				m_pHUD->animPlay(random_anim(*m), TRUE, NULL, GetState());
				return true;
			}
		}
	}
	return false;
}

void CEatableItemObject::PlayAnimIdle() {
	if (TryPlayAnimIdle()) return;
	m_pHUD->animPlay(random_anim(m_anim_idle), FALSE, NULL, eIdle);
}

void CEatableItemObject::onMovementChanged	(ACTOR_DEFS::EMoveCommand cmd) {
	const bool b = (
		cmd == ACTOR_DEFS::mcSprint ||
		cmd == ACTOR_DEFS::mcAnyMove ||
		cmd == ACTOR_DEFS::mcCrouch ||
		cmd == ACTOR_DEFS::mcAccel
	);
	if (b && (GetState() == eIdle)) {
		PlayAnimIdle();
	}
}

u16	CEatableItemObject::bone_count_to_synchronize() const {
	return CInventoryItem::object().PHGetSyncItemsNumber();
}



