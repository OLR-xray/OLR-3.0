///////////////////////////////////////////////////////////////
// Phrase.h
// класс, описывающий фразу (элемент диалога)
///////////////////////////////////////////////////////////////

#pragma once

#include "PhraseScript.h"


class CPhraseDialog;

class CPhrase {
private:
	friend CPhraseDialog;
public:
	CPhrase(void) {
		m_ID = "";
		m_iGoodwillLevel = 0;
	}
	virtual ~CPhrase(void) {}

	void SetText(LPCSTR text) {
		m_text = text;
	}
	LPCSTR GetText() const {
		return m_text.c_str();
	}

	void SetID(const shared_str& id) {
		m_ID = id;
	}
	const shared_str& GetID() const {
		return m_ID;
	}
	LPCSTR GetIDStr() const {
		return m_ID.c_str();
	}

	int GoodwillLevel()	const {
		return m_iGoodwillLevel;
	}

	bool IsDummy()	const {
		return ( xr_strlen(GetText()) == 0 );
	}
	CPhraseScript* GetPhraseScript() {
		return &m_PhraseScript;
	};

protected:
	//уникальный индекс в списке фраз диалога
	shared_str m_ID;
	//текстовое представление фразы
	xr_string m_text;
	
	//минимальный уровень благосклоггости, необходимый для того
	//чтоб фразу можно было сказать
	int m_iGoodwillLevel;
	
	//для вызова скриптовых функций
	CPhraseScript m_PhraseScript;
};

