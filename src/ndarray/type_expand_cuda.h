#pragma once


template<> struct type_expand<float2>{
	typedef float type;
	static const int n = 2;
};

template<> struct type_expand<float3>{
	typedef float type;
	static const int n = 3;
};

template<> struct type_expand<float4>{
	typedef float type;
	static const int n = 4;
};

template<> struct type_expand<int2>{
	typedef int type;
	static const int n = 2;
};

template<> struct type_expand<int3>{
	typedef int type;
	static const int n = 3;
};

template<> struct type_expand<int4>{
	typedef int type;
	static const int n = 4;
};

template<> struct type_expand<uchar2>{
	typedef unsigned char type;
	static const int n = 2;
};

template<> struct type_expand<uchar3>{
	typedef unsigned char type;
	static const int n = 3;
};

template<> struct type_expand<uchar4>{
	typedef unsigned char type;
	static const int n = 4;
};
