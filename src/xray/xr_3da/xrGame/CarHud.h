
#pragma once

#include "../Motion.h"
//#include "Car.h"
#include "level.h"
#include "../SkeletonAnimated.h"

typedef svector<MotionID,8> MotionSVec;

MotionID car_hud_random_anim(MotionSVec& v);

class CCar;

class CCarHud {
public:
							CCarHud					(CCar* parent);
	virtual					~CCarHud				();
	
	void					Load					(LPCSTR section);
	void					Update					();
	void					renderable_Render		();
	
	MotionID				AnimGet					(LPCSTR prefix) const;
	void					AnimPlay				(const MotionID M, BOOL bMixIn);
	
	
	void					PlayAnimIdle			() {
		AnimPlay(car_hud_random_anim(m_anim_idle), FALSE);
	}
	void					PlayAnimIdleRight		() {
		AnimPlay(car_hud_random_anim(m_anim_idle_right), FALSE);
	}
	void					PlayAnimIdleLeft		() {
		AnimPlay(car_hud_random_anim(m_anim_idle_left), FALSE);
	}
	
	void					PlayAnimRotateRight		();
	void					PlayAnimRotateLeft		();
	void					PlayAnimReturnRight		();
	void					PlayAnimReturnLeft		();
	
	u32						GetMotionLength			(const MotionID M) const;
	
	IRender_Visual*			Visual					() const {
		return m_animations;
	}
	
	bool					GetHudVisible			() const;
	
private:
	void					UpdateAnimPlayer		();
	void					UpdateHudPosition		();
	
	void					AnimListInit			(MotionSVec& lst, LPCSTR prefix);
	
	
	shared_str				m_hud_sect;
	CKinematicsAnimated*	m_animations;
	Fmatrix					m_hud_offset;
	
	
	Fmatrix					m_hud_position;
	u32						m_anim_time_end;
	
	CCar*					m_parent;
	
	MotionSVec				m_anim_idle;
	MotionSVec				m_anim_idle_right;
	MotionSVec				m_anim_idle_left;
	MotionSVec				m_anim_return_right;
	MotionSVec				m_anim_return_left;
	MotionSVec				m_anim_rotate_right;
	MotionSVec				m_anim_rotate_left;
	
	bool					m_right_rot;
	bool					m_left_rot;
	
};

