////////////////////////////////////////////////////////////////////////////
//	Module 		: eatable_item.cpp
//	Created 	: 24.03.2003
//  Modified 	: 29.01.2004
//	Author		: Yuri Dobronravin
//	Description : Eatable item
////////////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "eatable_item.h"
#include "xrmessages.h"
#include "../../xrNetServer/net_utils.h"
#include "physic_item.h"
#include "Level.h"
#include "EntityCondition.h"
#include "InventoryOwner.h"

#include "xrServer_Objects_ALife_Items.h"

CEatableItem::CEatableItem()
{
	m_fHealthInfluence = 0;
	m_fPowerInfluence = 0;
	m_fSatietyInfluence = 0;
	m_fRadiationInfluence = 0;

	m_iPortionsNum = -1;

	m_physic_item	= 0;
	m_use_hud		= false;
}

CEatableItem::~CEatableItem()
{
}

DLL_Pure *CEatableItem::_construct	()
{
	m_physic_item	= smart_cast<CPhysicItem*>(this);
	return			smart_cast<DLL_Pure*>(this);
}

void CEatableItem::Load(LPCSTR section)
{
	//inherited::Load(section);

	m_fHealthInfluence			= pSettings->r_float(section, "eat_health");
	m_fPowerInfluence			= pSettings->r_float(section, "eat_power");
	m_fSatietyInfluence			= pSettings->r_float(section, "eat_satiety");
	m_fRadiationInfluence		= pSettings->r_float(section, "eat_radiation");
	m_fWoundsHealPerc			= pSettings->r_float(section, "wounds_heal_perc");
	clamp						(m_fWoundsHealPerc, 0.f, 1.f);
	
	m_iStartPortionsNum			= pSettings->r_u32	(section, "eat_portions_num");
	if (m_iStartPortionsNum < 1) m_iStartPortionsNum = 1;
	m_fMaxPowerUpInfluence		= READ_IF_EXISTS	(pSettings,r_float,section,"eat_max_power",0.0f);
	VERIFY						(m_iPortionsNum<10000);
	m_use_hud = !!READ_IF_EXISTS	(pSettings,r_bool,section,"use_hud",false);
}

BOOL CEatableItem::net_Spawn				(CSE_Abstract* DC)
{
	//if (!inherited::net_Spawn(DC)) return FALSE;

	if (auto se_eat = smart_cast<CSE_ALifeItemEatable*>(DC))
	{
		m_iPortionsNum = se_eat->m_portions_num;
#if defined(EAT_PORTIONS_INFLUENCE)
		m_weight	-= m_weight / m_iStartPortionsNum * m_iPortionsNum;
		m_cost		-= m_cost	/ m_iStartPortionsNum * m_iPortionsNum;
#endif
	}
	else {
		Msg("m_iStartPortionsNum %i", m_iStartPortionsNum);
		m_iPortionsNum = m_iStartPortionsNum;
	}

	return TRUE;
};

bool CEatableItem::Useful() const
{
	//if(!inherited::Useful()) return false;

	//проверить не все ли еще съедено
	if(Empty()) return false;

	return true;
}
/* 
void CEatableItem::OnH_B_Independent(bool just_before_destroy)
{
	if(!Useful()) 
	{
		object().setVisible(FALSE);
		object().setEnabled(FALSE);
		if (m_physic_item)
			m_physic_item->m_ready_to_destroy	= true;
	}
	//inherited::OnH_B_Independent(just_before_destroy);
}
 */

void CEatableItem::net_Export(NET_Packet& P)
{
	//inherited::net_Export(P);
	P.w_s32(m_iPortionsNum);
}

void CEatableItem::net_Import(NET_Packet& P)
{
	//inherited::net_Import(P);
	m_iPortionsNum = P.r_s32();
}