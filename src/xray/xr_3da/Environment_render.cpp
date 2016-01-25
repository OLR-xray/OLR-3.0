#include "stdafx.h"
#pragma hdrstop

#include "Environment.h"
#ifndef _EDITOR
    #include "render.h"
#endif
#include "xr_efflensflare.h"
#include "rain.h"
#include "thunderbolt.h"

#ifndef _EDITOR
#	include "igame_level.h"
#endif

//////////////////////////////////////////////////////////////////////////
// half box def
static	Fvector3	hbox_verts[sky_ver_count]	=
{
	{-1.f,	-1.f,	-1.f}, {-1.f,	-1.01f,	-1.f},	// down
	{ 1.f,	-1.f,	-1.f}, { 1.f,	-1.01f,	-1.f},	// down
	{-1.f,	-1.f,	 1.f}, {-1.f,	-1.01f,	 1.f},	// down
	{ 1.f,	-1.f,	 1.f}, { 1.f,	-1.01f,	 1.f},	// down
	{-1.f,	 1.f,	-1.f}, {-1.f,	 1.f,	-1.f},
	{ 1.f,	 1.f,	-1.f}, { 1.f,	 1.f,	-1.f},
	{-1.f,	 1.f,	 1.f}, {-1.f,	 1.f,	 1.f},
	{ 1.f,	 1.f,	 1.f}, { 1.f,	 1.f,	 1.f},
	{-1.f,	 0.f,	-1.f}, {-1.f,	-1.f,	-1.f},	// half
	{ 1.f,	 0.f,	-1.f}, { 1.f,	-1.f,	-1.f},	// half
	{ 1.f,	 0.f,	 1.f}, { 1.f,	-1.f,	 1.f},	// half
	{-1.f,	 0.f,	 1.f}, {-1.f,	-1.f,	 1.f}	// half
};
static	u16			hbox_faces[sky_fac_count]	=
{
	0,	 2,	 3,
	3,	 1,	 0,
	4,	 5,	 7,
	7,	 6,	 4,
	0,	 1,	 9,
	9,	 8,	 0,
	8,	 9,	 5,
	5,	 4,	 8,
	1,	 3,	10,
	10,	 9,	 1,
	9,	10,	 7,
	7,	 5,	 9,
	3,	 2,	11,
	11,	10,	 3,
	10,	11,	 6,
	6,	 7,	10,
	2,	 0,	 8,
	8,	11,	 2,
	11,	 8,	 4,
	4,	 6,	11
};

#pragma pack(push,1)
struct v_skybox				{
	Fvector3	p;
	u32			color;
	Fvector3	uv	[2];

	void		set			(const Fvector3 _p, const u32 _c, const Fvector3 _tc) {
		p					= _p;
		color				= _c;
		uv[0]				= _tc;
		uv[1]				= _tc;
	}
};
const	u32 v_skybox_fvf	= D3DFVF_XYZ | D3DFVF_DIFFUSE | D3DFVF_TEX2 | D3DFVF_TEXCOORDSIZE3(0) | D3DFVF_TEXCOORDSIZE3(1);
const u32 v_background_fvf = v_skybox_fvf;
struct v_clouds				{
	Fvector3	p;
	u32			color;
	u32			intensity;
	void		set			(Fvector3& _p, u32 _c, u32 _i) {
		p					= _p;
		color				= _c;
		intensity			= _i;
	}
};
const	u32 v_clouds_fvf	= D3DFVF_XYZ | D3DFVF_DIFFUSE | D3DFVF_SPECULAR;
#pragma pack(pop)

//-----------------------------------------------------------------------------
// Environment render
//-----------------------------------------------------------------------------
extern float psHUD_FOV;
BOOL bNeed_re_create_env = FALSE;
void CEnvironment::RenderSky		() {
{
#ifndef _EDITOR
	if (0==g_pGameLevel)		return	;
#endif
	// clouds_sh.create		("clouds","null");
	//. this is the bug-fix for the case when the sky is broken
	//. for some unknown reason the geoms happen to be invalid sometimes
	//. if vTune show this in profile, please add simple cache (move-to-forward last found) 
	//. to the following functions:
	//.		CResourceManager::_CreateDecl
	//.		CResourceManager::CreateGeom
	if(bNeed_re_create_env)
	{
		sh_2sky.create			(&m_b_skybox,"skybox_2t");
		sh_2geom.create			(v_skybox_fvf,RCache.Vertex.Buffer(), RCache.Index.Buffer());
		clouds_sh.create		("clouds","null");
		clouds_geom.create		(v_clouds_fvf,RCache.Vertex.Buffer(), RCache.Index.Buffer());

		if (m_background_loaded) {
			sh_2background.create(
				background_shader_name.c_str(), "null"
			);
			background_geom.create(
				v_background_fvf,
				RCache.Vertex.Buffer(),
				RCache.Index.Buffer()
			);
		}
		
		bNeed_re_create_env		= FALSE;
	}
	::Render->rmFar				();

	// draw sky box
	Fmatrix						mSky;
	mSky.rotateY				(CurrentEnv.sky_rotation);
	mSky.translate_over			(Device.vCameraPosition);

	u32		i_offset,v_offset;
	u32		C					= color_rgba(iFloor(CurrentEnv.sky_color.x*255.f), iFloor(CurrentEnv.sky_color.y*255.f), iFloor(CurrentEnv.sky_color.z*255.f), iFloor(CurrentEnv.weight*255.f));

	// Fill index buffer
	u16*	pib					= RCache.Index.Lock	(20*3,i_offset);
	CopyMemory					(pib,hbox_faces,20*3*2);
	RCache.Index.Unlock			(20*3);

	// Fill vertex buffer
	v_skybox* pv				= (v_skybox*)	RCache.Vertex.Lock	(12,sh_2geom.stride(),v_offset);
	for (u32 v=0; v<12; v++)	pv[v].set		(hbox_verts[v*2],C,hbox_verts[v*2+1]);
	RCache.Vertex.Unlock		(12,sh_2geom.stride());

	// Render
	RCache.set_xform_world		(mSky);
	RCache.set_Geometry			(sh_2geom);
	RCache.set_Shader			(sh_2sky);
	RCache.set_Textures			(&CurrentEnv.sky_r_textures);
	RCache.Render				(D3DPT_TRIANGLELIST,v_offset,0,12,i_offset,20);

	// Sun
	::Render->rmNormal			();
	eff_LensFlare->Render(TRUE,FALSE,FALSE);
	}
	
	if (m_background_loaded) {
#ifndef _EDITOR
	if (0==g_pGameLevel)		return	;
#endif

	::Render->rmFar				();

	// draw sky box
	Fmatrix						mSky;
	mSky.translate_over			(Device.vCameraPosition);

	u32		i_offset,v_offset;
	const u32 C = color_rgba(iFloor(CurrentEnv.sky_color.x*255.f), iFloor(CurrentEnv.sky_color.y*255.f), iFloor(CurrentEnv.sky_color.z*255.f), iFloor(CurrentEnv.weight*255.f));

	// Fill index buffer
	u16* pib = RCache.Index.Lock	(20*3,i_offset);
	CopyMemory(pib,hbox_faces,20*3*2);
	RCache.Index.Unlock(20*3);

	// Fill vertex buffer
	v_skybox* pv = (v_skybox*) RCache.Vertex.Lock(12,background_geom.stride(),v_offset);
	for (u32 v=0; v<12; v++) {
		const float pAddY = GetAddY();
		const Fvector3 A = {
			hbox_verts[v*2].x,
			hbox_verts[v*2].y + pAddY,
			hbox_verts[v*2].z
		};
		const Fvector3 B = {
			hbox_verts[v*2+1].x,
			hbox_verts[v*2+1].y + pAddY,
			hbox_verts[v*2+1].z
		};
		pv[v].set(A,C,B);
	}
	RCache.Vertex.Unlock(12,background_geom.stride());

	// Render
	RCache.set_xform_world		(mSky);
	RCache.set_Geometry			(background_geom);
	RCache.set_Shader			(sh_2background);
	RCache.set_Textures			(&CurrentEnv.background_r_textures);
	RCache.Render				(D3DPT_TRIANGLELIST,v_offset,0,12,i_offset,20);
	
	// Sun
	::Render->rmNormal			();
	}
	
	//this->RenderBackground();
	
}

void CEnvironment::RenderClouds			()
{
#ifndef _EDITOR
	if (0==g_pGameLevel)		return	;
#endif

	// draw clouds
	if (fis_zero(CurrentEnv.clouds_color.w,EPS_L))	return;

	::Render->rmFar				();

	Fmatrix						mXFORM, mScale;
	mScale.scale				(10,0.4f,10);
	mXFORM.rotateY				(CurrentEnv.sky_rotation);
	mXFORM.mulB_43				(mScale);
	mXFORM.translate_over		(Device.vCameraPosition);

	Fvector wd0,wd1;
	Fvector4 wind_dir;
	wd0.setHP					(PI_DIV_4,0);
	wd1.setHP					(PI_DIV_4+PI_DIV_8,0);
	wind_dir.set				(wd0.x,wd0.z,wd1.x,wd1.z).mul(0.5f).add(0.5f).mul(255.f);
	u32		i_offset,v_offset;
	u32		C0					= color_rgba(iFloor(wind_dir.x),iFloor(wind_dir.y),iFloor(wind_dir.w),iFloor(wind_dir.z));
	u32		C1					= color_rgba(iFloor(CurrentEnv.clouds_color.x*255.f),iFloor(CurrentEnv.clouds_color.y*255.f),iFloor(CurrentEnv.clouds_color.z*255.f),iFloor(CurrentEnv.clouds_color.w*255.f));

	// Fill index buffer
	u16*	pib					= RCache.Index.Lock	(CloudsIndices.size(),i_offset);
	CopyMemory					(pib,&CloudsIndices.front(),CloudsIndices.size()*sizeof(u16));
	RCache.Index.Unlock			(CloudsIndices.size());

	// Fill vertex buffer
	v_clouds* pv				= (v_clouds*)	RCache.Vertex.Lock	(CloudsVerts.size(),clouds_geom.stride(),v_offset);
	for (FvectorIt it=CloudsVerts.begin(); it!=CloudsVerts.end(); it++,pv++)
		pv->set					(*it,C0,C1);
	RCache.Vertex.Unlock		(CloudsVerts.size(),clouds_geom.stride());

	// Render
	RCache.set_xform_world		(mXFORM);
	RCache.set_Geometry			(clouds_geom);
	RCache.set_Shader			(clouds_sh);
	RCache.set_Textures			(&CurrentEnv.clouds_r_textures);
	RCache.Render				(D3DPT_TRIANGLELIST,v_offset,0,CloudsVerts.size(),i_offset,CloudsIndices.size()/3);

	::Render->rmNormal			();
	
}

void CEnvironment::RenderFlares		()
{
#ifndef _EDITOR
	if (0==g_pGameLevel)			return	;
#endif
	// 1
	eff_LensFlare->Render			(FALSE,TRUE,TRUE);
}

void CEnvironment::RenderLast		()
{
#ifndef _EDITOR
	if (0==g_pGameLevel)			return	;
#endif
	// 2
	eff_Rain->Render				();
	eff_Thunderbolt->Render			();
}

void CEnvironment::BackgroundTextureLoad() {

	R_ASSERT (g_pGameLevel) ;
	R_ASSERT (g_pGameLevel->pLevel) ;
	
	if (g_pGameLevel->pLevel->section_exist("background_texture")) {
		LPCSTR shader_line = (::Render->get_generation()==IRender_interface::GENERATION_R2)?"shader_r2":"shader";
		background_texture_name = g_pGameLevel->pLevel->r_string("background_texture", "name");
		background_texture_empty_name = g_pGameLevel->pLevel->r_string("background_texture", "name_empty");
		background_texture.create(background_texture_name.c_str());
		background_empty_texture.create(background_texture_empty_name.c_str());
		background_shader_name = g_pGameLevel->pLevel->r_string("background_texture", shader_line);
		
		m_background_min_y = READ_IF_EXISTS(g_pGameLevel->pLevel, r_float, "background_texture", "min_y", 0.f);
		m_background_max_y = READ_IF_EXISTS(g_pGameLevel->pLevel, r_float, "background_texture", "max_y", 0.f);
		
		m_background_min_cam_y = READ_IF_EXISTS(g_pGameLevel->pLevel, r_float, "background_texture", "min_cam_y", 0.f);
		m_background_max_cam_y = READ_IF_EXISTS(g_pGameLevel->pLevel, r_float, "background_texture", "max_cam_y", 0.f);
		
		m_background_loaded = true;
		
	}
	else {
		m_background_loaded = false;
	}
	
}

void CEnvironment::BackgroundTextureDestroy() {
	if (m_background_loaded) {
		background_texture.destroy			();
		background_empty_texture.destroy			();
		m_background_loaded = false;
	}
}

void CEnvironment::OnDeviceCreate()
{
//.	bNeed_re_create_env			= TRUE;

	sh_2sky.create			(&m_b_skybox,"skybox_2t");
	sh_2geom.create			(v_skybox_fvf,RCache.Vertex.Buffer(), RCache.Index.Buffer());
	clouds_sh.create		("clouds","null");
	clouds_geom.create		(v_clouds_fvf,RCache.Vertex.Buffer(), RCache.Index.Buffer());

	// weathers
	{
		EnvsMapIt _I,_E;
		_I		= WeatherCycles.begin();
		_E		= WeatherCycles.end();
		for (; _I!=_E; _I++)
			for (EnvIt it=_I->second.begin(); it!=_I->second.end(); it++)
				(*it)->on_device_create();
	}
	// effects
	{
		EnvsMapIt _I,_E;
		_I		= WeatherFXs.begin();
		_E		= WeatherFXs.end();
		for (; _I!=_E; _I++)
			for (EnvIt it=_I->second.begin(); it!=_I->second.end(); it++)
				(*it)->on_device_create();
	}


	Invalidate	();
	OnFrame		();
}

void CEnvironment::OnDeviceDestroy()
{
	tsky0->surface_set						(NULL);
	tsky1->surface_set						(NULL);
	
	sh_2sky.destroy							();
	sh_2geom.destroy						();
	
	sh_2background.destroy							();
	background_geom.destroy						();
	
	clouds_sh.destroy						();
	clouds_geom.destroy						();
	// weathers
	{
		EnvsMapIt _I,_E;
		_I		= WeatherCycles.begin();
		_E		= WeatherCycles.end();
		for (; _I!=_E; _I++)
			for (EnvIt it=_I->second.begin(); it!=_I->second.end(); it++)
				(*it)->on_device_destroy();
	}
	// effects
	{
		EnvsMapIt _I,_E;
		_I		= WeatherFXs.begin();
		_E		= WeatherFXs.end();
		for (; _I!=_E; _I++)
			for (EnvIt it=_I->second.begin(); it!=_I->second.end(); it++)
				(*it)->on_device_destroy();
	}
	
	CurrentEnv.destroy();
	

}

#ifdef _EDITOR
void CEnvironment::ED_Reload()
{
	OnDeviceDestroy			();
	OnDeviceCreate			();
}
#endif

