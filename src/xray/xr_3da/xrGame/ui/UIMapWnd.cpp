#include "stdafx.h"
#include "UIMapWnd.h"
#include "UIMap.h"
#include "UIXmlInit.h"

#include "../map_manager.h"
#include "UIInventoryUtilities.h"
#include "../map_location.h"

#include "UIScrollBar.h"
#include "UIFrameWindow.h"
#include "UIFrameLineWnd.h"
#include "UITabControl.h"
#include "UI3tButton.h"
#include "UIMapWndActions.h"
#include "UIMapWndActionsSpace.h"
#include "map_hint.h"

#include "../HUDManager.h"

#include <dinput.h>				//remove me !!!
#include "../../xr_input.h"		//remove me !!!

const int SCROLLBARS_SHIFT = 5;
const int VSCROLLBAR_STEP = 20; // В пикселях
const int HSCROLLBAR_STEP = 20; // В пикселях

static bool MAP_FLY_MODE = true;

const u32 local_map_passive_color = color_rgba(0,0,255,255);
const u32 local_map_active_color = color_rgba(255,0,0,255);


CUIMapWnd::CUIMapWnd() {
	m_tgtMap = NULL;
	m_GlobalMap = NULL;
	m_flags.zero();
	m_currentZoom = 1.0f;
	m_hint = NULL;
//.	m_selected_location = NULL;
	m_text_hint = NULL;
	m_selected_map = NULL;
	m_select_local_map = false;
}

CUIMapWnd::~CUIMapWnd() {
	delete_data(m_ActionPlanner);
	delete_data(m_GameMaps);
	delete_data(m_hint);
	delete_data(m_text_hint);
}


void CUIMapWnd::Init(LPCSTR xml_name, LPCSTR start_from) {
	CUIXml uiXml;
	const bool xml_result = uiXml.Init(CONFIG_PATH, UI_PATH, xml_name);
	R_ASSERT3(xml_result, "xml file not found", xml_name);

	string512 pth;
	// load map background
	CUIXmlInit xml_init;
	strconcat(sizeof(pth),pth,start_from,":main_wnd");
	xml_init.InitWindow(uiXml, pth, 0, this);



	m_UIMainFrame = xr_new<CUIFrameWindow>();
	m_UIMainFrame->SetAutoDelete(true);
	AttachChild(m_UIMainFrame);
	strconcat(sizeof(pth),pth,start_from,":main_wnd:main_map_frame");
	xml_init.InitFrameWindow(uiXml, pth, 0, m_UIMainFrame);

	m_UILevelFrame = xr_new<CUIWindow>();
	m_UILevelFrame->SetAutoDelete(true);
	strconcat(sizeof(pth),pth,start_from,":main_wnd:main_map_frame:level_frame");
	xml_init.InitWindow(uiXml, pth, 0, m_UILevelFrame);
	m_UIMainFrame->AttachChild(m_UILevelFrame);

	const Frect r = m_UILevelFrame->GetWndRect();

	m_UIMainScrollV = xr_new<CUIScrollBar>(); m_UIMainScrollV->SetAutoDelete(true);
	m_UIMainScrollV->Init(r.right + SCROLLBARS_SHIFT, r.top, r.bottom+SCROLLBARS_SHIFT - r.top , false, "pda");
	m_UIMainScrollV->SetWindowName("scroll_v");
	m_UIMainScrollV->SetStepSize(_max(1,iFloor(m_UILevelFrame->GetHeight()/10)));
	m_UIMainScrollV->SetPageSize(iFloor(m_UILevelFrame->GetHeight()));
	m_UIMainFrame->AttachChild(m_UIMainScrollV);
	Register(m_UIMainScrollV);
	AddCallback("scroll_v",SCROLLBAR_VSCROLL,CUIWndCallback::void_function(this,&CUIMapWnd::OnScrollV));

	UIMainMapHeader = xr_new<CUIFrameLineWnd>(); UIMainMapHeader->SetAutoDelete(true);
	m_UIMainFrame->AttachChild(UIMainMapHeader);
	strconcat(sizeof(pth),pth,start_from,":main_wnd:map_header_frame_line");
	xml_init.InitFrameLine(uiXml, pth, 0, UIMainMapHeader);

	ZeroMemory(m_ToolBar,sizeof(m_ToolBar));
	xr_string sToolbar;
	sToolbar = xr_string(start_from) + ":main_wnd:map_header_frame_line:tool_bar";

	EMapToolBtn btnIndex;
	btnIndex = eGlobalMap;
	strconcat(sizeof(pth),pth, sToolbar.c_str(), ":global_map_btn");
	if(uiXml.NavigateToNode(pth,0)){
		m_ToolBar[btnIndex] = xr_new<CUI3tButton>();
		m_ToolBar[btnIndex]->SetAutoDelete(true);
		xml_init.Init3tButton(uiXml, pth, 0, m_ToolBar[btnIndex]);
		UIMainMapHeader->AttachChild(m_ToolBar[btnIndex]);
		Register(m_ToolBar[btnIndex]);
		AddCallback(*m_ToolBar[btnIndex]->WindowName(),BUTTON_CLICKED,CUIWndCallback::void_function(this,&CUIMapWnd::OnToolGlobalMapClicked));
	}

	m_text_hint = xr_new<CUIStatic>();
	strconcat(sizeof(pth),pth,start_from,":main_wnd:text_hint");
	xml_init.InitStatic(uiXml, pth, 0, m_text_hint);

	m_hint = xr_new<CUIMapHint>();
	m_hint->Init();
	m_hint->SetAutoDelete(false);

// Load maps

	CInifile& gameLtx = *pGameIni;

	m_GlobalMap = xr_new<CUIGlobalMap>(this);
	m_GlobalMap->SetAutoDelete(true);
	m_GlobalMap->Init("global_map",gameLtx,"hud\\default");

	m_UILevelFrame->AttachChild(m_GlobalMap);
	m_GlobalMap->OptimalFit(m_UILevelFrame->GetWndRect());
	m_GlobalMap->SetMinZoom(m_GlobalMap->GetCurrentZoom());
	m_currentZoom = m_GlobalMap->GetCurrentZoom();

	// initialize local maps
	LPCSTR sect_name = (IsGameTypeSingle())?"level_maps_single":"level_maps_mp";
	
	if (gameLtx.section_exist(sect_name)){
		CInifile::Sect& S = gameLtx.r_section(sect_name);
		CInifile::SectCIt it = S.Data.begin(), end = S.Data.end();
		for (;it!=end; it++){
			shared_str map_name = it->first;
			xr_strlwr(map_name);
			R_ASSERT2(m_GameMaps.end() == m_GameMaps.find(map_name), "Duplicate level name not allowed");
			
			CUICustomMap*& l = m_GameMaps[map_name];

			l = xr_new<CUILevelMap>(this);
			
			l->Init(map_name, gameLtx, "hud\\default");

			l->OptimalFit( m_UILevelFrame->GetWndRect() );
		}
	}
#ifdef DEBUG
	GameMaps::iterator it = m_GameMaps.begin();
	GameMaps::iterator it2;
	for(;it!=m_GameMaps.end();++it){
		CUILevelMap* l = smart_cast<CUILevelMap*>(it->second);VERIFY(l);
		for(it2=it; it2!=m_GameMaps.end();++it2){
			if(it==it2) continue;
			CUILevelMap* l2 = smart_cast<CUILevelMap*>(it2->second);VERIFY(l2);
			if(l->GlobalRect().intersected(l2->GlobalRect())){
				Msg(" --error-incorrect map definition global rect of map [%s] intersects with [%s]", *l->MapName(), *l2->MapName());
			}
		}
		if(FALSE == l->GlobalRect().intersected(GlobalMap()->BoundRect())){
			Msg(" --error-incorrect map definition map [%s] places outside global map", *l->MapName());
		}

	}
#endif

	Register(m_GlobalMap);
	m_ActionPlanner = xr_new<CMapActionPlanner>();
	m_ActionPlanner->setup(this);
	m_flags.set(lmFirst,TRUE);
}

void CUIMapWnd::Show(bool status) {
	inherited::Show(status);
	if (status) {
		m_GlobalMap->Show(true);
		m_GlobalMap->SetClipRect(ActiveMapRect());
		GameMaps::iterator it = m_GameMaps.begin();
		for(;it!=m_GameMaps.end();++it){
			m_GlobalMap->AttachChild(it->second);
			it->second->Show(true);
			it->second->SetClipRect(ActiveMapRect());
		}
		
		if (m_flags.test(lmFirst)) {
			inherited::Update();// only maps, not action planner
			OnToolGlobalMapClicked(NULL,NULL);
			m_flags.set(lmFirst,FALSE);
		}
		
		InventoryUtilities::SendInfoToActor("ui_pda_map_local");
	}
	else {
		if(GlobalMap()) {
			GlobalMap()->DetachAll();
			GlobalMap()->Show(false);
		}
		GameMaps::iterator	it = m_GameMaps.begin();
		for(;it!=m_GameMaps.end();++it) {
			it->second->DetachAll();
		}
	}

	m_hint->SetOwner(NULL);
}


void CUIMapWnd::AddMapToRender(CUICustomMap* m) {
	Register( m );
	m_UILevelFrame->AttachChild( m );
	m->Show( true );
	m_UILevelFrame->BringToTop( m );
	m->SetClipRect( ActiveMapRect() );
}

void CUIMapWnd::RemoveMapToRender(CUICustomMap* m) {
	if( m!=GlobalMap() ) {
		m_UILevelFrame->DetachChild(smart_cast<CUIWindow*>(m));
	}
}

void CUIMapWnd::SetTargetMap(const shared_str& name, const Fvector2& pos, bool bZoomIn, bool bMaxZoom) {
	u16	idx = GetIdxByName(name);
	if (idx!=u16(-1)) {
		CUICustomMap* lm = GetMapByIdx(idx);
		SetTargetMap(lm, pos, bZoomIn, bMaxZoom);
	}
}

void CUIMapWnd::SetTargetMap(const shared_str& name, bool bZoomIn, bool bMaxZoom) {
	u16	idx = GetIdxByName(name);
	if (idx!=u16(-1)) {
		CUICustomMap* lm = GetMapByIdx(idx);
		SetTargetMap(lm, bZoomIn, bMaxZoom);
	}
}

void CUIMapWnd::SetTargetMap(CUICustomMap* m, bool bZoomIn, bool bMaxZoom) {
	m_tgtMap = m;
	Fvector2 pos;
	Frect r = m->BoundRect();
	r.getcenter(pos);
	SetTargetMap(m, pos, bZoomIn, bMaxZoom);
}

//Получить значение зума, необходимое для приближения(По размерам локальной и глобальной карты)
static float GetZoomByRect(const Frect value, const Frect offset) {
	const float dist_1 = value.width();
	const float dist_offset_1 = offset.width();
	if (dist_1!=0.f) return _abs(dist_offset_1 / dist_1);
	return 1.f;
}

void CUIMapWnd::SetTargetMap(CUICustomMap* m, const Fvector2& pos, bool bZoomIn, bool bMaxZoom) {
	m_tgtMap = m;

	if(m==GlobalMap()){
		CUIGlobalMap* gm = GlobalMap();
		SetZoom(gm->GetMinZoom());
		Frect vis_rect = ActiveMapRect		();
		vis_rect.getcenter(m_tgtCenter);
		
		Fvector2 _p;
		gm->GetAbsolutePos(_p);
		
		m_tgtCenter.sub(_p);
		m_tgtCenter.div(gm->GetCurrentZoom());
 	}
	else {
		if (bZoomIn && fsimilar(GlobalMap()->GetCurrentZoom(), GlobalMap()->GetMinZoom(),EPS_L )) {
			float Zoom = 1.f;
			if (bMaxZoom) {
				Zoom = GlobalMap()->GetMaxZoom();
			}
			else {
				CInifile& gameLtx = *pGameIni;
				static const float zoom_sub_in_click = gameLtx.r_float("global_map","zoom_sub_in_click");
				Frect r, r2;
				m->GetAbsoluteRect(r);
				GlobalMap()->GetAbsoluteRect(r2);
				UI()->ClientToScreenScaled(r.lt, r.lt.x, r.lt.y);
				UI()->ClientToScreenScaled(r.rb, r.rb.x, r.rb.y);
				//UI()->ClientToScreenScaled(r2.lt, r2.lt.x, r2.lt.y);
				//UI()->ClientToScreenScaled(r2.rb, r2.rb.x, r2.rb.y);

				Zoom = GetZoomByRect(r, r2);
				
				Zoom -= zoom_sub_in_click;
				if (Zoom < 1.f) Zoom += 1.f;
			}
			SetZoom(Zoom);
		}

		m_tgtCenter = m->ConvertRealToLocalNoTransform(pos);
		m_tgtCenter.add(m->GetWndPos()).div(GlobalMap()->GetCurrentZoom());
	}
	ResetActionPlanner();
}

extern void add_rect_to_draw(Frect r, u32 c, Frect b);
extern void draw_wnds_rects();

void CUIMapWnd::Draw() {
	
	inherited::Draw();
	m_text_hint->Draw();
	if(m_hint->GetOwner()) {
		m_hint->Draw_();
	}
	
	if (!(m_tgtMap && m_tgtMap->MapName()!=GlobalMap()->MapName())) {
		GameMapsPairIt it = m_GameMaps.begin();
		GameMapsPairIt end = m_GameMaps.end();
		for ( ; it!=end;++it) {
			if (it->second) {
				Frect pRect, pBoundRect;
				m_UILevelFrame->GetAbsoluteRect(pBoundRect);
				(it->second)->GetAbsoluteRect(pRect);
				if (GetSelectedMap() == it->second) {
					add_rect_to_draw(pRect, local_map_active_color, pBoundRect);
				}
				else {
					add_rect_to_draw(pRect, local_map_passive_color, pBoundRect);
				}
			}
		}
		draw_wnds_rects();
	}
}

bool CUIMapWnd::OnMouse(float x, float y, EUIMessages mouse_action) {
	if(inherited::OnMouse(x,y,mouse_action)) return true;
	Fvector2 cursor_pos = GetUICursor()->GetCursorPosition();

	if (GlobalMap() && !GlobalMap()->Locked() && ActiveMapRect().in( cursor_pos ) ){
		switch (mouse_action) {
			case WINDOW_MOUSE_MOVE: {
				if (pInput->iGetAsyncBtnState(0)){
					const float dt_y = GetUICursor()->GetCursorPositionDelta().y;
					if (GetMovingState(dt_y) == false) return false;
					Fvector2 pos_delta;
					pos_delta.set(0.f, dt_y);
					GlobalMap()->MoveWndDelta(pos_delta);
					UpdateScroll();
					m_hint->SetOwner(NULL);
					return true;
				}
			} break;
		}	
	};
	
	if (mouse_action == WINDOW_LBUTTON_DOWN) {
		if (GetSelectedMap()) {
			
			m_select_local_map = true;
			//m_UIMainScrollV->Enable(false);
			SetTargetMap(GetSelectedMap(), true, false);
		}
		return true;
	}

	if (((mouse_action==WINDOW_MOUSE_WHEEL_DOWN) ||
	(mouse_action==WINDOW_MOUSE_WHEEL_UP)	
	)) {
		const bool b_zoom_in = (mouse_action==WINDOW_MOUSE_WHEEL_DOWN);

		CUIGlobalMap* gm = GlobalMap();

		Fvector2 pos_delta;
		const float fDelta = static_cast<float>((b_zoom_in)?(-VSCROLLBAR_STEP):VSCROLLBAR_STEP);

		if (GetMovingState(fDelta)) {
			pos_delta.set(0.0f, fDelta);
			gm->MoveWndDelta(pos_delta);
			UpdateScroll();
			m_hint->SetOwner(NULL);
		}
		
		return true;
	}


	return false;
}

void CUIMapWnd::SendMessage(CUIWindow* pWnd, s16 msg, void* pData) {
	CUIWndCallback::OnEvent(pWnd, msg, pData);
}

CUICustomMap* CUIMapWnd::GetMapByIdx(u16 idx) {
	VERIFY(idx!=u16(-1));
	GameMapsPairIt it = m_GameMaps.begin();
	std::advance(it, idx);
	return it->second;
}

u16 CUIMapWnd::GetIdxByName(const shared_str& map_name) {
	GameMapsPairIt it = m_GameMaps.find(map_name);
	if(it==m_GameMaps.end()) {	
		Msg("~ Level Map '%s' not registered",map_name.c_str());
		return u16(-1);
	}
	return (u16)std::distance(m_GameMaps.begin(),it);
}

void CUIMapWnd::UpdateScroll() {
	const Fvector2 w_pos = GlobalMap()->GetWndPos();
	m_UIMainScrollV->SetRange(0,iFloor(GlobalMap()->GetHeight()));
	m_UIMainScrollV->SetScrollPos(iFloor(-w_pos.y));
}


// Разрешено ли прокручивать карту вверх, или вниз(не уперся в конец)
bool CUIMapWnd::GetMovingState(const float dt_y) const {
	if (m_select_local_map) {
		CInifile& gameLtx = *pGameIni;
		static const float local_map_max_top = gameLtx.r_float("global_map","local_map_max_top");
		static const float local_map_max_bottom = gameLtx.r_float("global_map","local_map_max_bottom");
		Frect r;
		m_tgtMap->GetAbsoluteRect(r);
		UI()->ClientToScreenScaled(r.lt, r.lt.x, r.lt.y);
		UI()->ClientToScreenScaled(r.rb, r.rb.x, r.rb.y);
		
		if (r.top >= local_map_max_top && dt_y >= 0) return false;
		if (r.bottom <= local_map_max_bottom && dt_y < 0) return false;
	}
	return true;
}

void CUIMapWnd::OnScrollV(CUIWindow*, void*) {
	if (GlobalMap()) {
		const int iSPos = m_UIMainScrollV->GetScrollPos();
		const float fSPos = static_cast<float>(-iSPos);
		const Fvector2 w_pos = GlobalMap()->GetWndPos();
		const float delta_pos = fSPos - w_pos.y;
		if (GetMovingState(delta_pos)) {
			GlobalMap()->SetWndPos(w_pos.x,fSPos);
		}
		else {
			m_UIMainScrollV->SetScrollPos(static_cast<int>(-w_pos.y));
		}
	}
}


void CUIMapWnd::Update() {
	if (m_GlobalMap) {
		m_GlobalMap->SetClipRect(ActiveMapRect());
	}
	inherited::Update();
	m_ActionPlanner->update();
}

void CUIMapWnd::SetZoom	( float value) {
//	float _prev_zoom = m_currentZoom;
	m_currentZoom = value;
	//clamp(m_currentZoom, GlobalMap()->GetMinZoom(), GlobalMap()->GetMaxZoom());
}



void CUIMapWnd::OnToolGlobalMapClicked(CUIWindow* w, void*) {
	if (GlobalMap()->Locked()) return;
	SetTargetMap(GlobalMap());
	m_select_local_map = false;
	//m_UIMainScrollV->Enable(true);
}


void CUIMapWnd::ResetActionPlanner() {
	if (MAP_FLY_MODE) {
		m_ActionPlanner->m_storage.set_property(1,false);
		m_ActionPlanner->m_storage.set_property(2,false);
		m_ActionPlanner->m_storage.set_property(3,false);
	}else{
		Frect m_desiredMapRect;
		GlobalMap()->CalcOpenRect(m_tgtCenter,m_desiredMapRect,GetZoom());
		GlobalMap()->SetWndRect(m_desiredMapRect);
		UpdateScroll();
		
	}
}

void CUIMapWnd::ValidateToolBar() {

}

inline bool is_in(const Frect& b1, const Frect& b2) {
	return (b1.x1<b2.x1)&&(b1.x2>b2.x2)&&(b1.y1<b2.y1)&&(b1.y2>b2.y2);
}

void CUIMapWnd::ShowHint(CUIWindow* parent, LPCSTR text) {
	if(m_hint->GetOwner()) return;
	if(!text) return;
	Fvector2 c_pos = GetUICursor()->GetCursorPosition();
	const Frect vis_rect = ActiveMapRect();
	if(FALSE==vis_rect.in(c_pos)) return;

	m_hint->SetOwner(parent);
	m_hint->SetText(text);

	//select appropriate position
	Frect r;
	r.set(0.0f, 0.0f, m_hint->GetWidth(), m_hint->GetHeight());
	r.add(c_pos.x, c_pos.y);

	r.sub(0.0f,r.height());
	if (false==is_in(vis_rect,r)) {
		r.sub(r.width(),0.0f);
	}
	if (false==is_in(vis_rect,r)) {
		r.add(0.0f,r.height());
	}
	if (false==is_in(vis_rect,r)) {
		r.add(r.width(), 45.0f);
	}

	m_hint->SetWndPos(r.lt);
}

void CUIMapWnd::HideHint(CUIWindow* parent) {
	if(m_hint->GetOwner() == parent) {
		m_hint->SetOwner(NULL);
	}
}

void CUIMapWnd::Hint(const shared_str& text) {
	m_text_hint->SetTextST(*text);
}

void CUIMapWnd::Reset() {
	inherited::Reset();
	ResetActionPlanner();
}

