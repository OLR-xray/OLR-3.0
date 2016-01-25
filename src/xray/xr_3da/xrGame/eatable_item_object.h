////////////////////////////////////////////////////////////////////////////
//	Module 		: eatable_item_object.h
//	Created 	: 24.03.2003
//  Modified 	: 29.01.2004
//	Author		: Yuri Dobronravin
//	Description : Eatable item object implementation
////////////////////////////////////////////////////////////////////////////

#pragma once

#include "missile.h"
#include "eatable_item.h"
#include "hudsound.h"

class CEatableItemObject :
			public CHudItemObject,
			public CEatableItem
{
private:
	typedef CHudItemObject	inherited;
public:
									CEatableItemObject();
	virtual						~CEatableItemObject();
	virtual DLL_Pure*		_construct();

	virtual CPhysicsShellHolder* cast_physics_shell_holder() {return this;}
	virtual CInventoryItem* cast_inventory_item() {return this;}
	virtual CAttachableItem* cast_attachable_item() {return this;}
	virtual CWeapon* cast_weapon() {return 0;}
	virtual CFoodItem* cast_food_item() {return 0;}
	virtual CMissile* cast_missile() {return 0;}
	virtual CHudItem* cast_hud_item() {return this;}
	virtual CWeaponAmmo* cast_weapon_ammo() {return 0;}
	virtual CGameObject* cast_game_object() {return this;};

	virtual void	Load(LPCSTR);
	
	virtual bool		Action(s32, u32);
	virtual void		GetBriefInfo(xr_string&, xr_string&, xr_string&);

	virtual void	net_Import(NET_Packet&);					// import from server
	virtual void	net_Export(NET_Packet&);					// export to server
	virtual BOOL net_Spawn(CSE_Abstract*);

	virtual void	UseBy(CEntityAlive*);
	virtual bool	Useful() const;

	virtual bool	Activate();
	virtual void	Deactivate();
	
	virtual void	Hide				();
	virtual void	Show				();
	
	virtual void	OnStateSwitch		(u32 S);
	virtual void	UpdateXForm			();
	virtual void	onMovementChanged	(ACTOR_DEFS::EMoveCommand cmd);
	virtual void	OnAnimationEnd		(u32 state);
	virtual bool	IsHidden			()	const	{return GetState()==eHidden;}
	virtual void	PlayAnimIdle		();
	virtual u16	bone_count_to_synchronize	() const;
	virtual void	SilentHide			()	{SwitchState(eHidden);}
	
	//virtual void	OnHiddenItem();
	enum EEatableHudStates {
		eIdle = 0,
		eShowing,
		eHiding,
		eHidden,
		eEat,
	};
	
	bool			IsEat				() const {
		return m_eatStart;
	}
	
protected:
	
	void				DestroyByEat(CEntityAlive*);
	void				DestroyByEat(CEntityAlive*, u16 id);
	
	virtual bool		TryPlayAnimIdle	();
	
	bool				m_eatStart;
	bool				m_snd_eat_loaded;
	
	MotionSVec						m_anim_idle;
	MotionSVec						m_anim_idle_sprint;
	MotionSVec						m_anim_idle_walk;
	MotionSVec						m_anim_idle_walk_slow;
	MotionSVec						m_anim_hide;
	MotionSVec						m_anim_show;
	MotionSVec						m_anim_eat;
	
	HUD_SOUND m_sndEat;

};

