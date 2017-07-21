#pragma once

#define SAFE_DELETE(p)  { if (p) {delete p; p = NULL;} }
#define SAFE_DELETE_W(p){ if (p) {delete[] p; p = NULL;} }
#define CHECK_NULL(p)   { if(!p) return; }

//------------- Form Func Map ------------------------
#define BEGIN_FORM_FUNC_MAP(uri) \
	switch(uri) \
		{ \

#define ON_RESPONE_FUNC(pkgType, FUNC, unPack) \
	case pkgType::uri: \
		{ \
			pkgType pkg; \
			pkg.unmarshal(unPack); \
			FUNC(pkg); \
		} \
		break; \

#define ON_RESPONE_SRC_LEN_FUNC(pkgType, FUNC, unPack, data, len) \
	case pkgType::uri: \
		{ \
		pkgType pkg; \
		pkg.unmarshal(unPack); \
		FUNC(pkg,data,len); \
		} \
		break; \

#define ON_RESPONE_DEFAULT_FUNC(FUNC, unPack, data, len) \
	default: \
		{ \
			FUNC(unPack, data, len); \
		} \

#define END_FORM_FUNC_MAP }

//-----------   high prority form --------------------
#define ON_HIGH_PROPRITY_RESPONE_FUNC(pkgType, FUNC, unPack) \
	if ( pkgType::uri == unPack.uri() ) \
		{ \
			pkgType pkg; \
			pkg.unmarshal(unPack); \
			FUNC(pkg); \
			return; \
		} \

