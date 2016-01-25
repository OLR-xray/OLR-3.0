
#pragma once

#include "../Motion.h"
#include "../SkeletonAnimated.h"

class CLevelBackground {
public:
	CLevelBackground();
	~CLevelBackground();
	
	void Update();
	void renderable_Render();
	
	void MoveToCam();
	IRender_Visual*			Visual					() const {
		return m_animations;
	}

private:
	IRender_Visual*	m_animations;
	Fmatrix					m_position;
	bool						m_visible;
	
};

