// IRender_Visual.cpp: implementation of the IRender_Visual class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#pragma hdrstop

#ifndef _EDITOR
    #include "render.h"
#endif    
#include "fbasicvisual.h"
#include "fmesh.h"
#include "FHierrarhyVisual.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

IRender_Mesh::~IRender_Mesh()		
{ 
	_RELEASE(p_rm_Vertices); 
	_RELEASE(p_rm_Indices);		
}

IRender_Visual::IRender_Visual		()
{
	Type				= 0;
	shader_ref			= 0;
	vis.clear			();
	shader_name			= 0;
	textures			= 0;
}

IRender_Visual::~IRender_Visual		()
{
}

void IRender_Visual::Release		()
{
}

CStatTimer						tscreate;

void IRender_Visual::Load		(const char* N, IReader *data, u32 )
{
#ifdef DEBUG
	dbg_name	= N;
#endif	

	// header
	VERIFY		(data);
	ogf_header	hdr;
	if (data->r_chunk_safe(OGF_HEADER,&hdr,sizeof(hdr)))
	{
		R_ASSERT2			(hdr.format_version==xrOGF_FormatVersion, "Invalid visual version");
		Type				= hdr.type;
		if (hdr.shader_id)	shader_ref	= ::Render->getShader	(hdr.shader_id);
		vis.box.set			(hdr.bb.min,hdr.bb.max	);
		vis.sphere.set		(hdr.bs.c,	hdr.bs.r	);
	} else {
		FATAL				("Invalid visual");
	}

	// Shader
	if (data->find_chunk(OGF_TEXTURE)) {
		LPCSTR gsn = ::Render->getShaderFromModel();
		string256		fnT,fnS;
		data->r_stringZ	(fnT,sizeof(fnT));
		data->r_stringZ	(fnS,sizeof(fnS));
		if (gsn != NULL) {
			shader_ref.create	(gsn,fnT);
			shader_name = gsn;
		}
		else {
			shader_ref.create	(fnS,fnT);
			shader_name = fnS;
		}
		textures = fnT;
	}

    // desc
#ifdef _EDITOR
    if (data->find_chunk(OGF_S_DESC)) 
	    desc.Load		(*data);
#endif
}

#define PCOPY(a)	a = pFrom->a
void	IRender_Visual::Copy(IRender_Visual *pFrom)
{
	PCOPY(Type);
	PCOPY(shader_ref);
	PCOPY(vis);
	PCOPY(shader_name);
	PCOPY(textures);	

#ifdef _EDITOR
	PCOPY(desc);
#endif
#ifdef DEBUG
	PCOPY(dbg_name);
#endif
}

void IRender_Visual::UpdateShaders(LPCSTR shader, LPCSTR texture_name) {
	FHierrarhyVisual* pVisual = dynamic_cast<FHierrarhyVisual*>(this);
	if (pVisual) {
		xr_vector<IRender_Visual*>::iterator B, E;
		B = (pVisual->children).begin();
		E = (pVisual->children).end();
		for ( ; B!=E;++B) {
			IRender_Visual* pVisual2 = dynamic_cast<IRender_Visual*>(*B);
			if (pVisual2) {
				(pVisual2->shader_ref).create(shader, textures.c_str());
				shader_name = shader;
			}
		}
	}
	else {
		Msg("IRender_Visual::UpdateShaders(pVisual==NULL)");
	}
}

