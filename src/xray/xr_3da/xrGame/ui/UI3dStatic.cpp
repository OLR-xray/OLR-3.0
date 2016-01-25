// UI3dStatic.cpp: класс статического элемента, который рендерит 
// 3d объект в себя
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "ui3dstatic.h"
#include "../Inventory_Item.h"
#include "../gameobject.h"
#include "../../SkeletonAnimated.h"
#include "3d_static_shaders.h"

const float pRotateSpeed = 0.01;
const float pi_mul_2 = M_PI*2.f;

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CUI3dStatic::CUI3dStatic() {
	SetDefaultValues();
	m_pCurrentVisual = NULL;
	m_rotated = false;
	m_model_radius = -1;
	m_model_const_position = false;
	Enable(false);
}

CUI3dStatic::~CUI3dStatic() {
	ModelFree();
}


//расстояние от камеры до вещи, перед глазами
const float pDist = VIEWPORT_NEAR + 0.1f;


void CUI3dStatic::FromScreenToItem(
	const float x, const float y,
	float& x_item, float& y_item
) {

	const int halfwidth  = Device.dwWidth/2;
	const int halfheight = Device.dwHeight/2;

	const float size_y = VIEWPORT_NEAR * tanf( deg2rad(60.f) * 0.5f);
	const float size_x = size_y / (Device.fASPECT);

	const float r_pt = float(x-halfwidth) * size_x / (float) halfwidth;
	const float u_pt = float(halfheight-y) * size_y / (float) halfheight;

	x_item = r_pt * pDist / VIEWPORT_NEAR;
	y_item = u_pt * pDist / VIEWPORT_NEAR;
}

//Функция рисования модели должна вызываться из функции рисования худа
void CUI3dStatic::Draw() {
	inherited::Draw();
}

//прорисовка
void CUI3dStatic::Draw_() {
	if (m_pCurrentVisual) {
		::Render->set_Transform(&XFORM);
		::Render->add_Visual(m_pCurrentVisual);
	}
}

//обновление
void CUI3dStatic::Update() {
	inherited::Update();
	if (m_rotated) {
		if (m_dwRotateTime < Device.dwTimeGlobal) {
			m_dwRotateTime = Device.dwTimeGlobal + 10;
			m_y_angle += pRotateSpeed;
			if (m_y_angle>pi_mul_2) {
				m_y_angle -= pi_mul_2;
			}
		}
	}
	
	if (m_pCurrentVisual) {
		Frect rect;
		GetAbsoluteRect(rect);
		// Apply scale
		rect.top = (UI()->ClientToScreenScaledY(rect.top));
		rect.left = (UI()->ClientToScreenScaledX(rect.left));
		rect.bottom = (UI()->ClientToScreenScaledY(rect.bottom));
		rect.right = (UI()->ClientToScreenScaledX(rect.right));

		Fmatrix translate_matrix;
		Fmatrix scale_matrix;
		
		Fmatrix rx_m; 
		Fmatrix ry_m; 
		Fmatrix rz_m; 

		XFORM.identity();

		//поместить объект в центр сферы
		translate_matrix.identity();
		if (m_model_const_position) {
			translate_matrix.translate(0.f, 0.f, 0.f);
		}
		else {
			translate_matrix.translate(
				-m_pCurrentVisual->vis.sphere.P.x, 
				-m_pCurrentVisual->vis.sphere.P.y, 
				-m_pCurrentVisual->vis.sphere.P.z
			);
		}

		XFORM.mulA_44(translate_matrix);


		rx_m.identity();
		rx_m.rotateX(m_x_angle);
		ry_m.identity();
		ry_m.rotateY(m_y_angle);
		rz_m.identity();
		rz_m.rotateZ(m_z_angle);


		XFORM.mulA_44(rx_m);
		XFORM.mulA_44(ry_m);
		XFORM.mulA_44(rz_m);
		

		
		float x1, y1, x2, y2;

		FromScreenToItem(rect.left, rect.top, x1, y1);
		FromScreenToItem(rect.right, rect.bottom, x2, y2);

		const float normal_size = _min(_abs(x2-x1), _abs(y2-y1));
		const float radius = (m_model_radius>=0)?m_model_radius:m_pCurrentVisual->vis.sphere.R;
		const float scale = (normal_size/(radius*2)) * m_scale;

		scale_matrix.identity();
		scale_matrix.scale( scale, scale,scale);

		XFORM.mulA_44(scale_matrix);
        

		float right_item_offset, up_item_offset;

		
		///////////////////////////////	
		
		FromScreenToItem(
			rect.left + iFloor(UI()->ClientToScreenScaledX(GetWidth()/2)),
			rect.top + iFloor(UI()->ClientToScreenScaledY(GetHeight()/2)), 
			right_item_offset,
			up_item_offset
		);

		translate_matrix.identity();
		translate_matrix.translate(
			right_item_offset,
			up_item_offset,
			pDist
		);

		XFORM.mulA_44(translate_matrix);

		Fmatrix camera_matrix;
		camera_matrix.identity();
		camera_matrix = Device.mView;
		camera_matrix.invert();
		
		XFORM.mulA_44(camera_matrix);
		
	}
}
/*
void visual_set_shader(IRender_Visual* v,  LPCSTR replace);

static void update_shader_from_childrens(IRender_Visual* v,  LPCSTR replace) {
	auto pVisual = dynamic_cast<CKinematics*>(v);
	if (pVisual) {
		xr_vector<IRender_Visual*>::iterator B, E;
		B = (pVisual->children).begin();
		E = (pVisual->children).end();
		for ( ; B!=E;++B) {
			visual_set_shader(*B, replace);
		}
	}
}
*/

static inline IRender_Visual* load_model(LPCSTR name) {
	if (::Render->get_generation() == ::Render->GENERATION_R2) {
		::Render->setShaderFromModel(R2_STATIC_SHADER);
	}
	else {
		::Render->setShaderFromModel(STATIC_SHADER);
	}
	IRender_Visual* m = ::Render->model_Instance_Load(name);
	::Render->setShaderFromModel(NULL);
	return m;
}

void CUI3dStatic::SetGameObject(CGameObject* pItem, SStaticParamsFromGameObject params) {
	R_ASSERT(pItem);
	ModelFree();
	m_pCurrentVisual = load_model(pItem->cNameVisual().c_str());
	m_x_angle = params.m_rotate.x;
	m_z_angle = params.m_rotate.z;
	m_scale = params.m_scale;
}

void CUI3dStatic::SetGameObject(CInventoryItem* pItem) {
	LPCSTR visual_name = pItem->Get3DStaticVisualName();
	if (visual_name == NULL) {
		R_ASSERT(smart_cast<CGameObject*>(pItem));
		visual_name = smart_cast<CGameObject*>(pItem)->cNameVisual().c_str();
	}
	ModelFree();
	m_pCurrentVisual = load_model(visual_name);
	
	const Fvector rotate = pItem->Get3DStaticRotate();
	m_x_angle = rotate.x;
	m_z_angle = rotate.z;
	
	m_scale = pItem->Get3DStaticScale();
	
}

void CUI3dStatic::SetDefaultValues() {
	m_x_angle = m_y_angle = m_z_angle = 0.f;
	m_dwRotateTime = 0;
	m_scale = 1.f;
}

void CUI3dStatic::ModelFree() {
	if (m_pCurrentVisual) {
		::Render->model_Delete(m_pCurrentVisual);
		m_pCurrentVisual = NULL;
	}
}

