#include "stdafx.h"

#include "WeaponKnife.h"
#include "WeaponHUD.h"
#include "Entity.h"
#include "Actor.h"
#include "level.h"
#include "xr_level_controller.h"
#include "game_cl_base.h"
#include "../skeletonanimated.h"
#include "gamemtllib.h"
#include "level_bullet_manager.h"
#include "ai_sounds.h"
#include "game_cl_single.h"
#include "../../build_config_defines.h"

#define KNIFE_MATERIAL_NAME "objects\\knife"

CWeaponKnife::CWeaponKnife() : CWeapon("KNIFE") 
{
	m_attackStart			= false;
	SetState				( eHidden );
	SetNextState			( eHidden );
	knife_material_idx		= (u16)-1;
	SetSlot					(KNIFE_SLOT);
}
CWeaponKnife::~CWeaponKnife()
{
	HUD_SOUND::DestroySound(m_sndShot);

}

void CWeaponKnife::Load	(LPCSTR section)
{
	// verify class
	inherited::Load		(section);

	fWallmarkSize = pSettings->r_float(section,"wm_size");

	// HUD :: Anims
	R_ASSERT			(m_pHUD);
	animGet				(mhud_idle,		pSettings->r_string(*hud_sect,"anim_idle"));
	animGet				(mhud_hide,		pSettings->r_string(*hud_sect,"anim_hide"));
	animGet				(mhud_show,		pSettings->r_string(*hud_sect,"anim_draw"));
	animGet				(mhud_attack,	pSettings->r_string(*hud_sect,"anim_shoot1_start"));
	animGet				(mhud_attack2,	pSettings->r_string(*hud_sect,"anim_shoot2_start"));
	animGet				(mhud_attack_e,	pSettings->r_string(*hud_sect,"anim_shoot1_end"));
	animGet				(mhud_attack2_e,pSettings->r_string(*hud_sect,"anim_shoot2_end"));
#if defined(KNIFE_SPRINT_MOTION)
	animGet(mhud_idle_sprint, pSettings->r_string(*hud_sect,"anim_idle_sprint") );
#endif
	animGet(mhud_idle_walk, pSettings->r_string(*hud_sect,"anim_idle_walk") );
	animGet(mhud_idle_walk_slow, pSettings->r_string(*hud_sect,"anim_idle_walk_slow") );

	HUD_SOUND::LoadSound(section,"snd_shoot"		, m_sndShot		, ESoundTypes(SOUND_TYPE_WEAPON_SHOOTING)		);
	
	knife_material_idx =  GMLib.GetMaterialIdx(KNIFE_MATERIAL_NAME);
}

void CWeaponKnife::OnStateSwitch	(u32 S)
{
	inherited::OnStateSwitch(S);
	switch (S)
	{
	case eIdle:
		switch2_Idle	();
		break;
	case eShowing:
		switch2_Showing	();
		break;
	case eHiding:
		switch2_Hiding	();
		break;
	case eHidden:
		switch2_Hidden	();
		break;
	case eFire:
		Msg("CWeaponKnife::OnStateSwitch(fire)");
		{
			//-------------------------------------------
			m_eHitType		= m_eHitType_1;
			//fHitPower		= fHitPower_1;
			if (ParentIsActor())
			{
				if (GameID() == GAME_SINGLE)
				{
					fCurrentHit		= fvHitPower_1[g_SingleGameDifficulty];
				}
				else
				{
					fCurrentHit		= fvHitPower_1[egdMaster];
				}
			}
			else
			{
				fCurrentHit		= fvHitPower_1[egdMaster];
			}
			fHitImpulse		= fHitImpulse_1;
			//-------------------------------------------
			switch2_Attacking	(S);
		}break;
	case eFire2:
		Msg("CWeaponKnife::OnStateSwitch(fire2)");
		{
			//-------------------------------------------
			m_eHitType		= m_eHitType_2;
			//fHitPower		= fHitPower_2;
			if (ParentIsActor())
			{
				if (GameID() == GAME_SINGLE)
				{
					fCurrentHit		= fvHitPower_2[g_SingleGameDifficulty];
				}
				else
				{
					fCurrentHit		= fvHitPower_2[egdMaster];
				}
			}
			else
			{
				fCurrentHit		= fvHitPower_2[egdMaster];
			}
			fHitImpulse		= fHitImpulse_2;
			//-------------------------------------------
			switch2_Attacking	(S);
		}break;
	}
}
	

void CWeaponKnife::KnifeStrike(const Fvector& pos, const Fvector& dir)
{
	CCartridge						cartridge; 
	cartridge.m_buckShot			= 1;				
	cartridge.m_impair				= 1;
	cartridge.m_kDisp				= 1;
	cartridge.m_kHit				= 1;
	cartridge.m_kImpulse			= 1;
	cartridge.m_kPierce				= 1;
	cartridge.m_flags.set			(CCartridge::cfTracer, FALSE);
	cartridge.m_flags.set			(CCartridge::cfRicochet, FALSE);
	cartridge.fWallmarkSize			= fWallmarkSize;
	cartridge.bullet_material_idx	= knife_material_idx;

	while(m_magazine.size() < 2)	m_magazine.push_back(cartridge);
	iAmmoElapsed					= m_magazine.size();
	bool SendHit					= SendHitAllowed(H_Parent());

	PlaySound						(m_sndShot,pos);

	Level().BulletManager().AddBullet(	pos, 
										dir, 
										m_fStartBulletSpeed, 
										fCurrentHit, 
										fHitImpulse, 
										H_Parent()->ID(), 
										ID(), 
										m_eHitType, 
										fireDistance, 
										cartridge, 
										SendHit);
}


void CWeaponKnife::OnAnimationEnd(u32 state)
{
	switch (state)
	{
	case eHiding:	SwitchState(eHidden);	break;
	case eFire: 
	case eFire2: 
		{
            if(m_attackStart) 
			{
				m_attackStart = false;
				if(GetState()==eFire)
					m_pHUD->animPlay(random_anim(mhud_attack_e), TRUE, this, GetState());
				else
					m_pHUD->animPlay(random_anim(mhud_attack2_e), TRUE, this, GetState());

				Fvector	p1, d; 
				p1.set(get_LastFP()); 
				d.set(get_LastFD());

				if(H_Parent()) 
					smart_cast<CEntity*>(H_Parent())->g_fireParams(this, p1,d);
				else break;

				KnifeStrike(p1,d);
			} 
			else 
				SwitchState(eIdle);
				
			this->onMovementChanged(mcAnyMove);
		}break;
	case eShowing:
	case eIdle:	
		SwitchState(eIdle);		break;	
	}
}

void CWeaponKnife::state_Attacking	(float)
{
}

void CWeaponKnife::switch2_Attacking	(u32 state)
{
	if(m_bPending)	return;

	if(state==eFire)
		m_pHUD->animPlay(random_anim(mhud_attack),		FALSE, this, state);
	else //eFire2
		m_pHUD->animPlay(random_anim(mhud_attack2),		FALSE, this, state);

	m_attackStart	= true;
	m_bPending		= true;
}

bool CWeaponKnife::TryPlayAnimIdle() {

	CActor* pActor = smart_cast<CActor*>(H_Parent());
	if (pActor) {
		CEntity::SEntityState st;
		pActor->g_State(st);
		if (st.bSprint) {
			if (mhud_idle_sprint.size()) {
				m_pHUD->animPlay(random_anim(mhud_idle_sprint), TRUE, NULL, GetState());
				return true;
			}
		}
		else if (st.bWalk) {
			MotionSVec* m = NULL;
			const bool is_slow = (st.bAccel || st.bCrouch);
			if (is_slow && mhud_idle_walk_slow.size()) {
				m = &mhud_idle_walk_slow;
			}
			else if (mhud_idle_walk.size()) {
				m = &mhud_idle_walk;
			}
			if (m!=NULL) {
				m_pHUD->animPlay(random_anim(*m), TRUE, NULL, GetState());
				return true;
			}
		}
	}
	return false;
}

void CWeaponKnife::switch2_Idle	()
{
	m_bPending = false;
	PlayAnimIdle();
}

void CWeaponKnife::PlayAnimIdle() {
	VERIFY(GetState()==eIdle);
	if (TryPlayAnimIdle()) return;

	m_pHUD->animPlay(random_anim(mhud_idle), TRUE, this, GetState());
}

void CWeaponKnife::switch2_Hiding	()
{
	FireEnd					();
	VERIFY(GetState()==eHiding);
	m_pHUD->animPlay		(random_anim(mhud_hide), TRUE, this, GetState());
//	m_bPending				= true;
}

void CWeaponKnife::switch2_Hidden()
{
	signal_HideComplete		();
	m_bPending = false;
}

void CWeaponKnife::switch2_Showing	()
{
	VERIFY(GetState()==eShowing);
	m_pHUD->animPlay		(random_anim(mhud_show), FALSE, this, GetState());
//	m_bPending				= true;
}


void CWeaponKnife::FireStart()
{	
	inherited::FireStart();
	SwitchState			(eFire);
}

void CWeaponKnife::Fire2Start () 
{
	inherited::Fire2Start();
	SwitchState(eFire2);

	// Real Wolf: Прерывание спринта при ударе. 17.07.2014.
#if defined(KNIFE_SPRINT_FIX)
	if (ParentIsActor() )
		g_actor->set_state_wishful(g_actor->get_state_wishful() & (~mcSprint) );
#endif
}


bool CWeaponKnife::Action(s32 cmd, u32 flags) 
{
	if(inherited::Action(cmd, flags)) return true;
	switch(cmd) 
	{

		case kWPN_ZOOM : 
			if(flags&CMD_START) Fire2Start();
			else Fire2End();
			return true;
	}
	return false;
}

void CWeaponKnife::LoadFireParams(LPCSTR section, LPCSTR prefix)
{
	inherited::LoadFireParams(section, prefix);

	string256			full_name;
	string32			buffer;
	shared_str			s_sHitPower_2;
	//fHitPower_1		= fHitPower;
	fvHitPower_1		= fvHitPower;
	fHitImpulse_1		= fHitImpulse;
	m_eHitType_1		= ALife::g_tfString2HitType(pSettings->r_string(section, "hit_type"));

	//fHitPower_2			= pSettings->r_float	(section,strconcat(full_name, prefix, "hit_power_2"));
	s_sHitPower_2		= pSettings->r_string_wb	(section,strconcat(sizeof(full_name),full_name, prefix, "hit_power_2"));
	fvHitPower_2[egdMaster]	= (float)atof(_GetItem(*s_sHitPower_2,0,buffer));//первый параметр - это хит для уровня игры мастер

	fvHitPower_2[egdVeteran]	= fvHitPower_2[egdMaster];//изначально параметры для других уровней
	fvHitPower_2[egdStalker]	= fvHitPower_2[egdMaster];//сложности
	fvHitPower_2[egdNovice]		= fvHitPower_2[egdMaster];//такие же

	int num_game_diff_param=_GetItemCount(*s_sHitPower_2);//узнаём колличество параметров для хитов
	if (num_game_diff_param>1)//если задан второй параметр хита
	{
		fvHitPower_2[egdVeteran]	= (float)atof(_GetItem(*s_sHitPower_2,1,buffer));//то вычитываем его для уровня ветерана
	}
	if (num_game_diff_param>2)//если задан третий параметр хита
	{
		fvHitPower_2[egdStalker]	= (float)atof(_GetItem(*s_sHitPower_2,2,buffer));//то вычитываем его для уровня сталкера
	}
	if (num_game_diff_param>3)//если задан четвёртый параметр хита
	{
		fvHitPower_2[egdNovice]	= (float)atof(_GetItem(*s_sHitPower_2,3,buffer));//то вычитываем его для уровня новичка
	}

	fHitImpulse_2		= pSettings->r_float	(section,strconcat(sizeof(full_name),full_name, prefix, "hit_impulse_2"));
	m_eHitType_2		= ALife::g_tfString2HitType(pSettings->r_string(section, "hit_type_2"));
}

void CWeaponKnife::StartIdleAnim()
{
	if (TryPlayAnimIdle()) return;
	m_pHUD->animDisplay(mhud_idle[Random.randI(mhud_idle.size())], TRUE);
}
void CWeaponKnife::GetBriefInfo(xr_string& str_name, xr_string& icon_sect_name, xr_string& str_count)
{
	str_name		= NameShort();
	str_count		= "";
	icon_sect_name	= *cNameSect();
}

// Real Wolf: Анимация бега. 17.07.2014.
void CWeaponKnife::onMovementChanged(ACTOR_DEFS::EMoveCommand cmd) {
	const bool b = (
		cmd == ACTOR_DEFS::mcSprint ||
		cmd == ACTOR_DEFS::mcAnyMove ||
		cmd == ACTOR_DEFS::mcCrouch ||
		cmd == ACTOR_DEFS::mcAccel
	);
	if (b && (GetState() == eIdle)) {
		this->PlayAnimIdle();
	}
}

