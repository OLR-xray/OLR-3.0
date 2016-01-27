// stdafx.cpp : source file that includes just the standard includes
// stdafx.obj will contain the pre-compiled type information

#include "stdafx.h"
int (WINAPIV * __vsnprintf)(char *, size_t, const char*, va_list) = _vsnprintf;
#pragma comment(lib,	"xrCore"			)
#pragma comment(lib,	"dxguid.lib"			)
