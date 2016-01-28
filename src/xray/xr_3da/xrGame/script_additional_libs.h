#pragma once

#include "lua.h"
#include "lualib.h"
#include "lauxlib.h"
#include <cstdlib>
#include <cctype>
#include <random>

typedef unsigned long DWORD;
typedef unsigned char BYTE;


/*int ROL(int a, int n);
int ROR(int a, int n);
int bit_tobit(lua_State *L);
int bit_tohex(lua_State *L);
int bit_not(lua_State *L);
int bit_and(lua_State *L);
int bit_or(lua_State *L);
int bit_xor(lua_State *L);
int bit_rol(lua_State *L);
int bit_ror(lua_State *L);
int bit_lshift(lua_State *L);
int bit_rshift(lua_State *L);
int open_bit(lua_State *L);

//-----------------------------------------------------

int str_trim(lua_State *L);
int str_trim_l(lua_State *L);
int str_trim_r(lua_State *L);
int str_trim_w(lua_State *L);
int open_string(lua_State *L);

//-----------------------------------------------------

std::random_device ndrng;
std::mt19937 intgen;
std::uniform_real<float> float_random_01;

int gen_random_in_range(int a1, int a2);
int math_randomseed(lua_State *L);
int math_random(lua_State *L);
int open_math(lua_State *L);

//-----------------------------------------------------

inline DWORD C_get_size(lua_State *L);
int tab_keys(lua_State *L);
int tab_values(lua_State *L);
int get_size(lua_State *L);
int get_random(lua_State *L);*/
void open_additional_libs(lua_State*);