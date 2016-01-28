#ifndef rt_compressorH
#define rt_compressorH
#pragma once

extern XRCORE_API void	rtc_initialize	();
extern XRCORE_API size_t		rtc_compress	(void *dst, size_t dst_len, const void* src, size_t src_len);
extern XRCORE_API size_t		rtc_decompress	(void *dst, size_t dst_len, const void* src, size_t src_len);
extern XRCORE_API size_t		rtc_csize		(size_t in);

extern XRCORE_API void      rtc9_initialize	();
extern XRCORE_API void      rtc9_uninitialize	();
extern XRCORE_API size_t       rtc9_compress   (void *dst, size_t dst_len, const void* src, size_t src_len);
extern XRCORE_API size_t       rtc9_decompress	(void *dst, size_t dst_len, const void* src, size_t src_len);
extern XRCORE_API size_t       rtc9_csize		(size_t in);

#endif
