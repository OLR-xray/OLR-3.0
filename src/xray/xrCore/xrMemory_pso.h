#ifndef xrMemory_psoH
#define xrMemory_psoH
#pragma once

typedef void	__stdcall	pso_MemFill			(void* dest,  int value, size_t count);
typedef void	__stdcall	pso_MemFill32		(void* dest,  u32 value, size_t count);
typedef void	__stdcall	pso_MemCopy			(void* dest,  const void* src, size_t count);
#endif
