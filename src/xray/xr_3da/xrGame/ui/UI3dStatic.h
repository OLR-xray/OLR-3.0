// UI3dStatic.h: класс статического элемента, который рендерит 
// 3d объект в себя
//////////////////////////////////////////////////////////////////////

#ifndef _UI_3D_STATIC_H_
#define _UI_3D_STATIC_H_

#pragma once


#include "uistatic.h"

struct SStaticParamsFromGameObject {
	Fvector m_rotate;
	float m_scale;
};

class CInventoryItem;
class CGameObject;
class IRender_Visual;

class CUI3dStatic : public CUIStatic {
private:
	typedef CUIStatic inherited;
public:
	CUI3dStatic();
	virtual ~CUI3dStatic();
	
	//прорисовка окна
	virtual void Draw();
	//обновление вращения объекта
	virtual void Update();
	void Draw_();
	void Destroy() {
		this->ModelFree();
		this->SetDefaultValues();
	}

	
	void SetRotate(const float x, const float y, const float z) {
		m_x_angle = x;
		m_y_angle = y;
		m_z_angle = z;
	}

	void SetGameObject(CInventoryItem* pItem);
	void SetGameObject(CGameObject* pItem, SStaticParamsFromGameObject params);
	
	void SetRotatedMode(const bool value) {
		m_rotated = value;
	}
	bool GetRotatedMode() const {
		return m_rotated;
	}
	
	IRender_Visual* Visual() {
		return m_pCurrentVisual;
	}
	
	void SetModelRadius(float value) {
		m_model_radius = value;
	}
	float GetModelRadius() const {
		return m_model_radius;
	}
	void RemoveModelRadius() {
		m_model_radius = -1;
	}
	
	void SetModelConstPosition(bool value) {
		m_model_const_position = value;
	}
	bool GetModelConstPosition() const {
		return m_model_const_position;
	}

protected:
	//перевод из координат экрана в координаты той плоскости
	//где находиться объект
	void FromScreenToItem(const float x, const float y, float& x_item, float& y_item);

	Fmatrix XFORM;
	IRender_Visual* m_pCurrentVisual;
	float m_x_angle, m_y_angle, m_z_angle;
	float m_scale;

private:
	bool m_model_const_position;
	float m_model_radius;
	bool m_rotated;
	u32 m_dwRotateTime;
	void SetDefaultValues();
	void ModelFree();

};

#endif // _UI_3D_STATIC_H_

