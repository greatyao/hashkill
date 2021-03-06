#define GGI (get_global_id(0))
#define GLI (get_local_id(0))

#define SET_AB(ai1,ai2,ii1,ii2) { \
    elem=ii1>>2; \
    tmp1=(ii1&3)<<3; \
    ai1[elem] = ai1[elem]|(ai2<<(tmp1)); \
    ai1[elem+1] = (tmp1==0) ? 0 : ai2>>(32-tmp1);\
    }


__kernel void __attribute__((reqd_work_group_size(64, 1, 1))) 
strmodify( __global uint *dst,  __global uint *input, __global uint *input1, uint16 str, uint16 salt,uint4 singlehash, uint16 salt2, __global uint *block, __global uint *eapol, __global uint *size)
{
__local uint inpc[64][14];
uint SIZE;
uint elem,tmp1;


inpc[GLI][0] = input[GGI*(8)+0];
inpc[GLI][1] = input[GGI*(8)+1];
inpc[GLI][2] = input[GGI*(8)+2];
inpc[GLI][3] = input[GGI*(8)+3];
inpc[GLI][4] = input[GGI*(8)+4];
inpc[GLI][5] = input[GGI*(8)+5];
inpc[GLI][6] = input[GGI*(8)+6];
inpc[GLI][7] = input[GGI*(8)+7];

SIZE = size[GGI];

SET_AB(inpc[GLI],str.s0,SIZE,0);
SET_AB(inpc[GLI],str.s1,SIZE+4,0);
SET_AB(inpc[GLI],str.s2,SIZE+8,0);
SET_AB(inpc[GLI],str.s3,SIZE+12,0);

//SET_AB(inpc[GLI],0x80,(SIZE+str.sF),0);

dst[GGI*8+0] = inpc[GLI][0];
dst[GGI*8+1] = inpc[GLI][1];
dst[GGI*8+2] = inpc[GLI][2];
dst[GGI*8+3] = inpc[GLI][3];
dst[GGI*8+4] = inpc[GLI][4];
dst[GGI*8+5] = inpc[GLI][5];
dst[GGI*8+6] = inpc[GLI][6];
dst[GGI*8+7] = inpc[GLI][7];

}


#define F_00_19(bb,cc,dd) (bitselect((dd),(cc),(bb)))
#define F_20_39(bb,cc,dd)  ((bb) ^ (cc) ^ (dd))  
#define F_40_59(bb,cc,dd) (bitselect((cc),(bb),((dd)^(cc))))
#define F_60_79(bb,cc,dd)  F_20_39((bb),(cc),(dd)) 
#define MD5STEP_ROUND1(a, b, c, d, AC, x, s)  (a)=(a)+(AC)+(x)+bitselect((d),(c),(b));(a) = rotate((a),s)+(b);
#define MD5STEP_ROUND1_NULL(a, b, c, d, AC, s)  (a)=(a)+(AC)+bitselect((d),(c),(b));(a) = rotate((a),s)+(b);
#define MD5STEP_ROUND2(a, b, c, d, AC, x, s)  (a)=(a)+(AC)+(x)+bitselect((c),(b),(d));(a) = rotate((a),s)+(b);
#define MD5STEP_ROUND2_NULL(a, b, c, d, AC, s)  (a)=(a)+(AC)+bitselect((c),(b),(d)); (a) = rotate((a),s)+(b);
#define MD5STEP_ROUND3(a, b, c, d, AC, x, s) tmp1 = (b) ^ (c);tmp1 = tmp1 ^ (d);(a) = (a)+tmp1; (a) = (a)+(AC);(a) = (a)+(x); (a) = rotate((a),s); (a) = (a)+(b); 
#define MD5STEP_ROUND3_NULL(a, b, c, d, AC, s)  tmp1 = (b) ^ (c);tmp1 = tmp1 ^ (d);(a) = (a)+tmp1; (a) = (a)+(AC); (a) = rotate(a,s); (a) = (a)+(b);
#define MD5STEP_ROUND4(a, b, c, d, AC, x, s)  tmp1 = (~(d)); tmp1 = (b) | tmp1; tmp1 = tmp1 ^ (c); (a) = (a)+tmp1; (a) = (a)+(AC); (a) = (a)+(x); (a) = rotate((a),s); (a) = (a)+(b);  
#define MD5STEP_ROUND4_NULL(a, b, c, d, AC, s)  tmp1 = (~(d)); tmp1 = (b) | tmp1; tmp1 = tmp1 ^ (c); (a) = (a)+tmp1; (a) = (a)+(AC); (a) = rotate((a),s); (a) = (a)+(b);


#define Endian_Reverse32(aa) { l=(aa);tmp1=rotate(l,Sl);tmp2=rotate(l,Sr); (aa)=bitselect(tmp2,tmp1,m); }
#define ROTATE1(aa, bb, cc, dd, ee, x) (ee) = (ee) + rotate((aa),S2) + F_00_19((bb),(cc),(dd)) + (x); (ee) = (ee) + K; (bb) = rotate((bb),S3) 
#define ROTATE1_NULL(aa, bb, cc, dd, ee)  (ee) = (ee) + rotate((aa),S2) + F_00_19((bb),(cc),(dd)) + K; (bb) = rotate((bb),S3)
#define ROTATE2_F(aa, bb, cc, dd, ee, x) (ee) = (ee) + rotate((aa),S2) + F_20_39((bb),(cc),(dd)) + (x) + K; (bb) = rotate((bb),S3) 
#define ROTATE3_F(aa, bb, cc, dd, ee, x) (ee) = (ee) + rotate((aa),S2) + F_40_59((bb),(cc),(dd)) + (x) + K; (bb) = rotate((bb),S3)
#define ROTATE4_F(aa, bb, cc, dd, ee, x) (ee) = (ee) + rotate((aa),S2) + F_60_79((bb),(cc),(dd)) + (x) + K; (bb) = rotate((bb),S3)

#define GLI get_local_id(0)
#define Ca 0x67452301  
#define Cb 0xefcdab89  
#define Cc 0x98badcfe  
#define Cd 0x10325476  
#define S11 7U
#define S12 12U
#define S13 17U
#define S14 22U
#define S21 5U
#define S22 9U
#define S23 14U
#define S24 20U
#define S31 4U
#define S32 11U
#define S33 16U
#define S34 23U
#define S41 6U
#define S42 10U
#define S43 15U
#define S44 21U


#define S1 1U
#define S2 5U
#define S3 30U  
#define Sl 8U
#define Sr 24U 
#define m 0x00FF00FFU
#define m2 0xFF00FF00U 


#ifndef GCN

__kernel 
__attribute__((reqd_work_group_size(64, 1, 1)))
void prepare1( __global uint2 *dst,  __global uint *input, __global uint2 *input1, uint16 str, uint16 salt,uint4 singlehash, uint16 salt2, __global uint *block, __global uint *eapol)
{
uint2 SIZE;  
uint ib,ic,id;  
uint2 a,b,c,d,e,f,g,h, tmp1, tmp2,l; 
uint2 w0, w1, w2, w3, w4, w5, w6, w7,w8,w9,w10,w11,w12,w13,w14,w16,w15;
uint yl,yr,zl,zr,wl,wr;
uint2 K;
uint2 K0 = (uint2)0x5A827999;
uint2 K1 = (uint2)0x6ED9EBA1;
uint2 K2 = (uint2)0x8F1BBCDC;
uint2 K3 = (uint2)0xCA62C1D6;
uint2 H0 = (uint2)0x67452301;
uint2 H1 = (uint2)0xEFCDAB89;
uint2 H2 = (uint2)0x98BADCFE;
uint2 H3 = (uint2)0x10325476;
uint2 H4 = (uint2)0xC3D2E1F0;
uint2 A,B,C,D,E;
uint2 IPA,IPB,IPC,IPD,IPE;
uint2 OPA,OPB,OPC,OPD,OPE;
uint2 TTA,TTB,TTC,TTD,TTE;

TTA=TTB=TTC=TTD=TTE=(uint2)0;


a.s0=input[get_global_id(0)*2*8];
b.s0=input[get_global_id(0)*2*8+1];
c.s0=input[get_global_id(0)*2*8+2];
d.s0=input[get_global_id(0)*2*8+3];
e.s0=input[get_global_id(0)*2*8+4];
f.s0=input[get_global_id(0)*2*8+5];
g.s0=input[get_global_id(0)*2*8+6];
h.s0=input[get_global_id(0)*2*8+7];

a.s1=input[get_global_id(0)*2*8+8];
b.s1=input[get_global_id(0)*2*8+9];
c.s1=input[get_global_id(0)*2*8+10];
d.s1=input[get_global_id(0)*2*8+11];
e.s1=input[get_global_id(0)*2*8+12];
f.s1=input[get_global_id(0)*2*8+13];
g.s1=input[get_global_id(0)*2*8+14];
h.s1=input[get_global_id(0)*2*8+15];



// Initial HMAC (for PBKDF2)

// Calculate sha1(ipad^key)
w0=a^(uint2)0x36363636;
w1=b^(uint2)0x36363636;
w2=c^(uint2)0x36363636;
w3=d^(uint2)0x36363636;
w4=e^(uint2)0x36363636;
w5=f^(uint2)0x36363636;
w6=g^(uint2)0x36363636;
w7=h^(uint2)0x36363636;

w8=w9=w10=w11=w12=w13=w14=SIZE=(uint2)0x36363636;

A=H0;
B=H1;
C=H2;
D=H3;
E=H4;

K = K0;
Endian_Reverse32(w0);  
ROTATE1(A, B, C, D, E, w0);
Endian_Reverse32(w1);  
ROTATE1(E, A, B, C, D, w1);
Endian_Reverse32(w2);  
ROTATE1(D, E, A, B, C, w2);
Endian_Reverse32(w3);  
ROTATE1(C, D, E, A, B, w3);
Endian_Reverse32(w4);  
ROTATE1(B, C, D, E, A, w4);
Endian_Reverse32(w5);  
ROTATE1(A, B, C, D, E, w5);
Endian_Reverse32(w6);  
ROTATE1(E, A, B, C, D, w6);
Endian_Reverse32(w7);  
ROTATE1(D, E, A, B, C, w7);
ROTATE1(C, D, E, A, B, w8);
ROTATE1(B, C, D, E, A, w9);
ROTATE1(A, B, C, D, E, w10);
ROTATE1(E, A, B, C, D, w11);
ROTATE1(D, E, A, B, C, w12);
ROTATE1(C, D, E, A, B, w13);
ROTATE1(B, C, D, E, A, w14);
ROTATE1(A, B, C, D, E, SIZE);  
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1);ROTATE1(E,A,B,C,D,w16);
w0 = rotate((w14 ^ w9 ^ w3 ^ w1),S1);ROTATE1(D,E,A,B,C,w0); 
w1 = rotate((SIZE ^ w10 ^ w4 ^ w2),S1); ROTATE1(C,D,E,A,B,w1); 
w2 = rotate((w16 ^ w11 ^ w5 ^ w3),S1);  ROTATE1(B,C,D,E,A,w2); 
K = K1;
w3 = rotate((w0 ^ w12 ^ w6 ^ w4),S1); ROTATE2_F(A, B, C, D, E, w3);
w4 = rotate((w1 ^ w13 ^ w7 ^ w5),S1); ROTATE2_F(E, A, B, C, D, w4);
w5 = rotate((w2 ^ w14 ^ w8 ^ w6),S1); ROTATE2_F(D, E, A, B, C, w5);
w6 = rotate((w3 ^ SIZE ^ w9 ^ w7),S1);ROTATE2_F(C, D, E, A, B, w6);
w7 = rotate((w4 ^ w16 ^ w10 ^ w8),S1); ROTATE2_F(B, C, D, E, A, w7);
w8 = rotate((w5 ^ w0 ^ w11 ^ w9),S1); ROTATE2_F(A, B, C, D, E, w8);
w9 = rotate((w6 ^ w1 ^ w12 ^ w10),S1); ROTATE2_F(E, A, B, C, D, w9);
w10 = rotate((w7 ^ w2 ^ w13 ^ w11),S1); ROTATE2_F(D, E, A, B, C, w10); 
w11 = rotate((w8 ^ w3 ^ w14 ^ w12),S1); ROTATE2_F(C, D, E, A, B, w11); 
w12 = rotate((w9 ^ w4 ^ SIZE ^ w13),S1); ROTATE2_F(B, C, D, E, A, w12);
w13 = rotate((w10 ^ w5 ^ w16 ^ w14),S1); ROTATE2_F(A, B, C, D, E, w13);
w14 = rotate((w11 ^ w6 ^ w0 ^ SIZE),S1); ROTATE2_F(E, A, B, C, D, w14);
SIZE = rotate((w12 ^ w7 ^ w1 ^ w16),S1); ROTATE2_F(D, E, A, B, C, SIZE);
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1); ROTATE2_F(C, D, E, A, B, w16);  
w0 = rotate(w14 ^ w9 ^ w3 ^ w1,S1); ROTATE2_F(B, C, D, E, A, w0);  
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2,S1); ROTATE2_F(A, B, C, D, E, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE2_F(E, A, B, C, D, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE2_F(D, E, A, B, C, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1);ROTATE2_F(C, D, E, A, B, w4);
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE2_F(B, C, D, E, A, w5);  
K = K2;
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(A, B, C, D, E, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(E, A, B, C, D, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(D, E, A, B, C, w8); 
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE3_F(C, D, E, A, B, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE3_F(B, C, D, E, A, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE3_F(A, B, C, D, E, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE3_F(E, A, B, C, D, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE3_F(D, E, A, B, C, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE3_F(C, D, E, A, B, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE3_F(B, C, D, E, A, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE3_F(A, B, C, D, E, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE3_F(E, A, B, C, D, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE3_F(D, E, A, B, C, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3, S1); ROTATE3_F(C, D, E, A, B, w2);
w3 = rotate(w0 ^ w12 ^ w6 ^ w4, S1); ROTATE3_F(B, C, D, E, A, w3); 
w4 = rotate(w1 ^ w13 ^ w7 ^ w5, S1); ROTATE3_F(A, B, C, D, E, w4); 
w5 = rotate(w2 ^ w14 ^ w8 ^ w6, S1); ROTATE3_F(E, A, B, C, D, w5); 
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(D, E, A, B, C, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(C, D, E, A, B, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(B, C, D, E, A, w8); 
K = K3;
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE4_F(A, B, C, D, E, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE4_F(E, A, B, C, D, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE4_F(D, E, A, B, C, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE4_F(C, D, E, A, B, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE4_F(B, C, D, E, A, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE4_F(A, B, C, D, E, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE4_F(E, A, B, C, D, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE4_F(D, E, A, B, C, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE4_F(C, D, E, A, B, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE4_F(B, C, D, E, A, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE4_F(A, B, C, D, E, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE4_F(E, A, B, C, D, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1); ROTATE4_F(D, E, A, B, C, w4);  
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE4_F(C, D, E, A, B, w5);  
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7,S1); ROTATE4_F(B, C, D, E, A, w6); 
w7 = rotate(w4 ^ w16 ^ w10 ^ w8,S1); ROTATE4_F(A, B, C, D, E, w7); 
w8 = rotate(w5 ^ w0 ^ w11 ^ w9,S1); ROTATE4_F(E, A, B, C, D, w8);  
w9 = rotate(w6 ^ w1 ^ w12 ^ w10,S1); ROTATE4_F(D, E, A, B, C, w9); 
w10 = rotate(w7 ^ w2 ^ w13 ^ w11,S1); ROTATE4_F(C, D, E, A, B, w10);
w11 = rotate(w8 ^ w3 ^ w14 ^ w12,S1); ROTATE4_F(B, C, D, E, A, w11);

IPA=A+H0;IPB=B+H1;IPC=C+H2;IPD=D+H3;IPE=E+H4;



// Calculate sha1(opad^key)
w0=a^(uint2)0x5c5c5c5c;
w1=b^(uint2)0x5c5c5c5c;
w2=c^(uint2)0x5c5c5c5c;
w3=d^(uint2)0x5c5c5c5c;
w4=e^(uint2)0x5c5c5c5c;
w5=f^(uint2)0x5c5c5c5c;
w6=g^(uint2)0x5c5c5c5c;
w7=h^(uint2)0x5c5c5c5c;

w8=w9=w10=w11=w12=w13=w14=SIZE=(uint2)0x5c5c5c5c;
A=H0;
B=H1;
C=H2;
D=H3;
E=H4;
K = K0;
Endian_Reverse32(w0);  
ROTATE1(A, B, C, D, E, w0);
Endian_Reverse32(w1);  
ROTATE1(E, A, B, C, D, w1);
Endian_Reverse32(w2);  
ROTATE1(D, E, A, B, C, w2);
Endian_Reverse32(w3);  
ROTATE1(C, D, E, A, B, w3);
Endian_Reverse32(w4);  
ROTATE1(B, C, D, E, A, w4);
Endian_Reverse32(w5);  
ROTATE1(A, B, C, D, E, w5);
Endian_Reverse32(w6);  
ROTATE1(E, A, B, C, D, w6);
Endian_Reverse32(w7);  
ROTATE1(D, E, A, B, C, w7);
ROTATE1(C, D, E, A, B, w8);
ROTATE1(B, C, D, E, A, w9);
ROTATE1(A, B, C, D, E, w10);
ROTATE1(E, A, B, C, D, w11);
ROTATE1(D, E, A, B, C, w12);
ROTATE1(C, D, E, A, B, w13);
ROTATE1(B, C, D, E, A, w14);
ROTATE1(A, B, C, D, E, SIZE);  
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1);ROTATE1(E,A,B,C,D,w16);
w0 = rotate((w14 ^ w9 ^ w3 ^ w1),S1);ROTATE1(D,E,A,B,C,w0); 
w1 = rotate((SIZE ^ w10 ^ w4 ^ w2),S1); ROTATE1(C,D,E,A,B,w1); 
w2 = rotate((w16 ^ w11 ^ w5 ^ w3),S1);  ROTATE1(B,C,D,E,A,w2); 
K = K1;
w3 = rotate((w0 ^ w12 ^ w6 ^ w4),S1); ROTATE2_F(A, B, C, D, E, w3);
w4 = rotate((w1 ^ w13 ^ w7 ^ w5),S1); ROTATE2_F(E, A, B, C, D, w4);
w5 = rotate((w2 ^ w14 ^ w8 ^ w6),S1); ROTATE2_F(D, E, A, B, C, w5);
w6 = rotate((w3 ^ SIZE ^ w9 ^ w7),S1);ROTATE2_F(C, D, E, A, B, w6);
w7 = rotate((w4 ^ w16 ^ w10 ^ w8),S1); ROTATE2_F(B, C, D, E, A, w7);
w8 = rotate((w5 ^ w0 ^ w11 ^ w9),S1); ROTATE2_F(A, B, C, D, E, w8);
w9 = rotate((w6 ^ w1 ^ w12 ^ w10),S1); ROTATE2_F(E, A, B, C, D, w9);
w10 = rotate((w7 ^ w2 ^ w13 ^ w11),S1); ROTATE2_F(D, E, A, B, C, w10); 
w11 = rotate((w8 ^ w3 ^ w14 ^ w12),S1); ROTATE2_F(C, D, E, A, B, w11); 
w12 = rotate((w9 ^ w4 ^ SIZE ^ w13),S1); ROTATE2_F(B, C, D, E, A, w12);
w13 = rotate((w10 ^ w5 ^ w16 ^ w14),S1); ROTATE2_F(A, B, C, D, E, w13);
w14 = rotate((w11 ^ w6 ^ w0 ^ SIZE),S1); ROTATE2_F(E, A, B, C, D, w14);
SIZE = rotate((w12 ^ w7 ^ w1 ^ w16),S1); ROTATE2_F(D, E, A, B, C, SIZE);
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1); ROTATE2_F(C, D, E, A, B, w16);  
w0 = rotate(w14 ^ w9 ^ w3 ^ w1,S1); ROTATE2_F(B, C, D, E, A, w0);  
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2,S1); ROTATE2_F(A, B, C, D, E, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE2_F(E, A, B, C, D, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE2_F(D, E, A, B, C, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1);ROTATE2_F(C, D, E, A, B, w4);
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE2_F(B, C, D, E, A, w5);  
K = K2;
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(A, B, C, D, E, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(E, A, B, C, D, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(D, E, A, B, C, w8); 
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE3_F(C, D, E, A, B, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE3_F(B, C, D, E, A, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE3_F(A, B, C, D, E, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE3_F(E, A, B, C, D, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE3_F(D, E, A, B, C, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE3_F(C, D, E, A, B, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE3_F(B, C, D, E, A, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE3_F(A, B, C, D, E, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE3_F(E, A, B, C, D, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE3_F(D, E, A, B, C, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3, S1); ROTATE3_F(C, D, E, A, B, w2);
w3 = rotate(w0 ^ w12 ^ w6 ^ w4, S1); ROTATE3_F(B, C, D, E, A, w3); 
w4 = rotate(w1 ^ w13 ^ w7 ^ w5, S1); ROTATE3_F(A, B, C, D, E, w4); 
w5 = rotate(w2 ^ w14 ^ w8 ^ w6, S1); ROTATE3_F(E, A, B, C, D, w5); 
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(D, E, A, B, C, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(C, D, E, A, B, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(B, C, D, E, A, w8); 
K = K3;
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE4_F(A, B, C, D, E, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE4_F(E, A, B, C, D, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE4_F(D, E, A, B, C, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE4_F(C, D, E, A, B, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE4_F(B, C, D, E, A, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE4_F(A, B, C, D, E, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE4_F(E, A, B, C, D, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE4_F(D, E, A, B, C, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE4_F(C, D, E, A, B, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE4_F(B, C, D, E, A, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE4_F(A, B, C, D, E, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE4_F(E, A, B, C, D, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1); ROTATE4_F(D, E, A, B, C, w4);  
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE4_F(C, D, E, A, B, w5);  
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7,S1); ROTATE4_F(B, C, D, E, A, w6); 
w7 = rotate(w4 ^ w16 ^ w10 ^ w8,S1); ROTATE4_F(A, B, C, D, E, w7); 
w8 = rotate(w5 ^ w0 ^ w11 ^ w9,S1); ROTATE4_F(E, A, B, C, D, w8);  
w9 = rotate(w6 ^ w1 ^ w12 ^ w10,S1); ROTATE4_F(D, E, A, B, C, w9); 
w10 = rotate(w7 ^ w2 ^ w13 ^ w11,S1); ROTATE4_F(C, D, E, A, B, w10);
w11 = rotate(w8 ^ w3 ^ w14 ^ w12,S1); ROTATE4_F(B, C, D, E, A, w11);

OPA=A+H0;OPB=B+H1;OPC=C+H2;OPD=D+H3;OPE=E+H4;



// calculate hash sum 1
A=IPA;
B=IPB;
C=IPC;
D=IPD;
E=IPE;

w0=(uint2)salt.s0;
w1=(uint2)salt.s1;
w2=(uint2)salt.s2;
w3=(uint2)salt.s3;
w4=(uint2)salt.s4;
w5=(uint2)salt.s5;
w6=(uint2)salt.s6;
w7=(uint2)salt.s7;
w8=(uint2)salt.s8;
w9=(uint2)salt.s9;
w10=(uint2)salt.sA;

SIZE=(uint2)salt.sF;
w11=w12=w13=w14=(uint2)0;


K = K0;
Endian_Reverse32(w0);  
ROTATE1(A, B, C, D, E, w0);
Endian_Reverse32(w1);  
ROTATE1(E, A, B, C, D, w1);
Endian_Reverse32(w2);  
ROTATE1(D, E, A, B, C, w2);
Endian_Reverse32(w3);  
ROTATE1(C, D, E, A, B, w3);
Endian_Reverse32(w4);  
ROTATE1(B, C, D, E, A, w4);
Endian_Reverse32(w5);  
ROTATE1(A, B, C, D, E, w5);
Endian_Reverse32(w6);  
ROTATE1(E, A, B, C, D, w6);
Endian_Reverse32(w7);  
ROTATE1(D, E, A, B, C, w7);
Endian_Reverse32(w8);  
ROTATE1(C, D, E, A, B, w8);
Endian_Reverse32(w9);  
ROTATE1(B, C, D, E, A, w9);
Endian_Reverse32(w10);  
ROTATE1(A, B, C, D, E, w10);
ROTATE1(E, A, B, C, D, w11);
ROTATE1(D, E, A, B, C, w12);
ROTATE1(C, D, E, A, B, w13);
ROTATE1(B, C, D, E, A, w14);
ROTATE1(A, B, C, D, E, SIZE);  
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1);ROTATE1(E,A,B,C,D,w16);
w0 = rotate((w14 ^ w9 ^ w3 ^ w1),S1);ROTATE1(D,E,A,B,C,w0); 
w1 = rotate((SIZE ^ w10 ^ w4 ^ w2),S1); ROTATE1(C,D,E,A,B,w1); 
w2 = rotate((w16 ^ w11 ^ w5 ^ w3),S1);  ROTATE1(B,C,D,E,A,w2); 
K = K1;
w3 = rotate((w0 ^ w12 ^ w6 ^ w4),S1); ROTATE2_F(A, B, C, D, E, w3);
w4 = rotate((w1 ^ w13 ^ w7 ^ w5),S1); ROTATE2_F(E, A, B, C, D, w4);
w5 = rotate((w2 ^ w14 ^ w8 ^ w6),S1); ROTATE2_F(D, E, A, B, C, w5);
w6 = rotate((w3 ^ SIZE ^ w9 ^ w7),S1);ROTATE2_F(C, D, E, A, B, w6);
w7 = rotate((w4 ^ w16 ^ w10 ^ w8),S1); ROTATE2_F(B, C, D, E, A, w7);
w8 = rotate((w5 ^ w0 ^ w11 ^ w9),S1); ROTATE2_F(A, B, C, D, E, w8);
w9 = rotate((w6 ^ w1 ^ w12 ^ w10),S1); ROTATE2_F(E, A, B, C, D, w9);
w10 = rotate((w7 ^ w2 ^ w13 ^ w11),S1); ROTATE2_F(D, E, A, B, C, w10); 
w11 = rotate((w8 ^ w3 ^ w14 ^ w12),S1); ROTATE2_F(C, D, E, A, B, w11); 
w12 = rotate((w9 ^ w4 ^ SIZE ^ w13),S1); ROTATE2_F(B, C, D, E, A, w12);
w13 = rotate((w10 ^ w5 ^ w16 ^ w14),S1); ROTATE2_F(A, B, C, D, E, w13);
w14 = rotate((w11 ^ w6 ^ w0 ^ SIZE),S1); ROTATE2_F(E, A, B, C, D, w14);
SIZE = rotate((w12 ^ w7 ^ w1 ^ w16),S1); ROTATE2_F(D, E, A, B, C, SIZE);
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1); ROTATE2_F(C, D, E, A, B, w16);  
w0 = rotate(w14 ^ w9 ^ w3 ^ w1,S1); ROTATE2_F(B, C, D, E, A, w0);  
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2,S1); ROTATE2_F(A, B, C, D, E, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE2_F(E, A, B, C, D, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE2_F(D, E, A, B, C, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1);ROTATE2_F(C, D, E, A, B, w4);
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE2_F(B, C, D, E, A, w5);  
K = K2;
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(A, B, C, D, E, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(E, A, B, C, D, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(D, E, A, B, C, w8); 
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE3_F(C, D, E, A, B, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE3_F(B, C, D, E, A, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE3_F(A, B, C, D, E, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE3_F(E, A, B, C, D, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE3_F(D, E, A, B, C, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE3_F(C, D, E, A, B, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE3_F(B, C, D, E, A, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE3_F(A, B, C, D, E, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE3_F(E, A, B, C, D, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE3_F(D, E, A, B, C, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3, S1); ROTATE3_F(C, D, E, A, B, w2);
w3 = rotate(w0 ^ w12 ^ w6 ^ w4, S1); ROTATE3_F(B, C, D, E, A, w3); 
w4 = rotate(w1 ^ w13 ^ w7 ^ w5, S1); ROTATE3_F(A, B, C, D, E, w4); 
w5 = rotate(w2 ^ w14 ^ w8 ^ w6, S1); ROTATE3_F(E, A, B, C, D, w5); 
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(D, E, A, B, C, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(C, D, E, A, B, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(B, C, D, E, A, w8); 
K = K3;
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE4_F(A, B, C, D, E, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE4_F(E, A, B, C, D, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE4_F(D, E, A, B, C, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE4_F(C, D, E, A, B, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE4_F(B, C, D, E, A, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE4_F(A, B, C, D, E, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE4_F(E, A, B, C, D, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE4_F(D, E, A, B, C, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE4_F(C, D, E, A, B, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE4_F(B, C, D, E, A, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE4_F(A, B, C, D, E, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE4_F(E, A, B, C, D, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1); ROTATE4_F(D, E, A, B, C, w4);  
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE4_F(C, D, E, A, B, w5);  
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7,S1); ROTATE4_F(B, C, D, E, A, w6); 
w7 = rotate(w4 ^ w16 ^ w10 ^ w8,S1); ROTATE4_F(A, B, C, D, E, w7); 
w8 = rotate(w5 ^ w0 ^ w11 ^ w9,S1); ROTATE4_F(E, A, B, C, D, w8);  
w9 = rotate(w6 ^ w1 ^ w12 ^ w10,S1); ROTATE4_F(D, E, A, B, C, w9); 
w10 = rotate(w7 ^ w2 ^ w13 ^ w11,S1); ROTATE4_F(C, D, E, A, B, w10);
w11 = rotate(w8 ^ w3 ^ w14 ^ w12,S1); ROTATE4_F(B, C, D, E, A, w11);
A=A+IPA;B=B+IPB;C=C+IPC;D=D+IPD;E=E+IPE;





// calculate hash sum 2

w0=A;
w1=B;
w2=C;
w3=D;
w4=E;
w5=(uint2)0x80000000;
A=OPA;
B=OPB;
C=OPC;
D=OPD;
E=OPE;
SIZE=(uint2)((64+20)<<3);
w6=w7=w8=w9=w10=w11=w12=w13=w14=(uint2)0;


K = K0;
ROTATE1(A, B, C, D, E, w0);
ROTATE1(E, A, B, C, D, w1);
ROTATE1(D, E, A, B, C, w2);
ROTATE1(C, D, E, A, B, w3);
ROTATE1(B, C, D, E, A, w4);
ROTATE1(A, B, C, D, E, w5);
ROTATE1(E, A, B, C, D, w6);
ROTATE1(D, E, A, B, C, w7);
ROTATE1(C, D, E, A, B, w8);
ROTATE1(B, C, D, E, A, w9);
ROTATE1(A, B, C, D, E, w10);
ROTATE1(E, A, B, C, D, w11);
ROTATE1(D, E, A, B, C, w12);
ROTATE1(C, D, E, A, B, w13);
ROTATE1(B, C, D, E, A, w14);
ROTATE1(A, B, C, D, E, SIZE);  
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1);ROTATE1(E,A,B,C,D,w16);
w0 = rotate((w14 ^ w9 ^ w3 ^ w1),S1);ROTATE1(D,E,A,B,C,w0); 
w1 = rotate((SIZE ^ w10 ^ w4 ^ w2),S1); ROTATE1(C,D,E,A,B,w1); 
w2 = rotate((w16 ^ w11 ^ w5 ^ w3),S1);  ROTATE1(B,C,D,E,A,w2); 
K = K1;
w3 = rotate((w0 ^ w12 ^ w6 ^ w4),S1); ROTATE2_F(A, B, C, D, E, w3);
w4 = rotate((w1 ^ w13 ^ w7 ^ w5),S1); ROTATE2_F(E, A, B, C, D, w4);
w5 = rotate((w2 ^ w14 ^ w8 ^ w6),S1); ROTATE2_F(D, E, A, B, C, w5);
w6 = rotate((w3 ^ SIZE ^ w9 ^ w7),S1);ROTATE2_F(C, D, E, A, B, w6);
w7 = rotate((w4 ^ w16 ^ w10 ^ w8),S1); ROTATE2_F(B, C, D, E, A, w7);
w8 = rotate((w5 ^ w0 ^ w11 ^ w9),S1); ROTATE2_F(A, B, C, D, E, w8);
w9 = rotate((w6 ^ w1 ^ w12 ^ w10),S1); ROTATE2_F(E, A, B, C, D, w9);
w10 = rotate((w7 ^ w2 ^ w13 ^ w11),S1); ROTATE2_F(D, E, A, B, C, w10); 
w11 = rotate((w8 ^ w3 ^ w14 ^ w12),S1); ROTATE2_F(C, D, E, A, B, w11); 
w12 = rotate((w9 ^ w4 ^ SIZE ^ w13),S1); ROTATE2_F(B, C, D, E, A, w12);
w13 = rotate((w10 ^ w5 ^ w16 ^ w14),S1); ROTATE2_F(A, B, C, D, E, w13);
w14 = rotate((w11 ^ w6 ^ w0 ^ SIZE),S1); ROTATE2_F(E, A, B, C, D, w14);
SIZE = rotate((w12 ^ w7 ^ w1 ^ w16),S1); ROTATE2_F(D, E, A, B, C, SIZE);
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1); ROTATE2_F(C, D, E, A, B, w16);  
w0 = rotate(w14 ^ w9 ^ w3 ^ w1,S1); ROTATE2_F(B, C, D, E, A, w0);  
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2,S1); ROTATE2_F(A, B, C, D, E, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE2_F(E, A, B, C, D, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE2_F(D, E, A, B, C, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1);ROTATE2_F(C, D, E, A, B, w4);
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE2_F(B, C, D, E, A, w5);  
K = K2;
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(A, B, C, D, E, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(E, A, B, C, D, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(D, E, A, B, C, w8); 
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE3_F(C, D, E, A, B, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE3_F(B, C, D, E, A, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE3_F(A, B, C, D, E, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE3_F(E, A, B, C, D, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE3_F(D, E, A, B, C, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE3_F(C, D, E, A, B, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE3_F(B, C, D, E, A, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE3_F(A, B, C, D, E, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE3_F(E, A, B, C, D, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE3_F(D, E, A, B, C, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3, S1); ROTATE3_F(C, D, E, A, B, w2);
w3 = rotate(w0 ^ w12 ^ w6 ^ w4, S1); ROTATE3_F(B, C, D, E, A, w3); 
w4 = rotate(w1 ^ w13 ^ w7 ^ w5, S1); ROTATE3_F(A, B, C, D, E, w4); 
w5 = rotate(w2 ^ w14 ^ w8 ^ w6, S1); ROTATE3_F(E, A, B, C, D, w5); 
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(D, E, A, B, C, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(C, D, E, A, B, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(B, C, D, E, A, w8); 
K = K3;
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE4_F(A, B, C, D, E, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE4_F(E, A, B, C, D, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE4_F(D, E, A, B, C, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE4_F(C, D, E, A, B, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE4_F(B, C, D, E, A, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE4_F(A, B, C, D, E, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE4_F(E, A, B, C, D, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE4_F(D, E, A, B, C, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE4_F(C, D, E, A, B, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE4_F(B, C, D, E, A, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE4_F(A, B, C, D, E, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE4_F(E, A, B, C, D, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1); ROTATE4_F(D, E, A, B, C, w4);  
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE4_F(C, D, E, A, B, w5);  
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7,S1); ROTATE4_F(B, C, D, E, A, w6); 
w7 = rotate(w4 ^ w16 ^ w10 ^ w8,S1); ROTATE4_F(A, B, C, D, E, w7); 
w8 = rotate(w5 ^ w0 ^ w11 ^ w9,S1); ROTATE4_F(E, A, B, C, D, w8);  
w9 = rotate(w6 ^ w1 ^ w12 ^ w10,S1); ROTATE4_F(D, E, A, B, C, w9); 
w10 = rotate(w7 ^ w2 ^ w13 ^ w11,S1); ROTATE4_F(C, D, E, A, B, w10);
w11 = rotate(w8 ^ w3 ^ w14 ^ w12,S1); ROTATE4_F(B, C, D, E, A, w11);
A=A+OPA;B=B+OPB;C=C+OPC;D=D+OPD;E=E+OPE;
TTA=A;TTB=B;TTC=C;TTD=D;TTE=E;


input1[get_global_id(0)*2*5+0]=IPA;
input1[get_global_id(0)*2*5+1]=IPB;
input1[get_global_id(0)*2*5+2]=IPC;
input1[get_global_id(0)*2*5+3]=IPD;
input1[get_global_id(0)*2*5+4]=IPE;
input1[get_global_id(0)*2*5+5]=OPA;
input1[get_global_id(0)*2*5+6]=OPB;
input1[get_global_id(0)*2*5+7]=OPC;
input1[get_global_id(0)*2*5+8]=OPD;
input1[get_global_id(0)*2*5+9]=OPE;

dst[get_global_id(0)*3*5+0]=TTA;
dst[get_global_id(0)*3*5+1]=TTB;
dst[get_global_id(0)*3*5+2]=TTC;
dst[get_global_id(0)*3*5+3]=TTD;
dst[get_global_id(0)*3*5+4]=TTE;
dst[get_global_id(0)*3*5+10]=TTA;
dst[get_global_id(0)*3*5+11]=TTB;
dst[get_global_id(0)*3*5+12]=TTC;
dst[get_global_id(0)*3*5+13]=TTD;
dst[get_global_id(0)*3*5+14]=TTE;

}


__kernel 
__attribute__((reqd_work_group_size(64, 1, 1)))
void pbkdf1( __global uint2 *dst,  __global uint2 *input, __global uint2 *input1, uint16 str, uint16 salt,uint4 singlehash, uint16 salt2, __global uint *block, __global uint *eapol)
{
uint2 SIZE;  
uint ib,ic,id;  
uint2 a,b,c,d,e,f,g,h, tmp1, tmp2,l; 
uint2 w0, w1, w2, w3, w4, w5, w6, w7,w8,w9,w10,w11,w12,w13,w14,w16,w15;
uint2 K;
uint2 K0 = (uint2)0x5A827999;
uint2 K1 = (uint2)0x6ED9EBA1;
uint2 K2 = (uint2)0x8F1BBCDC;
uint2 K3 = (uint2)0xCA62C1D6;
uint2 H0 = (uint2)0x67452301;
uint2 H1 = (uint2)0xEFCDAB89;
uint2 H2 = (uint2)0x98BADCFE;
uint2 H3 = (uint2)0x10325476;
uint2 H4 = (uint2)0xC3D2E1F0;
uint2 A,B,C,D,E;
uint2 IPA,IPB,IPC,IPD,IPE;
uint2 OPA,OPB,OPC,OPD,OPE;
uint2 TTA,TTB,TTC,TTD,TTE;


TTA=dst[get_global_id(0)*3*5+0];
TTB=dst[get_global_id(0)*3*5+1];
TTC=dst[get_global_id(0)*3*5+2];
TTD=dst[get_global_id(0)*3*5+3];
TTE=dst[get_global_id(0)*3*5+4];
A=dst[get_global_id(0)*3*5+10];
B=dst[get_global_id(0)*3*5+11];
C=dst[get_global_id(0)*3*5+12];
D=dst[get_global_id(0)*3*5+13];
E=dst[get_global_id(0)*3*5+14];
IPA=input1[get_global_id(0)*2*5+0];
IPB=input1[get_global_id(0)*2*5+1];
IPC=input1[get_global_id(0)*2*5+2];
IPD=input1[get_global_id(0)*2*5+3];
IPE=input1[get_global_id(0)*2*5+4];
OPA=input1[get_global_id(0)*2*5+5];
OPB=input1[get_global_id(0)*2*5+6];
OPC=input1[get_global_id(0)*2*5+7];
OPD=input1[get_global_id(0)*2*5+8];
OPE=input1[get_global_id(0)*2*5+9];


// We now have the first HMAC. Iterate to find the rest
for (ic=str.sA;ic<1170+str.sA;ic+=2)
{

// calculate hash sum 1
w0=A;
w1=B;
w2=C;
w3=D;
w4=E;
w5=(uint2)0x80000000;
SIZE=(uint2)(64+20)<<3;

A=IPA;
B=IPB;
C=IPC;
D=IPD;
E=IPE;


w6=w7=w8=w9=w10=w11=w12=w13=w14=(uint2)0;


K = K0;
ROTATE1(A, B, C, D, E, w0);
ROTATE1(E, A, B, C, D, w1);
ROTATE1(D, E, A, B, C, w2);
ROTATE1(C, D, E, A, B, w3);
ROTATE1(B, C, D, E, A, w4);
ROTATE1(A, B, C, D, E, w5);
ROTATE1_NULL(E, A, B, C, D);
ROTATE1_NULL(D, E, A, B, C);
ROTATE1_NULL(C, D, E, A, B);
ROTATE1_NULL(B, C, D, E, A);
ROTATE1_NULL(A, B, C, D, E);
ROTATE1_NULL(E, A, B, C, D);
ROTATE1_NULL(D, E, A, B, C);
ROTATE1_NULL(C, D, E, A, B);
ROTATE1_NULL(B, C, D, E, A);
ROTATE1(A, B, C, D, E, SIZE);  
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1);ROTATE1(E,A,B,C,D,w16);
w0 = rotate((w14 ^ w9 ^ w3 ^ w1),S1);ROTATE1(D,E,A,B,C,w0); 
w1 = rotate((SIZE ^ w10 ^ w4 ^ w2),S1); ROTATE1(C,D,E,A,B,w1); 
w2 = rotate((w16 ^ w11 ^ w5 ^ w3),S1);  ROTATE1(B,C,D,E,A,w2); 
K = K1;
w3 = rotate((w0 ^ w12 ^ w6 ^ w4),S1); ROTATE2_F(A, B, C, D, E, w3);
w4 = rotate((w1 ^ w13 ^ w7 ^ w5),S1); ROTATE2_F(E, A, B, C, D, w4);
w5 = rotate((w2 ^ w14 ^ w8 ^ w6),S1); ROTATE2_F(D, E, A, B, C, w5);
w6 = rotate((w3 ^ SIZE ^ w9 ^ w7),S1);ROTATE2_F(C, D, E, A, B, w6);
w7 = rotate((w4 ^ w16 ^ w10 ^ w8),S1); ROTATE2_F(B, C, D, E, A, w7);
w8 = rotate((w5 ^ w0 ^ w11 ^ w9),S1); ROTATE2_F(A, B, C, D, E, w8);
w9 = rotate((w6 ^ w1 ^ w12 ^ w10),S1); ROTATE2_F(E, A, B, C, D, w9);
w10 = rotate((w7 ^ w2 ^ w13 ^ w11),S1); ROTATE2_F(D, E, A, B, C, w10); 
w11 = rotate((w8 ^ w3 ^ w14 ^ w12),S1); ROTATE2_F(C, D, E, A, B, w11); 
w12 = rotate((w9 ^ w4 ^ SIZE ^ w13),S1); ROTATE2_F(B, C, D, E, A, w12);
w13 = rotate((w10 ^ w5 ^ w16 ^ w14),S1); ROTATE2_F(A, B, C, D, E, w13);
w14 = rotate((w11 ^ w6 ^ w0 ^ SIZE),S1); ROTATE2_F(E, A, B, C, D, w14);
SIZE = rotate((w12 ^ w7 ^ w1 ^ w16),S1); ROTATE2_F(D, E, A, B, C, SIZE);
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1); ROTATE2_F(C, D, E, A, B, w16);  
w0 = rotate(w14 ^ w9 ^ w3 ^ w1,S1); ROTATE2_F(B, C, D, E, A, w0);  
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2,S1); ROTATE2_F(A, B, C, D, E, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE2_F(E, A, B, C, D, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE2_F(D, E, A, B, C, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1);ROTATE2_F(C, D, E, A, B, w4);
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE2_F(B, C, D, E, A, w5);  
K = K2;
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(A, B, C, D, E, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(E, A, B, C, D, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(D, E, A, B, C, w8); 
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE3_F(C, D, E, A, B, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE3_F(B, C, D, E, A, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE3_F(A, B, C, D, E, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE3_F(E, A, B, C, D, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE3_F(D, E, A, B, C, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE3_F(C, D, E, A, B, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE3_F(B, C, D, E, A, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE3_F(A, B, C, D, E, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE3_F(E, A, B, C, D, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE3_F(D, E, A, B, C, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3, S1); ROTATE3_F(C, D, E, A, B, w2);
w3 = rotate(w0 ^ w12 ^ w6 ^ w4, S1); ROTATE3_F(B, C, D, E, A, w3); 
w4 = rotate(w1 ^ w13 ^ w7 ^ w5, S1); ROTATE3_F(A, B, C, D, E, w4); 
w5 = rotate(w2 ^ w14 ^ w8 ^ w6, S1); ROTATE3_F(E, A, B, C, D, w5); 
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(D, E, A, B, C, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(C, D, E, A, B, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(B, C, D, E, A, w8); 
K = K3;
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE4_F(A, B, C, D, E, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE4_F(E, A, B, C, D, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE4_F(D, E, A, B, C, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE4_F(C, D, E, A, B, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE4_F(B, C, D, E, A, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE4_F(A, B, C, D, E, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE4_F(E, A, B, C, D, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE4_F(D, E, A, B, C, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE4_F(C, D, E, A, B, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE4_F(B, C, D, E, A, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE4_F(A, B, C, D, E, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE4_F(E, A, B, C, D, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1); ROTATE4_F(D, E, A, B, C, w4);  
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE4_F(C, D, E, A, B, w5);  
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7,S1); ROTATE4_F(B, C, D, E, A, w6); 
w7 = rotate(w4 ^ w16 ^ w10 ^ w8,S1); ROTATE4_F(A, B, C, D, E, w7); 
w8 = rotate(w5 ^ w0 ^ w11 ^ w9,S1); ROTATE4_F(E, A, B, C, D, w8);  
w9 = rotate(w6 ^ w1 ^ w12 ^ w10,S1); ROTATE4_F(D, E, A, B, C, w9); 
w10 = rotate(w7 ^ w2 ^ w13 ^ w11,S1); ROTATE4_F(C, D, E, A, B, w10);
w11 = rotate(w8 ^ w3 ^ w14 ^ w12,S1); ROTATE4_F(B, C, D, E, A, w11);

A+=IPA;
B+=IPB;
C+=IPC;
D+=IPD;
E+=IPE;


// calculate hash sum 1
w0=A;
w1=B;
w2=C;
w3=D;
w4=E;
w5=(uint2)0x80000000;
SIZE=(uint2)(64+20)<<3;

A=OPA;
B=OPB;
C=OPC;
D=OPD;
E=OPE;


w6=w7=w8=w9=w10=w11=w12=w13=w14=(uint2)0;


K = K0;
ROTATE1(A, B, C, D, E, w0);
ROTATE1(E, A, B, C, D, w1);
ROTATE1(D, E, A, B, C, w2);
ROTATE1(C, D, E, A, B, w3);
ROTATE1(B, C, D, E, A, w4);
ROTATE1(A, B, C, D, E, w5);
ROTATE1_NULL(E, A, B, C, D);
ROTATE1_NULL(D, E, A, B, C);
ROTATE1_NULL(C, D, E, A, B);
ROTATE1_NULL(B, C, D, E, A);
ROTATE1_NULL(A, B, C, D, E);
ROTATE1_NULL(E, A, B, C, D);
ROTATE1_NULL(D, E, A, B, C);
ROTATE1_NULL(C, D, E, A, B);
ROTATE1_NULL(B, C, D, E, A);
ROTATE1(A, B, C, D, E, SIZE);  
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1);ROTATE1(E,A,B,C,D,w16);
w0 = rotate((w14 ^ w9 ^ w3 ^ w1),S1);ROTATE1(D,E,A,B,C,w0); 
w1 = rotate((SIZE ^ w10 ^ w4 ^ w2),S1); ROTATE1(C,D,E,A,B,w1); 
w2 = rotate((w16 ^ w11 ^ w5 ^ w3),S1);  ROTATE1(B,C,D,E,A,w2); 
K = K1;
w3 = rotate((w0 ^ w12 ^ w6 ^ w4),S1); ROTATE2_F(A, B, C, D, E, w3);
w4 = rotate((w1 ^ w13 ^ w7 ^ w5),S1); ROTATE2_F(E, A, B, C, D, w4);
w5 = rotate((w2 ^ w14 ^ w8 ^ w6),S1); ROTATE2_F(D, E, A, B, C, w5);
w6 = rotate((w3 ^ SIZE ^ w9 ^ w7),S1);ROTATE2_F(C, D, E, A, B, w6);
w7 = rotate((w4 ^ w16 ^ w10 ^ w8),S1); ROTATE2_F(B, C, D, E, A, w7);
w8 = rotate((w5 ^ w0 ^ w11 ^ w9),S1); ROTATE2_F(A, B, C, D, E, w8);
w9 = rotate((w6 ^ w1 ^ w12 ^ w10),S1); ROTATE2_F(E, A, B, C, D, w9);
w10 = rotate((w7 ^ w2 ^ w13 ^ w11),S1); ROTATE2_F(D, E, A, B, C, w10); 
w11 = rotate((w8 ^ w3 ^ w14 ^ w12),S1); ROTATE2_F(C, D, E, A, B, w11); 
w12 = rotate((w9 ^ w4 ^ SIZE ^ w13),S1); ROTATE2_F(B, C, D, E, A, w12);
w13 = rotate((w10 ^ w5 ^ w16 ^ w14),S1); ROTATE2_F(A, B, C, D, E, w13);
w14 = rotate((w11 ^ w6 ^ w0 ^ SIZE),S1); ROTATE2_F(E, A, B, C, D, w14);
SIZE = rotate((w12 ^ w7 ^ w1 ^ w16),S1); ROTATE2_F(D, E, A, B, C, SIZE);
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1); ROTATE2_F(C, D, E, A, B, w16);  
w0 = rotate(w14 ^ w9 ^ w3 ^ w1,S1); ROTATE2_F(B, C, D, E, A, w0);  
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2,S1); ROTATE2_F(A, B, C, D, E, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE2_F(E, A, B, C, D, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE2_F(D, E, A, B, C, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1);ROTATE2_F(C, D, E, A, B, w4);
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE2_F(B, C, D, E, A, w5);  
K = K2;
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(A, B, C, D, E, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(E, A, B, C, D, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(D, E, A, B, C, w8); 
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE3_F(C, D, E, A, B, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE3_F(B, C, D, E, A, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE3_F(A, B, C, D, E, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE3_F(E, A, B, C, D, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE3_F(D, E, A, B, C, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE3_F(C, D, E, A, B, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE3_F(B, C, D, E, A, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE3_F(A, B, C, D, E, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE3_F(E, A, B, C, D, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE3_F(D, E, A, B, C, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3, S1); ROTATE3_F(C, D, E, A, B, w2);
w3 = rotate(w0 ^ w12 ^ w6 ^ w4, S1); ROTATE3_F(B, C, D, E, A, w3); 
w4 = rotate(w1 ^ w13 ^ w7 ^ w5, S1); ROTATE3_F(A, B, C, D, E, w4); 
w5 = rotate(w2 ^ w14 ^ w8 ^ w6, S1); ROTATE3_F(E, A, B, C, D, w5); 
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(D, E, A, B, C, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(C, D, E, A, B, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(B, C, D, E, A, w8); 
K = K3;
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE4_F(A, B, C, D, E, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE4_F(E, A, B, C, D, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE4_F(D, E, A, B, C, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE4_F(C, D, E, A, B, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE4_F(B, C, D, E, A, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE4_F(A, B, C, D, E, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE4_F(E, A, B, C, D, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE4_F(D, E, A, B, C, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE4_F(C, D, E, A, B, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE4_F(B, C, D, E, A, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE4_F(A, B, C, D, E, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE4_F(E, A, B, C, D, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1); ROTATE4_F(D, E, A, B, C, w4);  
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE4_F(C, D, E, A, B, w5);  
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7,S1); ROTATE4_F(B, C, D, E, A, w6); 
w7 = rotate(w4 ^ w16 ^ w10 ^ w8,S1); ROTATE4_F(A, B, C, D, E, w7); 
w8 = rotate(w5 ^ w0 ^ w11 ^ w9,S1); ROTATE4_F(E, A, B, C, D, w8);  
w9 = rotate(w6 ^ w1 ^ w12 ^ w10,S1); ROTATE4_F(D, E, A, B, C, w9); 
w10 = rotate(w7 ^ w2 ^ w13 ^ w11,S1); ROTATE4_F(C, D, E, A, B, w10);
w11 = rotate(w8 ^ w3 ^ w14 ^ w12,S1); ROTATE4_F(B, C, D, E, A, w11);

A+=OPA;
B+=OPB;
C+=OPC;
D+=OPD;
E+=OPE;


TTA ^= A;
TTB ^= B;
TTC ^= C;
TTD ^= D;
TTE ^= E;

}

dst[get_global_id(0)*3*5+0]=TTA;
dst[get_global_id(0)*3*5+1]=TTB;
dst[get_global_id(0)*3*5+2]=TTC;
dst[get_global_id(0)*3*5+3]=TTD;
dst[get_global_id(0)*3*5+4]=TTE;
dst[get_global_id(0)*3*5+10]=A;
dst[get_global_id(0)*3*5+11]=B;
dst[get_global_id(0)*3*5+12]=C;
dst[get_global_id(0)*3*5+13]=D;
dst[get_global_id(0)*3*5+14]=E;
}




__kernel 
__attribute__((reqd_work_group_size(64, 1, 1)))
void prepare2( __global uint2 *dst,  __global uint2 *input, __global uint2 *input1, uint16 str, uint16 salt,uint4 singlehash, uint16 salt2, __global uint *block, __global uint *eapol)
{
uint2 SIZE;  
uint ib,ic,id;  
uint2 a,b,c,d,e,f,g,h, tmp1, tmp2,l; 
uint2 w0, w1, w2, w3, w4, w5, w6, w7,w8,w9,w10,w11,w12,w13,w14,w16,w15;
uint yl,yr,zl,zr,wl,wr;
uint2 K;
uint2 K0 = (uint2)0x5A827999;
uint2 K1 = (uint2)0x6ED9EBA1;
uint2 K2 = (uint2)0x8F1BBCDC;
uint2 K3 = (uint2)0xCA62C1D6;
uint2 H0 = (uint2)0x67452301;
uint2 H1 = (uint2)0xEFCDAB89;
uint2 H2 = (uint2)0x98BADCFE;
uint2 H3 = (uint2)0x10325476;
uint2 H4 = (uint2)0xC3D2E1F0;
uint2 A,B,C,D,E;
uint2 IPA,IPB,IPC,IPD,IPE;
uint2 OPA,OPB,OPC,OPD,OPE;
uint2 TTA,TTB,TTC,TTD,TTE;


TTA=dst[get_global_id(0)*3*5+0];
TTB=dst[get_global_id(0)*3*5+1];
TTC=dst[get_global_id(0)*3*5+2];
TTD=dst[get_global_id(0)*3*5+3];
TTE=dst[get_global_id(0)*3*5+4];
IPA=input1[get_global_id(0)*2*5+0];
IPB=input1[get_global_id(0)*2*5+1];
IPC=input1[get_global_id(0)*2*5+2];
IPD=input1[get_global_id(0)*2*5+3];
IPE=input1[get_global_id(0)*2*5+4];
OPA=input1[get_global_id(0)*2*5+5];
OPB=input1[get_global_id(0)*2*5+6];
OPC=input1[get_global_id(0)*2*5+7];
OPD=input1[get_global_id(0)*2*5+8];
OPE=input1[get_global_id(0)*2*5+9];

// Second part of PBKDF2

// calculate hash sum 1
A=IPA;
B=IPB;
C=IPC;
D=IPD;
E=IPE;

w0=(uint2)salt2.s0;
w1=(uint2)salt2.s1;
w2=(uint2)salt2.s2;
w3=(uint2)salt2.s3;
w4=(uint2)salt2.s4;
w5=(uint2)salt2.s5;
w6=(uint2)salt2.s6;
w7=(uint2)salt2.s7;
w8=(uint2)salt2.s8;
w9=(uint2)salt2.s9;
w10=(uint2)salt2.sA;

SIZE=(uint2)salt2.sF;
w11=w12=w13=w14=(uint2)0;


K = K0;
Endian_Reverse32(w0);  
ROTATE1(A, B, C, D, E, w0);
Endian_Reverse32(w1);  
ROTATE1(E, A, B, C, D, w1);
Endian_Reverse32(w2);  
ROTATE1(D, E, A, B, C, w2);
Endian_Reverse32(w3);  
ROTATE1(C, D, E, A, B, w3);
Endian_Reverse32(w4);  
ROTATE1(B, C, D, E, A, w4);
Endian_Reverse32(w5);  
ROTATE1(A, B, C, D, E, w5);
Endian_Reverse32(w6);  
ROTATE1(E, A, B, C, D, w6);
Endian_Reverse32(w7);  
ROTATE1(D, E, A, B, C, w7);
Endian_Reverse32(w8);  
ROTATE1(C, D, E, A, B, w8);
Endian_Reverse32(w9);  
ROTATE1(B, C, D, E, A, w9);
Endian_Reverse32(w10);  
ROTATE1(A, B, C, D, E, w10);
ROTATE1(E, A, B, C, D, w11);
ROTATE1(D, E, A, B, C, w12);
ROTATE1(C, D, E, A, B, w13);
ROTATE1(B, C, D, E, A, w14);
ROTATE1(A, B, C, D, E, SIZE);  
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1);ROTATE1(E,A,B,C,D,w16);
w0 = rotate((w14 ^ w9 ^ w3 ^ w1),S1);ROTATE1(D,E,A,B,C,w0); 
w1 = rotate((SIZE ^ w10 ^ w4 ^ w2),S1); ROTATE1(C,D,E,A,B,w1); 
w2 = rotate((w16 ^ w11 ^ w5 ^ w3),S1);  ROTATE1(B,C,D,E,A,w2); 
K = K1;
w3 = rotate((w0 ^ w12 ^ w6 ^ w4),S1); ROTATE2_F(A, B, C, D, E, w3);
w4 = rotate((w1 ^ w13 ^ w7 ^ w5),S1); ROTATE2_F(E, A, B, C, D, w4);
w5 = rotate((w2 ^ w14 ^ w8 ^ w6),S1); ROTATE2_F(D, E, A, B, C, w5);
w6 = rotate((w3 ^ SIZE ^ w9 ^ w7),S1);ROTATE2_F(C, D, E, A, B, w6);
w7 = rotate((w4 ^ w16 ^ w10 ^ w8),S1); ROTATE2_F(B, C, D, E, A, w7);
w8 = rotate((w5 ^ w0 ^ w11 ^ w9),S1); ROTATE2_F(A, B, C, D, E, w8);
w9 = rotate((w6 ^ w1 ^ w12 ^ w10),S1); ROTATE2_F(E, A, B, C, D, w9);
w10 = rotate((w7 ^ w2 ^ w13 ^ w11),S1); ROTATE2_F(D, E, A, B, C, w10); 
w11 = rotate((w8 ^ w3 ^ w14 ^ w12),S1); ROTATE2_F(C, D, E, A, B, w11); 
w12 = rotate((w9 ^ w4 ^ SIZE ^ w13),S1); ROTATE2_F(B, C, D, E, A, w12);
w13 = rotate((w10 ^ w5 ^ w16 ^ w14),S1); ROTATE2_F(A, B, C, D, E, w13);
w14 = rotate((w11 ^ w6 ^ w0 ^ SIZE),S1); ROTATE2_F(E, A, B, C, D, w14);
SIZE = rotate((w12 ^ w7 ^ w1 ^ w16),S1); ROTATE2_F(D, E, A, B, C, SIZE);
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1); ROTATE2_F(C, D, E, A, B, w16);  
w0 = rotate(w14 ^ w9 ^ w3 ^ w1,S1); ROTATE2_F(B, C, D, E, A, w0);  
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2,S1); ROTATE2_F(A, B, C, D, E, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE2_F(E, A, B, C, D, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE2_F(D, E, A, B, C, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1);ROTATE2_F(C, D, E, A, B, w4);
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE2_F(B, C, D, E, A, w5);  
K = K2;
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(A, B, C, D, E, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(E, A, B, C, D, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(D, E, A, B, C, w8); 
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE3_F(C, D, E, A, B, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE3_F(B, C, D, E, A, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE3_F(A, B, C, D, E, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE3_F(E, A, B, C, D, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE3_F(D, E, A, B, C, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE3_F(C, D, E, A, B, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE3_F(B, C, D, E, A, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE3_F(A, B, C, D, E, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE3_F(E, A, B, C, D, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE3_F(D, E, A, B, C, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3, S1); ROTATE3_F(C, D, E, A, B, w2);
w3 = rotate(w0 ^ w12 ^ w6 ^ w4, S1); ROTATE3_F(B, C, D, E, A, w3); 
w4 = rotate(w1 ^ w13 ^ w7 ^ w5, S1); ROTATE3_F(A, B, C, D, E, w4); 
w5 = rotate(w2 ^ w14 ^ w8 ^ w6, S1); ROTATE3_F(E, A, B, C, D, w5); 
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(D, E, A, B, C, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(C, D, E, A, B, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(B, C, D, E, A, w8); 
K = K3;
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE4_F(A, B, C, D, E, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE4_F(E, A, B, C, D, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE4_F(D, E, A, B, C, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE4_F(C, D, E, A, B, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE4_F(B, C, D, E, A, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE4_F(A, B, C, D, E, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE4_F(E, A, B, C, D, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE4_F(D, E, A, B, C, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE4_F(C, D, E, A, B, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE4_F(B, C, D, E, A, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE4_F(A, B, C, D, E, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE4_F(E, A, B, C, D, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1); ROTATE4_F(D, E, A, B, C, w4);  
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE4_F(C, D, E, A, B, w5);  
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7,S1); ROTATE4_F(B, C, D, E, A, w6); 
w7 = rotate(w4 ^ w16 ^ w10 ^ w8,S1); ROTATE4_F(A, B, C, D, E, w7); 
w8 = rotate(w5 ^ w0 ^ w11 ^ w9,S1); ROTATE4_F(E, A, B, C, D, w8);  
w9 = rotate(w6 ^ w1 ^ w12 ^ w10,S1); ROTATE4_F(D, E, A, B, C, w9); 
w10 = rotate(w7 ^ w2 ^ w13 ^ w11,S1); ROTATE4_F(C, D, E, A, B, w10);
w11 = rotate(w8 ^ w3 ^ w14 ^ w12,S1); ROTATE4_F(B, C, D, E, A, w11);
A=A+IPA;B=B+IPB;C=C+IPC;D=D+IPD;E=E+IPE;



// calculate hash sum 2

w0=A;
w1=B;
w2=C;
w3=D;
w4=E;
w5=(uint2)0x80000000;
A=OPA;
B=OPB;
C=OPC;
D=OPD;
E=OPE;
SIZE=(uint2)((64+20)<<3);
w6=w7=w8=w9=w10=w11=w12=w13=w14=(uint2)0;


K = K0;
ROTATE1(A, B, C, D, E, w0);
ROTATE1(E, A, B, C, D, w1);
ROTATE1(D, E, A, B, C, w2);
ROTATE1(C, D, E, A, B, w3);
ROTATE1(B, C, D, E, A, w4);
ROTATE1(A, B, C, D, E, w5);
ROTATE1(E, A, B, C, D, w6);
ROTATE1(D, E, A, B, C, w7);
ROTATE1(C, D, E, A, B, w8);
ROTATE1(B, C, D, E, A, w9);
ROTATE1(A, B, C, D, E, w10);
ROTATE1(E, A, B, C, D, w11);
ROTATE1(D, E, A, B, C, w12);
ROTATE1(C, D, E, A, B, w13);
ROTATE1(B, C, D, E, A, w14);
ROTATE1(A, B, C, D, E, SIZE);  
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1);ROTATE1(E,A,B,C,D,w16);
w0 = rotate((w14 ^ w9 ^ w3 ^ w1),S1);ROTATE1(D,E,A,B,C,w0); 
w1 = rotate((SIZE ^ w10 ^ w4 ^ w2),S1); ROTATE1(C,D,E,A,B,w1); 
w2 = rotate((w16 ^ w11 ^ w5 ^ w3),S1);  ROTATE1(B,C,D,E,A,w2); 
K = K1;
w3 = rotate((w0 ^ w12 ^ w6 ^ w4),S1); ROTATE2_F(A, B, C, D, E, w3);
w4 = rotate((w1 ^ w13 ^ w7 ^ w5),S1); ROTATE2_F(E, A, B, C, D, w4);
w5 = rotate((w2 ^ w14 ^ w8 ^ w6),S1); ROTATE2_F(D, E, A, B, C, w5);
w6 = rotate((w3 ^ SIZE ^ w9 ^ w7),S1);ROTATE2_F(C, D, E, A, B, w6);
w7 = rotate((w4 ^ w16 ^ w10 ^ w8),S1); ROTATE2_F(B, C, D, E, A, w7);
w8 = rotate((w5 ^ w0 ^ w11 ^ w9),S1); ROTATE2_F(A, B, C, D, E, w8);
w9 = rotate((w6 ^ w1 ^ w12 ^ w10),S1); ROTATE2_F(E, A, B, C, D, w9);
w10 = rotate((w7 ^ w2 ^ w13 ^ w11),S1); ROTATE2_F(D, E, A, B, C, w10); 
w11 = rotate((w8 ^ w3 ^ w14 ^ w12),S1); ROTATE2_F(C, D, E, A, B, w11); 
w12 = rotate((w9 ^ w4 ^ SIZE ^ w13),S1); ROTATE2_F(B, C, D, E, A, w12);
w13 = rotate((w10 ^ w5 ^ w16 ^ w14),S1); ROTATE2_F(A, B, C, D, E, w13);
w14 = rotate((w11 ^ w6 ^ w0 ^ SIZE),S1); ROTATE2_F(E, A, B, C, D, w14);
SIZE = rotate((w12 ^ w7 ^ w1 ^ w16),S1); ROTATE2_F(D, E, A, B, C, SIZE);
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1); ROTATE2_F(C, D, E, A, B, w16);  
w0 = rotate(w14 ^ w9 ^ w3 ^ w1,S1); ROTATE2_F(B, C, D, E, A, w0);  
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2,S1); ROTATE2_F(A, B, C, D, E, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE2_F(E, A, B, C, D, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE2_F(D, E, A, B, C, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1);ROTATE2_F(C, D, E, A, B, w4);
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE2_F(B, C, D, E, A, w5);  
K = K2;
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(A, B, C, D, E, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(E, A, B, C, D, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(D, E, A, B, C, w8); 
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE3_F(C, D, E, A, B, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE3_F(B, C, D, E, A, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE3_F(A, B, C, D, E, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE3_F(E, A, B, C, D, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE3_F(D, E, A, B, C, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE3_F(C, D, E, A, B, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE3_F(B, C, D, E, A, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE3_F(A, B, C, D, E, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE3_F(E, A, B, C, D, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE3_F(D, E, A, B, C, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3, S1); ROTATE3_F(C, D, E, A, B, w2);
w3 = rotate(w0 ^ w12 ^ w6 ^ w4, S1); ROTATE3_F(B, C, D, E, A, w3); 
w4 = rotate(w1 ^ w13 ^ w7 ^ w5, S1); ROTATE3_F(A, B, C, D, E, w4); 
w5 = rotate(w2 ^ w14 ^ w8 ^ w6, S1); ROTATE3_F(E, A, B, C, D, w5); 
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(D, E, A, B, C, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(C, D, E, A, B, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(B, C, D, E, A, w8); 
K = K3;
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE4_F(A, B, C, D, E, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE4_F(E, A, B, C, D, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE4_F(D, E, A, B, C, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE4_F(C, D, E, A, B, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE4_F(B, C, D, E, A, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE4_F(A, B, C, D, E, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE4_F(E, A, B, C, D, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE4_F(D, E, A, B, C, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE4_F(C, D, E, A, B, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE4_F(B, C, D, E, A, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE4_F(A, B, C, D, E, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE4_F(E, A, B, C, D, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1); ROTATE4_F(D, E, A, B, C, w4);  
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE4_F(C, D, E, A, B, w5);  
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7,S1); ROTATE4_F(B, C, D, E, A, w6); 
w7 = rotate(w4 ^ w16 ^ w10 ^ w8,S1); ROTATE4_F(A, B, C, D, E, w7); 
w8 = rotate(w5 ^ w0 ^ w11 ^ w9,S1); ROTATE4_F(E, A, B, C, D, w8);  
w9 = rotate(w6 ^ w1 ^ w12 ^ w10,S1); ROTATE4_F(D, E, A, B, C, w9); 
w10 = rotate(w7 ^ w2 ^ w13 ^ w11,S1); ROTATE4_F(C, D, E, A, B, w10);
w11 = rotate(w8 ^ w3 ^ w14 ^ w12,S1); ROTATE4_F(B, C, D, E, A, w11);
A=A+OPA;B=B+OPB;C=C+OPC;D=D+OPD;E=E+OPE;
TTA=A;TTB=B;TTC=C;TTD=D;TTE=E;
dst[get_global_id(0)*3*5+5]=TTA;
dst[get_global_id(0)*3*5+6]=TTB;
dst[get_global_id(0)*3*5+7]=TTC;
dst[get_global_id(0)*3*5+8]=TTD;
dst[get_global_id(0)*3*5+9]=TTE;
dst[get_global_id(0)*3*5+10]=TTA;
dst[get_global_id(0)*3*5+11]=TTB;
dst[get_global_id(0)*3*5+12]=TTC;
dst[get_global_id(0)*3*5+13]=TTD;
dst[get_global_id(0)*3*5+14]=TTE;
}




__kernel 
__attribute__((reqd_work_group_size(64, 1, 1)))
void pbkdf2( __global uint2 *dst,  __global uint2 *input, __global uint2 *input1, uint16 str, uint16 salt,uint4 singlehash, uint16 salt2, __global uint *block, __global uint *eapol)
{
uint2 SIZE;  
uint ib,ic,id;  
uint2 a,b,c,d,e,f,g,h, tmp1, tmp2,l; 
uint2 w0, w1, w2, w3, w4, w5, w6, w7,w8,w9,w10,w11,w12,w13,w14,w16,w15;
uint yl,yr,zl,zr,wl,wr;
uint2 K;
uint2 K0 = (uint2)0x5A827999;
uint2 K1 = (uint2)0x6ED9EBA1;
uint2 K2 = (uint2)0x8F1BBCDC;
uint2 K3 = (uint2)0xCA62C1D6;
uint2 H0 = (uint2)0x67452301;
uint2 H1 = (uint2)0xEFCDAB89;
uint2 H2 = (uint2)0x98BADCFE;
uint2 H3 = (uint2)0x10325476;
uint2 H4 = (uint2)0xC3D2E1F0;
uint2 A,B,C,D,E;
uint2 IPA,IPB,IPC,IPD,IPE;
uint2 OPA,OPB,OPC,OPD,OPE;
uint2 TTA,TTB,TTC,TTD,TTE;


TTA=dst[get_global_id(0)*3*5+5];
TTB=dst[get_global_id(0)*3*5+6];
TTC=dst[get_global_id(0)*3*5+7];
TTD=dst[get_global_id(0)*3*5+8];
TTE=dst[get_global_id(0)*3*5+9];
A=dst[get_global_id(0)*3*5+10];
B=dst[get_global_id(0)*3*5+11];
C=dst[get_global_id(0)*3*5+12];
D=dst[get_global_id(0)*3*5+13];
E=dst[get_global_id(0)*3*5+14];
IPA=input1[get_global_id(0)*2*5+0];
IPB=input1[get_global_id(0)*2*5+1];
IPC=input1[get_global_id(0)*2*5+2];
IPD=input1[get_global_id(0)*2*5+3];
IPE=input1[get_global_id(0)*2*5+4];
OPA=input1[get_global_id(0)*2*5+5];
OPB=input1[get_global_id(0)*2*5+6];
OPC=input1[get_global_id(0)*2*5+7];
OPD=input1[get_global_id(0)*2*5+8];
OPE=input1[get_global_id(0)*2*5+9];


// We now have the first HMAC part2. Iterate to find the rest
for (ic=str.sA;ic<str.sA+1170;ic+=2)
{

// calculate hash sum 1
w0=A;
w1=B;
w2=C;
w3=D;
w4=E;
w5=(uint2)0x80000000;
SIZE=(uint2)(64+20)<<3;
A=IPA;
B=IPB;
C=IPC;
D=IPD;
E=IPE;

w6=w7=w8=w9=w10=w11=w12=w13=w14=(uint2)0;


K = K0;
ROTATE1(A, B, C, D, E, w0);
ROTATE1(E, A, B, C, D, w1);
ROTATE1(D, E, A, B, C, w2);
ROTATE1(C, D, E, A, B, w3);
ROTATE1(B, C, D, E, A, w4);
ROTATE1(A, B, C, D, E, w5);
ROTATE1_NULL(E, A, B, C, D);
ROTATE1_NULL(D, E, A, B, C);
ROTATE1_NULL(C, D, E, A, B);
ROTATE1_NULL(B, C, D, E, A);
ROTATE1_NULL(A, B, C, D, E);
ROTATE1_NULL(E, A, B, C, D);
ROTATE1_NULL(D, E, A, B, C);
ROTATE1_NULL(C, D, E, A, B);
ROTATE1_NULL(B, C, D, E, A);
ROTATE1(A, B, C, D, E, SIZE);  
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1);ROTATE1(E,A,B,C,D,w16);
w0 = rotate((w14 ^ w9 ^ w3 ^ w1),S1);ROTATE1(D,E,A,B,C,w0); 
w1 = rotate((SIZE ^ w10 ^ w4 ^ w2),S1); ROTATE1(C,D,E,A,B,w1); 
w2 = rotate((w16 ^ w11 ^ w5 ^ w3),S1);  ROTATE1(B,C,D,E,A,w2); 
K = K1;
w3 = rotate((w0 ^ w12 ^ w6 ^ w4),S1); ROTATE2_F(A, B, C, D, E, w3);
w4 = rotate((w1 ^ w13 ^ w7 ^ w5),S1); ROTATE2_F(E, A, B, C, D, w4);
w5 = rotate((w2 ^ w14 ^ w8 ^ w6),S1); ROTATE2_F(D, E, A, B, C, w5);
w6 = rotate((w3 ^ SIZE ^ w9 ^ w7),S1);ROTATE2_F(C, D, E, A, B, w6);
w7 = rotate((w4 ^ w16 ^ w10 ^ w8),S1); ROTATE2_F(B, C, D, E, A, w7);
w8 = rotate((w5 ^ w0 ^ w11 ^ w9),S1); ROTATE2_F(A, B, C, D, E, w8);
w9 = rotate((w6 ^ w1 ^ w12 ^ w10),S1); ROTATE2_F(E, A, B, C, D, w9);
w10 = rotate((w7 ^ w2 ^ w13 ^ w11),S1); ROTATE2_F(D, E, A, B, C, w10); 
w11 = rotate((w8 ^ w3 ^ w14 ^ w12),S1); ROTATE2_F(C, D, E, A, B, w11); 
w12 = rotate((w9 ^ w4 ^ SIZE ^ w13),S1); ROTATE2_F(B, C, D, E, A, w12);
w13 = rotate((w10 ^ w5 ^ w16 ^ w14),S1); ROTATE2_F(A, B, C, D, E, w13);
w14 = rotate((w11 ^ w6 ^ w0 ^ SIZE),S1); ROTATE2_F(E, A, B, C, D, w14);
SIZE = rotate((w12 ^ w7 ^ w1 ^ w16),S1); ROTATE2_F(D, E, A, B, C, SIZE);
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1); ROTATE2_F(C, D, E, A, B, w16);  
w0 = rotate(w14 ^ w9 ^ w3 ^ w1,S1); ROTATE2_F(B, C, D, E, A, w0);  
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2,S1); ROTATE2_F(A, B, C, D, E, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE2_F(E, A, B, C, D, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE2_F(D, E, A, B, C, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1);ROTATE2_F(C, D, E, A, B, w4);
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE2_F(B, C, D, E, A, w5);  
K = K2;
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(A, B, C, D, E, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(E, A, B, C, D, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(D, E, A, B, C, w8); 
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE3_F(C, D, E, A, B, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE3_F(B, C, D, E, A, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE3_F(A, B, C, D, E, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE3_F(E, A, B, C, D, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE3_F(D, E, A, B, C, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE3_F(C, D, E, A, B, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE3_F(B, C, D, E, A, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE3_F(A, B, C, D, E, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE3_F(E, A, B, C, D, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE3_F(D, E, A, B, C, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3, S1); ROTATE3_F(C, D, E, A, B, w2);
w3 = rotate(w0 ^ w12 ^ w6 ^ w4, S1); ROTATE3_F(B, C, D, E, A, w3); 
w4 = rotate(w1 ^ w13 ^ w7 ^ w5, S1); ROTATE3_F(A, B, C, D, E, w4); 
w5 = rotate(w2 ^ w14 ^ w8 ^ w6, S1); ROTATE3_F(E, A, B, C, D, w5); 
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(D, E, A, B, C, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(C, D, E, A, B, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(B, C, D, E, A, w8); 
K = K3;
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE4_F(A, B, C, D, E, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE4_F(E, A, B, C, D, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE4_F(D, E, A, B, C, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE4_F(C, D, E, A, B, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE4_F(B, C, D, E, A, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE4_F(A, B, C, D, E, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE4_F(E, A, B, C, D, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE4_F(D, E, A, B, C, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE4_F(C, D, E, A, B, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE4_F(B, C, D, E, A, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE4_F(A, B, C, D, E, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE4_F(E, A, B, C, D, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1); ROTATE4_F(D, E, A, B, C, w4);  
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE4_F(C, D, E, A, B, w5);  
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7,S1); ROTATE4_F(B, C, D, E, A, w6); 
w7 = rotate(w4 ^ w16 ^ w10 ^ w8,S1); ROTATE4_F(A, B, C, D, E, w7); 
w8 = rotate(w5 ^ w0 ^ w11 ^ w9,S1); ROTATE4_F(E, A, B, C, D, w8);  
w9 = rotate(w6 ^ w1 ^ w12 ^ w10,S1); ROTATE4_F(D, E, A, B, C, w9); 
w10 = rotate(w7 ^ w2 ^ w13 ^ w11,S1); ROTATE4_F(C, D, E, A, B, w10);
w11 = rotate(w8 ^ w3 ^ w14 ^ w12,S1); ROTATE4_F(B, C, D, E, A, w11);


A+=IPA;
B+=IPB;
C+=IPC;
D+=IPD;
E+=IPE;




// calculate hash sum 1
w0=A;
w1=B;
w2=C;
w3=D;
w4=E;
w5=(uint2)0x80000000;
SIZE=(uint2)(64+20)<<3;
A=OPA;
B=OPB;
C=OPC;
D=OPD;
E=OPE;

w6=w7=w8=w9=w10=w11=w12=w13=w14=(uint2)0;


K = K0;
ROTATE1(A, B, C, D, E, w0);
ROTATE1(E, A, B, C, D, w1);
ROTATE1(D, E, A, B, C, w2);
ROTATE1(C, D, E, A, B, w3);
ROTATE1(B, C, D, E, A, w4);
ROTATE1(A, B, C, D, E, w5);
ROTATE1_NULL(E, A, B, C, D);
ROTATE1_NULL(D, E, A, B, C);
ROTATE1_NULL(C, D, E, A, B);
ROTATE1_NULL(B, C, D, E, A);
ROTATE1_NULL(A, B, C, D, E);
ROTATE1_NULL(E, A, B, C, D);
ROTATE1_NULL(D, E, A, B, C);
ROTATE1_NULL(C, D, E, A, B);
ROTATE1_NULL(B, C, D, E, A);
ROTATE1(A, B, C, D, E, SIZE);  
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1);ROTATE1(E,A,B,C,D,w16);
w0 = rotate((w14 ^ w9 ^ w3 ^ w1),S1);ROTATE1(D,E,A,B,C,w0); 
w1 = rotate((SIZE ^ w10 ^ w4 ^ w2),S1); ROTATE1(C,D,E,A,B,w1); 
w2 = rotate((w16 ^ w11 ^ w5 ^ w3),S1);  ROTATE1(B,C,D,E,A,w2); 
K = K1;
w3 = rotate((w0 ^ w12 ^ w6 ^ w4),S1); ROTATE2_F(A, B, C, D, E, w3);
w4 = rotate((w1 ^ w13 ^ w7 ^ w5),S1); ROTATE2_F(E, A, B, C, D, w4);
w5 = rotate((w2 ^ w14 ^ w8 ^ w6),S1); ROTATE2_F(D, E, A, B, C, w5);
w6 = rotate((w3 ^ SIZE ^ w9 ^ w7),S1);ROTATE2_F(C, D, E, A, B, w6);
w7 = rotate((w4 ^ w16 ^ w10 ^ w8),S1); ROTATE2_F(B, C, D, E, A, w7);
w8 = rotate((w5 ^ w0 ^ w11 ^ w9),S1); ROTATE2_F(A, B, C, D, E, w8);
w9 = rotate((w6 ^ w1 ^ w12 ^ w10),S1); ROTATE2_F(E, A, B, C, D, w9);
w10 = rotate((w7 ^ w2 ^ w13 ^ w11),S1); ROTATE2_F(D, E, A, B, C, w10); 
w11 = rotate((w8 ^ w3 ^ w14 ^ w12),S1); ROTATE2_F(C, D, E, A, B, w11); 
w12 = rotate((w9 ^ w4 ^ SIZE ^ w13),S1); ROTATE2_F(B, C, D, E, A, w12);
w13 = rotate((w10 ^ w5 ^ w16 ^ w14),S1); ROTATE2_F(A, B, C, D, E, w13);
w14 = rotate((w11 ^ w6 ^ w0 ^ SIZE),S1); ROTATE2_F(E, A, B, C, D, w14);
SIZE = rotate((w12 ^ w7 ^ w1 ^ w16),S1); ROTATE2_F(D, E, A, B, C, SIZE);
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1); ROTATE2_F(C, D, E, A, B, w16);  
w0 = rotate(w14 ^ w9 ^ w3 ^ w1,S1); ROTATE2_F(B, C, D, E, A, w0);  
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2,S1); ROTATE2_F(A, B, C, D, E, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE2_F(E, A, B, C, D, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE2_F(D, E, A, B, C, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1);ROTATE2_F(C, D, E, A, B, w4);
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE2_F(B, C, D, E, A, w5);  
K = K2;
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(A, B, C, D, E, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(E, A, B, C, D, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(D, E, A, B, C, w8); 
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE3_F(C, D, E, A, B, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE3_F(B, C, D, E, A, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE3_F(A, B, C, D, E, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE3_F(E, A, B, C, D, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE3_F(D, E, A, B, C, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE3_F(C, D, E, A, B, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE3_F(B, C, D, E, A, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE3_F(A, B, C, D, E, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE3_F(E, A, B, C, D, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE3_F(D, E, A, B, C, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3, S1); ROTATE3_F(C, D, E, A, B, w2);
w3 = rotate(w0 ^ w12 ^ w6 ^ w4, S1); ROTATE3_F(B, C, D, E, A, w3); 
w4 = rotate(w1 ^ w13 ^ w7 ^ w5, S1); ROTATE3_F(A, B, C, D, E, w4); 
w5 = rotate(w2 ^ w14 ^ w8 ^ w6, S1); ROTATE3_F(E, A, B, C, D, w5); 
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(D, E, A, B, C, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(C, D, E, A, B, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(B, C, D, E, A, w8); 
K = K3;
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE4_F(A, B, C, D, E, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE4_F(E, A, B, C, D, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE4_F(D, E, A, B, C, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE4_F(C, D, E, A, B, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE4_F(B, C, D, E, A, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE4_F(A, B, C, D, E, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE4_F(E, A, B, C, D, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE4_F(D, E, A, B, C, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE4_F(C, D, E, A, B, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE4_F(B, C, D, E, A, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE4_F(A, B, C, D, E, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE4_F(E, A, B, C, D, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1); ROTATE4_F(D, E, A, B, C, w4);  
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE4_F(C, D, E, A, B, w5);  
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7,S1); ROTATE4_F(B, C, D, E, A, w6); 
w7 = rotate(w4 ^ w16 ^ w10 ^ w8,S1); ROTATE4_F(A, B, C, D, E, w7); 
w8 = rotate(w5 ^ w0 ^ w11 ^ w9,S1); ROTATE4_F(E, A, B, C, D, w8);  
w9 = rotate(w6 ^ w1 ^ w12 ^ w10,S1); ROTATE4_F(D, E, A, B, C, w9); 
w10 = rotate(w7 ^ w2 ^ w13 ^ w11,S1); ROTATE4_F(C, D, E, A, B, w10);
w11 = rotate(w8 ^ w3 ^ w14 ^ w12,S1); ROTATE4_F(B, C, D, E, A, w11);


A+=OPA;
B+=OPB;
C+=OPC;
D+=OPD;
E+=OPE;


TTA ^= A;
TTB ^= B;
TTC ^= C;
}


dst[get_global_id(0)*3*5+5]=TTA;
dst[get_global_id(0)*3*5+6]=TTB;
dst[get_global_id(0)*3*5+7]=TTC;
dst[get_global_id(0)*3*5+8]=TTD;
dst[get_global_id(0)*3*5+9]=TTE;
dst[get_global_id(0)*3*5+10]=A;
dst[get_global_id(0)*3*5+11]=B;
dst[get_global_id(0)*3*5+12]=C;
dst[get_global_id(0)*3*5+13]=D;
dst[get_global_id(0)*3*5+14]=E;

}




__kernel 
__attribute__((reqd_work_group_size(64, 1, 1)))
void final( __global uint4 *dst,  __global uint2 *input, __global uint2 *input1, uint16 str, uint16 salt,uint4 singlehash, uint16 salt2, __global uint *block, __global uint *eapol, global uint *found, global uint *found_ind)
{
uint2 SIZE;  
uint ib,ic,id;  
uint2 a,b,c,d,e,f,g,h, tmp1, tmp2,l; 
uint2 w0, w1, w2, w3, w4, w5, w6, w7,w8,w9,w10,w11,w12,w13,w14,w16,w15;
uint yl,yr,zl,zr,wl,wr;
uint2 K;
uint2 K0 = (uint2)0x5A827999;
uint2 K1 = (uint2)0x6ED9EBA1;
uint2 K2 = (uint2)0x8F1BBCDC;
uint2 K3 = (uint2)0xCA62C1D6;
uint2 H0 = (uint2)0x67452301;
uint2 H1 = (uint2)0xEFCDAB89;
uint2 H2 = (uint2)0x98BADCFE;
uint2 H3 = (uint2)0x10325476;
uint2 H4 = (uint2)0xC3D2E1F0;
uint2 A,B,C,D,E;
uint2 IPA,IPB,IPC,IPD,IPE;
uint2 OPA,OPB,OPC,OPD,OPE;
uint2 TTA,TTB,TTC,TTD,TTE,TTTA,TTTB,TTTC,TTTD,TTTE;
uint2 mAC1 = (uint2)0xd76aa478; 
uint2 mAC2 = (uint2)0xe8c7b756; 
uint2 mAC3 = (uint2)0x242070db; 
uint2 mAC4 = (uint2)0xc1bdceee; 
uint2 mAC5 = (uint2)0xf57c0faf; 
uint2 mAC6 = (uint2)0x4787c62a; 
uint2 mAC7 = (uint2)0xa8304613; 
uint2 mAC8 = (uint2)0xfd469501; 
uint2 mAC9 = (uint2)0x698098d8; 
uint2 mAC10= (uint2)0x8b44f7af; 
uint2 mAC11= (uint2)0xffff5bb1; 
uint2 mAC12= (uint2)0x895cd7be; 
uint2 mAC13= (uint2)0x6b901122; 
uint2 mAC14= (uint2)0xfd987193; 
uint2 mAC15= (uint2)0xa679438e; 
uint2 mAC16= (uint2)0x49b40821; 
uint2 mAC17= (uint2)0xf61e2562; 
uint2 mAC18= (uint2)0xc040b340; 
uint2 mAC19= (uint2)0x265e5a51; 
uint2 mAC20= (uint2)0xe9b6c7aa; 
uint2 mAC21= (uint2)0xd62f105d; 
uint2 mAC22= (uint2)0x02441453; 
uint2 mAC23= (uint2)0xd8a1e681; 
uint2 mAC24= (uint2)0xe7d3fbc8; 
uint2 mAC25= (uint2)0x21e1cde6; 
uint2 mAC26= (uint2)0xc33707d6; 
uint2 mAC27= (uint2)0xf4d50d87; 
uint2 mAC28= (uint2)0x455a14ed; 
uint2 mAC29= (uint2)0xa9e3e905; 
uint2 mAC30= (uint2)0xfcefa3f8; 
uint2 mAC31= (uint2)0x676f02d9; 
uint2 mAC32= (uint2)0x8d2a4c8a; 
uint2 mAC33= (uint2)0xfffa3942; 
uint2 mAC34= (uint2)0x8771f681; 
uint2 mAC35= (uint2)0x6d9d6122; 
uint2 mAC36= (uint2)0xfde5380c; 
uint2 mAC37= (uint2)0xa4beea44; 
uint2 mAC38= (uint2)0x4bdecfa9; 
uint2 mAC39= (uint2)0xf6bb4b60; 
uint2 mAC40= (uint2)0xbebfbc70; 
uint2 mAC41= (uint2)0x289b7ec6; 
uint2 mAC42= (uint2)0xeaa127fa; 
uint2 mAC43= (uint2)0xd4ef3085; 
uint2 mAC44= (uint2)0x04881d05; 
uint2 mAC45= (uint2)0xd9d4d039; 
uint2 mAC46= (uint2)0xe6db99e5; 
uint2 mAC47= (uint2)0x1fa27cf8; 
uint2 mAC48= (uint2)0xc4ac5665; 
uint2 mAC49= (uint2)0xf4292244; 
uint2 mAC50= (uint2)0x432aff97; 
uint2 mAC51= (uint2)0xab9423a7; 
uint2 mAC52= (uint2)0xfc93a039; 
uint2 mAC53= (uint2)0x655b59c3; 
uint2 mAC54= (uint2)0x8f0ccc92; 
uint2 mAC55= (uint2)0xffeff47d; 
uint2 mAC56= (uint2)0x85845dd1; 
uint2 mAC57= (uint2)0x6fa87e4f; 
uint2 mAC58= (uint2)0xfe2ce6e0; 
uint2 mAC59= (uint2)0xa3014314; 
uint2 mAC60= (uint2)0x4e0811a1; 
uint2 mAC61= (uint2)0xf7537e82; 
uint2 mAC62= (uint2)0xbd3af235; 
uint2 mAC63= (uint2)0x2ad7d2bb; 
uint2 mAC64= (uint2)0xeb86d391; 
uint2 mOne, mCa, mCb, mCc, mCd;


TTTA=input1[get_global_id(0)*3*5+0];
TTTB=input1[get_global_id(0)*3*5+1];
TTTC=input1[get_global_id(0)*3*5+2];
TTTD=input1[get_global_id(0)*3*5+3];
TTTE=input1[get_global_id(0)*3*5+4];
TTA=input1[get_global_id(0)*3*5+5];
TTB=input1[get_global_id(0)*3*5+6];
TTC=input1[get_global_id(0)*3*5+7];
TTD=input1[get_global_id(0)*3*5+8];
TTE=input1[get_global_id(0)*3*5+9];



// HMAC(PMK,BLOCK) 

// Calculate sha1(ipad^key)
w0=TTTA^(uint2)0x36363636;
w1=TTTB^(uint2)0x36363636;
w2=TTTC^(uint2)0x36363636;
w3=TTTD^(uint2)0x36363636;
w4=TTTE^(uint2)0x36363636;
w5=TTA^(uint2)0x36363636;
w6=TTB^(uint2)0x36363636;
w7=TTC^(uint2)0x36363636;

w8=w9=w10=w11=w12=w13=w14=SIZE=(uint2)0x36363636;

A=H0;
B=H1;
C=H2;
D=H3;
E=H4;

K = K0;
ROTATE1(A, B, C, D, E, w0);
ROTATE1(E, A, B, C, D, w1);
ROTATE1(D, E, A, B, C, w2);
ROTATE1(C, D, E, A, B, w3);
ROTATE1(B, C, D, E, A, w4);
ROTATE1(A, B, C, D, E, w5);
ROTATE1(E, A, B, C, D, w6);
ROTATE1(D, E, A, B, C, w7);
ROTATE1(C, D, E, A, B, w8);
ROTATE1(B, C, D, E, A, w9);
ROTATE1(A, B, C, D, E, w10);
ROTATE1(E, A, B, C, D, w11);
ROTATE1(D, E, A, B, C, w12);
ROTATE1(C, D, E, A, B, w13);
ROTATE1(B, C, D, E, A, w14);
ROTATE1(A, B, C, D, E, SIZE);  
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1);ROTATE1(E,A,B,C,D,w16);
w0 = rotate((w14 ^ w9 ^ w3 ^ w1),S1);ROTATE1(D,E,A,B,C,w0); 
w1 = rotate((SIZE ^ w10 ^ w4 ^ w2),S1); ROTATE1(C,D,E,A,B,w1); 
w2 = rotate((w16 ^ w11 ^ w5 ^ w3),S1);  ROTATE1(B,C,D,E,A,w2); 
K = K1;
w3 = rotate((w0 ^ w12 ^ w6 ^ w4),S1); ROTATE2_F(A, B, C, D, E, w3);
w4 = rotate((w1 ^ w13 ^ w7 ^ w5),S1); ROTATE2_F(E, A, B, C, D, w4);
w5 = rotate((w2 ^ w14 ^ w8 ^ w6),S1); ROTATE2_F(D, E, A, B, C, w5);
w6 = rotate((w3 ^ SIZE ^ w9 ^ w7),S1);ROTATE2_F(C, D, E, A, B, w6);
w7 = rotate((w4 ^ w16 ^ w10 ^ w8),S1); ROTATE2_F(B, C, D, E, A, w7);
w8 = rotate((w5 ^ w0 ^ w11 ^ w9),S1); ROTATE2_F(A, B, C, D, E, w8);
w9 = rotate((w6 ^ w1 ^ w12 ^ w10),S1); ROTATE2_F(E, A, B, C, D, w9);
w10 = rotate((w7 ^ w2 ^ w13 ^ w11),S1); ROTATE2_F(D, E, A, B, C, w10); 
w11 = rotate((w8 ^ w3 ^ w14 ^ w12),S1); ROTATE2_F(C, D, E, A, B, w11); 
w12 = rotate((w9 ^ w4 ^ SIZE ^ w13),S1); ROTATE2_F(B, C, D, E, A, w12);
w13 = rotate((w10 ^ w5 ^ w16 ^ w14),S1); ROTATE2_F(A, B, C, D, E, w13);
w14 = rotate((w11 ^ w6 ^ w0 ^ SIZE),S1); ROTATE2_F(E, A, B, C, D, w14);
SIZE = rotate((w12 ^ w7 ^ w1 ^ w16),S1); ROTATE2_F(D, E, A, B, C, SIZE);
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1); ROTATE2_F(C, D, E, A, B, w16);  
w0 = rotate(w14 ^ w9 ^ w3 ^ w1,S1); ROTATE2_F(B, C, D, E, A, w0);  
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2,S1); ROTATE2_F(A, B, C, D, E, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE2_F(E, A, B, C, D, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE2_F(D, E, A, B, C, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1);ROTATE2_F(C, D, E, A, B, w4);
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE2_F(B, C, D, E, A, w5);  
K = K2;
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(A, B, C, D, E, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(E, A, B, C, D, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(D, E, A, B, C, w8); 
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE3_F(C, D, E, A, B, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE3_F(B, C, D, E, A, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE3_F(A, B, C, D, E, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE3_F(E, A, B, C, D, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE3_F(D, E, A, B, C, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE3_F(C, D, E, A, B, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE3_F(B, C, D, E, A, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE3_F(A, B, C, D, E, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE3_F(E, A, B, C, D, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE3_F(D, E, A, B, C, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3, S1); ROTATE3_F(C, D, E, A, B, w2);
w3 = rotate(w0 ^ w12 ^ w6 ^ w4, S1); ROTATE3_F(B, C, D, E, A, w3); 
w4 = rotate(w1 ^ w13 ^ w7 ^ w5, S1); ROTATE3_F(A, B, C, D, E, w4); 
w5 = rotate(w2 ^ w14 ^ w8 ^ w6, S1); ROTATE3_F(E, A, B, C, D, w5); 
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(D, E, A, B, C, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(C, D, E, A, B, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(B, C, D, E, A, w8); 
K = K3;
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE4_F(A, B, C, D, E, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE4_F(E, A, B, C, D, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE4_F(D, E, A, B, C, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE4_F(C, D, E, A, B, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE4_F(B, C, D, E, A, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE4_F(A, B, C, D, E, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE4_F(E, A, B, C, D, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE4_F(D, E, A, B, C, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE4_F(C, D, E, A, B, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE4_F(B, C, D, E, A, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE4_F(A, B, C, D, E, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE4_F(E, A, B, C, D, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1); ROTATE4_F(D, E, A, B, C, w4);  
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE4_F(C, D, E, A, B, w5);  
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7,S1); ROTATE4_F(B, C, D, E, A, w6); 
w7 = rotate(w4 ^ w16 ^ w10 ^ w8,S1); ROTATE4_F(A, B, C, D, E, w7); 
w8 = rotate(w5 ^ w0 ^ w11 ^ w9,S1); ROTATE4_F(E, A, B, C, D, w8);  
w9 = rotate(w6 ^ w1 ^ w12 ^ w10,S1); ROTATE4_F(D, E, A, B, C, w9); 
w10 = rotate(w7 ^ w2 ^ w13 ^ w11,S1); ROTATE4_F(C, D, E, A, B, w10);
w11 = rotate(w8 ^ w3 ^ w14 ^ w12,S1); ROTATE4_F(B, C, D, E, A, w11);

IPA=A+H0;IPB=B+H1;IPC=C+H2;IPD=D+H3;IPE=E+H4;



// Calculate sha1(opad^key)
w0=TTTA^(uint2)0x5c5c5c5c;
w1=TTTB^(uint2)0x5c5c5c5c;
w2=TTTC^(uint2)0x5c5c5c5c;
w3=TTTD^(uint2)0x5c5c5c5c;
w4=TTTE^(uint2)0x5c5c5c5c;
w5=TTA^(uint2)0x5c5c5c5c;
w6=TTB^(uint2)0x5c5c5c5c;
w7=TTC^(uint2)0x5c5c5c5c;

w8=w9=w10=w11=w12=w13=w14=SIZE=(uint2)0x5c5c5c5c;
A=H0;
B=H1;
C=H2;
D=H3;
E=H4;
K = K0;
ROTATE1(A, B, C, D, E, w0);
ROTATE1(E, A, B, C, D, w1);
ROTATE1(D, E, A, B, C, w2);
ROTATE1(C, D, E, A, B, w3);
ROTATE1(B, C, D, E, A, w4);
ROTATE1(A, B, C, D, E, w5);
ROTATE1(E, A, B, C, D, w6);
ROTATE1(D, E, A, B, C, w7);
ROTATE1(C, D, E, A, B, w8);
ROTATE1(B, C, D, E, A, w9);
ROTATE1(A, B, C, D, E, w10);
ROTATE1(E, A, B, C, D, w11);
ROTATE1(D, E, A, B, C, w12);
ROTATE1(C, D, E, A, B, w13);
ROTATE1(B, C, D, E, A, w14);
ROTATE1(A, B, C, D, E, SIZE);  
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1);ROTATE1(E,A,B,C,D,w16);
w0 = rotate((w14 ^ w9 ^ w3 ^ w1),S1);ROTATE1(D,E,A,B,C,w0); 
w1 = rotate((SIZE ^ w10 ^ w4 ^ w2),S1); ROTATE1(C,D,E,A,B,w1); 
w2 = rotate((w16 ^ w11 ^ w5 ^ w3),S1);  ROTATE1(B,C,D,E,A,w2); 
K = K1;
w3 = rotate((w0 ^ w12 ^ w6 ^ w4),S1); ROTATE2_F(A, B, C, D, E, w3);
w4 = rotate((w1 ^ w13 ^ w7 ^ w5),S1); ROTATE2_F(E, A, B, C, D, w4);
w5 = rotate((w2 ^ w14 ^ w8 ^ w6),S1); ROTATE2_F(D, E, A, B, C, w5);
w6 = rotate((w3 ^ SIZE ^ w9 ^ w7),S1);ROTATE2_F(C, D, E, A, B, w6);
w7 = rotate((w4 ^ w16 ^ w10 ^ w8),S1); ROTATE2_F(B, C, D, E, A, w7);
w8 = rotate((w5 ^ w0 ^ w11 ^ w9),S1); ROTATE2_F(A, B, C, D, E, w8);
w9 = rotate((w6 ^ w1 ^ w12 ^ w10),S1); ROTATE2_F(E, A, B, C, D, w9);
w10 = rotate((w7 ^ w2 ^ w13 ^ w11),S1); ROTATE2_F(D, E, A, B, C, w10); 
w11 = rotate((w8 ^ w3 ^ w14 ^ w12),S1); ROTATE2_F(C, D, E, A, B, w11); 
w12 = rotate((w9 ^ w4 ^ SIZE ^ w13),S1); ROTATE2_F(B, C, D, E, A, w12);
w13 = rotate((w10 ^ w5 ^ w16 ^ w14),S1); ROTATE2_F(A, B, C, D, E, w13);
w14 = rotate((w11 ^ w6 ^ w0 ^ SIZE),S1); ROTATE2_F(E, A, B, C, D, w14);
SIZE = rotate((w12 ^ w7 ^ w1 ^ w16),S1); ROTATE2_F(D, E, A, B, C, SIZE);
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1); ROTATE2_F(C, D, E, A, B, w16);  
w0 = rotate(w14 ^ w9 ^ w3 ^ w1,S1); ROTATE2_F(B, C, D, E, A, w0);  
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2,S1); ROTATE2_F(A, B, C, D, E, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE2_F(E, A, B, C, D, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE2_F(D, E, A, B, C, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1);ROTATE2_F(C, D, E, A, B, w4);
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE2_F(B, C, D, E, A, w5);  
K = K2;
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(A, B, C, D, E, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(E, A, B, C, D, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(D, E, A, B, C, w8); 
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE3_F(C, D, E, A, B, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE3_F(B, C, D, E, A, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE3_F(A, B, C, D, E, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE3_F(E, A, B, C, D, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE3_F(D, E, A, B, C, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE3_F(C, D, E, A, B, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE3_F(B, C, D, E, A, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE3_F(A, B, C, D, E, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE3_F(E, A, B, C, D, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE3_F(D, E, A, B, C, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3, S1); ROTATE3_F(C, D, E, A, B, w2);
w3 = rotate(w0 ^ w12 ^ w6 ^ w4, S1); ROTATE3_F(B, C, D, E, A, w3); 
w4 = rotate(w1 ^ w13 ^ w7 ^ w5, S1); ROTATE3_F(A, B, C, D, E, w4); 
w5 = rotate(w2 ^ w14 ^ w8 ^ w6, S1); ROTATE3_F(E, A, B, C, D, w5); 
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(D, E, A, B, C, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(C, D, E, A, B, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(B, C, D, E, A, w8); 
K = K3;
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE4_F(A, B, C, D, E, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE4_F(E, A, B, C, D, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE4_F(D, E, A, B, C, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE4_F(C, D, E, A, B, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE4_F(B, C, D, E, A, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE4_F(A, B, C, D, E, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE4_F(E, A, B, C, D, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE4_F(D, E, A, B, C, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE4_F(C, D, E, A, B, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE4_F(B, C, D, E, A, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE4_F(A, B, C, D, E, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE4_F(E, A, B, C, D, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1); ROTATE4_F(D, E, A, B, C, w4);  
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE4_F(C, D, E, A, B, w5);  
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7,S1); ROTATE4_F(B, C, D, E, A, w6); 
w7 = rotate(w4 ^ w16 ^ w10 ^ w8,S1); ROTATE4_F(A, B, C, D, E, w7); 
w8 = rotate(w5 ^ w0 ^ w11 ^ w9,S1); ROTATE4_F(E, A, B, C, D, w8);  
w9 = rotate(w6 ^ w1 ^ w12 ^ w10,S1); ROTATE4_F(D, E, A, B, C, w9); 
w10 = rotate(w7 ^ w2 ^ w13 ^ w11,S1); ROTATE4_F(C, D, E, A, B, w10);
w11 = rotate(w8 ^ w3 ^ w14 ^ w12,S1); ROTATE4_F(B, C, D, E, A, w11);

OPA=A+H0;OPB=B+H1;OPC=C+H2;OPD=D+H3;OPE=E+H4;


// calculate hash sum 1 part 1
A=IPA;
B=IPB;
C=IPC;
D=IPD;
E=IPE;

w0=(uint2)block[0];
w1=(uint2)block[1];
w2=(uint2)block[2];
w3=(uint2)block[3];
w4=(uint2)block[4];
w5=(uint2)block[5];
w6=(uint2)block[6];
w7=(uint2)block[7];
w8=(uint2)block[8];
w9=(uint2)block[9];
w10=(uint2)block[10];
w11=(uint2)block[11];
w12=(uint2)block[12];
w13=(uint2)block[13];
w14=(uint2)block[14];
SIZE=(uint2)block[15];

K = K0;
Endian_Reverse32(w0);  
ROTATE1(A, B, C, D, E, w0);
Endian_Reverse32(w1);  
ROTATE1(E, A, B, C, D, w1);
Endian_Reverse32(w2);  
ROTATE1(D, E, A, B, C, w2);
Endian_Reverse32(w3);  
ROTATE1(C, D, E, A, B, w3);
Endian_Reverse32(w4);  
ROTATE1(B, C, D, E, A, w4);
Endian_Reverse32(w5);  
ROTATE1(A, B, C, D, E, w5);
Endian_Reverse32(w6);  
ROTATE1(E, A, B, C, D, w6);
Endian_Reverse32(w7);  
ROTATE1(D, E, A, B, C, w7);
Endian_Reverse32(w8);  
ROTATE1(C, D, E, A, B, w8);
Endian_Reverse32(w9);  
ROTATE1(B, C, D, E, A, w9);
Endian_Reverse32(w10);  
ROTATE1(A, B, C, D, E, w10);
Endian_Reverse32(w11);  
ROTATE1(E, A, B, C, D, w11);
Endian_Reverse32(w12);  
ROTATE1(D, E, A, B, C, w12);
Endian_Reverse32(w13);  
ROTATE1(C, D, E, A, B, w13);
Endian_Reverse32(w14);  
ROTATE1(B, C, D, E, A, w14);
Endian_Reverse32(SIZE);  
ROTATE1(A, B, C, D, E, SIZE);  
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1);ROTATE1(E,A,B,C,D,w16);
w0 = rotate((w14 ^ w9 ^ w3 ^ w1),S1);ROTATE1(D,E,A,B,C,w0); 
w1 = rotate((SIZE ^ w10 ^ w4 ^ w2),S1); ROTATE1(C,D,E,A,B,w1); 
w2 = rotate((w16 ^ w11 ^ w5 ^ w3),S1);  ROTATE1(B,C,D,E,A,w2); 
K = K1;
w3 = rotate((w0 ^ w12 ^ w6 ^ w4),S1); ROTATE2_F(A, B, C, D, E, w3);
w4 = rotate((w1 ^ w13 ^ w7 ^ w5),S1); ROTATE2_F(E, A, B, C, D, w4);
w5 = rotate((w2 ^ w14 ^ w8 ^ w6),S1); ROTATE2_F(D, E, A, B, C, w5);
w6 = rotate((w3 ^ SIZE ^ w9 ^ w7),S1);ROTATE2_F(C, D, E, A, B, w6);
w7 = rotate((w4 ^ w16 ^ w10 ^ w8),S1); ROTATE2_F(B, C, D, E, A, w7);
w8 = rotate((w5 ^ w0 ^ w11 ^ w9),S1); ROTATE2_F(A, B, C, D, E, w8);
w9 = rotate((w6 ^ w1 ^ w12 ^ w10),S1); ROTATE2_F(E, A, B, C, D, w9);
w10 = rotate((w7 ^ w2 ^ w13 ^ w11),S1); ROTATE2_F(D, E, A, B, C, w10); 
w11 = rotate((w8 ^ w3 ^ w14 ^ w12),S1); ROTATE2_F(C, D, E, A, B, w11); 
w12 = rotate((w9 ^ w4 ^ SIZE ^ w13),S1); ROTATE2_F(B, C, D, E, A, w12);
w13 = rotate((w10 ^ w5 ^ w16 ^ w14),S1); ROTATE2_F(A, B, C, D, E, w13);
w14 = rotate((w11 ^ w6 ^ w0 ^ SIZE),S1); ROTATE2_F(E, A, B, C, D, w14);
SIZE = rotate((w12 ^ w7 ^ w1 ^ w16),S1); ROTATE2_F(D, E, A, B, C, SIZE);
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1); ROTATE2_F(C, D, E, A, B, w16);  
w0 = rotate(w14 ^ w9 ^ w3 ^ w1,S1); ROTATE2_F(B, C, D, E, A, w0);  
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2,S1); ROTATE2_F(A, B, C, D, E, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE2_F(E, A, B, C, D, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE2_F(D, E, A, B, C, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1);ROTATE2_F(C, D, E, A, B, w4);
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE2_F(B, C, D, E, A, w5);  
K = K2;
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(A, B, C, D, E, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(E, A, B, C, D, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(D, E, A, B, C, w8); 
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE3_F(C, D, E, A, B, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE3_F(B, C, D, E, A, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE3_F(A, B, C, D, E, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE3_F(E, A, B, C, D, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE3_F(D, E, A, B, C, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE3_F(C, D, E, A, B, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE3_F(B, C, D, E, A, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE3_F(A, B, C, D, E, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE3_F(E, A, B, C, D, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE3_F(D, E, A, B, C, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3, S1); ROTATE3_F(C, D, E, A, B, w2);
w3 = rotate(w0 ^ w12 ^ w6 ^ w4, S1); ROTATE3_F(B, C, D, E, A, w3); 
w4 = rotate(w1 ^ w13 ^ w7 ^ w5, S1); ROTATE3_F(A, B, C, D, E, w4); 
w5 = rotate(w2 ^ w14 ^ w8 ^ w6, S1); ROTATE3_F(E, A, B, C, D, w5); 
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(D, E, A, B, C, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(C, D, E, A, B, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(B, C, D, E, A, w8); 
K = K3;
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE4_F(A, B, C, D, E, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE4_F(E, A, B, C, D, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE4_F(D, E, A, B, C, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE4_F(C, D, E, A, B, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE4_F(B, C, D, E, A, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE4_F(A, B, C, D, E, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE4_F(E, A, B, C, D, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE4_F(D, E, A, B, C, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE4_F(C, D, E, A, B, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE4_F(B, C, D, E, A, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE4_F(A, B, C, D, E, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE4_F(E, A, B, C, D, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1); ROTATE4_F(D, E, A, B, C, w4);  
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE4_F(C, D, E, A, B, w5);  
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7,S1); ROTATE4_F(B, C, D, E, A, w6); 
w7 = rotate(w4 ^ w16 ^ w10 ^ w8,S1); ROTATE4_F(A, B, C, D, E, w7); 
w8 = rotate(w5 ^ w0 ^ w11 ^ w9,S1); ROTATE4_F(E, A, B, C, D, w8);  
w9 = rotate(w6 ^ w1 ^ w12 ^ w10,S1); ROTATE4_F(D, E, A, B, C, w9); 
w10 = rotate(w7 ^ w2 ^ w13 ^ w11,S1); ROTATE4_F(C, D, E, A, B, w10);
w11 = rotate(w8 ^ w3 ^ w14 ^ w12,S1); ROTATE4_F(B, C, D, E, A, w11);
A=A+IPA;B=B+IPB;C=C+IPC;D=D+IPD;E=E+IPE;

TTA=A;TTB=B;TTC=C;TTD=D;TTE=E;
// calculate hash sum 1 part 1

w0=(uint2)block[16];
w1=(uint2)block[17];
w2=(uint2)block[18];
w3=(uint2)block[19];
w4=(uint2)block[20];
w5=(uint2)block[21];
w6=(uint2)block[22];
w7=(uint2)block[23];
w8=(uint2)block[24];
w9=(uint2)0x80000000;
w10=w11=w12=w13=w14=(uint2)0;
SIZE=(uint2)((164)<<3);

K = K0;
Endian_Reverse32(w0);  
ROTATE1(A, B, C, D, E, w0);
Endian_Reverse32(w1);  
ROTATE1(E, A, B, C, D, w1);
Endian_Reverse32(w2);  
ROTATE1(D, E, A, B, C, w2);
Endian_Reverse32(w3);  
ROTATE1(C, D, E, A, B, w3);
Endian_Reverse32(w4);  
ROTATE1(B, C, D, E, A, w4);
Endian_Reverse32(w5);  
ROTATE1(A, B, C, D, E, w5);
Endian_Reverse32(w6);  
ROTATE1(E, A, B, C, D, w6);
Endian_Reverse32(w7);  
ROTATE1(D, E, A, B, C, w7);
Endian_Reverse32(w8);  
ROTATE1(C, D, E, A, B, w8);
ROTATE1(B, C, D, E, A, w9);
ROTATE1(A, B, C, D, E, w10);
ROTATE1(E, A, B, C, D, w11);
ROTATE1(D, E, A, B, C, w12);
ROTATE1(C, D, E, A, B, w13);
ROTATE1(B, C, D, E, A, w14);
ROTATE1(A, B, C, D, E, SIZE);  
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1);ROTATE1(E,A,B,C,D,w16);
w0 = rotate((w14 ^ w9 ^ w3 ^ w1),S1);ROTATE1(D,E,A,B,C,w0); 
w1 = rotate((SIZE ^ w10 ^ w4 ^ w2),S1); ROTATE1(C,D,E,A,B,w1); 
w2 = rotate((w16 ^ w11 ^ w5 ^ w3),S1);  ROTATE1(B,C,D,E,A,w2); 
K = K1;
w3 = rotate((w0 ^ w12 ^ w6 ^ w4),S1); ROTATE2_F(A, B, C, D, E, w3);
w4 = rotate((w1 ^ w13 ^ w7 ^ w5),S1); ROTATE2_F(E, A, B, C, D, w4);
w5 = rotate((w2 ^ w14 ^ w8 ^ w6),S1); ROTATE2_F(D, E, A, B, C, w5);
w6 = rotate((w3 ^ SIZE ^ w9 ^ w7),S1);ROTATE2_F(C, D, E, A, B, w6);
w7 = rotate((w4 ^ w16 ^ w10 ^ w8),S1); ROTATE2_F(B, C, D, E, A, w7);
w8 = rotate((w5 ^ w0 ^ w11 ^ w9),S1); ROTATE2_F(A, B, C, D, E, w8);
w9 = rotate((w6 ^ w1 ^ w12 ^ w10),S1); ROTATE2_F(E, A, B, C, D, w9);
w10 = rotate((w7 ^ w2 ^ w13 ^ w11),S1); ROTATE2_F(D, E, A, B, C, w10); 
w11 = rotate((w8 ^ w3 ^ w14 ^ w12),S1); ROTATE2_F(C, D, E, A, B, w11); 
w12 = rotate((w9 ^ w4 ^ SIZE ^ w13),S1); ROTATE2_F(B, C, D, E, A, w12);
w13 = rotate((w10 ^ w5 ^ w16 ^ w14),S1); ROTATE2_F(A, B, C, D, E, w13);
w14 = rotate((w11 ^ w6 ^ w0 ^ SIZE),S1); ROTATE2_F(E, A, B, C, D, w14);
SIZE = rotate((w12 ^ w7 ^ w1 ^ w16),S1); ROTATE2_F(D, E, A, B, C, SIZE);
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1); ROTATE2_F(C, D, E, A, B, w16);  
w0 = rotate(w14 ^ w9 ^ w3 ^ w1,S1); ROTATE2_F(B, C, D, E, A, w0);  
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2,S1); ROTATE2_F(A, B, C, D, E, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE2_F(E, A, B, C, D, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE2_F(D, E, A, B, C, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1);ROTATE2_F(C, D, E, A, B, w4);
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE2_F(B, C, D, E, A, w5);  
K = K2;
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(A, B, C, D, E, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(E, A, B, C, D, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(D, E, A, B, C, w8); 
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE3_F(C, D, E, A, B, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE3_F(B, C, D, E, A, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE3_F(A, B, C, D, E, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE3_F(E, A, B, C, D, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE3_F(D, E, A, B, C, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE3_F(C, D, E, A, B, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE3_F(B, C, D, E, A, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE3_F(A, B, C, D, E, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE3_F(E, A, B, C, D, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE3_F(D, E, A, B, C, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3, S1); ROTATE3_F(C, D, E, A, B, w2);
w3 = rotate(w0 ^ w12 ^ w6 ^ w4, S1); ROTATE3_F(B, C, D, E, A, w3); 
w4 = rotate(w1 ^ w13 ^ w7 ^ w5, S1); ROTATE3_F(A, B, C, D, E, w4); 
w5 = rotate(w2 ^ w14 ^ w8 ^ w6, S1); ROTATE3_F(E, A, B, C, D, w5); 
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(D, E, A, B, C, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(C, D, E, A, B, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(B, C, D, E, A, w8); 
K = K3;
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE4_F(A, B, C, D, E, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE4_F(E, A, B, C, D, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE4_F(D, E, A, B, C, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE4_F(C, D, E, A, B, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE4_F(B, C, D, E, A, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE4_F(A, B, C, D, E, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE4_F(E, A, B, C, D, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE4_F(D, E, A, B, C, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE4_F(C, D, E, A, B, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE4_F(B, C, D, E, A, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE4_F(A, B, C, D, E, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE4_F(E, A, B, C, D, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1); ROTATE4_F(D, E, A, B, C, w4);  
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE4_F(C, D, E, A, B, w5);  
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7,S1); ROTATE4_F(B, C, D, E, A, w6); 
w7 = rotate(w4 ^ w16 ^ w10 ^ w8,S1); ROTATE4_F(A, B, C, D, E, w7); 
w8 = rotate(w5 ^ w0 ^ w11 ^ w9,S1); ROTATE4_F(E, A, B, C, D, w8);  
w9 = rotate(w6 ^ w1 ^ w12 ^ w10,S1); ROTATE4_F(D, E, A, B, C, w9); 
w10 = rotate(w7 ^ w2 ^ w13 ^ w11,S1); ROTATE4_F(C, D, E, A, B, w10);
w11 = rotate(w8 ^ w3 ^ w14 ^ w12,S1); ROTATE4_F(B, C, D, E, A, w11);
A=A+TTA;B=B+TTB;C=C+TTC;D=D+TTD;E=E+TTE;


// calculate hash sum 2

w0=A;
w1=B;
w2=C;
w3=D;
w4=E;
w5=(uint2)0x80000000;
A=OPA;
B=OPB;
C=OPC;
D=OPD;
E=OPE;
SIZE=(uint2)((64+20)<<3);
w6=w7=w8=w9=w10=w11=w12=w13=w14=(uint2)0;


K = K0;
ROTATE1(A, B, C, D, E, w0);
ROTATE1(E, A, B, C, D, w1);
ROTATE1(D, E, A, B, C, w2);
ROTATE1(C, D, E, A, B, w3);
ROTATE1(B, C, D, E, A, w4);
ROTATE1(A, B, C, D, E, w5);
ROTATE1(E, A, B, C, D, w6);
ROTATE1(D, E, A, B, C, w7);
ROTATE1(C, D, E, A, B, w8);
ROTATE1(B, C, D, E, A, w9);
ROTATE1(A, B, C, D, E, w10);
ROTATE1(E, A, B, C, D, w11);
ROTATE1(D, E, A, B, C, w12);
ROTATE1(C, D, E, A, B, w13);
ROTATE1(B, C, D, E, A, w14);
ROTATE1(A, B, C, D, E, SIZE);  
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1);ROTATE1(E,A,B,C,D,w16);
w0 = rotate((w14 ^ w9 ^ w3 ^ w1),S1);ROTATE1(D,E,A,B,C,w0); 
w1 = rotate((SIZE ^ w10 ^ w4 ^ w2),S1); ROTATE1(C,D,E,A,B,w1); 
w2 = rotate((w16 ^ w11 ^ w5 ^ w3),S1);  ROTATE1(B,C,D,E,A,w2); 
K = K1;
w3 = rotate((w0 ^ w12 ^ w6 ^ w4),S1); ROTATE2_F(A, B, C, D, E, w3);
w4 = rotate((w1 ^ w13 ^ w7 ^ w5),S1); ROTATE2_F(E, A, B, C, D, w4);
w5 = rotate((w2 ^ w14 ^ w8 ^ w6),S1); ROTATE2_F(D, E, A, B, C, w5);
w6 = rotate((w3 ^ SIZE ^ w9 ^ w7),S1);ROTATE2_F(C, D, E, A, B, w6);
w7 = rotate((w4 ^ w16 ^ w10 ^ w8),S1); ROTATE2_F(B, C, D, E, A, w7);
w8 = rotate((w5 ^ w0 ^ w11 ^ w9),S1); ROTATE2_F(A, B, C, D, E, w8);
w9 = rotate((w6 ^ w1 ^ w12 ^ w10),S1); ROTATE2_F(E, A, B, C, D, w9);
w10 = rotate((w7 ^ w2 ^ w13 ^ w11),S1); ROTATE2_F(D, E, A, B, C, w10); 
w11 = rotate((w8 ^ w3 ^ w14 ^ w12),S1); ROTATE2_F(C, D, E, A, B, w11); 
w12 = rotate((w9 ^ w4 ^ SIZE ^ w13),S1); ROTATE2_F(B, C, D, E, A, w12);
w13 = rotate((w10 ^ w5 ^ w16 ^ w14),S1); ROTATE2_F(A, B, C, D, E, w13);
w14 = rotate((w11 ^ w6 ^ w0 ^ SIZE),S1); ROTATE2_F(E, A, B, C, D, w14);
SIZE = rotate((w12 ^ w7 ^ w1 ^ w16),S1); ROTATE2_F(D, E, A, B, C, SIZE);
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1); ROTATE2_F(C, D, E, A, B, w16);  
w0 = rotate(w14 ^ w9 ^ w3 ^ w1,S1); ROTATE2_F(B, C, D, E, A, w0);  
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2,S1); ROTATE2_F(A, B, C, D, E, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE2_F(E, A, B, C, D, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE2_F(D, E, A, B, C, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1);ROTATE2_F(C, D, E, A, B, w4);
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE2_F(B, C, D, E, A, w5);  
K = K2;
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(A, B, C, D, E, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(E, A, B, C, D, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(D, E, A, B, C, w8); 
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE3_F(C, D, E, A, B, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE3_F(B, C, D, E, A, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE3_F(A, B, C, D, E, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE3_F(E, A, B, C, D, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE3_F(D, E, A, B, C, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE3_F(C, D, E, A, B, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE3_F(B, C, D, E, A, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE3_F(A, B, C, D, E, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE3_F(E, A, B, C, D, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE3_F(D, E, A, B, C, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3, S1); ROTATE3_F(C, D, E, A, B, w2);
w3 = rotate(w0 ^ w12 ^ w6 ^ w4, S1); ROTATE3_F(B, C, D, E, A, w3); 
w4 = rotate(w1 ^ w13 ^ w7 ^ w5, S1); ROTATE3_F(A, B, C, D, E, w4); 
w5 = rotate(w2 ^ w14 ^ w8 ^ w6, S1); ROTATE3_F(E, A, B, C, D, w5); 
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(D, E, A, B, C, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(C, D, E, A, B, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(B, C, D, E, A, w8); 
K = K3;
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE4_F(A, B, C, D, E, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE4_F(E, A, B, C, D, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE4_F(D, E, A, B, C, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE4_F(C, D, E, A, B, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE4_F(B, C, D, E, A, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE4_F(A, B, C, D, E, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE4_F(E, A, B, C, D, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE4_F(D, E, A, B, C, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE4_F(C, D, E, A, B, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE4_F(B, C, D, E, A, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE4_F(A, B, C, D, E, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE4_F(E, A, B, C, D, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1); ROTATE4_F(D, E, A, B, C, w4);  
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE4_F(C, D, E, A, B, w5);  
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7,S1); ROTATE4_F(B, C, D, E, A, w6); 
w7 = rotate(w4 ^ w16 ^ w10 ^ w8,S1); ROTATE4_F(A, B, C, D, E, w7); 
w8 = rotate(w5 ^ w0 ^ w11 ^ w9,S1); ROTATE4_F(E, A, B, C, D, w8);  
w9 = rotate(w6 ^ w1 ^ w12 ^ w10,S1); ROTATE4_F(D, E, A, B, C, w9); 
w10 = rotate(w7 ^ w2 ^ w13 ^ w11,S1); ROTATE4_F(C, D, E, A, B, w10);
w11 = rotate(w8 ^ w3 ^ w14 ^ w12,S1); ROTATE4_F(B, C, D, E, A, w11);
A=A+OPA;B=B+OPB;C=C+OPC;D=D+OPD;E=E+OPE;
TTA=A;
TTB=B;
TTC=C;
TTD=D;
Endian_Reverse32(TTA);
Endian_Reverse32(TTB);
Endian_Reverse32(TTC);
Endian_Reverse32(TTD);



// HMAC-MD5 (PTK,eapol)
mCa  = (uint2)Ca;
mCb  = (uint2)Cb;
mCc  = (uint2)Cc;
mCd  = (uint2)Cd;




a = mCa; b = mCb; c = mCc; d = mCd;  
w0=TTA^(uint2)0x36363636;
w1=TTB^(uint2)0x36363636;
w2=TTC^(uint2)0x36363636;
w3=TTD^(uint2)0x36363636;

w4=w5=w6=w7=w8=w9=w10=w11=w12=w13=SIZE=w15=(uint2)0x36363636;

MD5STEP_ROUND1(a, b, c, d, mAC1, w0, S11);
MD5STEP_ROUND1(d, a, b, c, mAC2, w1, S12);
MD5STEP_ROUND1(c, d, a, b, mAC3, w2, S13);
MD5STEP_ROUND1(b, c, d, a, mAC4, w3, S14);
MD5STEP_ROUND1(a, b, c, d, mAC5, w4, S11);
MD5STEP_ROUND1(d, a, b, c, mAC6, w5, S12);
MD5STEP_ROUND1(c, d, a, b, mAC7, w6, S13);
MD5STEP_ROUND1(b, c, d, a, mAC8, w7, S14);
MD5STEP_ROUND1(a, b, c, d, mAC9, w8, S11);
MD5STEP_ROUND1(d, a, b, c, mAC10, w9, S12);
MD5STEP_ROUND1(c, d, a, b, mAC11, w10,S13);  
MD5STEP_ROUND1(b, c, d, a, mAC12, w11,S14);  
MD5STEP_ROUND1(a, b, c, d, mAC13, w12,S11);  
MD5STEP_ROUND1(d, a, b, c, mAC14, w13,S12);  
MD5STEP_ROUND1(c, d, a, b, mAC15, SIZE, S13);
MD5STEP_ROUND1(b, c, d, a, mAC16, w15, S14);  

MD5STEP_ROUND2 (a, b, c, d, mAC17, w1, S21);  
MD5STEP_ROUND2 (d, a, b, c, mAC18, w6, S22); 
MD5STEP_ROUND2 (c, d, a, b, mAC19, w11, S23); 
MD5STEP_ROUND2 (b, c, d, a, mAC20, w0, S24);  
MD5STEP_ROUND2 (a, b, c, d, mAC21, w5, S21); 
MD5STEP_ROUND2 (d, a, b, c, mAC22, w10,S22); 
MD5STEP_ROUND2 (c, d,  a, b, mAC23, w15, S23); 
MD5STEP_ROUND2 (b, c, d, a, mAC24, w4, S24); 
MD5STEP_ROUND2 (a, b, c, d, mAC25, w9, S21); 
MD5STEP_ROUND2 (d, a, b, c, mAC26, SIZE, S22);
MD5STEP_ROUND2 (c, d, a, b, mAC27, w3, S23);  
MD5STEP_ROUND2 (b, c, d, a, mAC28, w8, S24); 
MD5STEP_ROUND2 (a, b, c, d, mAC29, w13, S21);  
MD5STEP_ROUND2 (d, a, b, c, mAC30, w2, S22);  
MD5STEP_ROUND2 (c, d, a, b, mAC31, w7, S23); 
MD5STEP_ROUND2 (b, c, d, a, mAC32, w12, S24);  

MD5STEP_ROUND3 (a, b, c, d, mAC33, w5, S31);
MD5STEP_ROUND3 (d, a, b, c, mAC34, w8, S32);
MD5STEP_ROUND3 (c, d, a, b, mAC35, w11, S33);
MD5STEP_ROUND3 (b, c, d, a, mAC36, SIZE, S34);  
MD5STEP_ROUND3 (a, b, c, d, mAC37, w1, S31);
MD5STEP_ROUND3 (d, a, b, c, mAC38, w4, S32);
MD5STEP_ROUND3 (c, d, a, b, mAC39, w7, S33);
MD5STEP_ROUND3 (b, c, d, a, mAC40, w10, S34);
MD5STEP_ROUND3 (a, b, c, d, mAC41, w13, S31);
MD5STEP_ROUND3 (d, a, b, c, mAC42, w0, S32);
MD5STEP_ROUND3 (c, d, a, b, mAC43, w3, S33);
MD5STEP_ROUND3 (b, c, d, a, mAC44, w6, S34);
MD5STEP_ROUND3 (a, b, c, d, mAC45, w9, S31);
MD5STEP_ROUND3 (d, a, b, c, mAC46, w12, S32);
MD5STEP_ROUND3 (c, d, a, b, mAC47, w15, S33);
MD5STEP_ROUND3 (b, c, d, a, mAC48, w2, S34);

MD5STEP_ROUND4 (a, b, c, d, mAC49, w0, S41);  
MD5STEP_ROUND4 (d, a, b, c, mAC50, w7, S42); 
MD5STEP_ROUND4 (c, d, a, b, mAC51, SIZE, S43);
MD5STEP_ROUND4 (b, c, d, a, mAC52, w5, S44); 
MD5STEP_ROUND4 (a, b, c, d, mAC53, w12, S41);  
MD5STEP_ROUND4 (d, a, b, c, mAC54, w3, S42);  
MD5STEP_ROUND4 (c, d, a, b, mAC55, w10, S43); 
MD5STEP_ROUND4 (b, c, d, a, mAC56, w1, S44);  
MD5STEP_ROUND4 (a, b, c, d, mAC57, w8, S41); 
MD5STEP_ROUND4 (d, a, b, c, mAC58, w15, S42);  
MD5STEP_ROUND4 (c, d, a, b, mAC59, w6, S43); 
MD5STEP_ROUND4 (b, c, d, a, mAC60, w13, S44);  
MD5STEP_ROUND4 (a, b, c, d, mAC61, w4, S41); 
MD5STEP_ROUND4 (d, a, b, c, mAC62, w11, S42); 
MD5STEP_ROUND4 (c, d, a, b, mAC63, w2, S43);  
MD5STEP_ROUND4 (b, c, d, a, mAC64, w9, S44); 

IPA=a+mCa;IPB=b+mCb;IPC=c+mCc;IPD=d+mCd;


a = mCa; b = mCb; c = mCc; d = mCd;  
w0=TTA^(uint2)0x5c5c5c5c;
w1=TTB^(uint2)0x5c5c5c5c;
w2=TTC^(uint2)0x5c5c5c5c;
w3=TTD^(uint2)0x5c5c5c5c;

w4=w5=w6=w7=w8=w9=w10=w11=w12=w13=SIZE=w15=(uint2)0x5c5c5c5c;

MD5STEP_ROUND1(a, b, c, d, mAC1, w0, S11);
MD5STEP_ROUND1(d, a, b, c, mAC2, w1, S12);
MD5STEP_ROUND1(c, d, a, b, mAC3, w2, S13);
MD5STEP_ROUND1(b, c, d, a, mAC4, w3, S14);
MD5STEP_ROUND1(a, b, c, d, mAC5, w4, S11);
MD5STEP_ROUND1(d, a, b, c, mAC6, w5, S12);
MD5STEP_ROUND1(c, d, a, b, mAC7, w6, S13);
MD5STEP_ROUND1(b, c, d, a, mAC8, w7, S14);
MD5STEP_ROUND1(a, b, c, d, mAC9, w8, S11);
MD5STEP_ROUND1(d, a, b, c, mAC10, w9, S12);
MD5STEP_ROUND1(c, d, a, b, mAC11, w10,S13);  
MD5STEP_ROUND1(b, c, d, a, mAC12, w11,S14);  
MD5STEP_ROUND1(a, b, c, d, mAC13, w12,S11);  
MD5STEP_ROUND1(d, a, b, c, mAC14, w13,S12);  
MD5STEP_ROUND1(c, d, a, b, mAC15, SIZE, S13);
MD5STEP_ROUND1(b, c, d, a, mAC16, w15, S14);  
MD5STEP_ROUND2 (a, b, c, d, mAC17, w1, S21);  
MD5STEP_ROUND2 (d, a, b, c, mAC18, w6, S22); 
MD5STEP_ROUND2 (c, d, a, b, mAC19, w11, S23); 
MD5STEP_ROUND2 (b, c, d, a, mAC20, w0, S24);  
MD5STEP_ROUND2 (a, b, c, d, mAC21, w5, S21); 
MD5STEP_ROUND2 (d, a, b, c, mAC22, w10,S22); 
MD5STEP_ROUND2 (c, d,  a, b, mAC23, w15, S23); 
MD5STEP_ROUND2 (b, c, d, a, mAC24, w4, S24); 
MD5STEP_ROUND2 (a, b, c, d, mAC25, w9, S21); 
MD5STEP_ROUND2 (d, a, b, c, mAC26, SIZE, S22);
MD5STEP_ROUND2 (c, d, a, b, mAC27, w3, S23);  
MD5STEP_ROUND2 (b, c, d, a, mAC28, w8, S24); 
MD5STEP_ROUND2 (a, b, c, d, mAC29, w13, S21);  
MD5STEP_ROUND2 (d, a, b, c, mAC30, w2, S22);  
MD5STEP_ROUND2 (c, d, a, b, mAC31, w7, S23); 
MD5STEP_ROUND2 (b, c, d, a, mAC32, w12, S24);  
MD5STEP_ROUND3 (a, b, c, d, mAC33, w5, S31);
MD5STEP_ROUND3 (d, a, b, c, mAC34, w8, S32);
MD5STEP_ROUND3 (c, d, a, b, mAC35, w11, S33);
MD5STEP_ROUND3 (b, c, d, a, mAC36, SIZE, S34);  
MD5STEP_ROUND3 (a, b, c, d, mAC37, w1, S31);
MD5STEP_ROUND3 (d, a, b, c, mAC38, w4, S32);
MD5STEP_ROUND3 (c, d, a, b, mAC39, w7, S33);
MD5STEP_ROUND3 (b, c, d, a, mAC40, w10, S34);
MD5STEP_ROUND3 (a, b, c, d, mAC41, w13, S31);
MD5STEP_ROUND3 (d, a, b, c, mAC42, w0, S32);
MD5STEP_ROUND3 (c, d, a, b, mAC43, w3, S33);
MD5STEP_ROUND3 (b, c, d, a, mAC44, w6, S34);
MD5STEP_ROUND3 (a, b, c, d, mAC45, w9, S31);
MD5STEP_ROUND3 (d, a, b, c, mAC46, w12, S32);
MD5STEP_ROUND3 (c, d, a, b, mAC47, w15, S33);
MD5STEP_ROUND3 (b, c, d, a, mAC48, w2, S34);
MD5STEP_ROUND4 (a, b, c, d, mAC49, w0, S41);  
MD5STEP_ROUND4 (d, a, b, c, mAC50, w7, S42); 
MD5STEP_ROUND4 (c, d, a, b, mAC51, SIZE, S43);
MD5STEP_ROUND4 (b, c, d, a, mAC52, w5, S44); 
MD5STEP_ROUND4 (a, b, c, d, mAC53, w12, S41);  
MD5STEP_ROUND4 (d, a, b, c, mAC54, w3, S42);  
MD5STEP_ROUND4 (c, d, a, b, mAC55, w10, S43); 
MD5STEP_ROUND4 (b, c, d, a, mAC56, w1, S44);  
MD5STEP_ROUND4 (a, b, c, d, mAC57, w8, S41); 
MD5STEP_ROUND4 (d, a, b, c, mAC58, w15, S42);  
MD5STEP_ROUND4 (c, d, a, b, mAC59, w6, S43); 
MD5STEP_ROUND4 (b, c, d, a, mAC60, w13, S44);  
MD5STEP_ROUND4 (a, b, c, d, mAC61, w4, S41); 
MD5STEP_ROUND4 (d, a, b, c, mAC62, w11, S42); 
MD5STEP_ROUND4 (c, d, a, b, mAC63, w2, S43);  
MD5STEP_ROUND4 (b, c, d, a, mAC64, w9, S44); 

OPA=a+mCa;OPB=b+mCb;OPC=c+mCc;OPD=d+mCd;


a=IPA;
b=IPB;
c=IPC;
d=IPD;

w0=(uint2)eapol[0];
w1=(uint2)eapol[1];
w2=(uint2)eapol[2];
w3=(uint2)eapol[3];
w4=(uint2)eapol[4];
w5=(uint2)eapol[5];
w6=(uint2)eapol[6];
w7=(uint2)eapol[7];
w8=(uint2)eapol[8];
w9=(uint2)eapol[9];
w10=(uint2)eapol[10];
w11=(uint2)eapol[11];
w12=(uint2)eapol[12];
w13=(uint2)eapol[13];
SIZE=(uint2)eapol[14];
w15=(uint2)eapol[15];

MD5STEP_ROUND1(a, b, c, d, mAC1, w0, S11);
MD5STEP_ROUND1(d, a, b, c, mAC2, w1, S12);
MD5STEP_ROUND1(c, d, a, b, mAC3, w2, S13);
MD5STEP_ROUND1(b, c, d, a, mAC4, w3, S14);
MD5STEP_ROUND1(a, b, c, d, mAC5, w4, S11);
MD5STEP_ROUND1(d, a, b, c, mAC6, w5, S12);
MD5STEP_ROUND1(c, d, a, b, mAC7, w6, S13);
MD5STEP_ROUND1(b, c, d, a, mAC8, w7, S14);
MD5STEP_ROUND1(a, b, c, d, mAC9, w8, S11);
MD5STEP_ROUND1(d, a, b, c, mAC10, w9, S12);
MD5STEP_ROUND1(c, d, a, b, mAC11, w10,S13);  
MD5STEP_ROUND1(b, c, d, a, mAC12, w11,S14);  
MD5STEP_ROUND1(a, b, c, d, mAC13, w12,S11);  
MD5STEP_ROUND1(d, a, b, c, mAC14, w13,S12);  
MD5STEP_ROUND1(c, d, a, b, mAC15, SIZE, S13);
MD5STEP_ROUND1(b, c, d, a, mAC16, w15, S14);  
MD5STEP_ROUND2 (a, b, c, d, mAC17, w1, S21);  
MD5STEP_ROUND2 (d, a, b, c, mAC18, w6, S22); 
MD5STEP_ROUND2 (c, d, a, b, mAC19, w11, S23); 
MD5STEP_ROUND2 (b, c, d, a, mAC20, w0, S24);  
MD5STEP_ROUND2 (a, b, c, d, mAC21, w5, S21); 
MD5STEP_ROUND2 (d, a, b, c, mAC22, w10,S22); 
MD5STEP_ROUND2 (c, d,  a, b, mAC23, w15, S23); 
MD5STEP_ROUND2 (b, c, d, a, mAC24, w4, S24); 
MD5STEP_ROUND2 (a, b, c, d, mAC25, w9, S21); 
MD5STEP_ROUND2 (d, a, b, c, mAC26, SIZE, S22);
MD5STEP_ROUND2 (c, d, a, b, mAC27, w3, S23);  
MD5STEP_ROUND2 (b, c, d, a, mAC28, w8, S24); 
MD5STEP_ROUND2 (a, b, c, d, mAC29, w13, S21);  
MD5STEP_ROUND2 (d, a, b, c, mAC30, w2, S22);  
MD5STEP_ROUND2 (c, d, a, b, mAC31, w7, S23); 
MD5STEP_ROUND2 (b, c, d, a, mAC32, w12, S24);  
MD5STEP_ROUND3 (a, b, c, d, mAC33, w5, S31);
MD5STEP_ROUND3 (d, a, b, c, mAC34, w8, S32);
MD5STEP_ROUND3 (c, d, a, b, mAC35, w11, S33);
MD5STEP_ROUND3 (b, c, d, a, mAC36, SIZE, S34);  
MD5STEP_ROUND3 (a, b, c, d, mAC37, w1, S31);
MD5STEP_ROUND3 (d, a, b, c, mAC38, w4, S32);
MD5STEP_ROUND3 (c, d, a, b, mAC39, w7, S33);
MD5STEP_ROUND3 (b, c, d, a, mAC40, w10, S34);
MD5STEP_ROUND3 (a, b, c, d, mAC41, w13, S31);
MD5STEP_ROUND3 (d, a, b, c, mAC42, w0, S32);
MD5STEP_ROUND3 (c, d, a, b, mAC43, w3, S33);
MD5STEP_ROUND3 (b, c, d, a, mAC44, w6, S34);
MD5STEP_ROUND3 (a, b, c, d, mAC45, w9, S31);
MD5STEP_ROUND3 (d, a, b, c, mAC46, w12, S32);
MD5STEP_ROUND3 (c, d, a, b, mAC47, w15, S33);
MD5STEP_ROUND3 (b, c, d, a, mAC48, w2, S34);
MD5STEP_ROUND4 (a, b, c, d, mAC49, w0, S41);  
MD5STEP_ROUND4 (d, a, b, c, mAC50, w7, S42); 
MD5STEP_ROUND4 (c, d, a, b, mAC51, SIZE, S43);
MD5STEP_ROUND4 (b, c, d, a, mAC52, w5, S44); 
MD5STEP_ROUND4 (a, b, c, d, mAC53, w12, S41);  
MD5STEP_ROUND4 (d, a, b, c, mAC54, w3, S42);  
MD5STEP_ROUND4 (c, d, a, b, mAC55, w10, S43); 
MD5STEP_ROUND4 (b, c, d, a, mAC56, w1, S44);  
MD5STEP_ROUND4 (a, b, c, d, mAC57, w8, S41); 
MD5STEP_ROUND4 (d, a, b, c, mAC58, w15, S42);  
MD5STEP_ROUND4 (c, d, a, b, mAC59, w6, S43); 
MD5STEP_ROUND4 (b, c, d, a, mAC60, w13, S44);  
MD5STEP_ROUND4 (a, b, c, d, mAC61, w4, S41); 
MD5STEP_ROUND4 (d, a, b, c, mAC62, w11, S42); 
MD5STEP_ROUND4 (c, d, a, b, mAC63, w2, S43);  
MD5STEP_ROUND4 (b, c, d, a, mAC64, w9, S44); 


a=a+IPA;b=b+IPB;c=c+IPC;d=d+IPD;
TTA=a;TTB=b;TTC=c;TTD=d;

w0=(uint2)eapol[16];
w1=(uint2)eapol[17];
w2=(uint2)eapol[18];
w3=(uint2)eapol[19];
w4=(uint2)eapol[20];
w5=(uint2)eapol[21];
w6=(uint2)eapol[22];
w7=(uint2)eapol[23];
w8=(uint2)eapol[24];
w9=(uint2)eapol[25];
w10=(uint2)eapol[26];
w11=(uint2)eapol[27];
w12=(uint2)eapol[28];
w13=(uint2)eapol[29];
SIZE=(uint2)eapol[30];
w15=(uint2)eapol[31];

MD5STEP_ROUND1(a, b, c, d, mAC1, w0, S11);
MD5STEP_ROUND1(d, a, b, c, mAC2, w1, S12);
MD5STEP_ROUND1(c, d, a, b, mAC3, w2, S13);
MD5STEP_ROUND1(b, c, d, a, mAC4, w3, S14);
MD5STEP_ROUND1(a, b, c, d, mAC5, w4, S11);
MD5STEP_ROUND1(d, a, b, c, mAC6, w5, S12);
MD5STEP_ROUND1(c, d, a, b, mAC7, w6, S13);
MD5STEP_ROUND1(b, c, d, a, mAC8, w7, S14);
MD5STEP_ROUND1(a, b, c, d, mAC9, w8, S11);
MD5STEP_ROUND1(d, a, b, c, mAC10, w9, S12);
MD5STEP_ROUND1(c, d, a, b, mAC11, w10,S13);  
MD5STEP_ROUND1(b, c, d, a, mAC12, w11,S14);  
MD5STEP_ROUND1(a, b, c, d, mAC13, w12,S11);  
MD5STEP_ROUND1(d, a, b, c, mAC14, w13,S12);  
MD5STEP_ROUND1(c, d, a, b, mAC15, SIZE, S13);
MD5STEP_ROUND1(b, c, d, a, mAC16, w15, S14);  
MD5STEP_ROUND2 (a, b, c, d, mAC17, w1, S21);  
MD5STEP_ROUND2 (d, a, b, c, mAC18, w6, S22); 
MD5STEP_ROUND2 (c, d, a, b, mAC19, w11, S23); 
MD5STEP_ROUND2 (b, c, d, a, mAC20, w0, S24);  
MD5STEP_ROUND2 (a, b, c, d, mAC21, w5, S21); 
MD5STEP_ROUND2 (d, a, b, c, mAC22, w10,S22); 
MD5STEP_ROUND2 (c, d,  a, b, mAC23, w15, S23); 
MD5STEP_ROUND2 (b, c, d, a, mAC24, w4, S24); 
MD5STEP_ROUND2 (a, b, c, d, mAC25, w9, S21); 
MD5STEP_ROUND2 (d, a, b, c, mAC26, SIZE, S22);
MD5STEP_ROUND2 (c, d, a, b, mAC27, w3, S23);  
MD5STEP_ROUND2 (b, c, d, a, mAC28, w8, S24); 
MD5STEP_ROUND2 (a, b, c, d, mAC29, w13, S21);  
MD5STEP_ROUND2 (d, a, b, c, mAC30, w2, S22);  
MD5STEP_ROUND2 (c, d, a, b, mAC31, w7, S23); 
MD5STEP_ROUND2 (b, c, d, a, mAC32, w12, S24);  
MD5STEP_ROUND3 (a, b, c, d, mAC33, w5, S31);
MD5STEP_ROUND3 (d, a, b, c, mAC34, w8, S32);
MD5STEP_ROUND3 (c, d, a, b, mAC35, w11, S33);
MD5STEP_ROUND3 (b, c, d, a, mAC36, SIZE, S34);  
MD5STEP_ROUND3 (a, b, c, d, mAC37, w1, S31);
MD5STEP_ROUND3 (d, a, b, c, mAC38, w4, S32);
MD5STEP_ROUND3 (c, d, a, b, mAC39, w7, S33);
MD5STEP_ROUND3 (b, c, d, a, mAC40, w10, S34);
MD5STEP_ROUND3 (a, b, c, d, mAC41, w13, S31);
MD5STEP_ROUND3 (d, a, b, c, mAC42, w0, S32);
MD5STEP_ROUND3 (c, d, a, b, mAC43, w3, S33);
MD5STEP_ROUND3 (b, c, d, a, mAC44, w6, S34);
MD5STEP_ROUND3 (a, b, c, d, mAC45, w9, S31);
MD5STEP_ROUND3 (d, a, b, c, mAC46, w12, S32);
MD5STEP_ROUND3 (c, d, a, b, mAC47, w15, S33);
MD5STEP_ROUND3 (b, c, d, a, mAC48, w2, S34);
MD5STEP_ROUND4 (a, b, c, d, mAC49, w0, S41);  
MD5STEP_ROUND4 (d, a, b, c, mAC50, w7, S42); 
MD5STEP_ROUND4 (c, d, a, b, mAC51, SIZE, S43);
MD5STEP_ROUND4 (b, c, d, a, mAC52, w5, S44); 
MD5STEP_ROUND4 (a, b, c, d, mAC53, w12, S41);  
MD5STEP_ROUND4 (d, a, b, c, mAC54, w3, S42);  
MD5STEP_ROUND4 (c, d, a, b, mAC55, w10, S43); 
MD5STEP_ROUND4 (b, c, d, a, mAC56, w1, S44);  
MD5STEP_ROUND4 (a, b, c, d, mAC57, w8, S41); 
MD5STEP_ROUND4 (d, a, b, c, mAC58, w15, S42);  
MD5STEP_ROUND4 (c, d, a, b, mAC59, w6, S43); 
MD5STEP_ROUND4 (b, c, d, a, mAC60, w13, S44);  
MD5STEP_ROUND4 (a, b, c, d, mAC61, w4, S41); 
MD5STEP_ROUND4 (d, a, b, c, mAC62, w11, S42); 
MD5STEP_ROUND4 (c, d, a, b, mAC63, w2, S43);  
MD5STEP_ROUND4 (b, c, d, a, mAC64, w9, S44); 

a=a+TTA;b=b+TTB;c=c+TTC;d=d+TTD;
TTA=a;TTB=b;TTC=c;TTD=d;


w0=(uint2)eapol[32];
w1=(uint2)eapol[33];
w2=(uint2)eapol[34];
w3=(uint2)eapol[35];
w4=(uint2)eapol[36];
w5=(uint2)eapol[37];
w6=(uint2)eapol[38];
w7=(uint2)eapol[39];
w8=(uint2)eapol[40];
w9=(uint2)eapol[41];
w10=(uint2)eapol[42];
w11=(uint2)eapol[43];
w12=(uint2)eapol[44];
w13=(uint2)eapol[45];
SIZE=(uint2)salt.sE;
w15=(uint2)eapol[47];

MD5STEP_ROUND1(a, b, c, d, mAC1, w0, S11);
MD5STEP_ROUND1(d, a, b, c, mAC2, w1, S12);
MD5STEP_ROUND1(c, d, a, b, mAC3, w2, S13);
MD5STEP_ROUND1(b, c, d, a, mAC4, w3, S14);
MD5STEP_ROUND1(a, b, c, d, mAC5, w4, S11);
MD5STEP_ROUND1(d, a, b, c, mAC6, w5, S12);
MD5STEP_ROUND1(c, d, a, b, mAC7, w6, S13);
MD5STEP_ROUND1(b, c, d, a, mAC8, w7, S14);
MD5STEP_ROUND1(a, b, c, d, mAC9, w8, S11);
MD5STEP_ROUND1(d, a, b, c, mAC10, w9, S12);
MD5STEP_ROUND1(c, d, a, b, mAC11, w10,S13);  
MD5STEP_ROUND1(b, c, d, a, mAC12, w11,S14);  
MD5STEP_ROUND1(a, b, c, d, mAC13, w12,S11);  
MD5STEP_ROUND1(d, a, b, c, mAC14, w13,S12);  
MD5STEP_ROUND1(c, d, a, b, mAC15, SIZE, S13);
MD5STEP_ROUND1(b, c, d, a, mAC16, w15, S14);  
MD5STEP_ROUND2 (a, b, c, d, mAC17, w1, S21);  
MD5STEP_ROUND2 (d, a, b, c, mAC18, w6, S22); 
MD5STEP_ROUND2 (c, d, a, b, mAC19, w11, S23); 
MD5STEP_ROUND2 (b, c, d, a, mAC20, w0, S24);  
MD5STEP_ROUND2 (a, b, c, d, mAC21, w5, S21); 
MD5STEP_ROUND2 (d, a, b, c, mAC22, w10,S22); 
MD5STEP_ROUND2 (c, d,  a, b, mAC23, w15, S23); 
MD5STEP_ROUND2 (b, c, d, a, mAC24, w4, S24); 
MD5STEP_ROUND2 (a, b, c, d, mAC25, w9, S21); 
MD5STEP_ROUND2 (d, a, b, c, mAC26, SIZE, S22);
MD5STEP_ROUND2 (c, d, a, b, mAC27, w3, S23);  
MD5STEP_ROUND2 (b, c, d, a, mAC28, w8, S24); 
MD5STEP_ROUND2 (a, b, c, d, mAC29, w13, S21);  
MD5STEP_ROUND2 (d, a, b, c, mAC30, w2, S22);  
MD5STEP_ROUND2 (c, d, a, b, mAC31, w7, S23); 
MD5STEP_ROUND2 (b, c, d, a, mAC32, w12, S24);  
MD5STEP_ROUND3 (a, b, c, d, mAC33, w5, S31);
MD5STEP_ROUND3 (d, a, b, c, mAC34, w8, S32);
MD5STEP_ROUND3 (c, d, a, b, mAC35, w11, S33);
MD5STEP_ROUND3 (b, c, d, a, mAC36, SIZE, S34);  
MD5STEP_ROUND3 (a, b, c, d, mAC37, w1, S31);
MD5STEP_ROUND3 (d, a, b, c, mAC38, w4, S32);
MD5STEP_ROUND3 (c, d, a, b, mAC39, w7, S33);
MD5STEP_ROUND3 (b, c, d, a, mAC40, w10, S34);
MD5STEP_ROUND3 (a, b, c, d, mAC41, w13, S31);
MD5STEP_ROUND3 (d, a, b, c, mAC42, w0, S32);
MD5STEP_ROUND3 (c, d, a, b, mAC43, w3, S33);
MD5STEP_ROUND3 (b, c, d, a, mAC44, w6, S34);
MD5STEP_ROUND3 (a, b, c, d, mAC45, w9, S31);
MD5STEP_ROUND3 (d, a, b, c, mAC46, w12, S32);
MD5STEP_ROUND3 (c, d, a, b, mAC47, w15, S33);
MD5STEP_ROUND3 (b, c, d, a, mAC48, w2, S34);
MD5STEP_ROUND4 (a, b, c, d, mAC49, w0, S41);  
MD5STEP_ROUND4 (d, a, b, c, mAC50, w7, S42); 
MD5STEP_ROUND4 (c, d, a, b, mAC51, SIZE, S43);
MD5STEP_ROUND4 (b, c, d, a, mAC52, w5, S44); 
MD5STEP_ROUND4 (a, b, c, d, mAC53, w12, S41);  
MD5STEP_ROUND4 (d, a, b, c, mAC54, w3, S42);  
MD5STEP_ROUND4 (c, d, a, b, mAC55, w10, S43); 
MD5STEP_ROUND4 (b, c, d, a, mAC56, w1, S44);  
MD5STEP_ROUND4 (a, b, c, d, mAC57, w8, S41); 
MD5STEP_ROUND4 (d, a, b, c, mAC58, w15, S42);  
MD5STEP_ROUND4 (c, d, a, b, mAC59, w6, S43); 
MD5STEP_ROUND4 (b, c, d, a, mAC60, w13, S44);  
MD5STEP_ROUND4 (a, b, c, d, mAC61, w4, S41); 
MD5STEP_ROUND4 (d, a, b, c, mAC62, w11, S42); 
MD5STEP_ROUND4 (c, d, a, b, mAC63, w2, S43);  
MD5STEP_ROUND4 (b, c, d, a, mAC64, w9, S44); 

a=a+TTA;b=b+TTB;c=c+TTC;d=d+TTD;
TTA=a;TTB=b;TTC=c;TTD=d;




a=OPA;b=OPB;c=OPC;d=OPD;
w0=TTA;
w1=TTB;
w2=TTC;
w3=TTD;
w4=(uint2)0x80;
SIZE=(uint2)((64+16)<<3);
w5=w6=w7=w8=w9=w10=w11=w12=w13=w15=(uint2)0;

MD5STEP_ROUND1(a, b, c, d, mAC1, w0, S11);
MD5STEP_ROUND1(d, a, b, c, mAC2, w1, S12);
MD5STEP_ROUND1(c, d, a, b, mAC3, w2, S13);
MD5STEP_ROUND1(b, c, d, a, mAC4, w3, S14);
MD5STEP_ROUND1(a, b, c, d, mAC5, w4, S11);
MD5STEP_ROUND1(d, a, b, c, mAC6, w5, S12);
MD5STEP_ROUND1(c, d, a, b, mAC7, w6, S13);
MD5STEP_ROUND1(b, c, d, a, mAC8, w7, S14);
MD5STEP_ROUND1(a, b, c, d, mAC9, w8, S11);
MD5STEP_ROUND1(d, a, b, c, mAC10, w9, S12);
MD5STEP_ROUND1(c, d, a, b, mAC11, w10,S13);  
MD5STEP_ROUND1(b, c, d, a, mAC12, w11,S14);  
MD5STEP_ROUND1(a, b, c, d, mAC13, w12,S11);  
MD5STEP_ROUND1(d, a, b, c, mAC14, w13,S12);  
MD5STEP_ROUND1(c, d, a, b, mAC15, SIZE, S13);
MD5STEP_ROUND1(b, c, d, a, mAC16, w15, S14);  
MD5STEP_ROUND2 (a, b, c, d, mAC17, w1, S21);  
MD5STEP_ROUND2 (d, a, b, c, mAC18, w6, S22); 
MD5STEP_ROUND2 (c, d, a, b, mAC19, w11, S23); 
MD5STEP_ROUND2 (b, c, d, a, mAC20, w0, S24);  
MD5STEP_ROUND2 (a, b, c, d, mAC21, w5, S21); 
MD5STEP_ROUND2 (d, a, b, c, mAC22, w10,S22); 
MD5STEP_ROUND2 (c, d,  a, b, mAC23, w15, S23); 
MD5STEP_ROUND2 (b, c, d, a, mAC24, w4, S24); 
MD5STEP_ROUND2 (a, b, c, d, mAC25, w9, S21); 
MD5STEP_ROUND2 (d, a, b, c, mAC26, SIZE, S22);
MD5STEP_ROUND2 (c, d, a, b, mAC27, w3, S23);  
MD5STEP_ROUND2 (b, c, d, a, mAC28, w8, S24); 
MD5STEP_ROUND2 (a, b, c, d, mAC29, w13, S21);  
MD5STEP_ROUND2 (d, a, b, c, mAC30, w2, S22);  
MD5STEP_ROUND2 (c, d, a, b, mAC31, w7, S23); 
MD5STEP_ROUND2 (b, c, d, a, mAC32, w12, S24);  
MD5STEP_ROUND3 (a, b, c, d, mAC33, w5, S31);
MD5STEP_ROUND3 (d, a, b, c, mAC34, w8, S32);
MD5STEP_ROUND3 (c, d, a, b, mAC35, w11, S33);
MD5STEP_ROUND3 (b, c, d, a, mAC36, SIZE, S34);  
MD5STEP_ROUND3 (a, b, c, d, mAC37, w1, S31);
MD5STEP_ROUND3 (d, a, b, c, mAC38, w4, S32);
MD5STEP_ROUND3 (c, d, a, b, mAC39, w7, S33);
MD5STEP_ROUND3 (b, c, d, a, mAC40, w10, S34);
MD5STEP_ROUND3 (a, b, c, d, mAC41, w13, S31);
MD5STEP_ROUND3 (d, a, b, c, mAC42, w0, S32);
MD5STEP_ROUND3 (c, d, a, b, mAC43, w3, S33);
MD5STEP_ROUND3 (b, c, d, a, mAC44, w6, S34);
MD5STEP_ROUND3 (a, b, c, d, mAC45, w9, S31);
MD5STEP_ROUND3 (d, a, b, c, mAC46, w12, S32);
MD5STEP_ROUND3 (c, d, a, b, mAC47, w15, S33);
MD5STEP_ROUND3 (b, c, d, a, mAC48, w2, S34);
MD5STEP_ROUND4 (a, b, c, d, mAC49, w0, S41);  
MD5STEP_ROUND4 (d, a, b, c, mAC50, w7, S42); 
MD5STEP_ROUND4 (c, d, a, b, mAC51, SIZE, S43);
MD5STEP_ROUND4 (b, c, d, a, mAC52, w5, S44); 
MD5STEP_ROUND4 (a, b, c, d, mAC53, w12, S41);  
MD5STEP_ROUND4 (d, a, b, c, mAC54, w3, S42);  
MD5STEP_ROUND4 (c, d, a, b, mAC55, w10, S43); 
MD5STEP_ROUND4 (b, c, d, a, mAC56, w1, S44);  
MD5STEP_ROUND4 (a, b, c, d, mAC57, w8, S41); 
MD5STEP_ROUND4 (d, a, b, c, mAC58, w15, S42);  
MD5STEP_ROUND4 (c, d, a, b, mAC59, w6, S43); 
MD5STEP_ROUND4 (b, c, d, a, mAC60, w13, S44);  
MD5STEP_ROUND4 (a, b, c, d, mAC61, w4, S41); 
MD5STEP_ROUND4 (d, a, b, c, mAC62, w11, S42); 
MD5STEP_ROUND4 (c, d, a, b, mAC63, w2, S43);  
MD5STEP_ROUND4 (b, c, d, a, mAC64, w9, S44); 

a=a+OPA;b=b+OPB;c=c+OPC;d=d+OPD;



if (all((uint2)(singlehash.x)!=(a))) return;
if (all((uint2)(singlehash.y)!=(b))) return;

dst[(get_global_id(0)<<1)] = (uint4) (a.s0,b.s0,c.s0,d.s0);
dst[(get_global_id(0)<<1)+1] = (uint4)(a.s1,b.s1,c.s1,d.s1);

found[0] = 1;
found_ind[get_global_id(0)] = 1;
}



#else

__kernel 
__attribute__((reqd_work_group_size(64, 1, 1)))
void prepare1( __global uint *dst,  __global uint *input, __global uint *input1, uint16 str, uint16 salt,uint4 singlehash, uint16 salt2, __global uint *block, __global uint *eapol)
{
uint SIZE;  
uint ib,ic,id;  
uint a,b,c,d,e,f,g,h, tmp1, tmp2,l; 
uint w0, w1, w2, w3, w4, w5, w6, w7,w8,w9,w10,w11,w12,w13,w14,w16,w15;
uint yl,yr,zl,zr,wl,wr;
uint K;
uint K0 = (uint)0x5A827999;
uint K1 = (uint)0x6ED9EBA1;
uint K2 = (uint)0x8F1BBCDC;
uint K3 = (uint)0xCA62C1D6;
uint H0 = (uint)0x67452301;
uint H1 = (uint)0xEFCDAB89;
uint H2 = (uint)0x98BADCFE;
uint H3 = (uint)0x10325476;
uint H4 = (uint)0xC3D2E1F0;
uint A,B,C,D,E;
uint IPA,IPB,IPC,IPD,IPE;
uint OPA,OPB,OPC,OPD,OPE;
uint TTA,TTB,TTC,TTD,TTE;

TTA=TTB=TTC=TTD=TTE=(uint)0;


a=input[get_global_id(0)*2*8];
b=input[get_global_id(0)*2*8+1];
c=input[get_global_id(0)*2*8+2];
d=input[get_global_id(0)*2*8+3];
e=input[get_global_id(0)*2*8+4];
f=input[get_global_id(0)*2*8+5];
g=input[get_global_id(0)*2*8+6];
h=input[get_global_id(0)*2*8+7];



// Initial HMAC (for PBKDF2)

// Calculate sha1(ipad^key)
w0=a^(uint)0x36363636;
w1=b^(uint)0x36363636;
w2=c^(uint)0x36363636;
w3=d^(uint)0x36363636;
w4=e^(uint)0x36363636;
w5=f^(uint)0x36363636;
w6=g^(uint)0x36363636;
w7=h^(uint)0x36363636;

w8=w9=w10=w11=w12=w13=w14=SIZE=(uint)0x36363636;

A=H0;
B=H1;
C=H2;
D=H3;
E=H4;

K = K0;
Endian_Reverse32(w0);  
ROTATE1(A, B, C, D, E, w0);
Endian_Reverse32(w1);  
ROTATE1(E, A, B, C, D, w1);
Endian_Reverse32(w2);  
ROTATE1(D, E, A, B, C, w2);
Endian_Reverse32(w3);  
ROTATE1(C, D, E, A, B, w3);
Endian_Reverse32(w4);  
ROTATE1(B, C, D, E, A, w4);
Endian_Reverse32(w5);  
ROTATE1(A, B, C, D, E, w5);
Endian_Reverse32(w6);  
ROTATE1(E, A, B, C, D, w6);
Endian_Reverse32(w7);  
ROTATE1(D, E, A, B, C, w7);
ROTATE1(C, D, E, A, B, w8);
ROTATE1(B, C, D, E, A, w9);
ROTATE1(A, B, C, D, E, w10);
ROTATE1(E, A, B, C, D, w11);
ROTATE1(D, E, A, B, C, w12);
ROTATE1(C, D, E, A, B, w13);
ROTATE1(B, C, D, E, A, w14);
ROTATE1(A, B, C, D, E, SIZE);  
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1);ROTATE1(E,A,B,C,D,w16);
w0 = rotate((w14 ^ w9 ^ w3 ^ w1),S1);ROTATE1(D,E,A,B,C,w0); 
w1 = rotate((SIZE ^ w10 ^ w4 ^ w2),S1); ROTATE1(C,D,E,A,B,w1); 
w2 = rotate((w16 ^ w11 ^ w5 ^ w3),S1);  ROTATE1(B,C,D,E,A,w2); 
K = K1;
w3 = rotate((w0 ^ w12 ^ w6 ^ w4),S1); ROTATE2_F(A, B, C, D, E, w3);
w4 = rotate((w1 ^ w13 ^ w7 ^ w5),S1); ROTATE2_F(E, A, B, C, D, w4);
w5 = rotate((w2 ^ w14 ^ w8 ^ w6),S1); ROTATE2_F(D, E, A, B, C, w5);
w6 = rotate((w3 ^ SIZE ^ w9 ^ w7),S1);ROTATE2_F(C, D, E, A, B, w6);
w7 = rotate((w4 ^ w16 ^ w10 ^ w8),S1); ROTATE2_F(B, C, D, E, A, w7);
w8 = rotate((w5 ^ w0 ^ w11 ^ w9),S1); ROTATE2_F(A, B, C, D, E, w8);
w9 = rotate((w6 ^ w1 ^ w12 ^ w10),S1); ROTATE2_F(E, A, B, C, D, w9);
w10 = rotate((w7 ^ w2 ^ w13 ^ w11),S1); ROTATE2_F(D, E, A, B, C, w10); 
w11 = rotate((w8 ^ w3 ^ w14 ^ w12),S1); ROTATE2_F(C, D, E, A, B, w11); 
w12 = rotate((w9 ^ w4 ^ SIZE ^ w13),S1); ROTATE2_F(B, C, D, E, A, w12);
w13 = rotate((w10 ^ w5 ^ w16 ^ w14),S1); ROTATE2_F(A, B, C, D, E, w13);
w14 = rotate((w11 ^ w6 ^ w0 ^ SIZE),S1); ROTATE2_F(E, A, B, C, D, w14);
SIZE = rotate((w12 ^ w7 ^ w1 ^ w16),S1); ROTATE2_F(D, E, A, B, C, SIZE);
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1); ROTATE2_F(C, D, E, A, B, w16);  
w0 = rotate(w14 ^ w9 ^ w3 ^ w1,S1); ROTATE2_F(B, C, D, E, A, w0);  
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2,S1); ROTATE2_F(A, B, C, D, E, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE2_F(E, A, B, C, D, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE2_F(D, E, A, B, C, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1);ROTATE2_F(C, D, E, A, B, w4);
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE2_F(B, C, D, E, A, w5);  
K = K2;
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(A, B, C, D, E, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(E, A, B, C, D, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(D, E, A, B, C, w8); 
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE3_F(C, D, E, A, B, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE3_F(B, C, D, E, A, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE3_F(A, B, C, D, E, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE3_F(E, A, B, C, D, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE3_F(D, E, A, B, C, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE3_F(C, D, E, A, B, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE3_F(B, C, D, E, A, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE3_F(A, B, C, D, E, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE3_F(E, A, B, C, D, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE3_F(D, E, A, B, C, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3, S1); ROTATE3_F(C, D, E, A, B, w2);
w3 = rotate(w0 ^ w12 ^ w6 ^ w4, S1); ROTATE3_F(B, C, D, E, A, w3); 
w4 = rotate(w1 ^ w13 ^ w7 ^ w5, S1); ROTATE3_F(A, B, C, D, E, w4); 
w5 = rotate(w2 ^ w14 ^ w8 ^ w6, S1); ROTATE3_F(E, A, B, C, D, w5); 
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(D, E, A, B, C, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(C, D, E, A, B, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(B, C, D, E, A, w8); 
K = K3;
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE4_F(A, B, C, D, E, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE4_F(E, A, B, C, D, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE4_F(D, E, A, B, C, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE4_F(C, D, E, A, B, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE4_F(B, C, D, E, A, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE4_F(A, B, C, D, E, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE4_F(E, A, B, C, D, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE4_F(D, E, A, B, C, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE4_F(C, D, E, A, B, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE4_F(B, C, D, E, A, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE4_F(A, B, C, D, E, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE4_F(E, A, B, C, D, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1); ROTATE4_F(D, E, A, B, C, w4);  
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE4_F(C, D, E, A, B, w5);  
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7,S1); ROTATE4_F(B, C, D, E, A, w6); 
w7 = rotate(w4 ^ w16 ^ w10 ^ w8,S1); ROTATE4_F(A, B, C, D, E, w7); 
w8 = rotate(w5 ^ w0 ^ w11 ^ w9,S1); ROTATE4_F(E, A, B, C, D, w8);  
w9 = rotate(w6 ^ w1 ^ w12 ^ w10,S1); ROTATE4_F(D, E, A, B, C, w9); 
w10 = rotate(w7 ^ w2 ^ w13 ^ w11,S1); ROTATE4_F(C, D, E, A, B, w10);
w11 = rotate(w8 ^ w3 ^ w14 ^ w12,S1); ROTATE4_F(B, C, D, E, A, w11);

IPA=A+H0;IPB=B+H1;IPC=C+H2;IPD=D+H3;IPE=E+H4;



// Calculate sha1(opad^key)
w0=a^(uint)0x5c5c5c5c;
w1=b^(uint)0x5c5c5c5c;
w2=c^(uint)0x5c5c5c5c;
w3=d^(uint)0x5c5c5c5c;
w4=e^(uint)0x5c5c5c5c;
w5=f^(uint)0x5c5c5c5c;
w6=g^(uint)0x5c5c5c5c;
w7=h^(uint)0x5c5c5c5c;

w8=w9=w10=w11=w12=w13=w14=SIZE=(uint)0x5c5c5c5c;
A=H0;
B=H1;
C=H2;
D=H3;
E=H4;
K = K0;
Endian_Reverse32(w0);  
ROTATE1(A, B, C, D, E, w0);
Endian_Reverse32(w1);  
ROTATE1(E, A, B, C, D, w1);
Endian_Reverse32(w2);  
ROTATE1(D, E, A, B, C, w2);
Endian_Reverse32(w3);  
ROTATE1(C, D, E, A, B, w3);
Endian_Reverse32(w4);  
ROTATE1(B, C, D, E, A, w4);
Endian_Reverse32(w5);  
ROTATE1(A, B, C, D, E, w5);
Endian_Reverse32(w6);  
ROTATE1(E, A, B, C, D, w6);
Endian_Reverse32(w7);  
ROTATE1(D, E, A, B, C, w7);
ROTATE1(C, D, E, A, B, w8);
ROTATE1(B, C, D, E, A, w9);
ROTATE1(A, B, C, D, E, w10);
ROTATE1(E, A, B, C, D, w11);
ROTATE1(D, E, A, B, C, w12);
ROTATE1(C, D, E, A, B, w13);
ROTATE1(B, C, D, E, A, w14);
ROTATE1(A, B, C, D, E, SIZE);  
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1);ROTATE1(E,A,B,C,D,w16);
w0 = rotate((w14 ^ w9 ^ w3 ^ w1),S1);ROTATE1(D,E,A,B,C,w0); 
w1 = rotate((SIZE ^ w10 ^ w4 ^ w2),S1); ROTATE1(C,D,E,A,B,w1); 
w2 = rotate((w16 ^ w11 ^ w5 ^ w3),S1);  ROTATE1(B,C,D,E,A,w2); 
K = K1;
w3 = rotate((w0 ^ w12 ^ w6 ^ w4),S1); ROTATE2_F(A, B, C, D, E, w3);
w4 = rotate((w1 ^ w13 ^ w7 ^ w5),S1); ROTATE2_F(E, A, B, C, D, w4);
w5 = rotate((w2 ^ w14 ^ w8 ^ w6),S1); ROTATE2_F(D, E, A, B, C, w5);
w6 = rotate((w3 ^ SIZE ^ w9 ^ w7),S1);ROTATE2_F(C, D, E, A, B, w6);
w7 = rotate((w4 ^ w16 ^ w10 ^ w8),S1); ROTATE2_F(B, C, D, E, A, w7);
w8 = rotate((w5 ^ w0 ^ w11 ^ w9),S1); ROTATE2_F(A, B, C, D, E, w8);
w9 = rotate((w6 ^ w1 ^ w12 ^ w10),S1); ROTATE2_F(E, A, B, C, D, w9);
w10 = rotate((w7 ^ w2 ^ w13 ^ w11),S1); ROTATE2_F(D, E, A, B, C, w10); 
w11 = rotate((w8 ^ w3 ^ w14 ^ w12),S1); ROTATE2_F(C, D, E, A, B, w11); 
w12 = rotate((w9 ^ w4 ^ SIZE ^ w13),S1); ROTATE2_F(B, C, D, E, A, w12);
w13 = rotate((w10 ^ w5 ^ w16 ^ w14),S1); ROTATE2_F(A, B, C, D, E, w13);
w14 = rotate((w11 ^ w6 ^ w0 ^ SIZE),S1); ROTATE2_F(E, A, B, C, D, w14);
SIZE = rotate((w12 ^ w7 ^ w1 ^ w16),S1); ROTATE2_F(D, E, A, B, C, SIZE);
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1); ROTATE2_F(C, D, E, A, B, w16);  
w0 = rotate(w14 ^ w9 ^ w3 ^ w1,S1); ROTATE2_F(B, C, D, E, A, w0);  
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2,S1); ROTATE2_F(A, B, C, D, E, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE2_F(E, A, B, C, D, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE2_F(D, E, A, B, C, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1);ROTATE2_F(C, D, E, A, B, w4);
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE2_F(B, C, D, E, A, w5);  
K = K2;
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(A, B, C, D, E, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(E, A, B, C, D, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(D, E, A, B, C, w8); 
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE3_F(C, D, E, A, B, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE3_F(B, C, D, E, A, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE3_F(A, B, C, D, E, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE3_F(E, A, B, C, D, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE3_F(D, E, A, B, C, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE3_F(C, D, E, A, B, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE3_F(B, C, D, E, A, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE3_F(A, B, C, D, E, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE3_F(E, A, B, C, D, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE3_F(D, E, A, B, C, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3, S1); ROTATE3_F(C, D, E, A, B, w2);
w3 = rotate(w0 ^ w12 ^ w6 ^ w4, S1); ROTATE3_F(B, C, D, E, A, w3); 
w4 = rotate(w1 ^ w13 ^ w7 ^ w5, S1); ROTATE3_F(A, B, C, D, E, w4); 
w5 = rotate(w2 ^ w14 ^ w8 ^ w6, S1); ROTATE3_F(E, A, B, C, D, w5); 
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(D, E, A, B, C, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(C, D, E, A, B, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(B, C, D, E, A, w8); 
K = K3;
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE4_F(A, B, C, D, E, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE4_F(E, A, B, C, D, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE4_F(D, E, A, B, C, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE4_F(C, D, E, A, B, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE4_F(B, C, D, E, A, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE4_F(A, B, C, D, E, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE4_F(E, A, B, C, D, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE4_F(D, E, A, B, C, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE4_F(C, D, E, A, B, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE4_F(B, C, D, E, A, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE4_F(A, B, C, D, E, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE4_F(E, A, B, C, D, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1); ROTATE4_F(D, E, A, B, C, w4);  
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE4_F(C, D, E, A, B, w5);  
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7,S1); ROTATE4_F(B, C, D, E, A, w6); 
w7 = rotate(w4 ^ w16 ^ w10 ^ w8,S1); ROTATE4_F(A, B, C, D, E, w7); 
w8 = rotate(w5 ^ w0 ^ w11 ^ w9,S1); ROTATE4_F(E, A, B, C, D, w8);  
w9 = rotate(w6 ^ w1 ^ w12 ^ w10,S1); ROTATE4_F(D, E, A, B, C, w9); 
w10 = rotate(w7 ^ w2 ^ w13 ^ w11,S1); ROTATE4_F(C, D, E, A, B, w10);
w11 = rotate(w8 ^ w3 ^ w14 ^ w12,S1); ROTATE4_F(B, C, D, E, A, w11);

OPA=A+H0;OPB=B+H1;OPC=C+H2;OPD=D+H3;OPE=E+H4;



// calculate hash sum 1
A=IPA;
B=IPB;
C=IPC;
D=IPD;
E=IPE;

w0=(uint)salt.s0;
w1=(uint)salt.s1;
w2=(uint)salt.s2;
w3=(uint)salt.s3;
w4=(uint)salt.s4;
w5=(uint)salt.s5;
w6=(uint)salt.s6;
w7=(uint)salt.s7;
w8=(uint)salt.s8;
w9=(uint)salt.s9;
w10=(uint)salt.sA;

SIZE=(uint)salt.sF;
w11=w12=w13=w14=(uint)0;


K = K0;
Endian_Reverse32(w0);  
ROTATE1(A, B, C, D, E, w0);
Endian_Reverse32(w1);  
ROTATE1(E, A, B, C, D, w1);
Endian_Reverse32(w2);  
ROTATE1(D, E, A, B, C, w2);
Endian_Reverse32(w3);  
ROTATE1(C, D, E, A, B, w3);
Endian_Reverse32(w4);  
ROTATE1(B, C, D, E, A, w4);
Endian_Reverse32(w5);  
ROTATE1(A, B, C, D, E, w5);
Endian_Reverse32(w6);  
ROTATE1(E, A, B, C, D, w6);
Endian_Reverse32(w7);  
ROTATE1(D, E, A, B, C, w7);
Endian_Reverse32(w8);  
ROTATE1(C, D, E, A, B, w8);
Endian_Reverse32(w9);  
ROTATE1(B, C, D, E, A, w9);
Endian_Reverse32(w10);  
ROTATE1(A, B, C, D, E, w10);
ROTATE1(E, A, B, C, D, w11);
ROTATE1(D, E, A, B, C, w12);
ROTATE1(C, D, E, A, B, w13);
ROTATE1(B, C, D, E, A, w14);
ROTATE1(A, B, C, D, E, SIZE);  
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1);ROTATE1(E,A,B,C,D,w16);
w0 = rotate((w14 ^ w9 ^ w3 ^ w1),S1);ROTATE1(D,E,A,B,C,w0); 
w1 = rotate((SIZE ^ w10 ^ w4 ^ w2),S1); ROTATE1(C,D,E,A,B,w1); 
w2 = rotate((w16 ^ w11 ^ w5 ^ w3),S1);  ROTATE1(B,C,D,E,A,w2); 
K = K1;
w3 = rotate((w0 ^ w12 ^ w6 ^ w4),S1); ROTATE2_F(A, B, C, D, E, w3);
w4 = rotate((w1 ^ w13 ^ w7 ^ w5),S1); ROTATE2_F(E, A, B, C, D, w4);
w5 = rotate((w2 ^ w14 ^ w8 ^ w6),S1); ROTATE2_F(D, E, A, B, C, w5);
w6 = rotate((w3 ^ SIZE ^ w9 ^ w7),S1);ROTATE2_F(C, D, E, A, B, w6);
w7 = rotate((w4 ^ w16 ^ w10 ^ w8),S1); ROTATE2_F(B, C, D, E, A, w7);
w8 = rotate((w5 ^ w0 ^ w11 ^ w9),S1); ROTATE2_F(A, B, C, D, E, w8);
w9 = rotate((w6 ^ w1 ^ w12 ^ w10),S1); ROTATE2_F(E, A, B, C, D, w9);
w10 = rotate((w7 ^ w2 ^ w13 ^ w11),S1); ROTATE2_F(D, E, A, B, C, w10); 
w11 = rotate((w8 ^ w3 ^ w14 ^ w12),S1); ROTATE2_F(C, D, E, A, B, w11); 
w12 = rotate((w9 ^ w4 ^ SIZE ^ w13),S1); ROTATE2_F(B, C, D, E, A, w12);
w13 = rotate((w10 ^ w5 ^ w16 ^ w14),S1); ROTATE2_F(A, B, C, D, E, w13);
w14 = rotate((w11 ^ w6 ^ w0 ^ SIZE),S1); ROTATE2_F(E, A, B, C, D, w14);
SIZE = rotate((w12 ^ w7 ^ w1 ^ w16),S1); ROTATE2_F(D, E, A, B, C, SIZE);
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1); ROTATE2_F(C, D, E, A, B, w16);  
w0 = rotate(w14 ^ w9 ^ w3 ^ w1,S1); ROTATE2_F(B, C, D, E, A, w0);  
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2,S1); ROTATE2_F(A, B, C, D, E, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE2_F(E, A, B, C, D, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE2_F(D, E, A, B, C, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1);ROTATE2_F(C, D, E, A, B, w4);
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE2_F(B, C, D, E, A, w5);  
K = K2;
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(A, B, C, D, E, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(E, A, B, C, D, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(D, E, A, B, C, w8); 
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE3_F(C, D, E, A, B, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE3_F(B, C, D, E, A, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE3_F(A, B, C, D, E, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE3_F(E, A, B, C, D, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE3_F(D, E, A, B, C, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE3_F(C, D, E, A, B, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE3_F(B, C, D, E, A, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE3_F(A, B, C, D, E, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE3_F(E, A, B, C, D, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE3_F(D, E, A, B, C, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3, S1); ROTATE3_F(C, D, E, A, B, w2);
w3 = rotate(w0 ^ w12 ^ w6 ^ w4, S1); ROTATE3_F(B, C, D, E, A, w3); 
w4 = rotate(w1 ^ w13 ^ w7 ^ w5, S1); ROTATE3_F(A, B, C, D, E, w4); 
w5 = rotate(w2 ^ w14 ^ w8 ^ w6, S1); ROTATE3_F(E, A, B, C, D, w5); 
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(D, E, A, B, C, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(C, D, E, A, B, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(B, C, D, E, A, w8); 
K = K3;
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE4_F(A, B, C, D, E, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE4_F(E, A, B, C, D, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE4_F(D, E, A, B, C, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE4_F(C, D, E, A, B, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE4_F(B, C, D, E, A, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE4_F(A, B, C, D, E, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE4_F(E, A, B, C, D, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE4_F(D, E, A, B, C, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE4_F(C, D, E, A, B, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE4_F(B, C, D, E, A, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE4_F(A, B, C, D, E, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE4_F(E, A, B, C, D, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1); ROTATE4_F(D, E, A, B, C, w4);  
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE4_F(C, D, E, A, B, w5);  
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7,S1); ROTATE4_F(B, C, D, E, A, w6); 
w7 = rotate(w4 ^ w16 ^ w10 ^ w8,S1); ROTATE4_F(A, B, C, D, E, w7); 
w8 = rotate(w5 ^ w0 ^ w11 ^ w9,S1); ROTATE4_F(E, A, B, C, D, w8);  
w9 = rotate(w6 ^ w1 ^ w12 ^ w10,S1); ROTATE4_F(D, E, A, B, C, w9); 
w10 = rotate(w7 ^ w2 ^ w13 ^ w11,S1); ROTATE4_F(C, D, E, A, B, w10);
w11 = rotate(w8 ^ w3 ^ w14 ^ w12,S1); ROTATE4_F(B, C, D, E, A, w11);
A=A+IPA;B=B+IPB;C=C+IPC;D=D+IPD;E=E+IPE;





// calculate hash sum 2

w0=A;
w1=B;
w2=C;
w3=D;
w4=E;
w5=(uint)0x80000000;
A=OPA;
B=OPB;
C=OPC;
D=OPD;
E=OPE;
SIZE=(uint)((64+20)<<3);
w6=w7=w8=w9=w10=w11=w12=w13=w14=(uint)0;


K = K0;
ROTATE1(A, B, C, D, E, w0);
ROTATE1(E, A, B, C, D, w1);
ROTATE1(D, E, A, B, C, w2);
ROTATE1(C, D, E, A, B, w3);
ROTATE1(B, C, D, E, A, w4);
ROTATE1(A, B, C, D, E, w5);
ROTATE1(E, A, B, C, D, w6);
ROTATE1(D, E, A, B, C, w7);
ROTATE1(C, D, E, A, B, w8);
ROTATE1(B, C, D, E, A, w9);
ROTATE1(A, B, C, D, E, w10);
ROTATE1(E, A, B, C, D, w11);
ROTATE1(D, E, A, B, C, w12);
ROTATE1(C, D, E, A, B, w13);
ROTATE1(B, C, D, E, A, w14);
ROTATE1(A, B, C, D, E, SIZE);  
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1);ROTATE1(E,A,B,C,D,w16);
w0 = rotate((w14 ^ w9 ^ w3 ^ w1),S1);ROTATE1(D,E,A,B,C,w0); 
w1 = rotate((SIZE ^ w10 ^ w4 ^ w2),S1); ROTATE1(C,D,E,A,B,w1); 
w2 = rotate((w16 ^ w11 ^ w5 ^ w3),S1);  ROTATE1(B,C,D,E,A,w2); 
K = K1;
w3 = rotate((w0 ^ w12 ^ w6 ^ w4),S1); ROTATE2_F(A, B, C, D, E, w3);
w4 = rotate((w1 ^ w13 ^ w7 ^ w5),S1); ROTATE2_F(E, A, B, C, D, w4);
w5 = rotate((w2 ^ w14 ^ w8 ^ w6),S1); ROTATE2_F(D, E, A, B, C, w5);
w6 = rotate((w3 ^ SIZE ^ w9 ^ w7),S1);ROTATE2_F(C, D, E, A, B, w6);
w7 = rotate((w4 ^ w16 ^ w10 ^ w8),S1); ROTATE2_F(B, C, D, E, A, w7);
w8 = rotate((w5 ^ w0 ^ w11 ^ w9),S1); ROTATE2_F(A, B, C, D, E, w8);
w9 = rotate((w6 ^ w1 ^ w12 ^ w10),S1); ROTATE2_F(E, A, B, C, D, w9);
w10 = rotate((w7 ^ w2 ^ w13 ^ w11),S1); ROTATE2_F(D, E, A, B, C, w10); 
w11 = rotate((w8 ^ w3 ^ w14 ^ w12),S1); ROTATE2_F(C, D, E, A, B, w11); 
w12 = rotate((w9 ^ w4 ^ SIZE ^ w13),S1); ROTATE2_F(B, C, D, E, A, w12);
w13 = rotate((w10 ^ w5 ^ w16 ^ w14),S1); ROTATE2_F(A, B, C, D, E, w13);
w14 = rotate((w11 ^ w6 ^ w0 ^ SIZE),S1); ROTATE2_F(E, A, B, C, D, w14);
SIZE = rotate((w12 ^ w7 ^ w1 ^ w16),S1); ROTATE2_F(D, E, A, B, C, SIZE);
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1); ROTATE2_F(C, D, E, A, B, w16);  
w0 = rotate(w14 ^ w9 ^ w3 ^ w1,S1); ROTATE2_F(B, C, D, E, A, w0);  
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2,S1); ROTATE2_F(A, B, C, D, E, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE2_F(E, A, B, C, D, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE2_F(D, E, A, B, C, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1);ROTATE2_F(C, D, E, A, B, w4);
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE2_F(B, C, D, E, A, w5);  
K = K2;
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(A, B, C, D, E, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(E, A, B, C, D, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(D, E, A, B, C, w8); 
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE3_F(C, D, E, A, B, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE3_F(B, C, D, E, A, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE3_F(A, B, C, D, E, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE3_F(E, A, B, C, D, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE3_F(D, E, A, B, C, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE3_F(C, D, E, A, B, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE3_F(B, C, D, E, A, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE3_F(A, B, C, D, E, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE3_F(E, A, B, C, D, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE3_F(D, E, A, B, C, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3, S1); ROTATE3_F(C, D, E, A, B, w2);
w3 = rotate(w0 ^ w12 ^ w6 ^ w4, S1); ROTATE3_F(B, C, D, E, A, w3); 
w4 = rotate(w1 ^ w13 ^ w7 ^ w5, S1); ROTATE3_F(A, B, C, D, E, w4); 
w5 = rotate(w2 ^ w14 ^ w8 ^ w6, S1); ROTATE3_F(E, A, B, C, D, w5); 
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(D, E, A, B, C, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(C, D, E, A, B, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(B, C, D, E, A, w8); 
K = K3;
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE4_F(A, B, C, D, E, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE4_F(E, A, B, C, D, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE4_F(D, E, A, B, C, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE4_F(C, D, E, A, B, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE4_F(B, C, D, E, A, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE4_F(A, B, C, D, E, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE4_F(E, A, B, C, D, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE4_F(D, E, A, B, C, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE4_F(C, D, E, A, B, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE4_F(B, C, D, E, A, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE4_F(A, B, C, D, E, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE4_F(E, A, B, C, D, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1); ROTATE4_F(D, E, A, B, C, w4);  
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE4_F(C, D, E, A, B, w5);  
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7,S1); ROTATE4_F(B, C, D, E, A, w6); 
w7 = rotate(w4 ^ w16 ^ w10 ^ w8,S1); ROTATE4_F(A, B, C, D, E, w7); 
w8 = rotate(w5 ^ w0 ^ w11 ^ w9,S1); ROTATE4_F(E, A, B, C, D, w8);  
w9 = rotate(w6 ^ w1 ^ w12 ^ w10,S1); ROTATE4_F(D, E, A, B, C, w9); 
w10 = rotate(w7 ^ w2 ^ w13 ^ w11,S1); ROTATE4_F(C, D, E, A, B, w10);
w11 = rotate(w8 ^ w3 ^ w14 ^ w12,S1); ROTATE4_F(B, C, D, E, A, w11);
A=A+OPA;B=B+OPB;C=C+OPC;D=D+OPD;E=E+OPE;
TTA=A;TTB=B;TTC=C;TTD=D;TTE=E;


input1[get_global_id(0)*2*5+0]=IPA;
input1[get_global_id(0)*2*5+1]=IPB;
input1[get_global_id(0)*2*5+2]=IPC;
input1[get_global_id(0)*2*5+3]=IPD;
input1[get_global_id(0)*2*5+4]=IPE;
input1[get_global_id(0)*2*5+5]=OPA;
input1[get_global_id(0)*2*5+6]=OPB;
input1[get_global_id(0)*2*5+7]=OPC;
input1[get_global_id(0)*2*5+8]=OPD;
input1[get_global_id(0)*2*5+9]=OPE;

dst[get_global_id(0)*3*5+0]=TTA;
dst[get_global_id(0)*3*5+1]=TTB;
dst[get_global_id(0)*3*5+2]=TTC;
dst[get_global_id(0)*3*5+3]=TTD;
dst[get_global_id(0)*3*5+4]=TTE;
dst[get_global_id(0)*3*5+10]=TTA;
dst[get_global_id(0)*3*5+11]=TTB;
dst[get_global_id(0)*3*5+12]=TTC;
dst[get_global_id(0)*3*5+13]=TTD;
dst[get_global_id(0)*3*5+14]=TTE;

}


__kernel 
__attribute__((reqd_work_group_size(64, 1, 1)))
void pbkdf1( __global uint *dst,  __global uint *input, __global uint *input1, uint16 str, uint16 salt,uint4 singlehash, uint16 salt2, __global uint *block, __global uint *eapol)
{
uint SIZE;  
uint ib,ic,id;  
uint a,b,c,d,e,f,g,h, tmp1, tmp2,l; 
uint w0, w1, w2, w3, w4, w5, w6, w7,w8,w9,w10,w11,w12,w13,w14,w16,w15;
uint K;
uint K0 = (uint)0x5A827999;
uint K1 = (uint)0x6ED9EBA1;
uint K2 = (uint)0x8F1BBCDC;
uint K3 = (uint)0xCA62C1D6;
uint H0 = (uint)0x67452301;
uint H1 = (uint)0xEFCDAB89;
uint H2 = (uint)0x98BADCFE;
uint H3 = (uint)0x10325476;
uint H4 = (uint)0xC3D2E1F0;
uint A,B,C,D,E;
uint IPA,IPB,IPC,IPD,IPE;
uint OPA,OPB,OPC,OPD,OPE;
uint TTA,TTB,TTC,TTD,TTE;


TTA=dst[get_global_id(0)*3*5+0];
TTB=dst[get_global_id(0)*3*5+1];
TTC=dst[get_global_id(0)*3*5+2];
TTD=dst[get_global_id(0)*3*5+3];
TTE=dst[get_global_id(0)*3*5+4];
A=dst[get_global_id(0)*3*5+10];
B=dst[get_global_id(0)*3*5+11];
C=dst[get_global_id(0)*3*5+12];
D=dst[get_global_id(0)*3*5+13];
E=dst[get_global_id(0)*3*5+14];
IPA=input1[get_global_id(0)*2*5+0];
IPB=input1[get_global_id(0)*2*5+1];
IPC=input1[get_global_id(0)*2*5+2];
IPD=input1[get_global_id(0)*2*5+3];
IPE=input1[get_global_id(0)*2*5+4];
OPA=input1[get_global_id(0)*2*5+5];
OPB=input1[get_global_id(0)*2*5+6];
OPC=input1[get_global_id(0)*2*5+7];
OPD=input1[get_global_id(0)*2*5+8];
OPE=input1[get_global_id(0)*2*5+9];


// We now have the first HMAC. Iterate to find the rest

for (ic=str.sA;ic<1170+str.sA;ic+=2)
{

// calculate hash sum 1
w0=A;
w1=B;
w2=C;
w3=D;
w4=E;
w5=(uint)0x80000000;
SIZE=(uint)(64+20)<<3;

A=IPA;
B=IPB;
C=IPC;
D=IPD;
E=IPE;


w6=w7=w8=w9=w10=w11=w12=w13=w14=(uint)0;


K = K0;
ROTATE1(A, B, C, D, E, w0);
ROTATE1(E, A, B, C, D, w1);
ROTATE1(D, E, A, B, C, w2);
ROTATE1(C, D, E, A, B, w3);
ROTATE1(B, C, D, E, A, w4);
ROTATE1(A, B, C, D, E, w5);
ROTATE1_NULL(E, A, B, C, D);
ROTATE1_NULL(D, E, A, B, C);
ROTATE1_NULL(C, D, E, A, B);
ROTATE1_NULL(B, C, D, E, A);
ROTATE1_NULL(A, B, C, D, E);
ROTATE1_NULL(E, A, B, C, D);
ROTATE1_NULL(D, E, A, B, C);
ROTATE1_NULL(C, D, E, A, B);
ROTATE1_NULL(B, C, D, E, A);
ROTATE1(A, B, C, D, E, SIZE);  
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1);ROTATE1(E,A,B,C,D,w16);
w0 = rotate((w14 ^ w9 ^ w3 ^ w1),S1);ROTATE1(D,E,A,B,C,w0); 
w1 = rotate((SIZE ^ w10 ^ w4 ^ w2),S1); ROTATE1(C,D,E,A,B,w1); 
w2 = rotate((w16 ^ w11 ^ w5 ^ w3),S1);  ROTATE1(B,C,D,E,A,w2); 
K = K1;
w3 = rotate((w0 ^ w12 ^ w6 ^ w4),S1); ROTATE2_F(A, B, C, D, E, w3);
w4 = rotate((w1 ^ w13 ^ w7 ^ w5),S1); ROTATE2_F(E, A, B, C, D, w4);
w5 = rotate((w2 ^ w14 ^ w8 ^ w6),S1); ROTATE2_F(D, E, A, B, C, w5);
w6 = rotate((w3 ^ SIZE ^ w9 ^ w7),S1);ROTATE2_F(C, D, E, A, B, w6);
w7 = rotate((w4 ^ w16 ^ w10 ^ w8),S1); ROTATE2_F(B, C, D, E, A, w7);
w8 = rotate((w5 ^ w0 ^ w11 ^ w9),S1); ROTATE2_F(A, B, C, D, E, w8);
w9 = rotate((w6 ^ w1 ^ w12 ^ w10),S1); ROTATE2_F(E, A, B, C, D, w9);
w10 = rotate((w7 ^ w2 ^ w13 ^ w11),S1); ROTATE2_F(D, E, A, B, C, w10); 
w11 = rotate((w8 ^ w3 ^ w14 ^ w12),S1); ROTATE2_F(C, D, E, A, B, w11); 
w12 = rotate((w9 ^ w4 ^ SIZE ^ w13),S1); ROTATE2_F(B, C, D, E, A, w12);
w13 = rotate((w10 ^ w5 ^ w16 ^ w14),S1); ROTATE2_F(A, B, C, D, E, w13);
w14 = rotate((w11 ^ w6 ^ w0 ^ SIZE),S1); ROTATE2_F(E, A, B, C, D, w14);
SIZE = rotate((w12 ^ w7 ^ w1 ^ w16),S1); ROTATE2_F(D, E, A, B, C, SIZE);
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1); ROTATE2_F(C, D, E, A, B, w16);  
w0 = rotate(w14 ^ w9 ^ w3 ^ w1,S1); ROTATE2_F(B, C, D, E, A, w0);  
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2,S1); ROTATE2_F(A, B, C, D, E, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE2_F(E, A, B, C, D, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE2_F(D, E, A, B, C, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1);ROTATE2_F(C, D, E, A, B, w4);
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE2_F(B, C, D, E, A, w5);  
K = K2;
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(A, B, C, D, E, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(E, A, B, C, D, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(D, E, A, B, C, w8); 
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE3_F(C, D, E, A, B, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE3_F(B, C, D, E, A, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE3_F(A, B, C, D, E, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE3_F(E, A, B, C, D, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE3_F(D, E, A, B, C, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE3_F(C, D, E, A, B, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE3_F(B, C, D, E, A, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE3_F(A, B, C, D, E, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE3_F(E, A, B, C, D, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE3_F(D, E, A, B, C, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3, S1); ROTATE3_F(C, D, E, A, B, w2);
w3 = rotate(w0 ^ w12 ^ w6 ^ w4, S1); ROTATE3_F(B, C, D, E, A, w3); 
w4 = rotate(w1 ^ w13 ^ w7 ^ w5, S1); ROTATE3_F(A, B, C, D, E, w4); 
w5 = rotate(w2 ^ w14 ^ w8 ^ w6, S1); ROTATE3_F(E, A, B, C, D, w5); 
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(D, E, A, B, C, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(C, D, E, A, B, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(B, C, D, E, A, w8); 
K = K3;
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE4_F(A, B, C, D, E, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE4_F(E, A, B, C, D, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE4_F(D, E, A, B, C, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE4_F(C, D, E, A, B, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE4_F(B, C, D, E, A, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE4_F(A, B, C, D, E, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE4_F(E, A, B, C, D, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE4_F(D, E, A, B, C, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE4_F(C, D, E, A, B, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE4_F(B, C, D, E, A, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE4_F(A, B, C, D, E, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE4_F(E, A, B, C, D, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1); ROTATE4_F(D, E, A, B, C, w4);  
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE4_F(C, D, E, A, B, w5);  
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7,S1); ROTATE4_F(B, C, D, E, A, w6); 
w7 = rotate(w4 ^ w16 ^ w10 ^ w8,S1); ROTATE4_F(A, B, C, D, E, w7); 
w8 = rotate(w5 ^ w0 ^ w11 ^ w9,S1); ROTATE4_F(E, A, B, C, D, w8);  
w9 = rotate(w6 ^ w1 ^ w12 ^ w10,S1); ROTATE4_F(D, E, A, B, C, w9); 
w10 = rotate(w7 ^ w2 ^ w13 ^ w11,S1); ROTATE4_F(C, D, E, A, B, w10);
w11 = rotate(w8 ^ w3 ^ w14 ^ w12,S1); ROTATE4_F(B, C, D, E, A, w11);

A+=IPA;
B+=IPB;
C+=IPC;
D+=IPD;
E+=IPE;


// calculate hash sum 1
w0=A;
w1=B;
w2=C;
w3=D;
w4=E;
w5=(uint)0x80000000;
SIZE=(uint)(64+20)<<3;

A=OPA;
B=OPB;
C=OPC;
D=OPD;
E=OPE;


w6=w7=w8=w9=w10=w11=w12=w13=w14=(uint)0;


K = K0;
ROTATE1(A, B, C, D, E, w0);
ROTATE1(E, A, B, C, D, w1);
ROTATE1(D, E, A, B, C, w2);
ROTATE1(C, D, E, A, B, w3);
ROTATE1(B, C, D, E, A, w4);
ROTATE1(A, B, C, D, E, w5);
ROTATE1_NULL(E, A, B, C, D);
ROTATE1_NULL(D, E, A, B, C);
ROTATE1_NULL(C, D, E, A, B);
ROTATE1_NULL(B, C, D, E, A);
ROTATE1_NULL(A, B, C, D, E);
ROTATE1_NULL(E, A, B, C, D);
ROTATE1_NULL(D, E, A, B, C);
ROTATE1_NULL(C, D, E, A, B);
ROTATE1_NULL(B, C, D, E, A);
ROTATE1(A, B, C, D, E, SIZE);  
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1);ROTATE1(E,A,B,C,D,w16);
w0 = rotate((w14 ^ w9 ^ w3 ^ w1),S1);ROTATE1(D,E,A,B,C,w0); 
w1 = rotate((SIZE ^ w10 ^ w4 ^ w2),S1); ROTATE1(C,D,E,A,B,w1); 
w2 = rotate((w16 ^ w11 ^ w5 ^ w3),S1);  ROTATE1(B,C,D,E,A,w2); 
K = K1;
w3 = rotate((w0 ^ w12 ^ w6 ^ w4),S1); ROTATE2_F(A, B, C, D, E, w3);
w4 = rotate((w1 ^ w13 ^ w7 ^ w5),S1); ROTATE2_F(E, A, B, C, D, w4);
w5 = rotate((w2 ^ w14 ^ w8 ^ w6),S1); ROTATE2_F(D, E, A, B, C, w5);
w6 = rotate((w3 ^ SIZE ^ w9 ^ w7),S1);ROTATE2_F(C, D, E, A, B, w6);
w7 = rotate((w4 ^ w16 ^ w10 ^ w8),S1); ROTATE2_F(B, C, D, E, A, w7);
w8 = rotate((w5 ^ w0 ^ w11 ^ w9),S1); ROTATE2_F(A, B, C, D, E, w8);
w9 = rotate((w6 ^ w1 ^ w12 ^ w10),S1); ROTATE2_F(E, A, B, C, D, w9);
w10 = rotate((w7 ^ w2 ^ w13 ^ w11),S1); ROTATE2_F(D, E, A, B, C, w10); 
w11 = rotate((w8 ^ w3 ^ w14 ^ w12),S1); ROTATE2_F(C, D, E, A, B, w11); 
w12 = rotate((w9 ^ w4 ^ SIZE ^ w13),S1); ROTATE2_F(B, C, D, E, A, w12);
w13 = rotate((w10 ^ w5 ^ w16 ^ w14),S1); ROTATE2_F(A, B, C, D, E, w13);
w14 = rotate((w11 ^ w6 ^ w0 ^ SIZE),S1); ROTATE2_F(E, A, B, C, D, w14);
SIZE = rotate((w12 ^ w7 ^ w1 ^ w16),S1); ROTATE2_F(D, E, A, B, C, SIZE);
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1); ROTATE2_F(C, D, E, A, B, w16);  
w0 = rotate(w14 ^ w9 ^ w3 ^ w1,S1); ROTATE2_F(B, C, D, E, A, w0);  
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2,S1); ROTATE2_F(A, B, C, D, E, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE2_F(E, A, B, C, D, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE2_F(D, E, A, B, C, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1);ROTATE2_F(C, D, E, A, B, w4);
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE2_F(B, C, D, E, A, w5);  
K = K2;
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(A, B, C, D, E, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(E, A, B, C, D, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(D, E, A, B, C, w8); 
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE3_F(C, D, E, A, B, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE3_F(B, C, D, E, A, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE3_F(A, B, C, D, E, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE3_F(E, A, B, C, D, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE3_F(D, E, A, B, C, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE3_F(C, D, E, A, B, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE3_F(B, C, D, E, A, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE3_F(A, B, C, D, E, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE3_F(E, A, B, C, D, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE3_F(D, E, A, B, C, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3, S1); ROTATE3_F(C, D, E, A, B, w2);
w3 = rotate(w0 ^ w12 ^ w6 ^ w4, S1); ROTATE3_F(B, C, D, E, A, w3); 
w4 = rotate(w1 ^ w13 ^ w7 ^ w5, S1); ROTATE3_F(A, B, C, D, E, w4); 
w5 = rotate(w2 ^ w14 ^ w8 ^ w6, S1); ROTATE3_F(E, A, B, C, D, w5); 
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(D, E, A, B, C, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(C, D, E, A, B, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(B, C, D, E, A, w8); 
K = K3;
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE4_F(A, B, C, D, E, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE4_F(E, A, B, C, D, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE4_F(D, E, A, B, C, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE4_F(C, D, E, A, B, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE4_F(B, C, D, E, A, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE4_F(A, B, C, D, E, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE4_F(E, A, B, C, D, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE4_F(D, E, A, B, C, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE4_F(C, D, E, A, B, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE4_F(B, C, D, E, A, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE4_F(A, B, C, D, E, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE4_F(E, A, B, C, D, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1); ROTATE4_F(D, E, A, B, C, w4);  
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE4_F(C, D, E, A, B, w5);  
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7,S1); ROTATE4_F(B, C, D, E, A, w6); 
w7 = rotate(w4 ^ w16 ^ w10 ^ w8,S1); ROTATE4_F(A, B, C, D, E, w7); 
w8 = rotate(w5 ^ w0 ^ w11 ^ w9,S1); ROTATE4_F(E, A, B, C, D, w8);  
w9 = rotate(w6 ^ w1 ^ w12 ^ w10,S1); ROTATE4_F(D, E, A, B, C, w9); 
w10 = rotate(w7 ^ w2 ^ w13 ^ w11,S1); ROTATE4_F(C, D, E, A, B, w10);
w11 = rotate(w8 ^ w3 ^ w14 ^ w12,S1); ROTATE4_F(B, C, D, E, A, w11);

A+=OPA;
B+=OPB;
C+=OPC;
D+=OPD;
E+=OPE;


TTA ^= A;
TTB ^= B;
TTC ^= C;
TTD ^= D;
TTE ^= E;
}

dst[get_global_id(0)*3*5+0]=TTA;
dst[get_global_id(0)*3*5+1]=TTB;
dst[get_global_id(0)*3*5+2]=TTC;
dst[get_global_id(0)*3*5+3]=TTD;
dst[get_global_id(0)*3*5+4]=TTE;
dst[get_global_id(0)*3*5+10]=A;
dst[get_global_id(0)*3*5+11]=B;
dst[get_global_id(0)*3*5+12]=C;
dst[get_global_id(0)*3*5+13]=D;
dst[get_global_id(0)*3*5+14]=E;
}




__kernel 
__attribute__((reqd_work_group_size(64, 1, 1)))
void prepare2( __global uint *dst,  __global uint *input, __global uint *input1, uint16 str, uint16 salt,uint4 singlehash, uint16 salt2, __global uint *block, __global uint *eapol)
{
uint SIZE;  
uint ib,ic,id;  
uint a,b,c,d,e,f,g,h, tmp1, tmp2,l; 
uint w0, w1, w2, w3, w4, w5, w6, w7,w8,w9,w10,w11,w12,w13,w14,w16,w15;
uint yl,yr,zl,zr,wl,wr;
uint K;
uint K0 = (uint)0x5A827999;
uint K1 = (uint)0x6ED9EBA1;
uint K2 = (uint)0x8F1BBCDC;
uint K3 = (uint)0xCA62C1D6;
uint H0 = (uint)0x67452301;
uint H1 = (uint)0xEFCDAB89;
uint H2 = (uint)0x98BADCFE;
uint H3 = (uint)0x10325476;
uint H4 = (uint)0xC3D2E1F0;
uint A,B,C,D,E;
uint IPA,IPB,IPC,IPD,IPE;
uint OPA,OPB,OPC,OPD,OPE;
uint TTA,TTB,TTC,TTD,TTE;


TTA=dst[get_global_id(0)*3*5+0];
TTB=dst[get_global_id(0)*3*5+1];
TTC=dst[get_global_id(0)*3*5+2];
TTD=dst[get_global_id(0)*3*5+3];
TTE=dst[get_global_id(0)*3*5+4];
IPA=input1[get_global_id(0)*2*5+0];
IPB=input1[get_global_id(0)*2*5+1];
IPC=input1[get_global_id(0)*2*5+2];
IPD=input1[get_global_id(0)*2*5+3];
IPE=input1[get_global_id(0)*2*5+4];
OPA=input1[get_global_id(0)*2*5+5];
OPB=input1[get_global_id(0)*2*5+6];
OPC=input1[get_global_id(0)*2*5+7];
OPD=input1[get_global_id(0)*2*5+8];
OPE=input1[get_global_id(0)*2*5+9];

// Second part of PBKDF2

// calculate hash sum 1
A=IPA;
B=IPB;
C=IPC;
D=IPD;
E=IPE;

w0=(uint)salt2.s0;
w1=(uint)salt2.s1;
w2=(uint)salt2.s2;
w3=(uint)salt2.s3;
w4=(uint)salt2.s4;
w5=(uint)salt2.s5;
w6=(uint)salt2.s6;
w7=(uint)salt2.s7;
w8=(uint)salt2.s8;
w9=(uint)salt2.s9;
w10=(uint)salt2.sA;

SIZE=(uint)salt2.sF;
w11=w12=w13=w14=(uint)0;


K = K0;
Endian_Reverse32(w0);  
ROTATE1(A, B, C, D, E, w0);
Endian_Reverse32(w1);  
ROTATE1(E, A, B, C, D, w1);
Endian_Reverse32(w2);  
ROTATE1(D, E, A, B, C, w2);
Endian_Reverse32(w3);  
ROTATE1(C, D, E, A, B, w3);
Endian_Reverse32(w4);  
ROTATE1(B, C, D, E, A, w4);
Endian_Reverse32(w5);  
ROTATE1(A, B, C, D, E, w5);
Endian_Reverse32(w6);  
ROTATE1(E, A, B, C, D, w6);
Endian_Reverse32(w7);  
ROTATE1(D, E, A, B, C, w7);
Endian_Reverse32(w8);  
ROTATE1(C, D, E, A, B, w8);
Endian_Reverse32(w9);  
ROTATE1(B, C, D, E, A, w9);
Endian_Reverse32(w10);  
ROTATE1(A, B, C, D, E, w10);
ROTATE1(E, A, B, C, D, w11);
ROTATE1(D, E, A, B, C, w12);
ROTATE1(C, D, E, A, B, w13);
ROTATE1(B, C, D, E, A, w14);
ROTATE1(A, B, C, D, E, SIZE);  
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1);ROTATE1(E,A,B,C,D,w16);
w0 = rotate((w14 ^ w9 ^ w3 ^ w1),S1);ROTATE1(D,E,A,B,C,w0); 
w1 = rotate((SIZE ^ w10 ^ w4 ^ w2),S1); ROTATE1(C,D,E,A,B,w1); 
w2 = rotate((w16 ^ w11 ^ w5 ^ w3),S1);  ROTATE1(B,C,D,E,A,w2); 
K = K1;
w3 = rotate((w0 ^ w12 ^ w6 ^ w4),S1); ROTATE2_F(A, B, C, D, E, w3);
w4 = rotate((w1 ^ w13 ^ w7 ^ w5),S1); ROTATE2_F(E, A, B, C, D, w4);
w5 = rotate((w2 ^ w14 ^ w8 ^ w6),S1); ROTATE2_F(D, E, A, B, C, w5);
w6 = rotate((w3 ^ SIZE ^ w9 ^ w7),S1);ROTATE2_F(C, D, E, A, B, w6);
w7 = rotate((w4 ^ w16 ^ w10 ^ w8),S1); ROTATE2_F(B, C, D, E, A, w7);
w8 = rotate((w5 ^ w0 ^ w11 ^ w9),S1); ROTATE2_F(A, B, C, D, E, w8);
w9 = rotate((w6 ^ w1 ^ w12 ^ w10),S1); ROTATE2_F(E, A, B, C, D, w9);
w10 = rotate((w7 ^ w2 ^ w13 ^ w11),S1); ROTATE2_F(D, E, A, B, C, w10); 
w11 = rotate((w8 ^ w3 ^ w14 ^ w12),S1); ROTATE2_F(C, D, E, A, B, w11); 
w12 = rotate((w9 ^ w4 ^ SIZE ^ w13),S1); ROTATE2_F(B, C, D, E, A, w12);
w13 = rotate((w10 ^ w5 ^ w16 ^ w14),S1); ROTATE2_F(A, B, C, D, E, w13);
w14 = rotate((w11 ^ w6 ^ w0 ^ SIZE),S1); ROTATE2_F(E, A, B, C, D, w14);
SIZE = rotate((w12 ^ w7 ^ w1 ^ w16),S1); ROTATE2_F(D, E, A, B, C, SIZE);
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1); ROTATE2_F(C, D, E, A, B, w16);  
w0 = rotate(w14 ^ w9 ^ w3 ^ w1,S1); ROTATE2_F(B, C, D, E, A, w0);  
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2,S1); ROTATE2_F(A, B, C, D, E, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE2_F(E, A, B, C, D, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE2_F(D, E, A, B, C, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1);ROTATE2_F(C, D, E, A, B, w4);
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE2_F(B, C, D, E, A, w5);  
K = K2;
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(A, B, C, D, E, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(E, A, B, C, D, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(D, E, A, B, C, w8); 
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE3_F(C, D, E, A, B, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE3_F(B, C, D, E, A, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE3_F(A, B, C, D, E, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE3_F(E, A, B, C, D, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE3_F(D, E, A, B, C, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE3_F(C, D, E, A, B, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE3_F(B, C, D, E, A, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE3_F(A, B, C, D, E, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE3_F(E, A, B, C, D, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE3_F(D, E, A, B, C, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3, S1); ROTATE3_F(C, D, E, A, B, w2);
w3 = rotate(w0 ^ w12 ^ w6 ^ w4, S1); ROTATE3_F(B, C, D, E, A, w3); 
w4 = rotate(w1 ^ w13 ^ w7 ^ w5, S1); ROTATE3_F(A, B, C, D, E, w4); 
w5 = rotate(w2 ^ w14 ^ w8 ^ w6, S1); ROTATE3_F(E, A, B, C, D, w5); 
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(D, E, A, B, C, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(C, D, E, A, B, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(B, C, D, E, A, w8); 
K = K3;
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE4_F(A, B, C, D, E, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE4_F(E, A, B, C, D, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE4_F(D, E, A, B, C, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE4_F(C, D, E, A, B, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE4_F(B, C, D, E, A, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE4_F(A, B, C, D, E, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE4_F(E, A, B, C, D, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE4_F(D, E, A, B, C, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE4_F(C, D, E, A, B, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE4_F(B, C, D, E, A, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE4_F(A, B, C, D, E, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE4_F(E, A, B, C, D, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1); ROTATE4_F(D, E, A, B, C, w4);  
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE4_F(C, D, E, A, B, w5);  
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7,S1); ROTATE4_F(B, C, D, E, A, w6); 
w7 = rotate(w4 ^ w16 ^ w10 ^ w8,S1); ROTATE4_F(A, B, C, D, E, w7); 
w8 = rotate(w5 ^ w0 ^ w11 ^ w9,S1); ROTATE4_F(E, A, B, C, D, w8);  
w9 = rotate(w6 ^ w1 ^ w12 ^ w10,S1); ROTATE4_F(D, E, A, B, C, w9); 
w10 = rotate(w7 ^ w2 ^ w13 ^ w11,S1); ROTATE4_F(C, D, E, A, B, w10);
w11 = rotate(w8 ^ w3 ^ w14 ^ w12,S1); ROTATE4_F(B, C, D, E, A, w11);
A=A+IPA;B=B+IPB;C=C+IPC;D=D+IPD;E=E+IPE;



// calculate hash sum 2

w0=A;
w1=B;
w2=C;
w3=D;
w4=E;
w5=(uint)0x80000000;
A=OPA;
B=OPB;
C=OPC;
D=OPD;
E=OPE;
SIZE=(uint)((64+20)<<3);
w6=w7=w8=w9=w10=w11=w12=w13=w14=(uint)0;


K = K0;
ROTATE1(A, B, C, D, E, w0);
ROTATE1(E, A, B, C, D, w1);
ROTATE1(D, E, A, B, C, w2);
ROTATE1(C, D, E, A, B, w3);
ROTATE1(B, C, D, E, A, w4);
ROTATE1(A, B, C, D, E, w5);
ROTATE1(E, A, B, C, D, w6);
ROTATE1(D, E, A, B, C, w7);
ROTATE1(C, D, E, A, B, w8);
ROTATE1(B, C, D, E, A, w9);
ROTATE1(A, B, C, D, E, w10);
ROTATE1(E, A, B, C, D, w11);
ROTATE1(D, E, A, B, C, w12);
ROTATE1(C, D, E, A, B, w13);
ROTATE1(B, C, D, E, A, w14);
ROTATE1(A, B, C, D, E, SIZE);  
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1);ROTATE1(E,A,B,C,D,w16);
w0 = rotate((w14 ^ w9 ^ w3 ^ w1),S1);ROTATE1(D,E,A,B,C,w0); 
w1 = rotate((SIZE ^ w10 ^ w4 ^ w2),S1); ROTATE1(C,D,E,A,B,w1); 
w2 = rotate((w16 ^ w11 ^ w5 ^ w3),S1);  ROTATE1(B,C,D,E,A,w2); 
K = K1;
w3 = rotate((w0 ^ w12 ^ w6 ^ w4),S1); ROTATE2_F(A, B, C, D, E, w3);
w4 = rotate((w1 ^ w13 ^ w7 ^ w5),S1); ROTATE2_F(E, A, B, C, D, w4);
w5 = rotate((w2 ^ w14 ^ w8 ^ w6),S1); ROTATE2_F(D, E, A, B, C, w5);
w6 = rotate((w3 ^ SIZE ^ w9 ^ w7),S1);ROTATE2_F(C, D, E, A, B, w6);
w7 = rotate((w4 ^ w16 ^ w10 ^ w8),S1); ROTATE2_F(B, C, D, E, A, w7);
w8 = rotate((w5 ^ w0 ^ w11 ^ w9),S1); ROTATE2_F(A, B, C, D, E, w8);
w9 = rotate((w6 ^ w1 ^ w12 ^ w10),S1); ROTATE2_F(E, A, B, C, D, w9);
w10 = rotate((w7 ^ w2 ^ w13 ^ w11),S1); ROTATE2_F(D, E, A, B, C, w10); 
w11 = rotate((w8 ^ w3 ^ w14 ^ w12),S1); ROTATE2_F(C, D, E, A, B, w11); 
w12 = rotate((w9 ^ w4 ^ SIZE ^ w13),S1); ROTATE2_F(B, C, D, E, A, w12);
w13 = rotate((w10 ^ w5 ^ w16 ^ w14),S1); ROTATE2_F(A, B, C, D, E, w13);
w14 = rotate((w11 ^ w6 ^ w0 ^ SIZE),S1); ROTATE2_F(E, A, B, C, D, w14);
SIZE = rotate((w12 ^ w7 ^ w1 ^ w16),S1); ROTATE2_F(D, E, A, B, C, SIZE);
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1); ROTATE2_F(C, D, E, A, B, w16);  
w0 = rotate(w14 ^ w9 ^ w3 ^ w1,S1); ROTATE2_F(B, C, D, E, A, w0);  
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2,S1); ROTATE2_F(A, B, C, D, E, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE2_F(E, A, B, C, D, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE2_F(D, E, A, B, C, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1);ROTATE2_F(C, D, E, A, B, w4);
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE2_F(B, C, D, E, A, w5);  
K = K2;
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(A, B, C, D, E, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(E, A, B, C, D, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(D, E, A, B, C, w8); 
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE3_F(C, D, E, A, B, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE3_F(B, C, D, E, A, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE3_F(A, B, C, D, E, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE3_F(E, A, B, C, D, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE3_F(D, E, A, B, C, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE3_F(C, D, E, A, B, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE3_F(B, C, D, E, A, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE3_F(A, B, C, D, E, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE3_F(E, A, B, C, D, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE3_F(D, E, A, B, C, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3, S1); ROTATE3_F(C, D, E, A, B, w2);
w3 = rotate(w0 ^ w12 ^ w6 ^ w4, S1); ROTATE3_F(B, C, D, E, A, w3); 
w4 = rotate(w1 ^ w13 ^ w7 ^ w5, S1); ROTATE3_F(A, B, C, D, E, w4); 
w5 = rotate(w2 ^ w14 ^ w8 ^ w6, S1); ROTATE3_F(E, A, B, C, D, w5); 
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(D, E, A, B, C, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(C, D, E, A, B, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(B, C, D, E, A, w8); 
K = K3;
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE4_F(A, B, C, D, E, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE4_F(E, A, B, C, D, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE4_F(D, E, A, B, C, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE4_F(C, D, E, A, B, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE4_F(B, C, D, E, A, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE4_F(A, B, C, D, E, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE4_F(E, A, B, C, D, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE4_F(D, E, A, B, C, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE4_F(C, D, E, A, B, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE4_F(B, C, D, E, A, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE4_F(A, B, C, D, E, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE4_F(E, A, B, C, D, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1); ROTATE4_F(D, E, A, B, C, w4);  
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE4_F(C, D, E, A, B, w5);  
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7,S1); ROTATE4_F(B, C, D, E, A, w6); 
w7 = rotate(w4 ^ w16 ^ w10 ^ w8,S1); ROTATE4_F(A, B, C, D, E, w7); 
w8 = rotate(w5 ^ w0 ^ w11 ^ w9,S1); ROTATE4_F(E, A, B, C, D, w8);  
w9 = rotate(w6 ^ w1 ^ w12 ^ w10,S1); ROTATE4_F(D, E, A, B, C, w9); 
w10 = rotate(w7 ^ w2 ^ w13 ^ w11,S1); ROTATE4_F(C, D, E, A, B, w10);
w11 = rotate(w8 ^ w3 ^ w14 ^ w12,S1); ROTATE4_F(B, C, D, E, A, w11);
A=A+OPA;B=B+OPB;C=C+OPC;D=D+OPD;E=E+OPE;
TTA=A;TTB=B;TTC=C;TTD=D;TTE=E;
dst[get_global_id(0)*3*5+5]=TTA;
dst[get_global_id(0)*3*5+6]=TTB;
dst[get_global_id(0)*3*5+7]=TTC;
dst[get_global_id(0)*3*5+8]=TTD;
dst[get_global_id(0)*3*5+9]=TTE;
dst[get_global_id(0)*3*5+10]=TTA;
dst[get_global_id(0)*3*5+11]=TTB;
dst[get_global_id(0)*3*5+12]=TTC;
dst[get_global_id(0)*3*5+13]=TTD;
dst[get_global_id(0)*3*5+14]=TTE;
}




__kernel 
__attribute__((reqd_work_group_size(64, 1, 1)))
void pbkdf2( __global uint *dst,  __global uint *input, __global uint *input1, uint16 str, uint16 salt,uint4 singlehash, uint16 salt2, __global uint *block, __global uint *eapol)
{
uint SIZE;  
uint ib,ic,id;  
uint a,b,c,d,e,f,g,h, tmp1, tmp2,l; 
uint w0, w1, w2, w3, w4, w5, w6, w7,w8,w9,w10,w11,w12,w13,w14,w16,w15;
uint yl,yr,zl,zr,wl,wr;
uint K;
uint K0 = (uint)0x5A827999;
uint K1 = (uint)0x6ED9EBA1;
uint K2 = (uint)0x8F1BBCDC;
uint K3 = (uint)0xCA62C1D6;
uint H0 = (uint)0x67452301;
uint H1 = (uint)0xEFCDAB89;
uint H2 = (uint)0x98BADCFE;
uint H3 = (uint)0x10325476;
uint H4 = (uint)0xC3D2E1F0;
uint A,B,C,D,E;
uint IPA,IPB,IPC,IPD,IPE;
uint OPA,OPB,OPC,OPD,OPE;
uint TTA,TTB,TTC,TTD,TTE;


TTA=dst[get_global_id(0)*3*5+5];
TTB=dst[get_global_id(0)*3*5+6];
TTC=dst[get_global_id(0)*3*5+7];
TTD=dst[get_global_id(0)*3*5+8];
TTE=dst[get_global_id(0)*3*5+9];
A=dst[get_global_id(0)*3*5+10];
B=dst[get_global_id(0)*3*5+11];
C=dst[get_global_id(0)*3*5+12];
D=dst[get_global_id(0)*3*5+13];
E=dst[get_global_id(0)*3*5+14];
IPA=input1[get_global_id(0)*2*5+0];
IPB=input1[get_global_id(0)*2*5+1];
IPC=input1[get_global_id(0)*2*5+2];
IPD=input1[get_global_id(0)*2*5+3];
IPE=input1[get_global_id(0)*2*5+4];
OPA=input1[get_global_id(0)*2*5+5];
OPB=input1[get_global_id(0)*2*5+6];
OPC=input1[get_global_id(0)*2*5+7];
OPD=input1[get_global_id(0)*2*5+8];
OPE=input1[get_global_id(0)*2*5+9];


// We now have the first HMAC part2. Iterate to find the rest
for (ic=str.sA;ic<str.sA+1170;ic+=2)
{

// calculate hash sum 1
w0=A;
w1=B;
w2=C;
w3=D;
w4=E;
w5=(uint)0x80000000;
SIZE=(uint)(64+20)<<3;
A=IPA;
B=IPB;
C=IPC;
D=IPD;
E=IPE;

w6=w7=w8=w9=w10=w11=w12=w13=w14=(uint)0;


K = K0;
ROTATE1(A, B, C, D, E, w0);
ROTATE1(E, A, B, C, D, w1);
ROTATE1(D, E, A, B, C, w2);
ROTATE1(C, D, E, A, B, w3);
ROTATE1(B, C, D, E, A, w4);
ROTATE1(A, B, C, D, E, w5);
ROTATE1_NULL(E, A, B, C, D);
ROTATE1_NULL(D, E, A, B, C);
ROTATE1_NULL(C, D, E, A, B);
ROTATE1_NULL(B, C, D, E, A);
ROTATE1_NULL(A, B, C, D, E);
ROTATE1_NULL(E, A, B, C, D);
ROTATE1_NULL(D, E, A, B, C);
ROTATE1_NULL(C, D, E, A, B);
ROTATE1_NULL(B, C, D, E, A);
ROTATE1(A, B, C, D, E, SIZE);  
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1);ROTATE1(E,A,B,C,D,w16);
w0 = rotate((w14 ^ w9 ^ w3 ^ w1),S1);ROTATE1(D,E,A,B,C,w0); 
w1 = rotate((SIZE ^ w10 ^ w4 ^ w2),S1); ROTATE1(C,D,E,A,B,w1); 
w2 = rotate((w16 ^ w11 ^ w5 ^ w3),S1);  ROTATE1(B,C,D,E,A,w2); 
K = K1;
w3 = rotate((w0 ^ w12 ^ w6 ^ w4),S1); ROTATE2_F(A, B, C, D, E, w3);
w4 = rotate((w1 ^ w13 ^ w7 ^ w5),S1); ROTATE2_F(E, A, B, C, D, w4);
w5 = rotate((w2 ^ w14 ^ w8 ^ w6),S1); ROTATE2_F(D, E, A, B, C, w5);
w6 = rotate((w3 ^ SIZE ^ w9 ^ w7),S1);ROTATE2_F(C, D, E, A, B, w6);
w7 = rotate((w4 ^ w16 ^ w10 ^ w8),S1); ROTATE2_F(B, C, D, E, A, w7);
w8 = rotate((w5 ^ w0 ^ w11 ^ w9),S1); ROTATE2_F(A, B, C, D, E, w8);
w9 = rotate((w6 ^ w1 ^ w12 ^ w10),S1); ROTATE2_F(E, A, B, C, D, w9);
w10 = rotate((w7 ^ w2 ^ w13 ^ w11),S1); ROTATE2_F(D, E, A, B, C, w10); 
w11 = rotate((w8 ^ w3 ^ w14 ^ w12),S1); ROTATE2_F(C, D, E, A, B, w11); 
w12 = rotate((w9 ^ w4 ^ SIZE ^ w13),S1); ROTATE2_F(B, C, D, E, A, w12);
w13 = rotate((w10 ^ w5 ^ w16 ^ w14),S1); ROTATE2_F(A, B, C, D, E, w13);
w14 = rotate((w11 ^ w6 ^ w0 ^ SIZE),S1); ROTATE2_F(E, A, B, C, D, w14);
SIZE = rotate((w12 ^ w7 ^ w1 ^ w16),S1); ROTATE2_F(D, E, A, B, C, SIZE);
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1); ROTATE2_F(C, D, E, A, B, w16);  
w0 = rotate(w14 ^ w9 ^ w3 ^ w1,S1); ROTATE2_F(B, C, D, E, A, w0);  
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2,S1); ROTATE2_F(A, B, C, D, E, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE2_F(E, A, B, C, D, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE2_F(D, E, A, B, C, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1);ROTATE2_F(C, D, E, A, B, w4);
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE2_F(B, C, D, E, A, w5);  
K = K2;
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(A, B, C, D, E, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(E, A, B, C, D, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(D, E, A, B, C, w8); 
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE3_F(C, D, E, A, B, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE3_F(B, C, D, E, A, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE3_F(A, B, C, D, E, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE3_F(E, A, B, C, D, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE3_F(D, E, A, B, C, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE3_F(C, D, E, A, B, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE3_F(B, C, D, E, A, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE3_F(A, B, C, D, E, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE3_F(E, A, B, C, D, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE3_F(D, E, A, B, C, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3, S1); ROTATE3_F(C, D, E, A, B, w2);
w3 = rotate(w0 ^ w12 ^ w6 ^ w4, S1); ROTATE3_F(B, C, D, E, A, w3); 
w4 = rotate(w1 ^ w13 ^ w7 ^ w5, S1); ROTATE3_F(A, B, C, D, E, w4); 
w5 = rotate(w2 ^ w14 ^ w8 ^ w6, S1); ROTATE3_F(E, A, B, C, D, w5); 
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(D, E, A, B, C, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(C, D, E, A, B, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(B, C, D, E, A, w8); 
K = K3;
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE4_F(A, B, C, D, E, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE4_F(E, A, B, C, D, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE4_F(D, E, A, B, C, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE4_F(C, D, E, A, B, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE4_F(B, C, D, E, A, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE4_F(A, B, C, D, E, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE4_F(E, A, B, C, D, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE4_F(D, E, A, B, C, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE4_F(C, D, E, A, B, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE4_F(B, C, D, E, A, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE4_F(A, B, C, D, E, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE4_F(E, A, B, C, D, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1); ROTATE4_F(D, E, A, B, C, w4);  
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE4_F(C, D, E, A, B, w5);  
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7,S1); ROTATE4_F(B, C, D, E, A, w6); 
w7 = rotate(w4 ^ w16 ^ w10 ^ w8,S1); ROTATE4_F(A, B, C, D, E, w7); 
w8 = rotate(w5 ^ w0 ^ w11 ^ w9,S1); ROTATE4_F(E, A, B, C, D, w8);  
w9 = rotate(w6 ^ w1 ^ w12 ^ w10,S1); ROTATE4_F(D, E, A, B, C, w9); 
w10 = rotate(w7 ^ w2 ^ w13 ^ w11,S1); ROTATE4_F(C, D, E, A, B, w10);
w11 = rotate(w8 ^ w3 ^ w14 ^ w12,S1); ROTATE4_F(B, C, D, E, A, w11);


A+=IPA;
B+=IPB;
C+=IPC;
D+=IPD;
E+=IPE;




// calculate hash sum 1
w0=A;
w1=B;
w2=C;
w3=D;
w4=E;
w5=(uint)0x80000000;
SIZE=(uint)(64+20)<<3;
A=OPA;
B=OPB;
C=OPC;
D=OPD;
E=OPE;

w6=w7=w8=w9=w10=w11=w12=w13=w14=(uint)0;


K = K0;
ROTATE1(A, B, C, D, E, w0);
ROTATE1(E, A, B, C, D, w1);
ROTATE1(D, E, A, B, C, w2);
ROTATE1(C, D, E, A, B, w3);
ROTATE1(B, C, D, E, A, w4);
ROTATE1(A, B, C, D, E, w5);
ROTATE1_NULL(E, A, B, C, D);
ROTATE1_NULL(D, E, A, B, C);
ROTATE1_NULL(C, D, E, A, B);
ROTATE1_NULL(B, C, D, E, A);
ROTATE1_NULL(A, B, C, D, E);
ROTATE1_NULL(E, A, B, C, D);
ROTATE1_NULL(D, E, A, B, C);
ROTATE1_NULL(C, D, E, A, B);
ROTATE1_NULL(B, C, D, E, A);
ROTATE1(A, B, C, D, E, SIZE);  
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1);ROTATE1(E,A,B,C,D,w16);
w0 = rotate((w14 ^ w9 ^ w3 ^ w1),S1);ROTATE1(D,E,A,B,C,w0); 
w1 = rotate((SIZE ^ w10 ^ w4 ^ w2),S1); ROTATE1(C,D,E,A,B,w1); 
w2 = rotate((w16 ^ w11 ^ w5 ^ w3),S1);  ROTATE1(B,C,D,E,A,w2); 
K = K1;
w3 = rotate((w0 ^ w12 ^ w6 ^ w4),S1); ROTATE2_F(A, B, C, D, E, w3);
w4 = rotate((w1 ^ w13 ^ w7 ^ w5),S1); ROTATE2_F(E, A, B, C, D, w4);
w5 = rotate((w2 ^ w14 ^ w8 ^ w6),S1); ROTATE2_F(D, E, A, B, C, w5);
w6 = rotate((w3 ^ SIZE ^ w9 ^ w7),S1);ROTATE2_F(C, D, E, A, B, w6);
w7 = rotate((w4 ^ w16 ^ w10 ^ w8),S1); ROTATE2_F(B, C, D, E, A, w7);
w8 = rotate((w5 ^ w0 ^ w11 ^ w9),S1); ROTATE2_F(A, B, C, D, E, w8);
w9 = rotate((w6 ^ w1 ^ w12 ^ w10),S1); ROTATE2_F(E, A, B, C, D, w9);
w10 = rotate((w7 ^ w2 ^ w13 ^ w11),S1); ROTATE2_F(D, E, A, B, C, w10); 
w11 = rotate((w8 ^ w3 ^ w14 ^ w12),S1); ROTATE2_F(C, D, E, A, B, w11); 
w12 = rotate((w9 ^ w4 ^ SIZE ^ w13),S1); ROTATE2_F(B, C, D, E, A, w12);
w13 = rotate((w10 ^ w5 ^ w16 ^ w14),S1); ROTATE2_F(A, B, C, D, E, w13);
w14 = rotate((w11 ^ w6 ^ w0 ^ SIZE),S1); ROTATE2_F(E, A, B, C, D, w14);
SIZE = rotate((w12 ^ w7 ^ w1 ^ w16),S1); ROTATE2_F(D, E, A, B, C, SIZE);
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1); ROTATE2_F(C, D, E, A, B, w16);  
w0 = rotate(w14 ^ w9 ^ w3 ^ w1,S1); ROTATE2_F(B, C, D, E, A, w0);  
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2,S1); ROTATE2_F(A, B, C, D, E, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE2_F(E, A, B, C, D, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE2_F(D, E, A, B, C, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1);ROTATE2_F(C, D, E, A, B, w4);
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE2_F(B, C, D, E, A, w5);  
K = K2;
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(A, B, C, D, E, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(E, A, B, C, D, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(D, E, A, B, C, w8); 
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE3_F(C, D, E, A, B, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE3_F(B, C, D, E, A, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE3_F(A, B, C, D, E, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE3_F(E, A, B, C, D, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE3_F(D, E, A, B, C, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE3_F(C, D, E, A, B, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE3_F(B, C, D, E, A, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE3_F(A, B, C, D, E, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE3_F(E, A, B, C, D, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE3_F(D, E, A, B, C, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3, S1); ROTATE3_F(C, D, E, A, B, w2);
w3 = rotate(w0 ^ w12 ^ w6 ^ w4, S1); ROTATE3_F(B, C, D, E, A, w3); 
w4 = rotate(w1 ^ w13 ^ w7 ^ w5, S1); ROTATE3_F(A, B, C, D, E, w4); 
w5 = rotate(w2 ^ w14 ^ w8 ^ w6, S1); ROTATE3_F(E, A, B, C, D, w5); 
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(D, E, A, B, C, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(C, D, E, A, B, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(B, C, D, E, A, w8); 
K = K3;
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE4_F(A, B, C, D, E, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE4_F(E, A, B, C, D, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE4_F(D, E, A, B, C, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE4_F(C, D, E, A, B, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE4_F(B, C, D, E, A, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE4_F(A, B, C, D, E, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE4_F(E, A, B, C, D, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE4_F(D, E, A, B, C, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE4_F(C, D, E, A, B, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE4_F(B, C, D, E, A, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE4_F(A, B, C, D, E, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE4_F(E, A, B, C, D, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1); ROTATE4_F(D, E, A, B, C, w4);  
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE4_F(C, D, E, A, B, w5);  
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7,S1); ROTATE4_F(B, C, D, E, A, w6); 
w7 = rotate(w4 ^ w16 ^ w10 ^ w8,S1); ROTATE4_F(A, B, C, D, E, w7); 
w8 = rotate(w5 ^ w0 ^ w11 ^ w9,S1); ROTATE4_F(E, A, B, C, D, w8);  
w9 = rotate(w6 ^ w1 ^ w12 ^ w10,S1); ROTATE4_F(D, E, A, B, C, w9); 
w10 = rotate(w7 ^ w2 ^ w13 ^ w11,S1); ROTATE4_F(C, D, E, A, B, w10);
w11 = rotate(w8 ^ w3 ^ w14 ^ w12,S1); ROTATE4_F(B, C, D, E, A, w11);


A+=OPA;
B+=OPB;
C+=OPC;
D+=OPD;
E+=OPE;


TTA ^= A;
TTB ^= B;
TTC ^= C;
}


dst[get_global_id(0)*3*5+5]=TTA;
dst[get_global_id(0)*3*5+6]=TTB;
dst[get_global_id(0)*3*5+7]=TTC;
dst[get_global_id(0)*3*5+8]=TTD;
dst[get_global_id(0)*3*5+9]=TTE;
dst[get_global_id(0)*3*5+10]=A;
dst[get_global_id(0)*3*5+11]=B;
dst[get_global_id(0)*3*5+12]=C;
dst[get_global_id(0)*3*5+13]=D;
dst[get_global_id(0)*3*5+14]=E;

}




__kernel 
__attribute__((reqd_work_group_size(64, 1, 1)))
void final( __global uint4 *dst,  __global uint *input, __global uint *input1, uint16 str, uint16 salt,uint4 singlehash, uint16 salt2, __global uint *block, __global uint *eapol, global uint *found, global uint *found_ind)
{
uint SIZE;  
uint ib,ic,id;  
uint a,b,c,d,e,f,g,h, tmp1, tmp2,l; 
uint w0, w1, w2, w3, w4, w5, w6, w7,w8,w9,w10,w11,w12,w13,w14,w16,w15;
uint yl,yr,zl,zr,wl,wr;
uint K;
uint K0 = (uint)0x5A827999;
uint K1 = (uint)0x6ED9EBA1;
uint K2 = (uint)0x8F1BBCDC;
uint K3 = (uint)0xCA62C1D6;
uint H0 = (uint)0x67452301;
uint H1 = (uint)0xEFCDAB89;
uint H2 = (uint)0x98BADCFE;
uint H3 = (uint)0x10325476;
uint H4 = (uint)0xC3D2E1F0;
uint A,B,C,D,E;
uint IPA,IPB,IPC,IPD,IPE;
uint OPA,OPB,OPC,OPD,OPE;
uint TTA,TTB,TTC,TTD,TTE;
uint TTTA,TTTB,TTTC,TTTD,TTTE;
uint mAC1 = (uint)0xd76aa478; 
uint mAC2 = (uint)0xe8c7b756; 
uint mAC3 = (uint)0x242070db; 
uint mAC4 = (uint)0xc1bdceee; 
uint mAC5 = (uint)0xf57c0faf; 
uint mAC6 = (uint)0x4787c62a; 
uint mAC7 = (uint)0xa8304613; 
uint mAC8 = (uint)0xfd469501; 
uint mAC9 = (uint)0x698098d8; 
uint mAC10= (uint)0x8b44f7af; 
uint mAC11= (uint)0xffff5bb1; 
uint mAC12= (uint)0x895cd7be; 
uint mAC13= (uint)0x6b901122; 
uint mAC14= (uint)0xfd987193; 
uint mAC15= (uint)0xa679438e; 
uint mAC16= (uint)0x49b40821; 
uint mAC17= (uint)0xf61e2562; 
uint mAC18= (uint)0xc040b340; 
uint mAC19= (uint)0x265e5a51; 
uint mAC20= (uint)0xe9b6c7aa; 
uint mAC21= (uint)0xd62f105d; 
uint mAC22= (uint)0x02441453; 
uint mAC23= (uint)0xd8a1e681; 
uint mAC24= (uint)0xe7d3fbc8; 
uint mAC25= (uint)0x21e1cde6; 
uint mAC26= (uint)0xc33707d6; 
uint mAC27= (uint)0xf4d50d87; 
uint mAC28= (uint)0x455a14ed; 
uint mAC29= (uint)0xa9e3e905; 
uint mAC30= (uint)0xfcefa3f8; 
uint mAC31= (uint)0x676f02d9; 
uint mAC32= (uint)0x8d2a4c8a; 
uint mAC33= (uint)0xfffa3942; 
uint mAC34= (uint)0x8771f681; 
uint mAC35= (uint)0x6d9d6122; 
uint mAC36= (uint)0xfde5380c; 
uint mAC37= (uint)0xa4beea44; 
uint mAC38= (uint)0x4bdecfa9; 
uint mAC39= (uint)0xf6bb4b60; 
uint mAC40= (uint)0xbebfbc70; 
uint mAC41= (uint)0x289b7ec6; 
uint mAC42= (uint)0xeaa127fa; 
uint mAC43= (uint)0xd4ef3085; 
uint mAC44= (uint)0x04881d05; 
uint mAC45= (uint)0xd9d4d039; 
uint mAC46= (uint)0xe6db99e5; 
uint mAC47= (uint)0x1fa27cf8; 
uint mAC48= (uint)0xc4ac5665; 
uint mAC49= (uint)0xf4292244; 
uint mAC50= (uint)0x432aff97; 
uint mAC51= (uint)0xab9423a7; 
uint mAC52= (uint)0xfc93a039; 
uint mAC53= (uint)0x655b59c3; 
uint mAC54= (uint)0x8f0ccc92; 
uint mAC55= (uint)0xffeff47d; 
uint mAC56= (uint)0x85845dd1; 
uint mAC57= (uint)0x6fa87e4f; 
uint mAC58= (uint)0xfe2ce6e0; 
uint mAC59= (uint)0xa3014314; 
uint mAC60= (uint)0x4e0811a1; 
uint mAC61= (uint)0xf7537e82; 
uint mAC62= (uint)0xbd3af235; 
uint mAC63= (uint)0x2ad7d2bb; 
uint mAC64= (uint)0xeb86d391; 
uint mOne, mCa, mCb, mCc, mCd;


TTTA=input1[get_global_id(0)*3*5+0];
TTTB=input1[get_global_id(0)*3*5+1];
TTTC=input1[get_global_id(0)*3*5+2];
TTTD=input1[get_global_id(0)*3*5+3];
TTTE=input1[get_global_id(0)*3*5+4];
TTA=input1[get_global_id(0)*3*5+5];
TTB=input1[get_global_id(0)*3*5+6];
TTC=input1[get_global_id(0)*3*5+7];
TTD=input1[get_global_id(0)*3*5+8];
TTE=input1[get_global_id(0)*3*5+9];



// HMAC(PMK,BLOCK) 

// Calculate sha1(ipad^key)
w0=TTTA^(uint)0x36363636;
w1=TTTB^(uint)0x36363636;
w2=TTTC^(uint)0x36363636;
w3=TTTD^(uint)0x36363636;
w4=TTTE^(uint)0x36363636;
w5=TTA^(uint)0x36363636;
w6=TTB^(uint)0x36363636;
w7=TTC^(uint)0x36363636;

w8=w9=w10=w11=w12=w13=w14=SIZE=(uint)0x36363636;

A=H0;
B=H1;
C=H2;
D=H3;
E=H4;

K = K0;
ROTATE1(A, B, C, D, E, w0);
ROTATE1(E, A, B, C, D, w1);
ROTATE1(D, E, A, B, C, w2);
ROTATE1(C, D, E, A, B, w3);
ROTATE1(B, C, D, E, A, w4);
ROTATE1(A, B, C, D, E, w5);
ROTATE1(E, A, B, C, D, w6);
ROTATE1(D, E, A, B, C, w7);
ROTATE1(C, D, E, A, B, w8);
ROTATE1(B, C, D, E, A, w9);
ROTATE1(A, B, C, D, E, w10);
ROTATE1(E, A, B, C, D, w11);
ROTATE1(D, E, A, B, C, w12);
ROTATE1(C, D, E, A, B, w13);
ROTATE1(B, C, D, E, A, w14);
ROTATE1(A, B, C, D, E, SIZE);  
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1);ROTATE1(E,A,B,C,D,w16);
w0 = rotate((w14 ^ w9 ^ w3 ^ w1),S1);ROTATE1(D,E,A,B,C,w0); 
w1 = rotate((SIZE ^ w10 ^ w4 ^ w2),S1); ROTATE1(C,D,E,A,B,w1); 
w2 = rotate((w16 ^ w11 ^ w5 ^ w3),S1);  ROTATE1(B,C,D,E,A,w2); 
K = K1;
w3 = rotate((w0 ^ w12 ^ w6 ^ w4),S1); ROTATE2_F(A, B, C, D, E, w3);
w4 = rotate((w1 ^ w13 ^ w7 ^ w5),S1); ROTATE2_F(E, A, B, C, D, w4);
w5 = rotate((w2 ^ w14 ^ w8 ^ w6),S1); ROTATE2_F(D, E, A, B, C, w5);
w6 = rotate((w3 ^ SIZE ^ w9 ^ w7),S1);ROTATE2_F(C, D, E, A, B, w6);
w7 = rotate((w4 ^ w16 ^ w10 ^ w8),S1); ROTATE2_F(B, C, D, E, A, w7);
w8 = rotate((w5 ^ w0 ^ w11 ^ w9),S1); ROTATE2_F(A, B, C, D, E, w8);
w9 = rotate((w6 ^ w1 ^ w12 ^ w10),S1); ROTATE2_F(E, A, B, C, D, w9);
w10 = rotate((w7 ^ w2 ^ w13 ^ w11),S1); ROTATE2_F(D, E, A, B, C, w10); 
w11 = rotate((w8 ^ w3 ^ w14 ^ w12),S1); ROTATE2_F(C, D, E, A, B, w11); 
w12 = rotate((w9 ^ w4 ^ SIZE ^ w13),S1); ROTATE2_F(B, C, D, E, A, w12);
w13 = rotate((w10 ^ w5 ^ w16 ^ w14),S1); ROTATE2_F(A, B, C, D, E, w13);
w14 = rotate((w11 ^ w6 ^ w0 ^ SIZE),S1); ROTATE2_F(E, A, B, C, D, w14);
SIZE = rotate((w12 ^ w7 ^ w1 ^ w16),S1); ROTATE2_F(D, E, A, B, C, SIZE);
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1); ROTATE2_F(C, D, E, A, B, w16);  
w0 = rotate(w14 ^ w9 ^ w3 ^ w1,S1); ROTATE2_F(B, C, D, E, A, w0);  
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2,S1); ROTATE2_F(A, B, C, D, E, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE2_F(E, A, B, C, D, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE2_F(D, E, A, B, C, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1);ROTATE2_F(C, D, E, A, B, w4);
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE2_F(B, C, D, E, A, w5);  
K = K2;
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(A, B, C, D, E, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(E, A, B, C, D, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(D, E, A, B, C, w8); 
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE3_F(C, D, E, A, B, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE3_F(B, C, D, E, A, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE3_F(A, B, C, D, E, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE3_F(E, A, B, C, D, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE3_F(D, E, A, B, C, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE3_F(C, D, E, A, B, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE3_F(B, C, D, E, A, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE3_F(A, B, C, D, E, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE3_F(E, A, B, C, D, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE3_F(D, E, A, B, C, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3, S1); ROTATE3_F(C, D, E, A, B, w2);
w3 = rotate(w0 ^ w12 ^ w6 ^ w4, S1); ROTATE3_F(B, C, D, E, A, w3); 
w4 = rotate(w1 ^ w13 ^ w7 ^ w5, S1); ROTATE3_F(A, B, C, D, E, w4); 
w5 = rotate(w2 ^ w14 ^ w8 ^ w6, S1); ROTATE3_F(E, A, B, C, D, w5); 
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(D, E, A, B, C, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(C, D, E, A, B, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(B, C, D, E, A, w8); 
K = K3;
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE4_F(A, B, C, D, E, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE4_F(E, A, B, C, D, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE4_F(D, E, A, B, C, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE4_F(C, D, E, A, B, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE4_F(B, C, D, E, A, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE4_F(A, B, C, D, E, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE4_F(E, A, B, C, D, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE4_F(D, E, A, B, C, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE4_F(C, D, E, A, B, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE4_F(B, C, D, E, A, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE4_F(A, B, C, D, E, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE4_F(E, A, B, C, D, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1); ROTATE4_F(D, E, A, B, C, w4);  
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE4_F(C, D, E, A, B, w5);  
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7,S1); ROTATE4_F(B, C, D, E, A, w6); 
w7 = rotate(w4 ^ w16 ^ w10 ^ w8,S1); ROTATE4_F(A, B, C, D, E, w7); 
w8 = rotate(w5 ^ w0 ^ w11 ^ w9,S1); ROTATE4_F(E, A, B, C, D, w8);  
w9 = rotate(w6 ^ w1 ^ w12 ^ w10,S1); ROTATE4_F(D, E, A, B, C, w9); 
w10 = rotate(w7 ^ w2 ^ w13 ^ w11,S1); ROTATE4_F(C, D, E, A, B, w10);
w11 = rotate(w8 ^ w3 ^ w14 ^ w12,S1); ROTATE4_F(B, C, D, E, A, w11);

IPA=A+H0;IPB=B+H1;IPC=C+H2;IPD=D+H3;IPE=E+H4;



// Calculate sha1(opad^key)
w0=TTTA^(uint)0x5c5c5c5c;
w1=TTTB^(uint)0x5c5c5c5c;
w2=TTTC^(uint)0x5c5c5c5c;
w3=TTTD^(uint)0x5c5c5c5c;
w4=TTTE^(uint)0x5c5c5c5c;
w5=TTA^(uint)0x5c5c5c5c;
w6=TTB^(uint)0x5c5c5c5c;
w7=TTC^(uint)0x5c5c5c5c;

w8=w9=w10=w11=w12=w13=w14=SIZE=(uint)0x5c5c5c5c;
A=H0;
B=H1;
C=H2;
D=H3;
E=H4;
K = K0;
ROTATE1(A, B, C, D, E, w0);
ROTATE1(E, A, B, C, D, w1);
ROTATE1(D, E, A, B, C, w2);
ROTATE1(C, D, E, A, B, w3);
ROTATE1(B, C, D, E, A, w4);
ROTATE1(A, B, C, D, E, w5);
ROTATE1(E, A, B, C, D, w6);
ROTATE1(D, E, A, B, C, w7);
ROTATE1(C, D, E, A, B, w8);
ROTATE1(B, C, D, E, A, w9);
ROTATE1(A, B, C, D, E, w10);
ROTATE1(E, A, B, C, D, w11);
ROTATE1(D, E, A, B, C, w12);
ROTATE1(C, D, E, A, B, w13);
ROTATE1(B, C, D, E, A, w14);
ROTATE1(A, B, C, D, E, SIZE);  
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1);ROTATE1(E,A,B,C,D,w16);
w0 = rotate((w14 ^ w9 ^ w3 ^ w1),S1);ROTATE1(D,E,A,B,C,w0); 
w1 = rotate((SIZE ^ w10 ^ w4 ^ w2),S1); ROTATE1(C,D,E,A,B,w1); 
w2 = rotate((w16 ^ w11 ^ w5 ^ w3),S1);  ROTATE1(B,C,D,E,A,w2); 
K = K1;
w3 = rotate((w0 ^ w12 ^ w6 ^ w4),S1); ROTATE2_F(A, B, C, D, E, w3);
w4 = rotate((w1 ^ w13 ^ w7 ^ w5),S1); ROTATE2_F(E, A, B, C, D, w4);
w5 = rotate((w2 ^ w14 ^ w8 ^ w6),S1); ROTATE2_F(D, E, A, B, C, w5);
w6 = rotate((w3 ^ SIZE ^ w9 ^ w7),S1);ROTATE2_F(C, D, E, A, B, w6);
w7 = rotate((w4 ^ w16 ^ w10 ^ w8),S1); ROTATE2_F(B, C, D, E, A, w7);
w8 = rotate((w5 ^ w0 ^ w11 ^ w9),S1); ROTATE2_F(A, B, C, D, E, w8);
w9 = rotate((w6 ^ w1 ^ w12 ^ w10),S1); ROTATE2_F(E, A, B, C, D, w9);
w10 = rotate((w7 ^ w2 ^ w13 ^ w11),S1); ROTATE2_F(D, E, A, B, C, w10); 
w11 = rotate((w8 ^ w3 ^ w14 ^ w12),S1); ROTATE2_F(C, D, E, A, B, w11); 
w12 = rotate((w9 ^ w4 ^ SIZE ^ w13),S1); ROTATE2_F(B, C, D, E, A, w12);
w13 = rotate((w10 ^ w5 ^ w16 ^ w14),S1); ROTATE2_F(A, B, C, D, E, w13);
w14 = rotate((w11 ^ w6 ^ w0 ^ SIZE),S1); ROTATE2_F(E, A, B, C, D, w14);
SIZE = rotate((w12 ^ w7 ^ w1 ^ w16),S1); ROTATE2_F(D, E, A, B, C, SIZE);
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1); ROTATE2_F(C, D, E, A, B, w16);  
w0 = rotate(w14 ^ w9 ^ w3 ^ w1,S1); ROTATE2_F(B, C, D, E, A, w0);  
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2,S1); ROTATE2_F(A, B, C, D, E, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE2_F(E, A, B, C, D, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE2_F(D, E, A, B, C, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1);ROTATE2_F(C, D, E, A, B, w4);
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE2_F(B, C, D, E, A, w5);  
K = K2;
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(A, B, C, D, E, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(E, A, B, C, D, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(D, E, A, B, C, w8); 
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE3_F(C, D, E, A, B, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE3_F(B, C, D, E, A, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE3_F(A, B, C, D, E, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE3_F(E, A, B, C, D, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE3_F(D, E, A, B, C, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE3_F(C, D, E, A, B, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE3_F(B, C, D, E, A, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE3_F(A, B, C, D, E, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE3_F(E, A, B, C, D, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE3_F(D, E, A, B, C, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3, S1); ROTATE3_F(C, D, E, A, B, w2);
w3 = rotate(w0 ^ w12 ^ w6 ^ w4, S1); ROTATE3_F(B, C, D, E, A, w3); 
w4 = rotate(w1 ^ w13 ^ w7 ^ w5, S1); ROTATE3_F(A, B, C, D, E, w4); 
w5 = rotate(w2 ^ w14 ^ w8 ^ w6, S1); ROTATE3_F(E, A, B, C, D, w5); 
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(D, E, A, B, C, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(C, D, E, A, B, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(B, C, D, E, A, w8); 
K = K3;
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE4_F(A, B, C, D, E, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE4_F(E, A, B, C, D, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE4_F(D, E, A, B, C, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE4_F(C, D, E, A, B, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE4_F(B, C, D, E, A, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE4_F(A, B, C, D, E, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE4_F(E, A, B, C, D, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE4_F(D, E, A, B, C, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE4_F(C, D, E, A, B, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE4_F(B, C, D, E, A, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE4_F(A, B, C, D, E, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE4_F(E, A, B, C, D, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1); ROTATE4_F(D, E, A, B, C, w4);  
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE4_F(C, D, E, A, B, w5);  
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7,S1); ROTATE4_F(B, C, D, E, A, w6); 
w7 = rotate(w4 ^ w16 ^ w10 ^ w8,S1); ROTATE4_F(A, B, C, D, E, w7); 
w8 = rotate(w5 ^ w0 ^ w11 ^ w9,S1); ROTATE4_F(E, A, B, C, D, w8);  
w9 = rotate(w6 ^ w1 ^ w12 ^ w10,S1); ROTATE4_F(D, E, A, B, C, w9); 
w10 = rotate(w7 ^ w2 ^ w13 ^ w11,S1); ROTATE4_F(C, D, E, A, B, w10);
w11 = rotate(w8 ^ w3 ^ w14 ^ w12,S1); ROTATE4_F(B, C, D, E, A, w11);

OPA=A+H0;OPB=B+H1;OPC=C+H2;OPD=D+H3;OPE=E+H4;


// calculate hash sum 1 part 1
A=IPA;
B=IPB;
C=IPC;
D=IPD;
E=IPE;

w0=(uint)block[0];
w1=(uint)block[1];
w2=(uint)block[2];
w3=(uint)block[3];
w4=(uint)block[4];
w5=(uint)block[5];
w6=(uint)block[6];
w7=(uint)block[7];
w8=(uint)block[8];
w9=(uint)block[9];
w10=(uint)block[10];
w11=(uint)block[11];
w12=(uint)block[12];
w13=(uint)block[13];
w14=(uint)block[14];
SIZE=(uint)block[15];

K = K0;
Endian_Reverse32(w0);  
ROTATE1(A, B, C, D, E, w0);
Endian_Reverse32(w1);  
ROTATE1(E, A, B, C, D, w1);
Endian_Reverse32(w2);  
ROTATE1(D, E, A, B, C, w2);
Endian_Reverse32(w3);  
ROTATE1(C, D, E, A, B, w3);
Endian_Reverse32(w4);  
ROTATE1(B, C, D, E, A, w4);
Endian_Reverse32(w5);  
ROTATE1(A, B, C, D, E, w5);
Endian_Reverse32(w6);  
ROTATE1(E, A, B, C, D, w6);
Endian_Reverse32(w7);  
ROTATE1(D, E, A, B, C, w7);
Endian_Reverse32(w8);  
ROTATE1(C, D, E, A, B, w8);
Endian_Reverse32(w9);  
ROTATE1(B, C, D, E, A, w9);
Endian_Reverse32(w10);  
ROTATE1(A, B, C, D, E, w10);
Endian_Reverse32(w11);  
ROTATE1(E, A, B, C, D, w11);
Endian_Reverse32(w12);  
ROTATE1(D, E, A, B, C, w12);
Endian_Reverse32(w13);  
ROTATE1(C, D, E, A, B, w13);
Endian_Reverse32(w14);  
ROTATE1(B, C, D, E, A, w14);
Endian_Reverse32(SIZE);  
ROTATE1(A, B, C, D, E, SIZE);  
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1);ROTATE1(E,A,B,C,D,w16);
w0 = rotate((w14 ^ w9 ^ w3 ^ w1),S1);ROTATE1(D,E,A,B,C,w0); 
w1 = rotate((SIZE ^ w10 ^ w4 ^ w2),S1); ROTATE1(C,D,E,A,B,w1); 
w2 = rotate((w16 ^ w11 ^ w5 ^ w3),S1);  ROTATE1(B,C,D,E,A,w2); 
K = K1;
w3 = rotate((w0 ^ w12 ^ w6 ^ w4),S1); ROTATE2_F(A, B, C, D, E, w3);
w4 = rotate((w1 ^ w13 ^ w7 ^ w5),S1); ROTATE2_F(E, A, B, C, D, w4);
w5 = rotate((w2 ^ w14 ^ w8 ^ w6),S1); ROTATE2_F(D, E, A, B, C, w5);
w6 = rotate((w3 ^ SIZE ^ w9 ^ w7),S1);ROTATE2_F(C, D, E, A, B, w6);
w7 = rotate((w4 ^ w16 ^ w10 ^ w8),S1); ROTATE2_F(B, C, D, E, A, w7);
w8 = rotate((w5 ^ w0 ^ w11 ^ w9),S1); ROTATE2_F(A, B, C, D, E, w8);
w9 = rotate((w6 ^ w1 ^ w12 ^ w10),S1); ROTATE2_F(E, A, B, C, D, w9);
w10 = rotate((w7 ^ w2 ^ w13 ^ w11),S1); ROTATE2_F(D, E, A, B, C, w10); 
w11 = rotate((w8 ^ w3 ^ w14 ^ w12),S1); ROTATE2_F(C, D, E, A, B, w11); 
w12 = rotate((w9 ^ w4 ^ SIZE ^ w13),S1); ROTATE2_F(B, C, D, E, A, w12);
w13 = rotate((w10 ^ w5 ^ w16 ^ w14),S1); ROTATE2_F(A, B, C, D, E, w13);
w14 = rotate((w11 ^ w6 ^ w0 ^ SIZE),S1); ROTATE2_F(E, A, B, C, D, w14);
SIZE = rotate((w12 ^ w7 ^ w1 ^ w16),S1); ROTATE2_F(D, E, A, B, C, SIZE);
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1); ROTATE2_F(C, D, E, A, B, w16);  
w0 = rotate(w14 ^ w9 ^ w3 ^ w1,S1); ROTATE2_F(B, C, D, E, A, w0);  
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2,S1); ROTATE2_F(A, B, C, D, E, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE2_F(E, A, B, C, D, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE2_F(D, E, A, B, C, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1);ROTATE2_F(C, D, E, A, B, w4);
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE2_F(B, C, D, E, A, w5);  
K = K2;
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(A, B, C, D, E, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(E, A, B, C, D, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(D, E, A, B, C, w8); 
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE3_F(C, D, E, A, B, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE3_F(B, C, D, E, A, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE3_F(A, B, C, D, E, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE3_F(E, A, B, C, D, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE3_F(D, E, A, B, C, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE3_F(C, D, E, A, B, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE3_F(B, C, D, E, A, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE3_F(A, B, C, D, E, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE3_F(E, A, B, C, D, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE3_F(D, E, A, B, C, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3, S1); ROTATE3_F(C, D, E, A, B, w2);
w3 = rotate(w0 ^ w12 ^ w6 ^ w4, S1); ROTATE3_F(B, C, D, E, A, w3); 
w4 = rotate(w1 ^ w13 ^ w7 ^ w5, S1); ROTATE3_F(A, B, C, D, E, w4); 
w5 = rotate(w2 ^ w14 ^ w8 ^ w6, S1); ROTATE3_F(E, A, B, C, D, w5); 
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(D, E, A, B, C, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(C, D, E, A, B, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(B, C, D, E, A, w8); 
K = K3;
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE4_F(A, B, C, D, E, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE4_F(E, A, B, C, D, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE4_F(D, E, A, B, C, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE4_F(C, D, E, A, B, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE4_F(B, C, D, E, A, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE4_F(A, B, C, D, E, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE4_F(E, A, B, C, D, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE4_F(D, E, A, B, C, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE4_F(C, D, E, A, B, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE4_F(B, C, D, E, A, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE4_F(A, B, C, D, E, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE4_F(E, A, B, C, D, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1); ROTATE4_F(D, E, A, B, C, w4);  
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE4_F(C, D, E, A, B, w5);  
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7,S1); ROTATE4_F(B, C, D, E, A, w6); 
w7 = rotate(w4 ^ w16 ^ w10 ^ w8,S1); ROTATE4_F(A, B, C, D, E, w7); 
w8 = rotate(w5 ^ w0 ^ w11 ^ w9,S1); ROTATE4_F(E, A, B, C, D, w8);  
w9 = rotate(w6 ^ w1 ^ w12 ^ w10,S1); ROTATE4_F(D, E, A, B, C, w9); 
w10 = rotate(w7 ^ w2 ^ w13 ^ w11,S1); ROTATE4_F(C, D, E, A, B, w10);
w11 = rotate(w8 ^ w3 ^ w14 ^ w12,S1); ROTATE4_F(B, C, D, E, A, w11);
A=A+IPA;B=B+IPB;C=C+IPC;D=D+IPD;E=E+IPE;

TTA=A;TTB=B;TTC=C;TTD=D;TTE=E;
// calculate hash sum 1 part 1

w0=(uint)block[16];
w1=(uint)block[17];
w2=(uint)block[18];
w3=(uint)block[19];
w4=(uint)block[20];
w5=(uint)block[21];
w6=(uint)block[22];
w7=(uint)block[23];
w8=(uint)block[24];
w9=(uint)0x80000000;
w10=w11=w12=w13=w14=(uint)0;
SIZE=(uint)((164)<<3);

K = K0;
Endian_Reverse32(w0);  
ROTATE1(A, B, C, D, E, w0);
Endian_Reverse32(w1);  
ROTATE1(E, A, B, C, D, w1);
Endian_Reverse32(w2);  
ROTATE1(D, E, A, B, C, w2);
Endian_Reverse32(w3);  
ROTATE1(C, D, E, A, B, w3);
Endian_Reverse32(w4);  
ROTATE1(B, C, D, E, A, w4);
Endian_Reverse32(w5);  
ROTATE1(A, B, C, D, E, w5);
Endian_Reverse32(w6);  
ROTATE1(E, A, B, C, D, w6);
Endian_Reverse32(w7);  
ROTATE1(D, E, A, B, C, w7);
Endian_Reverse32(w8);  
ROTATE1(C, D, E, A, B, w8);
ROTATE1(B, C, D, E, A, w9);
ROTATE1(A, B, C, D, E, w10);
ROTATE1(E, A, B, C, D, w11);
ROTATE1(D, E, A, B, C, w12);
ROTATE1(C, D, E, A, B, w13);
ROTATE1(B, C, D, E, A, w14);
ROTATE1(A, B, C, D, E, SIZE);  
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1);ROTATE1(E,A,B,C,D,w16);
w0 = rotate((w14 ^ w9 ^ w3 ^ w1),S1);ROTATE1(D,E,A,B,C,w0); 
w1 = rotate((SIZE ^ w10 ^ w4 ^ w2),S1); ROTATE1(C,D,E,A,B,w1); 
w2 = rotate((w16 ^ w11 ^ w5 ^ w3),S1);  ROTATE1(B,C,D,E,A,w2); 
K = K1;
w3 = rotate((w0 ^ w12 ^ w6 ^ w4),S1); ROTATE2_F(A, B, C, D, E, w3);
w4 = rotate((w1 ^ w13 ^ w7 ^ w5),S1); ROTATE2_F(E, A, B, C, D, w4);
w5 = rotate((w2 ^ w14 ^ w8 ^ w6),S1); ROTATE2_F(D, E, A, B, C, w5);
w6 = rotate((w3 ^ SIZE ^ w9 ^ w7),S1);ROTATE2_F(C, D, E, A, B, w6);
w7 = rotate((w4 ^ w16 ^ w10 ^ w8),S1); ROTATE2_F(B, C, D, E, A, w7);
w8 = rotate((w5 ^ w0 ^ w11 ^ w9),S1); ROTATE2_F(A, B, C, D, E, w8);
w9 = rotate((w6 ^ w1 ^ w12 ^ w10),S1); ROTATE2_F(E, A, B, C, D, w9);
w10 = rotate((w7 ^ w2 ^ w13 ^ w11),S1); ROTATE2_F(D, E, A, B, C, w10); 
w11 = rotate((w8 ^ w3 ^ w14 ^ w12),S1); ROTATE2_F(C, D, E, A, B, w11); 
w12 = rotate((w9 ^ w4 ^ SIZE ^ w13),S1); ROTATE2_F(B, C, D, E, A, w12);
w13 = rotate((w10 ^ w5 ^ w16 ^ w14),S1); ROTATE2_F(A, B, C, D, E, w13);
w14 = rotate((w11 ^ w6 ^ w0 ^ SIZE),S1); ROTATE2_F(E, A, B, C, D, w14);
SIZE = rotate((w12 ^ w7 ^ w1 ^ w16),S1); ROTATE2_F(D, E, A, B, C, SIZE);
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1); ROTATE2_F(C, D, E, A, B, w16);  
w0 = rotate(w14 ^ w9 ^ w3 ^ w1,S1); ROTATE2_F(B, C, D, E, A, w0);  
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2,S1); ROTATE2_F(A, B, C, D, E, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE2_F(E, A, B, C, D, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE2_F(D, E, A, B, C, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1);ROTATE2_F(C, D, E, A, B, w4);
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE2_F(B, C, D, E, A, w5);  
K = K2;
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(A, B, C, D, E, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(E, A, B, C, D, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(D, E, A, B, C, w8); 
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE3_F(C, D, E, A, B, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE3_F(B, C, D, E, A, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE3_F(A, B, C, D, E, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE3_F(E, A, B, C, D, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE3_F(D, E, A, B, C, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE3_F(C, D, E, A, B, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE3_F(B, C, D, E, A, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE3_F(A, B, C, D, E, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE3_F(E, A, B, C, D, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE3_F(D, E, A, B, C, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3, S1); ROTATE3_F(C, D, E, A, B, w2);
w3 = rotate(w0 ^ w12 ^ w6 ^ w4, S1); ROTATE3_F(B, C, D, E, A, w3); 
w4 = rotate(w1 ^ w13 ^ w7 ^ w5, S1); ROTATE3_F(A, B, C, D, E, w4); 
w5 = rotate(w2 ^ w14 ^ w8 ^ w6, S1); ROTATE3_F(E, A, B, C, D, w5); 
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(D, E, A, B, C, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(C, D, E, A, B, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(B, C, D, E, A, w8); 
K = K3;
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE4_F(A, B, C, D, E, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE4_F(E, A, B, C, D, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE4_F(D, E, A, B, C, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE4_F(C, D, E, A, B, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE4_F(B, C, D, E, A, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE4_F(A, B, C, D, E, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE4_F(E, A, B, C, D, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE4_F(D, E, A, B, C, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE4_F(C, D, E, A, B, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE4_F(B, C, D, E, A, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE4_F(A, B, C, D, E, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE4_F(E, A, B, C, D, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1); ROTATE4_F(D, E, A, B, C, w4);  
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE4_F(C, D, E, A, B, w5);  
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7,S1); ROTATE4_F(B, C, D, E, A, w6); 
w7 = rotate(w4 ^ w16 ^ w10 ^ w8,S1); ROTATE4_F(A, B, C, D, E, w7); 
w8 = rotate(w5 ^ w0 ^ w11 ^ w9,S1); ROTATE4_F(E, A, B, C, D, w8);  
w9 = rotate(w6 ^ w1 ^ w12 ^ w10,S1); ROTATE4_F(D, E, A, B, C, w9); 
w10 = rotate(w7 ^ w2 ^ w13 ^ w11,S1); ROTATE4_F(C, D, E, A, B, w10);
w11 = rotate(w8 ^ w3 ^ w14 ^ w12,S1); ROTATE4_F(B, C, D, E, A, w11);
A=A+TTA;B=B+TTB;C=C+TTC;D=D+TTD;E=E+TTE;


// calculate hash sum 2

w0=A;
w1=B;
w2=C;
w3=D;
w4=E;
w5=(uint)0x80000000;
A=OPA;
B=OPB;
C=OPC;
D=OPD;
E=OPE;
SIZE=(uint)((64+20)<<3);
w6=w7=w8=w9=w10=w11=w12=w13=w14=(uint)0;


K = K0;
ROTATE1(A, B, C, D, E, w0);
ROTATE1(E, A, B, C, D, w1);
ROTATE1(D, E, A, B, C, w2);
ROTATE1(C, D, E, A, B, w3);
ROTATE1(B, C, D, E, A, w4);
ROTATE1(A, B, C, D, E, w5);
ROTATE1(E, A, B, C, D, w6);
ROTATE1(D, E, A, B, C, w7);
ROTATE1(C, D, E, A, B, w8);
ROTATE1(B, C, D, E, A, w9);
ROTATE1(A, B, C, D, E, w10);
ROTATE1(E, A, B, C, D, w11);
ROTATE1(D, E, A, B, C, w12);
ROTATE1(C, D, E, A, B, w13);
ROTATE1(B, C, D, E, A, w14);
ROTATE1(A, B, C, D, E, SIZE);  
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1);ROTATE1(E,A,B,C,D,w16);
w0 = rotate((w14 ^ w9 ^ w3 ^ w1),S1);ROTATE1(D,E,A,B,C,w0); 
w1 = rotate((SIZE ^ w10 ^ w4 ^ w2),S1); ROTATE1(C,D,E,A,B,w1); 
w2 = rotate((w16 ^ w11 ^ w5 ^ w3),S1);  ROTATE1(B,C,D,E,A,w2); 
K = K1;
w3 = rotate((w0 ^ w12 ^ w6 ^ w4),S1); ROTATE2_F(A, B, C, D, E, w3);
w4 = rotate((w1 ^ w13 ^ w7 ^ w5),S1); ROTATE2_F(E, A, B, C, D, w4);
w5 = rotate((w2 ^ w14 ^ w8 ^ w6),S1); ROTATE2_F(D, E, A, B, C, w5);
w6 = rotate((w3 ^ SIZE ^ w9 ^ w7),S1);ROTATE2_F(C, D, E, A, B, w6);
w7 = rotate((w4 ^ w16 ^ w10 ^ w8),S1); ROTATE2_F(B, C, D, E, A, w7);
w8 = rotate((w5 ^ w0 ^ w11 ^ w9),S1); ROTATE2_F(A, B, C, D, E, w8);
w9 = rotate((w6 ^ w1 ^ w12 ^ w10),S1); ROTATE2_F(E, A, B, C, D, w9);
w10 = rotate((w7 ^ w2 ^ w13 ^ w11),S1); ROTATE2_F(D, E, A, B, C, w10); 
w11 = rotate((w8 ^ w3 ^ w14 ^ w12),S1); ROTATE2_F(C, D, E, A, B, w11); 
w12 = rotate((w9 ^ w4 ^ SIZE ^ w13),S1); ROTATE2_F(B, C, D, E, A, w12);
w13 = rotate((w10 ^ w5 ^ w16 ^ w14),S1); ROTATE2_F(A, B, C, D, E, w13);
w14 = rotate((w11 ^ w6 ^ w0 ^ SIZE),S1); ROTATE2_F(E, A, B, C, D, w14);
SIZE = rotate((w12 ^ w7 ^ w1 ^ w16),S1); ROTATE2_F(D, E, A, B, C, SIZE);
w16 = rotate((w13 ^ w8 ^ w2 ^ w0),S1); ROTATE2_F(C, D, E, A, B, w16);  
w0 = rotate(w14 ^ w9 ^ w3 ^ w1,S1); ROTATE2_F(B, C, D, E, A, w0);  
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2,S1); ROTATE2_F(A, B, C, D, E, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE2_F(E, A, B, C, D, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE2_F(D, E, A, B, C, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1);ROTATE2_F(C, D, E, A, B, w4);
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE2_F(B, C, D, E, A, w5);  
K = K2;
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(A, B, C, D, E, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(E, A, B, C, D, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(D, E, A, B, C, w8); 
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE3_F(C, D, E, A, B, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE3_F(B, C, D, E, A, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE3_F(A, B, C, D, E, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE3_F(E, A, B, C, D, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE3_F(D, E, A, B, C, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE3_F(C, D, E, A, B, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE3_F(B, C, D, E, A, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE3_F(A, B, C, D, E, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE3_F(E, A, B, C, D, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE3_F(D, E, A, B, C, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3, S1); ROTATE3_F(C, D, E, A, B, w2);
w3 = rotate(w0 ^ w12 ^ w6 ^ w4, S1); ROTATE3_F(B, C, D, E, A, w3); 
w4 = rotate(w1 ^ w13 ^ w7 ^ w5, S1); ROTATE3_F(A, B, C, D, E, w4); 
w5 = rotate(w2 ^ w14 ^ w8 ^ w6, S1); ROTATE3_F(E, A, B, C, D, w5); 
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7, S1); ROTATE3_F(D, E, A, B, C, w6);
w7 = rotate(w4 ^ w16 ^ w10 ^ w8, S1); ROTATE3_F(C, D, E, A, B, w7);
w8 = rotate(w5 ^ w0 ^ w11 ^ w9, S1); ROTATE3_F(B, C, D, E, A, w8); 
K = K3;
w9 = rotate(w6 ^ w1 ^ w12 ^ w10, S1); ROTATE4_F(A, B, C, D, E, w9);
w10 = rotate(w7 ^ w2 ^ w13 ^ w11, S1); ROTATE4_F(E, A, B, C, D, w10);  
w11 = rotate(w8 ^ w3 ^ w14 ^ w12, S1); ROTATE4_F(D, E, A, B, C, w11);  
w12 = rotate(w9 ^ w4 ^ SIZE ^ w13, S1); ROTATE4_F(C, D, E, A, B, w12); 
w13 = rotate(w10 ^ w5 ^ w16 ^ w14, S1); ROTATE4_F(B, C, D, E, A, w13); 
w14 = rotate(w11 ^ w6 ^ w0 ^ SIZE, S1); ROTATE4_F(A, B, C, D, E, w14); 
SIZE = rotate(w12 ^ w7 ^ w1 ^ w16, S1); ROTATE4_F(E, A, B, C, D, SIZE);
w16 = rotate(w13 ^ w8 ^ w2 ^ w0, S1); ROTATE4_F(D, E, A, B, C, w16);
w0 = rotate(w14 ^ w9 ^ w3 ^ w1, S1); ROTATE4_F(C, D, E, A, B, w0); 
w1 = rotate(SIZE ^ w10 ^ w4 ^ w2, S1); ROTATE4_F(B, C, D, E, A, w1);
w2 = rotate(w16 ^ w11 ^ w5 ^ w3,S1); ROTATE4_F(A, B, C, D, E, w2); 
w3 = rotate(w0 ^ w12 ^ w6 ^ w4,S1); ROTATE4_F(E, A, B, C, D, w3);  
w4 = rotate(w1 ^ w13 ^ w7 ^ w5,S1); ROTATE4_F(D, E, A, B, C, w4);  
w5 = rotate(w2 ^ w14 ^ w8 ^ w6,S1); ROTATE4_F(C, D, E, A, B, w5);  
w6 = rotate(w3 ^ SIZE ^ w9 ^ w7,S1); ROTATE4_F(B, C, D, E, A, w6); 
w7 = rotate(w4 ^ w16 ^ w10 ^ w8,S1); ROTATE4_F(A, B, C, D, E, w7); 
w8 = rotate(w5 ^ w0 ^ w11 ^ w9,S1); ROTATE4_F(E, A, B, C, D, w8);  
w9 = rotate(w6 ^ w1 ^ w12 ^ w10,S1); ROTATE4_F(D, E, A, B, C, w9); 
w10 = rotate(w7 ^ w2 ^ w13 ^ w11,S1); ROTATE4_F(C, D, E, A, B, w10);
w11 = rotate(w8 ^ w3 ^ w14 ^ w12,S1); ROTATE4_F(B, C, D, E, A, w11);
A=A+OPA;B=B+OPB;C=C+OPC;D=D+OPD;E=E+OPE;
TTA=A;
TTB=B;
TTC=C;
TTD=D;
Endian_Reverse32(TTA);
Endian_Reverse32(TTB);
Endian_Reverse32(TTC);
Endian_Reverse32(TTD);



// HMAC-MD5 (PTK,eapol)
mCa  = (uint)Ca;
mCb  = (uint)Cb;
mCc  = (uint)Cc;
mCd  = (uint)Cd;




a = mCa; b = mCb; c = mCc; d = mCd;  
w0=TTA^(uint)0x36363636;
w1=TTB^(uint)0x36363636;
w2=TTC^(uint)0x36363636;
w3=TTD^(uint)0x36363636;

w4=w5=w6=w7=w8=w9=w10=w11=w12=w13=SIZE=w15=(uint)0x36363636;

MD5STEP_ROUND1(a, b, c, d, mAC1, w0, S11);
MD5STEP_ROUND1(d, a, b, c, mAC2, w1, S12);
MD5STEP_ROUND1(c, d, a, b, mAC3, w2, S13);
MD5STEP_ROUND1(b, c, d, a, mAC4, w3, S14);
MD5STEP_ROUND1(a, b, c, d, mAC5, w4, S11);
MD5STEP_ROUND1(d, a, b, c, mAC6, w5, S12);
MD5STEP_ROUND1(c, d, a, b, mAC7, w6, S13);
MD5STEP_ROUND1(b, c, d, a, mAC8, w7, S14);
MD5STEP_ROUND1(a, b, c, d, mAC9, w8, S11);
MD5STEP_ROUND1(d, a, b, c, mAC10, w9, S12);
MD5STEP_ROUND1(c, d, a, b, mAC11, w10,S13);  
MD5STEP_ROUND1(b, c, d, a, mAC12, w11,S14);  
MD5STEP_ROUND1(a, b, c, d, mAC13, w12,S11);  
MD5STEP_ROUND1(d, a, b, c, mAC14, w13,S12);  
MD5STEP_ROUND1(c, d, a, b, mAC15, SIZE, S13);
MD5STEP_ROUND1(b, c, d, a, mAC16, w15, S14);  

MD5STEP_ROUND2 (a, b, c, d, mAC17, w1, S21);  
MD5STEP_ROUND2 (d, a, b, c, mAC18, w6, S22); 
MD5STEP_ROUND2 (c, d, a, b, mAC19, w11, S23); 
MD5STEP_ROUND2 (b, c, d, a, mAC20, w0, S24);  
MD5STEP_ROUND2 (a, b, c, d, mAC21, w5, S21); 
MD5STEP_ROUND2 (d, a, b, c, mAC22, w10,S22); 
MD5STEP_ROUND2 (c, d,  a, b, mAC23, w15, S23); 
MD5STEP_ROUND2 (b, c, d, a, mAC24, w4, S24); 
MD5STEP_ROUND2 (a, b, c, d, mAC25, w9, S21); 
MD5STEP_ROUND2 (d, a, b, c, mAC26, SIZE, S22);
MD5STEP_ROUND2 (c, d, a, b, mAC27, w3, S23);  
MD5STEP_ROUND2 (b, c, d, a, mAC28, w8, S24); 
MD5STEP_ROUND2 (a, b, c, d, mAC29, w13, S21);  
MD5STEP_ROUND2 (d, a, b, c, mAC30, w2, S22);  
MD5STEP_ROUND2 (c, d, a, b, mAC31, w7, S23); 
MD5STEP_ROUND2 (b, c, d, a, mAC32, w12, S24);  

MD5STEP_ROUND3 (a, b, c, d, mAC33, w5, S31);
MD5STEP_ROUND3 (d, a, b, c, mAC34, w8, S32);
MD5STEP_ROUND3 (c, d, a, b, mAC35, w11, S33);
MD5STEP_ROUND3 (b, c, d, a, mAC36, SIZE, S34);  
MD5STEP_ROUND3 (a, b, c, d, mAC37, w1, S31);
MD5STEP_ROUND3 (d, a, b, c, mAC38, w4, S32);
MD5STEP_ROUND3 (c, d, a, b, mAC39, w7, S33);
MD5STEP_ROUND3 (b, c, d, a, mAC40, w10, S34);
MD5STEP_ROUND3 (a, b, c, d, mAC41, w13, S31);
MD5STEP_ROUND3 (d, a, b, c, mAC42, w0, S32);
MD5STEP_ROUND3 (c, d, a, b, mAC43, w3, S33);
MD5STEP_ROUND3 (b, c, d, a, mAC44, w6, S34);
MD5STEP_ROUND3 (a, b, c, d, mAC45, w9, S31);
MD5STEP_ROUND3 (d, a, b, c, mAC46, w12, S32);
MD5STEP_ROUND3 (c, d, a, b, mAC47, w15, S33);
MD5STEP_ROUND3 (b, c, d, a, mAC48, w2, S34);

MD5STEP_ROUND4 (a, b, c, d, mAC49, w0, S41);  
MD5STEP_ROUND4 (d, a, b, c, mAC50, w7, S42); 
MD5STEP_ROUND4 (c, d, a, b, mAC51, SIZE, S43);
MD5STEP_ROUND4 (b, c, d, a, mAC52, w5, S44); 
MD5STEP_ROUND4 (a, b, c, d, mAC53, w12, S41);  
MD5STEP_ROUND4 (d, a, b, c, mAC54, w3, S42);  
MD5STEP_ROUND4 (c, d, a, b, mAC55, w10, S43); 
MD5STEP_ROUND4 (b, c, d, a, mAC56, w1, S44);  
MD5STEP_ROUND4 (a, b, c, d, mAC57, w8, S41); 
MD5STEP_ROUND4 (d, a, b, c, mAC58, w15, S42);  
MD5STEP_ROUND4 (c, d, a, b, mAC59, w6, S43); 
MD5STEP_ROUND4 (b, c, d, a, mAC60, w13, S44);  
MD5STEP_ROUND4 (a, b, c, d, mAC61, w4, S41); 
MD5STEP_ROUND4 (d, a, b, c, mAC62, w11, S42); 
MD5STEP_ROUND4 (c, d, a, b, mAC63, w2, S43);  
MD5STEP_ROUND4 (b, c, d, a, mAC64, w9, S44); 

IPA=a+mCa;IPB=b+mCb;IPC=c+mCc;IPD=d+mCd;


a = mCa; b = mCb; c = mCc; d = mCd;  
w0=TTA^(uint)0x5c5c5c5c;
w1=TTB^(uint)0x5c5c5c5c;
w2=TTC^(uint)0x5c5c5c5c;
w3=TTD^(uint)0x5c5c5c5c;

w4=w5=w6=w7=w8=w9=w10=w11=w12=w13=SIZE=w15=(uint)0x5c5c5c5c;

MD5STEP_ROUND1(a, b, c, d, mAC1, w0, S11);
MD5STEP_ROUND1(d, a, b, c, mAC2, w1, S12);
MD5STEP_ROUND1(c, d, a, b, mAC3, w2, S13);
MD5STEP_ROUND1(b, c, d, a, mAC4, w3, S14);
MD5STEP_ROUND1(a, b, c, d, mAC5, w4, S11);
MD5STEP_ROUND1(d, a, b, c, mAC6, w5, S12);
MD5STEP_ROUND1(c, d, a, b, mAC7, w6, S13);
MD5STEP_ROUND1(b, c, d, a, mAC8, w7, S14);
MD5STEP_ROUND1(a, b, c, d, mAC9, w8, S11);
MD5STEP_ROUND1(d, a, b, c, mAC10, w9, S12);
MD5STEP_ROUND1(c, d, a, b, mAC11, w10,S13);  
MD5STEP_ROUND1(b, c, d, a, mAC12, w11,S14);  
MD5STEP_ROUND1(a, b, c, d, mAC13, w12,S11);  
MD5STEP_ROUND1(d, a, b, c, mAC14, w13,S12);  
MD5STEP_ROUND1(c, d, a, b, mAC15, SIZE, S13);
MD5STEP_ROUND1(b, c, d, a, mAC16, w15, S14);  
MD5STEP_ROUND2 (a, b, c, d, mAC17, w1, S21);  
MD5STEP_ROUND2 (d, a, b, c, mAC18, w6, S22); 
MD5STEP_ROUND2 (c, d, a, b, mAC19, w11, S23); 
MD5STEP_ROUND2 (b, c, d, a, mAC20, w0, S24);  
MD5STEP_ROUND2 (a, b, c, d, mAC21, w5, S21); 
MD5STEP_ROUND2 (d, a, b, c, mAC22, w10,S22); 
MD5STEP_ROUND2 (c, d,  a, b, mAC23, w15, S23); 
MD5STEP_ROUND2 (b, c, d, a, mAC24, w4, S24); 
MD5STEP_ROUND2 (a, b, c, d, mAC25, w9, S21); 
MD5STEP_ROUND2 (d, a, b, c, mAC26, SIZE, S22);
MD5STEP_ROUND2 (c, d, a, b, mAC27, w3, S23);  
MD5STEP_ROUND2 (b, c, d, a, mAC28, w8, S24); 
MD5STEP_ROUND2 (a, b, c, d, mAC29, w13, S21);  
MD5STEP_ROUND2 (d, a, b, c, mAC30, w2, S22);  
MD5STEP_ROUND2 (c, d, a, b, mAC31, w7, S23); 
MD5STEP_ROUND2 (b, c, d, a, mAC32, w12, S24);  
MD5STEP_ROUND3 (a, b, c, d, mAC33, w5, S31);
MD5STEP_ROUND3 (d, a, b, c, mAC34, w8, S32);
MD5STEP_ROUND3 (c, d, a, b, mAC35, w11, S33);
MD5STEP_ROUND3 (b, c, d, a, mAC36, SIZE, S34);  
MD5STEP_ROUND3 (a, b, c, d, mAC37, w1, S31);
MD5STEP_ROUND3 (d, a, b, c, mAC38, w4, S32);
MD5STEP_ROUND3 (c, d, a, b, mAC39, w7, S33);
MD5STEP_ROUND3 (b, c, d, a, mAC40, w10, S34);
MD5STEP_ROUND3 (a, b, c, d, mAC41, w13, S31);
MD5STEP_ROUND3 (d, a, b, c, mAC42, w0, S32);
MD5STEP_ROUND3 (c, d, a, b, mAC43, w3, S33);
MD5STEP_ROUND3 (b, c, d, a, mAC44, w6, S34);
MD5STEP_ROUND3 (a, b, c, d, mAC45, w9, S31);
MD5STEP_ROUND3 (d, a, b, c, mAC46, w12, S32);
MD5STEP_ROUND3 (c, d, a, b, mAC47, w15, S33);
MD5STEP_ROUND3 (b, c, d, a, mAC48, w2, S34);
MD5STEP_ROUND4 (a, b, c, d, mAC49, w0, S41);  
MD5STEP_ROUND4 (d, a, b, c, mAC50, w7, S42); 
MD5STEP_ROUND4 (c, d, a, b, mAC51, SIZE, S43);
MD5STEP_ROUND4 (b, c, d, a, mAC52, w5, S44); 
MD5STEP_ROUND4 (a, b, c, d, mAC53, w12, S41);  
MD5STEP_ROUND4 (d, a, b, c, mAC54, w3, S42);  
MD5STEP_ROUND4 (c, d, a, b, mAC55, w10, S43); 
MD5STEP_ROUND4 (b, c, d, a, mAC56, w1, S44);  
MD5STEP_ROUND4 (a, b, c, d, mAC57, w8, S41); 
MD5STEP_ROUND4 (d, a, b, c, mAC58, w15, S42);  
MD5STEP_ROUND4 (c, d, a, b, mAC59, w6, S43); 
MD5STEP_ROUND4 (b, c, d, a, mAC60, w13, S44);  
MD5STEP_ROUND4 (a, b, c, d, mAC61, w4, S41); 
MD5STEP_ROUND4 (d, a, b, c, mAC62, w11, S42); 
MD5STEP_ROUND4 (c, d, a, b, mAC63, w2, S43);  
MD5STEP_ROUND4 (b, c, d, a, mAC64, w9, S44); 

OPA=a+mCa;OPB=b+mCb;OPC=c+mCc;OPD=d+mCd;


a=IPA;
b=IPB;
c=IPC;
d=IPD;

w0=(uint)eapol[0];
w1=(uint)eapol[1];
w2=(uint)eapol[2];
w3=(uint)eapol[3];
w4=(uint)eapol[4];
w5=(uint)eapol[5];
w6=(uint)eapol[6];
w7=(uint)eapol[7];
w8=(uint)eapol[8];
w9=(uint)eapol[9];
w10=(uint)eapol[10];
w11=(uint)eapol[11];
w12=(uint)eapol[12];
w13=(uint)eapol[13];
SIZE=(uint)eapol[14];
w15=(uint)eapol[15];

MD5STEP_ROUND1(a, b, c, d, mAC1, w0, S11);
MD5STEP_ROUND1(d, a, b, c, mAC2, w1, S12);
MD5STEP_ROUND1(c, d, a, b, mAC3, w2, S13);
MD5STEP_ROUND1(b, c, d, a, mAC4, w3, S14);
MD5STEP_ROUND1(a, b, c, d, mAC5, w4, S11);
MD5STEP_ROUND1(d, a, b, c, mAC6, w5, S12);
MD5STEP_ROUND1(c, d, a, b, mAC7, w6, S13);
MD5STEP_ROUND1(b, c, d, a, mAC8, w7, S14);
MD5STEP_ROUND1(a, b, c, d, mAC9, w8, S11);
MD5STEP_ROUND1(d, a, b, c, mAC10, w9, S12);
MD5STEP_ROUND1(c, d, a, b, mAC11, w10,S13);  
MD5STEP_ROUND1(b, c, d, a, mAC12, w11,S14);  
MD5STEP_ROUND1(a, b, c, d, mAC13, w12,S11);  
MD5STEP_ROUND1(d, a, b, c, mAC14, w13,S12);  
MD5STEP_ROUND1(c, d, a, b, mAC15, SIZE, S13);
MD5STEP_ROUND1(b, c, d, a, mAC16, w15, S14);  
MD5STEP_ROUND2 (a, b, c, d, mAC17, w1, S21);  
MD5STEP_ROUND2 (d, a, b, c, mAC18, w6, S22); 
MD5STEP_ROUND2 (c, d, a, b, mAC19, w11, S23); 
MD5STEP_ROUND2 (b, c, d, a, mAC20, w0, S24);  
MD5STEP_ROUND2 (a, b, c, d, mAC21, w5, S21); 
MD5STEP_ROUND2 (d, a, b, c, mAC22, w10,S22); 
MD5STEP_ROUND2 (c, d,  a, b, mAC23, w15, S23); 
MD5STEP_ROUND2 (b, c, d, a, mAC24, w4, S24); 
MD5STEP_ROUND2 (a, b, c, d, mAC25, w9, S21); 
MD5STEP_ROUND2 (d, a, b, c, mAC26, SIZE, S22);
MD5STEP_ROUND2 (c, d, a, b, mAC27, w3, S23);  
MD5STEP_ROUND2 (b, c, d, a, mAC28, w8, S24); 
MD5STEP_ROUND2 (a, b, c, d, mAC29, w13, S21);  
MD5STEP_ROUND2 (d, a, b, c, mAC30, w2, S22);  
MD5STEP_ROUND2 (c, d, a, b, mAC31, w7, S23); 
MD5STEP_ROUND2 (b, c, d, a, mAC32, w12, S24);  
MD5STEP_ROUND3 (a, b, c, d, mAC33, w5, S31);
MD5STEP_ROUND3 (d, a, b, c, mAC34, w8, S32);
MD5STEP_ROUND3 (c, d, a, b, mAC35, w11, S33);
MD5STEP_ROUND3 (b, c, d, a, mAC36, SIZE, S34);  
MD5STEP_ROUND3 (a, b, c, d, mAC37, w1, S31);
MD5STEP_ROUND3 (d, a, b, c, mAC38, w4, S32);
MD5STEP_ROUND3 (c, d, a, b, mAC39, w7, S33);
MD5STEP_ROUND3 (b, c, d, a, mAC40, w10, S34);
MD5STEP_ROUND3 (a, b, c, d, mAC41, w13, S31);
MD5STEP_ROUND3 (d, a, b, c, mAC42, w0, S32);
MD5STEP_ROUND3 (c, d, a, b, mAC43, w3, S33);
MD5STEP_ROUND3 (b, c, d, a, mAC44, w6, S34);
MD5STEP_ROUND3 (a, b, c, d, mAC45, w9, S31);
MD5STEP_ROUND3 (d, a, b, c, mAC46, w12, S32);
MD5STEP_ROUND3 (c, d, a, b, mAC47, w15, S33);
MD5STEP_ROUND3 (b, c, d, a, mAC48, w2, S34);
MD5STEP_ROUND4 (a, b, c, d, mAC49, w0, S41);  
MD5STEP_ROUND4 (d, a, b, c, mAC50, w7, S42); 
MD5STEP_ROUND4 (c, d, a, b, mAC51, SIZE, S43);
MD5STEP_ROUND4 (b, c, d, a, mAC52, w5, S44); 
MD5STEP_ROUND4 (a, b, c, d, mAC53, w12, S41);  
MD5STEP_ROUND4 (d, a, b, c, mAC54, w3, S42);  
MD5STEP_ROUND4 (c, d, a, b, mAC55, w10, S43); 
MD5STEP_ROUND4 (b, c, d, a, mAC56, w1, S44);  
MD5STEP_ROUND4 (a, b, c, d, mAC57, w8, S41); 
MD5STEP_ROUND4 (d, a, b, c, mAC58, w15, S42);  
MD5STEP_ROUND4 (c, d, a, b, mAC59, w6, S43); 
MD5STEP_ROUND4 (b, c, d, a, mAC60, w13, S44);  
MD5STEP_ROUND4 (a, b, c, d, mAC61, w4, S41); 
MD5STEP_ROUND4 (d, a, b, c, mAC62, w11, S42); 
MD5STEP_ROUND4 (c, d, a, b, mAC63, w2, S43);  
MD5STEP_ROUND4 (b, c, d, a, mAC64, w9, S44); 


a=a+IPA;b=b+IPB;c=c+IPC;d=d+IPD;
TTA=a;TTB=b;TTC=c;TTD=d;

w0=(uint)eapol[16];
w1=(uint)eapol[17];
w2=(uint)eapol[18];
w3=(uint)eapol[19];
w4=(uint)eapol[20];
w5=(uint)eapol[21];
w6=(uint)eapol[22];
w7=(uint)eapol[23];
w8=(uint)eapol[24];
w9=(uint)eapol[25];
w10=(uint)eapol[26];
w11=(uint)eapol[27];
w12=(uint)eapol[28];
w13=(uint)eapol[29];
SIZE=(uint)eapol[30];
w15=(uint)eapol[31];

MD5STEP_ROUND1(a, b, c, d, mAC1, w0, S11);
MD5STEP_ROUND1(d, a, b, c, mAC2, w1, S12);
MD5STEP_ROUND1(c, d, a, b, mAC3, w2, S13);
MD5STEP_ROUND1(b, c, d, a, mAC4, w3, S14);
MD5STEP_ROUND1(a, b, c, d, mAC5, w4, S11);
MD5STEP_ROUND1(d, a, b, c, mAC6, w5, S12);
MD5STEP_ROUND1(c, d, a, b, mAC7, w6, S13);
MD5STEP_ROUND1(b, c, d, a, mAC8, w7, S14);
MD5STEP_ROUND1(a, b, c, d, mAC9, w8, S11);
MD5STEP_ROUND1(d, a, b, c, mAC10, w9, S12);
MD5STEP_ROUND1(c, d, a, b, mAC11, w10,S13);  
MD5STEP_ROUND1(b, c, d, a, mAC12, w11,S14);  
MD5STEP_ROUND1(a, b, c, d, mAC13, w12,S11);  
MD5STEP_ROUND1(d, a, b, c, mAC14, w13,S12);  
MD5STEP_ROUND1(c, d, a, b, mAC15, SIZE, S13);
MD5STEP_ROUND1(b, c, d, a, mAC16, w15, S14);  
MD5STEP_ROUND2 (a, b, c, d, mAC17, w1, S21);  
MD5STEP_ROUND2 (d, a, b, c, mAC18, w6, S22); 
MD5STEP_ROUND2 (c, d, a, b, mAC19, w11, S23); 
MD5STEP_ROUND2 (b, c, d, a, mAC20, w0, S24);  
MD5STEP_ROUND2 (a, b, c, d, mAC21, w5, S21); 
MD5STEP_ROUND2 (d, a, b, c, mAC22, w10,S22); 
MD5STEP_ROUND2 (c, d,  a, b, mAC23, w15, S23); 
MD5STEP_ROUND2 (b, c, d, a, mAC24, w4, S24); 
MD5STEP_ROUND2 (a, b, c, d, mAC25, w9, S21); 
MD5STEP_ROUND2 (d, a, b, c, mAC26, SIZE, S22);
MD5STEP_ROUND2 (c, d, a, b, mAC27, w3, S23);  
MD5STEP_ROUND2 (b, c, d, a, mAC28, w8, S24); 
MD5STEP_ROUND2 (a, b, c, d, mAC29, w13, S21);  
MD5STEP_ROUND2 (d, a, b, c, mAC30, w2, S22);  
MD5STEP_ROUND2 (c, d, a, b, mAC31, w7, S23); 
MD5STEP_ROUND2 (b, c, d, a, mAC32, w12, S24);  
MD5STEP_ROUND3 (a, b, c, d, mAC33, w5, S31);
MD5STEP_ROUND3 (d, a, b, c, mAC34, w8, S32);
MD5STEP_ROUND3 (c, d, a, b, mAC35, w11, S33);
MD5STEP_ROUND3 (b, c, d, a, mAC36, SIZE, S34);  
MD5STEP_ROUND3 (a, b, c, d, mAC37, w1, S31);
MD5STEP_ROUND3 (d, a, b, c, mAC38, w4, S32);
MD5STEP_ROUND3 (c, d, a, b, mAC39, w7, S33);
MD5STEP_ROUND3 (b, c, d, a, mAC40, w10, S34);
MD5STEP_ROUND3 (a, b, c, d, mAC41, w13, S31);
MD5STEP_ROUND3 (d, a, b, c, mAC42, w0, S32);
MD5STEP_ROUND3 (c, d, a, b, mAC43, w3, S33);
MD5STEP_ROUND3 (b, c, d, a, mAC44, w6, S34);
MD5STEP_ROUND3 (a, b, c, d, mAC45, w9, S31);
MD5STEP_ROUND3 (d, a, b, c, mAC46, w12, S32);
MD5STEP_ROUND3 (c, d, a, b, mAC47, w15, S33);
MD5STEP_ROUND3 (b, c, d, a, mAC48, w2, S34);
MD5STEP_ROUND4 (a, b, c, d, mAC49, w0, S41);  
MD5STEP_ROUND4 (d, a, b, c, mAC50, w7, S42); 
MD5STEP_ROUND4 (c, d, a, b, mAC51, SIZE, S43);
MD5STEP_ROUND4 (b, c, d, a, mAC52, w5, S44); 
MD5STEP_ROUND4 (a, b, c, d, mAC53, w12, S41);  
MD5STEP_ROUND4 (d, a, b, c, mAC54, w3, S42);  
MD5STEP_ROUND4 (c, d, a, b, mAC55, w10, S43); 
MD5STEP_ROUND4 (b, c, d, a, mAC56, w1, S44);  
MD5STEP_ROUND4 (a, b, c, d, mAC57, w8, S41); 
MD5STEP_ROUND4 (d, a, b, c, mAC58, w15, S42);  
MD5STEP_ROUND4 (c, d, a, b, mAC59, w6, S43); 
MD5STEP_ROUND4 (b, c, d, a, mAC60, w13, S44);  
MD5STEP_ROUND4 (a, b, c, d, mAC61, w4, S41); 
MD5STEP_ROUND4 (d, a, b, c, mAC62, w11, S42); 
MD5STEP_ROUND4 (c, d, a, b, mAC63, w2, S43);  
MD5STEP_ROUND4 (b, c, d, a, mAC64, w9, S44); 

a=a+TTA;b=b+TTB;c=c+TTC;d=d+TTD;
TTA=a;TTB=b;TTC=c;TTD=d;


w0=(uint)eapol[32];
w1=(uint)eapol[33];
w2=(uint)eapol[34];
w3=(uint)eapol[35];
w4=(uint)eapol[36];
w5=(uint)eapol[37];
w6=(uint)eapol[38];
w7=(uint)eapol[39];
w8=(uint)eapol[40];
w9=(uint)eapol[41];
w10=(uint)eapol[42];
w11=(uint)eapol[43];
w12=(uint)eapol[44];
w13=(uint)eapol[45];
SIZE=(uint)salt.sE;
w15=(uint)eapol[47];

MD5STEP_ROUND1(a, b, c, d, mAC1, w0, S11);
MD5STEP_ROUND1(d, a, b, c, mAC2, w1, S12);
MD5STEP_ROUND1(c, d, a, b, mAC3, w2, S13);
MD5STEP_ROUND1(b, c, d, a, mAC4, w3, S14);
MD5STEP_ROUND1(a, b, c, d, mAC5, w4, S11);
MD5STEP_ROUND1(d, a, b, c, mAC6, w5, S12);
MD5STEP_ROUND1(c, d, a, b, mAC7, w6, S13);
MD5STEP_ROUND1(b, c, d, a, mAC8, w7, S14);
MD5STEP_ROUND1(a, b, c, d, mAC9, w8, S11);
MD5STEP_ROUND1(d, a, b, c, mAC10, w9, S12);
MD5STEP_ROUND1(c, d, a, b, mAC11, w10,S13);  
MD5STEP_ROUND1(b, c, d, a, mAC12, w11,S14);  
MD5STEP_ROUND1(a, b, c, d, mAC13, w12,S11);  
MD5STEP_ROUND1(d, a, b, c, mAC14, w13,S12);  
MD5STEP_ROUND1(c, d, a, b, mAC15, SIZE, S13);
MD5STEP_ROUND1(b, c, d, a, mAC16, w15, S14);  
MD5STEP_ROUND2 (a, b, c, d, mAC17, w1, S21);  
MD5STEP_ROUND2 (d, a, b, c, mAC18, w6, S22); 
MD5STEP_ROUND2 (c, d, a, b, mAC19, w11, S23); 
MD5STEP_ROUND2 (b, c, d, a, mAC20, w0, S24);  
MD5STEP_ROUND2 (a, b, c, d, mAC21, w5, S21); 
MD5STEP_ROUND2 (d, a, b, c, mAC22, w10,S22); 
MD5STEP_ROUND2 (c, d,  a, b, mAC23, w15, S23); 
MD5STEP_ROUND2 (b, c, d, a, mAC24, w4, S24); 
MD5STEP_ROUND2 (a, b, c, d, mAC25, w9, S21); 
MD5STEP_ROUND2 (d, a, b, c, mAC26, SIZE, S22);
MD5STEP_ROUND2 (c, d, a, b, mAC27, w3, S23);  
MD5STEP_ROUND2 (b, c, d, a, mAC28, w8, S24); 
MD5STEP_ROUND2 (a, b, c, d, mAC29, w13, S21);  
MD5STEP_ROUND2 (d, a, b, c, mAC30, w2, S22);  
MD5STEP_ROUND2 (c, d, a, b, mAC31, w7, S23); 
MD5STEP_ROUND2 (b, c, d, a, mAC32, w12, S24);  
MD5STEP_ROUND3 (a, b, c, d, mAC33, w5, S31);
MD5STEP_ROUND3 (d, a, b, c, mAC34, w8, S32);
MD5STEP_ROUND3 (c, d, a, b, mAC35, w11, S33);
MD5STEP_ROUND3 (b, c, d, a, mAC36, SIZE, S34);  
MD5STEP_ROUND3 (a, b, c, d, mAC37, w1, S31);
MD5STEP_ROUND3 (d, a, b, c, mAC38, w4, S32);
MD5STEP_ROUND3 (c, d, a, b, mAC39, w7, S33);
MD5STEP_ROUND3 (b, c, d, a, mAC40, w10, S34);
MD5STEP_ROUND3 (a, b, c, d, mAC41, w13, S31);
MD5STEP_ROUND3 (d, a, b, c, mAC42, w0, S32);
MD5STEP_ROUND3 (c, d, a, b, mAC43, w3, S33);
MD5STEP_ROUND3 (b, c, d, a, mAC44, w6, S34);
MD5STEP_ROUND3 (a, b, c, d, mAC45, w9, S31);
MD5STEP_ROUND3 (d, a, b, c, mAC46, w12, S32);
MD5STEP_ROUND3 (c, d, a, b, mAC47, w15, S33);
MD5STEP_ROUND3 (b, c, d, a, mAC48, w2, S34);
MD5STEP_ROUND4 (a, b, c, d, mAC49, w0, S41);  
MD5STEP_ROUND4 (d, a, b, c, mAC50, w7, S42); 
MD5STEP_ROUND4 (c, d, a, b, mAC51, SIZE, S43);
MD5STEP_ROUND4 (b, c, d, a, mAC52, w5, S44); 
MD5STEP_ROUND4 (a, b, c, d, mAC53, w12, S41);  
MD5STEP_ROUND4 (d, a, b, c, mAC54, w3, S42);  
MD5STEP_ROUND4 (c, d, a, b, mAC55, w10, S43); 
MD5STEP_ROUND4 (b, c, d, a, mAC56, w1, S44);  
MD5STEP_ROUND4 (a, b, c, d, mAC57, w8, S41); 
MD5STEP_ROUND4 (d, a, b, c, mAC58, w15, S42);  
MD5STEP_ROUND4 (c, d, a, b, mAC59, w6, S43); 
MD5STEP_ROUND4 (b, c, d, a, mAC60, w13, S44);  
MD5STEP_ROUND4 (a, b, c, d, mAC61, w4, S41); 
MD5STEP_ROUND4 (d, a, b, c, mAC62, w11, S42); 
MD5STEP_ROUND4 (c, d, a, b, mAC63, w2, S43);  
MD5STEP_ROUND4 (b, c, d, a, mAC64, w9, S44); 

a=a+TTA;b=b+TTB;c=c+TTC;d=d+TTD;
TTA=a;TTB=b;TTC=c;TTD=d;




a=OPA;b=OPB;c=OPC;d=OPD;
w0=TTA;
w1=TTB;
w2=TTC;
w3=TTD;
w4=(uint)0x80;
SIZE=(uint)((64+16)<<3);
w5=w6=w7=w8=w9=w10=w11=w12=w13=w15=(uint)0;

MD5STEP_ROUND1(a, b, c, d, mAC1, w0, S11);
MD5STEP_ROUND1(d, a, b, c, mAC2, w1, S12);
MD5STEP_ROUND1(c, d, a, b, mAC3, w2, S13);
MD5STEP_ROUND1(b, c, d, a, mAC4, w3, S14);
MD5STEP_ROUND1(a, b, c, d, mAC5, w4, S11);
MD5STEP_ROUND1(d, a, b, c, mAC6, w5, S12);
MD5STEP_ROUND1(c, d, a, b, mAC7, w6, S13);
MD5STEP_ROUND1(b, c, d, a, mAC8, w7, S14);
MD5STEP_ROUND1(a, b, c, d, mAC9, w8, S11);
MD5STEP_ROUND1(d, a, b, c, mAC10, w9, S12);
MD5STEP_ROUND1(c, d, a, b, mAC11, w10,S13);  
MD5STEP_ROUND1(b, c, d, a, mAC12, w11,S14);  
MD5STEP_ROUND1(a, b, c, d, mAC13, w12,S11);  
MD5STEP_ROUND1(d, a, b, c, mAC14, w13,S12);  
MD5STEP_ROUND1(c, d, a, b, mAC15, SIZE, S13);
MD5STEP_ROUND1(b, c, d, a, mAC16, w15, S14);  
MD5STEP_ROUND2 (a, b, c, d, mAC17, w1, S21);  
MD5STEP_ROUND2 (d, a, b, c, mAC18, w6, S22); 
MD5STEP_ROUND2 (c, d, a, b, mAC19, w11, S23); 
MD5STEP_ROUND2 (b, c, d, a, mAC20, w0, S24);  
MD5STEP_ROUND2 (a, b, c, d, mAC21, w5, S21); 
MD5STEP_ROUND2 (d, a, b, c, mAC22, w10,S22); 
MD5STEP_ROUND2 (c, d,  a, b, mAC23, w15, S23); 
MD5STEP_ROUND2 (b, c, d, a, mAC24, w4, S24); 
MD5STEP_ROUND2 (a, b, c, d, mAC25, w9, S21); 
MD5STEP_ROUND2 (d, a, b, c, mAC26, SIZE, S22);
MD5STEP_ROUND2 (c, d, a, b, mAC27, w3, S23);  
MD5STEP_ROUND2 (b, c, d, a, mAC28, w8, S24); 
MD5STEP_ROUND2 (a, b, c, d, mAC29, w13, S21);  
MD5STEP_ROUND2 (d, a, b, c, mAC30, w2, S22);  
MD5STEP_ROUND2 (c, d, a, b, mAC31, w7, S23); 
MD5STEP_ROUND2 (b, c, d, a, mAC32, w12, S24);  
MD5STEP_ROUND3 (a, b, c, d, mAC33, w5, S31);
MD5STEP_ROUND3 (d, a, b, c, mAC34, w8, S32);
MD5STEP_ROUND3 (c, d, a, b, mAC35, w11, S33);
MD5STEP_ROUND3 (b, c, d, a, mAC36, SIZE, S34);  
MD5STEP_ROUND3 (a, b, c, d, mAC37, w1, S31);
MD5STEP_ROUND3 (d, a, b, c, mAC38, w4, S32);
MD5STEP_ROUND3 (c, d, a, b, mAC39, w7, S33);
MD5STEP_ROUND3 (b, c, d, a, mAC40, w10, S34);
MD5STEP_ROUND3 (a, b, c, d, mAC41, w13, S31);
MD5STEP_ROUND3 (d, a, b, c, mAC42, w0, S32);
MD5STEP_ROUND3 (c, d, a, b, mAC43, w3, S33);
MD5STEP_ROUND3 (b, c, d, a, mAC44, w6, S34);
MD5STEP_ROUND3 (a, b, c, d, mAC45, w9, S31);
MD5STEP_ROUND3 (d, a, b, c, mAC46, w12, S32);
MD5STEP_ROUND3 (c, d, a, b, mAC47, w15, S33);
MD5STEP_ROUND3 (b, c, d, a, mAC48, w2, S34);
MD5STEP_ROUND4 (a, b, c, d, mAC49, w0, S41);  
MD5STEP_ROUND4 (d, a, b, c, mAC50, w7, S42); 
MD5STEP_ROUND4 (c, d, a, b, mAC51, SIZE, S43);
MD5STEP_ROUND4 (b, c, d, a, mAC52, w5, S44); 
MD5STEP_ROUND4 (a, b, c, d, mAC53, w12, S41);  
MD5STEP_ROUND4 (d, a, b, c, mAC54, w3, S42);  
MD5STEP_ROUND4 (c, d, a, b, mAC55, w10, S43); 
MD5STEP_ROUND4 (b, c, d, a, mAC56, w1, S44);  
MD5STEP_ROUND4 (a, b, c, d, mAC57, w8, S41); 
MD5STEP_ROUND4 (d, a, b, c, mAC58, w15, S42);  
MD5STEP_ROUND4 (c, d, a, b, mAC59, w6, S43); 
MD5STEP_ROUND4 (b, c, d, a, mAC60, w13, S44);  
MD5STEP_ROUND4 (a, b, c, d, mAC61, w4, S41); 
MD5STEP_ROUND4 (d, a, b, c, mAC62, w11, S42); 
MD5STEP_ROUND4 (c, d, a, b, mAC63, w2, S43);  
MD5STEP_ROUND4 (b, c, d, a, mAC64, w9, S44); 

a=a+OPA;b=b+OPB;c=c+OPC;d=d+OPD;



if (((uint)(singlehash.x)!=(a))) return;
if (((uint)(singlehash.y)!=(b))) return;

dst[(get_global_id(0))] = (uint4) (a,b,c,d);

found[0] = 1;
found_ind[get_global_id(0)] = 1;
}


#endif




