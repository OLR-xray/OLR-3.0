#pragma once


#include "ui/UIStatic.h"

class CActor;
class CUICustomMap;
//////////////////////////////////////////////////////////////////////////
const float pUpdateZoomFactorByClick = 0.2;
const float pMaxZoomFactor = 2.0;
const float pMinZoomFactor = 0.5;

class CUIZoneMap {
	CUICustomMap*				m_activeMap;
	float						m_fScale;

	CUIStatic					m_background;
	CUIStatic					m_center;
	CUIStatic					m_compass;
	CUIStatic					m_clipFrame;
	CUIStatic					m_pointerDistanceText;
	
	float						m_fZoomFactor;

public:
								CUIZoneMap		();
	virtual						~CUIZoneMap		();

	void						SetHeading		(float angle);
	void						Init			();

	void						Render			();
	void						UpdateRadar		(Fvector pos);

	void						SetScale		(float s)							{m_fScale = s;}
	float						GetScale		() const {
		return m_fScale;
	}

	bool						ZoomIn			();
	bool						ZoomOut			();


	CUIStatic&					Background		()  {
		return m_background;
	};
	CUIStatic&					ClipFrame		()  {
		return m_clipFrame;
	}; // alpet: для экспорта в скрипты
	CUIStatic&					Compass			()  {
		return m_compass;
	}; // alpet: для экспорта в скрипты

	void						SetupCurrentMap	();
	
	void						SetZoomFactor(float value);
	float						GetZoomFactor() const {
		return m_fZoomFactor;
	}
	
	void						IncZoom() {
		SetZoomFactor(GetZoomFactor()+pUpdateZoomFactorByClick);
	}
	void						DecZoom() {
		SetZoomFactor(GetZoomFactor()-pUpdateZoomFactorByClick);
	}
	
	void						load(IReader &input_packet);
	void						save(NET_Packet &output_packet);
};

