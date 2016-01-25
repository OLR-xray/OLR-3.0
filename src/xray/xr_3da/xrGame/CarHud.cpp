
#include "stdafx.h"
#include "CarHud.h"
#include "Car.h"

MotionID car_hud_random_anim(MotionSVec& v) {
	return v[Random.randI(v.size())];
}

CCarHud::CCarHud(CCar* parent) {
	m_anim_time_end = 0;
	m_parent = parent;
	m_right_rot = false;
	m_left_rot = false;
}

CCarHud::~CCarHud() {
	if (m_animations) {
		::Render->model_Delete((IRender_Visual*&)m_animations);
	}
}

void CCarHud::renderable_Render() {
	if (this->GetHudVisible() && m_animations) { 
		// HUD render
		::Render->set_Transform(&m_hud_position);
		::Render->add_Visual(m_animations);
	}
}

void CCarHud::Load(LPCSTR section) {
	
	if(pSettings->line_exist(section,"hud")) {
		m_hud_sect = pSettings->r_string(section,"hud");
	}

	if (*m_hud_sect) {
		
		// Visual
		string256 visual_name;
		LPCSTR visual_name_base = pSettings->r_string(*m_hud_sect, "visual");
		strcpy_s(visual_name, 256, visual_name_base);
		const char* suffix = strtok(NULL, "|");
		if (suffix && xr_strlen(suffix)) {
			strconcat(256, visual_name, visual_name_base, "|", suffix);
		}
		
		const Fvector v_hud_offset = pSettings->r_fvector3(*m_hud_sect, "position");
		m_hud_offset.translate_over(v_hud_offset);
	
		m_animations = smart_cast<CKinematicsAnimated*>(::Render->model_Create(visual_name));
		
		
		AnimListInit(m_anim_idle, pSettings->r_string(*m_hud_sect,"anim_idle"));
		
		AnimListInit(m_anim_idle_right, pSettings->r_string(*m_hud_sect,"anim_idle_right"));
		AnimListInit(m_anim_idle_left, pSettings->r_string(*m_hud_sect,"anim_idle_left"));
		
		AnimListInit(m_anim_return_left, pSettings->r_string(*m_hud_sect,"anim_return_left"));
		AnimListInit(m_anim_return_right, pSettings->r_string(*m_hud_sect,"anim_return_right"));
		
		AnimListInit(m_anim_rotate_left, pSettings->r_string(*m_hud_sect,"anim_rotate_left"));
		AnimListInit(m_anim_rotate_right, pSettings->r_string(*m_hud_sect,"anim_rotate_right"));
	}

}

void CCarHud::Update() {
	if (this->GetHudVisible() && m_animations) {
		m_animations->UpdateTracks();
	}
	UpdateHudPosition	();
	UpdateAnimPlayer	();
}

void CCarHud::UpdateAnimPlayer() {
	if (!this->GetHudVisible()) return;
	if (Device.dwTimeGlobal > m_anim_time_end) {
		if (m_right_rot) {
			this->PlayAnimIdleRight();
		}
		else if (m_left_rot) {
			this->PlayAnimIdleLeft();
		}
		else {
			this->PlayAnimIdle();
		}
	}
}

void CCarHud::UpdateHudPosition() {
	if (this->GetHudVisible()) {
		Fmatrix trans;
		trans.mul_43(m_parent->XFORM(), m_hud_offset);
		m_hud_position.set(m_parent->XFORM());
		m_hud_position.c = trans.c;
	}
}

void CCarHud::AnimListInit(MotionSVec& lst, LPCSTR prefix) {
	const MotionID& M = AnimGet(prefix);
	if (M) {
		lst.push_back(M);
	}
	for (int i=0; i<8; ++i) {
		string128 sh_anim;
		sprintf_s(sh_anim,"%s%d",prefix,i);
		const MotionID& M = AnimGet(sh_anim);
		if (M) {
			lst.push_back(M);
		}
	}
	R_ASSERT2(!lst.empty(),prefix);
}

bool CCarHud::GetHudVisible() const {
	return (m_parent->Owner() && m_parent->Owner()->ID() == Level().CurrentEntity()->ID());
}

MotionID CCarHud::AnimGet(LPCSTR prefix) const {
	return m_animations->ID_Cycle_Safe(prefix);
}

u32 CCarHud::GetMotionLength(const MotionID M) const {
	CKinematicsAnimated* skeleton_animated = m_animations;
	VERIFY(skeleton_animated);
	CMotionDef* motion_def = skeleton_animated->LL_GetMotionDef(M);
	VERIFY(motion_def);

	//if (motion_def->flags & esmStopAtEnd) {
		CMotion* motion = skeleton_animated->LL_GetRootMotion(M);
		return iFloor(0.5f + 1000.f*motion->GetLength()/ motion_def->Dequantize(motion_def->speed));
	//}
	return 0;
}

void CCarHud::AnimPlay(const MotionID M, BOOL bMixIn) {
	if (this->GetHudVisible()) {
		if (m_animations) {
			m_animations->PlayCycle(M,bMixIn);
			m_animations->CalculateBones_Invalidate();
		}
	}
	const u32 anim_time = this->GetMotionLength(M);
	if (anim_time > 0) {
		m_anim_time_end = Device.dwTimeGlobal + anim_time;
	}
}

void CCarHud::PlayAnimReturnRight() {
	AnimPlay(car_hud_random_anim(m_anim_return_right), TRUE);
	m_right_rot = false;
	m_left_rot = false;
}

void CCarHud::PlayAnimReturnLeft() {
	AnimPlay(car_hud_random_anim(m_anim_return_left), TRUE);
	m_right_rot = false;
	m_left_rot = false;
}

void CCarHud::PlayAnimRotateRight() {
	AnimPlay(car_hud_random_anim(m_anim_rotate_right), TRUE);
	m_right_rot = true;
	m_left_rot = false;
}

void CCarHud::PlayAnimRotateLeft() {
	AnimPlay(car_hud_random_anim(m_anim_rotate_left), TRUE);
	m_right_rot = false;
	m_left_rot = true;
}
