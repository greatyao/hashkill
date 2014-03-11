__constant uint c_crctable[256] = 
    {0x00000000,0x77073096,0xee0e612c,0x990951ba,0x076dc419,
     0x706af48f,0xe963a535,0x9e6495a3,0x0edb8832,0x79dcb8a4,
     0xe0d5e91e,0x97d2d988,0x09b64c2b,0x7eb17cbd,0xe7b82d07,
     0x90bf1d91,0x1db71064,0x6ab020f2,0xf3b97148,0x84be41de,
     0x1adad47d,0x6ddde4eb,0xf4d4b551,0x83d385c7,0x136c9856,
     0x646ba8c0,0xfd62f97a,0x8a65c9ec,0x14015c4f,0x63066cd9,
     0xfa0f3d63,0x8d080df5,0x3b6e20c8,0x4c69105e,0xd56041e4,
     0xa2677172,0x3c03e4d1,0x4b04d447,0xd20d85fd,0xa50ab56b,
     0x35b5a8fa,0x42b2986c,0xdbbbc9d6,0xacbcf940,0x32d86ce3,
     0x45df5c75,0xdcd60dcf,0xabd13d59,0x26d930ac,0x51de003a,
     0xc8d75180,0xbfd06116,0x21b4f4b5,0x56b3c423,0xcfba9599,
     0xb8bda50f,0x2802b89e,0x5f058808,0xc60cd9b2,0xb10be924,
     0x2f6f7c87,0x58684c11,0xc1611dab,0xb6662d3d,0x76dc4190,
     0x01db7106,0x98d220bc,0xefd5102a,0x71b18589,0x06b6b51f,
     0x9fbfe4a5,0xe8b8d433,0x7807c9a2,0x0f00f934,0x9609a88e,
     0xe10e9818,0x7f6a0dbb,0x086d3d2d,0x91646c97,0xe6635c01,
     0x6b6b51f4,0x1c6c6162,0x856530d8,0xf262004e,0x6c0695ed,
     0x1b01a57b,0x8208f4c1,0xf50fc457,0x65b0d9c6,0x12b7e950,
     0x8bbeb8ea,0xfcb9887c,0x62dd1ddf,0x15da2d49,0x8cd37cf3,
     0xfbd44c65,0x4db26158,0x3ab551ce,0xa3bc0074,0xd4bb30e2,
     0x4adfa541,0x3dd895d7,0xa4d1c46d,0xd3d6f4fb,0x4369e96a,
     0x346ed9fc,0xad678846,0xda60b8d0,0x44042d73,0x33031de5,
     0xaa0a4c5f,0xdd0d7cc9,0x5005713c,0x270241aa,0xbe0b1010,
     0xc90c2086,0x5768b525,0x206f85b3,0xb966d409,0xce61e49f,
     0x5edef90e,0x29d9c998,0xb0d09822,0xc7d7a8b4,0x59b33d17,
     0x2eb40d81,0xb7bd5c3b,0xc0ba6cad,0xedb88320,0x9abfb3b6,
     0x03b6e20c,0x74b1d29a,0xead54739,0x9dd277af,0x04db2615,
     0x73dc1683,0xe3630b12,0x94643b84,0x0d6d6a3e,0x7a6a5aa8,
     0xe40ecf0b,0x9309ff9d,0x0a00ae27,0x7d079eb1,0xf00f9344,
     0x8708a3d2,0x1e01f268,0x6906c2fe,0xf762575d,0x806567cb,
     0x196c3671,0x6e6b06e7,0xfed41b76,0x89d32be0,0x10da7a5a,
     0x67dd4acc,0xf9b9df6f,0x8ebeeff9,0x17b7be43,0x60b08ed5,
     0xd6d6a3e8,0xa1d1937e,0x38d8c2c4,0x4fdff252,0xd1bb67f1,
     0xa6bc5767,0x3fb506dd,0x48b2364b,0xd80d2bda,0xaf0a1b4c,
     0x36034af6,0x41047a60,0xdf60efc3,0xa867df55,0x316e8eef,
     0x4669be79,0xcb61b38c,0xbc66831a,0x256fd2a0,0x5268e236,
     0xcc0c7795,0xbb0b4703,0x220216b9,0x5505262f,0xc5ba3bbe,
     0xb2bd0b28,0x2bb45a92,0x5cb36a04,0xc2d7ffa7,0xb5d0cf31,
     0x2cd99e8b,0x5bdeae1d,0x9b64c2b0,0xec63f226,0x756aa39c,
     0x026d930a,0x9c0906a9,0xeb0e363f,0x72076785,0x05005713,
     0x95bf4a82,0xe2b87a14,0x7bb12bae,0x0cb61b38,0x92d28e9b,
     0xe5d5be0d,0x7cdcefb7,0x0bdbdf21,0x86d3d2d4,0xf1d4e242,
     0x68ddb3f8,0x1fda836e,0x81be16cd,0xf6b9265b,0x6fb077e1,
     0x18b74777,0x88085ae6,0xff0f6a70,0x66063bca,0x11010b5c,
     0x8f659eff,0xf862ae69,0x616bffd3,0x166ccf45,0xa00ae278,
     0xd70dd2ee,0x4e048354,0x3903b3c2,0xa7672661,0xd06016f7,
     0x4969474d,0x3e6e77db,0xaed16a4a,0xd9d65adc,0x40df0b66,
     0x37d83bf0,0xa9bcae53,0xdebb9ec5,0x47b2cf7f,0x30b5ffe9,
     0xbdbdf21c,0xcabac28a,0x53b39330,0x24b4a3a6,0xbad03605,
     0xcdd70693,0x54de5729,0x23d967bf,0xb3667a2e,0xc4614ab8,
     0x5d681b02,0x2a6f2b94,0xb40bbe37,0xc30c8ea1,0x5a05df1b,0x2d02ef8d};


#ifdef GCN
#pragma OPENCL EXTENSION cl_amd_media_ops : enable
#define getglobalid(a) (mad24(get_group_id(0), 64U, get_local_id(0)))

#define kCrcPoly 0xEDB88320


#define CRC_UPDATE_BYTE(crc, b) ((uint) ( ((crctable[((crc) ^ (b)) & 0xFF] ^ ((crc) >> 8))) ))

#define GETBYTE(arr,bt)  ((((arr[bt>>2]) >> ((bt&3)<<3) )&255))


void zip_long1( __global uint4 *hashes, const uint4 input, const uint size,  __global uint4 *plains, __global uint *found,  uint4 singlehash,uint x0,uint16 salt,__local uint crctable[256]) 
{

uint ic,i,ia,ib;
uint key0 = 305419896;
uint key1 = 591751049;
uint key2 = 878082192;
uint k0,k1,k2,c;
uint kk0,kk1,kk2;
uint temp,temp1,temp2;
uint SIZE;
uint password[8];
uint bt,t;
uint verifier;

password[0] = x0;
password[1] = (uint)input.y;
password[2] = (uint)input.z;
password[3] = (uint)input.w;



SIZE=salt.sF;


for (ic=0; ic<SIZE; ic++)
{
bt = GETBYTE(password,ic);
key0=CRC_UPDATE_BYTE(key0, bt);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);
}
k0=key0;k1=key1;k2=key2;



// Unroll the 12 iterations, iteration 1
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = salt.s0&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 2
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s0>>8)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 3
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s0>>16)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 4
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s0>>24)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 5
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s1>>0)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 6
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s1>>8)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 7
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s1>>16)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 8
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s1>>24)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 9
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s2>>0)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 10
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s2>>8)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 11
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s2>>16)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);


// Unroll the 12 iterations, iteration 12
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s2>>24)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

if ((c!=(uint)salt.s9)) return;
verifier=(c&255)^(uint)salt.s9;

kk0=key0;
kk1=key1;
kk2=key2;


if (salt.sE>1)
{

key0=k0;key1=k1;key2=k2;
// Unroll the 12 iterations, iteration 1
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = salt.s3&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 2
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s3>>8)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 3
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s3>>16)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 4
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s3>>24)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 5
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s4>>0)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 6
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s4>>8)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 7
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s4>>16)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 8
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s4>>24)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 9
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s5>>0)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 10
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s5>>8)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 11
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s5>>16)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);


// Unroll the 12 iterations, iteration 12
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s5>>24)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

if ((c!=(uint)salt.sA)) return;
verifier+=c^(uint)salt.sA;
}



if (salt.sE>2)
{
key0=k0;key1=k1;key2=k2;
// Unroll the 12 iterations, iteration 1
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = salt.s6&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 2
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s6>>8)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 3
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s6>>16)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 4
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s6>>24)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 5
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s7>>0)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 6
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s7>>8)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 7
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s7>>16)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 8
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s7>>24)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 9
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s8>>0)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 10
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s8>>8)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 11
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s8>>16)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);


// Unroll the 12 iterations, iteration 12
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s8>>24)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

if ((c!=(uint)salt.sB)) return;
verifier+=c^(uint)salt.sB;
}



if (salt.sE>3)
{
key0=k0;key1=k1;key2=k2;
// Unroll the 12 iterations, iteration 1
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = singlehash.x&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 2
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (singlehash.x>>8)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 3
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (singlehash.x>>16)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 4
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (singlehash.x>>24)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 5
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (singlehash.y>>0)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 6
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (singlehash.y>>8)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 7
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (singlehash.y>>16)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 8
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (singlehash.y>>24)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 9
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (singlehash.z>>0)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 10
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (singlehash.z>>8)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 11
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (singlehash.z>>16)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);


// Unroll the 12 iterations, iteration 12
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (singlehash.z>>24)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

if ((c!=(uint)singlehash.w)) return;
verifier+=c^(uint)singlehash.w;
}

verifier+=(uint)1;


uint res = atomic_inc(found);
hashes[res] = (uint4)(kk0,kk1,kk2,verifier);

uint xx1,xx2,xx3;
xx1=(uint)input.y;
xx2=(uint)input.z;
xx3=(uint)input.w;
plains[res] = (uint4)(x0,xx1,xx2,xx3);
}



__kernel void  __attribute__((reqd_work_group_size(64, 1, 1))) 
zip_long_double( __global uint4 *hashes,  const uint size,  __global uint4 *plains, __global uint *found, __global const  uint *table,const uint16 chbase1,  const uint16 chbase2,uint16 chbase3,uint16 chbase4,uint16 chbase5) 
{
uint i;
uint j;
uint k;
uint c0,x0;
uint d0,d1,d2;
uint t1,t2,t3;
uint x1,SIZE;
uint c1,c2,x2;
uint t4;
uint4 input;
uint4 singlehash; 
__local uint crctable[256];

crctable[get_local_id(0)]=c_crctable[get_local_id(0)];
crctable[get_local_id(0)+64]=c_crctable[get_local_id(0)+64];
crctable[get_local_id(0)+128]=c_crctable[get_local_id(0)+128];
crctable[get_local_id(0)+192]=c_crctable[get_local_id(0)+192];

barrier(CLK_LOCAL_MEM_FENCE);


SIZE = (uint)(size); 
i=table[get_global_id(1)];
j=table[get_global_id(0)]<<16;

k=(i|j);


input=(uint4)(chbase1.s0,chbase1.s1,chbase1.s2,chbase1.s3);
singlehash=(uint4)(chbase2.s0,chbase2.s1,chbase2.s2,chbase2.s3);
zip_long1(hashes,input, size, plains, found, singlehash,k,chbase5,crctable);

input=(uint4)(chbase1.s4,chbase1.s5,chbase1.s6,chbase1.s7);
singlehash=(uint4)(chbase2.s4,chbase2.s5,chbase2.s6,chbase2.s7);
zip_long1(hashes,input, size, plains, found, singlehash,k,chbase5,crctable);

input=(uint4)(chbase1.s8,chbase1.s9,chbase1.sA,chbase1.sB);
singlehash=(uint4)(chbase2.s8,chbase2.s9,chbase2.sA,chbase2.sB);
zip_long1(hashes,input, size, plains, found, singlehash,k,chbase5,crctable);

input=(uint4)(chbase1.sC,chbase1.sD,chbase1.sE,chbase1.sF);
singlehash=(uint4)(chbase2.sC,chbase2.sD,chbase2.sE,chbase2.sF);
zip_long1(hashes,input, size, plains, found, singlehash,k,chbase5,crctable);

input=(uint4)(chbase3.s0,chbase3.s1,chbase3.s2,chbase3.s3);
singlehash=(uint4)(chbase4.s0,chbase4.s1,chbase4.s2,chbase4.s3);
zip_long1(hashes,input, size, plains, found, singlehash,k,chbase5,crctable);


input=(uint4)(chbase3.s4,chbase3.s5,chbase3.s6,chbase3.s7);
singlehash=(uint4)(chbase4.s4,chbase4.s5,chbase4.s6,chbase4.s7);
zip_long1(hashes,input, size, plains, found, singlehash,k,chbase5,crctable);

input=(uint4)(chbase3.s8,chbase3.s9,chbase3.sA,chbase3.sB);
singlehash=(uint4)(chbase4.s8,chbase4.s9,chbase4.sA,chbase4.sB);
zip_long1(hashes,input, size, plains, found, singlehash,k,chbase5,crctable);

input=(uint4)(chbase3.sC,chbase3.sD,chbase3.sE,chbase3.sF);
singlehash=(uint4)(chbase4.sC,chbase4.sD,chbase4.sE,chbase4.sF);
zip_long1(hashes,input, size, plains, found, singlehash,k,chbase5,crctable);



}




__kernel void  __attribute__((reqd_work_group_size(64, 1, 1))) 
zip_long_normal( __global uint4 *hashes,  const uint size,  __global uint4 *plains, __global uint *found, __global const  uint * table,const uint16 chbase1,  const uint16 chbase2,uint16 chbase3,uint16 chbase4,uint16 chbase5) 
{
uint i,k;
uint j;
uint c0,x0;
uint d0,d1,d2;
uint t1,t2,t3;
uint x1,SIZE;
uint c1,c2,x2;
uint t4;
uint4 input;
uint4 singlehash; 
__local uint crctable[256];

crctable[get_local_id(0)]=c_crctable[get_local_id(0)];
crctable[get_local_id(0)+64]=c_crctable[get_local_id(0)+64];
crctable[get_local_id(0)+128]=c_crctable[get_local_id(0)+128];
crctable[get_local_id(0)+192]=c_crctable[get_local_id(0)+192];

barrier(CLK_LOCAL_MEM_FENCE);


SIZE = (uint)(size); 
i=table[get_global_id(1)];
j=table[get_global_id(0)]<<16;

k=(i|j);

input=(uint4)(chbase1.s0,chbase1.s1,chbase1.s2,chbase1.s3);
singlehash=(uint4)(chbase2.s0,chbase2.s1,chbase2.s2,chbase2.s3);
zip_long1(hashes,input, size, plains, found, singlehash,k,chbase5,crctable);

input=(uint4)(chbase1.s4,chbase1.s5,chbase1.s6,chbase1.s7);
singlehash=(uint4)(chbase2.s4,chbase2.s5,chbase2.s6,chbase2.s7);
zip_long1(hashes,input, size, plains, found, singlehash,k,chbase5,crctable);

input=(uint4)(chbase1.s8,chbase1.s9,chbase1.sA,chbase1.sB);
singlehash=(uint4)(chbase2.s8,chbase2.s9,chbase2.sA,chbase2.sB);
zip_long1(hashes,input, size, plains, found, singlehash,k,chbase5,crctable);

input=(uint4)(chbase1.sC,chbase1.sD,chbase1.sE,chbase1.sF);
singlehash=(uint4)(chbase2.sC,chbase2.sD,chbase2.sE,chbase2.sF);
zip_long1(hashes,input, size, plains, found, singlehash,k,chbase5,crctable);

}


#endif

#if (!OLD_ATI && !GCN)
#pragma OPENCL EXTENSION cl_amd_media_ops : enable
#define getglobalid(a) (mad24(get_group_id(0), 64U, get_local_id(0)))

#define kCrcPoly 0xEDB88320


#define CRC_UPDATE_BYTE(crc, b) \
((uint4) ( \
          ((crctable[((crc.x) ^ (b.x)) & 0xFF] ^ ((crc.x) >> 8))), \
          ((crctable[((crc.y) ^ (b.y)) & 0xFF] ^ ((crc.y) >> 8))), \
          ((crctable[((crc.z) ^ (b.z)) & 0xFF] ^ ((crc.z) >> 8))), \
          ((crctable[((crc.w) ^ (b.w)) & 0xFF] ^ ((crc.w) >> 8))) \
          ))

#define GETBYTE(arr,bt)  \
((uint4) ((((arr[bt>>2]) >> ((bt&3)<<3) )&255)))


void zip_long1( __global uint4 *hashes, const uint4 input, const uint size,  __global uint4 *plains, __global uint *found,  uint4 singlehash,uint4 x0,uint16 salt,__local uint crctable[256]) 
{

uint ic,i,ia,ib;
uint4 key0 = 305419896;
uint4 key1 = 591751049;
uint4 key2 = 878082192;
uint4 k0,k1,k2,c;
uint4 kk0,kk1,kk2;
uint4 temp,temp1,temp2;
uint SIZE;
uint4 password[8];
uint4 bt,t;
uint4 verifier;

password[0] = x0;
password[1] = (uint4)input.y;
password[2] = (uint4)input.z;
password[3] = (uint4)input.w;



SIZE=salt.sF;


for (ic=0; ic<SIZE; ic++)
{
bt = GETBYTE(password,ic);
key0=CRC_UPDATE_BYTE(key0, bt);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);
}
k0=key0;k1=key1;k2=key2;



// Unroll the 12 iterations, iteration 1
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = salt.s0&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 2
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s0>>8)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 3
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s0>>16)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 4
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s0>>24)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 5
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s1>>0)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 6
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s1>>8)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 7
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s1>>16)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 8
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s1>>24)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 9
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s2>>0)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 10
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s2>>8)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 11
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s2>>16)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);


// Unroll the 12 iterations, iteration 12
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s2>>24)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

if (all(c!=(uint4)salt.s9)) return;
verifier=(c&255)^(uint4)salt.s9;

kk0=key0;
kk1=key1;
kk2=key2;


if (salt.sE>1)
{

key0=k0;key1=k1;key2=k2;
// Unroll the 12 iterations, iteration 1
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = salt.s3&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 2
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s3>>8)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 3
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s3>>16)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 4
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s3>>24)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 5
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s4>>0)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 6
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s4>>8)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 7
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s4>>16)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 8
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s4>>24)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 9
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s5>>0)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 10
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s5>>8)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 11
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s5>>16)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);


// Unroll the 12 iterations, iteration 12
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s5>>24)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

if (all(c!=(uint4)salt.sA)) return;
verifier+=c^(uint4)salt.sA;
}



if (salt.sE>2)
{
key0=k0;key1=k1;key2=k2;
// Unroll the 12 iterations, iteration 1
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = salt.s6&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 2
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s6>>8)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 3
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s6>>16)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 4
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s6>>24)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 5
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s7>>0)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 6
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s7>>8)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 7
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s7>>16)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 8
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s7>>24)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 9
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s8>>0)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 10
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s8>>8)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 11
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s8>>16)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);


// Unroll the 12 iterations, iteration 12
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s8>>24)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

if (all(c!=(uint4)salt.sB)) return;
verifier+=c^(uint4)salt.sB;
}



if (salt.sE>3)
{
key0=k0;key1=k1;key2=k2;
// Unroll the 12 iterations, iteration 1
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = singlehash.x&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 2
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (singlehash.x>>8)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 3
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (singlehash.x>>16)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 4
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (singlehash.x>>24)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 5
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (singlehash.y>>0)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 6
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (singlehash.y>>8)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 7
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (singlehash.y>>16)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 8
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (singlehash.y>>24)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 9
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (singlehash.z>>0)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 10
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (singlehash.z>>8)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 11
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (singlehash.z>>16)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);


// Unroll the 12 iterations, iteration 12
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (singlehash.z>>24)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

if (all(c!=(uint4)singlehash.w)) return;
verifier+=c^(uint4)singlehash.w;
}

verifier+=(uint4)1;


uint res = atomic_inc(found);
hashes[res*4] = (uint4)(kk0.s0,kk1.s0,kk2.s0,verifier.s0);
hashes[res*4+1] = (uint4)(kk0.s1,kk1.s1,kk2.s1,verifier.s1);
hashes[res*4+2] = (uint4)(kk0.s2,kk1.s2,kk2.s2,verifier.s2);
hashes[res*4+3] = (uint4)(kk0.s3,kk1.s3,kk2.s3,verifier.s3);

uint4 xx1,xx2,xx3;
xx1=(uint4)input.y;
xx2=(uint4)input.z;
xx3=(uint4)input.w;
plains[res*4] = (uint4)(x0.s0,xx1.s0,xx2.s0,xx3.s0);
plains[res*4+1] = (uint4)(x0.s1,xx1.s1,xx2.s1,xx3.s1);
plains[res*4+2] = (uint4)(x0.s2,xx1.s2,xx2.s2,xx3.s2);
plains[res*4+3] = (uint4)(x0.s3,xx1.s3,xx2.s3,xx3.s3);
}



__kernel void  __attribute__((reqd_work_group_size(64, 1, 1))) 
zip_long_double( __global uint4 *hashes,  const uint size,  __global uint4 *plains, __global uint *found, __global const  uint *table,const uint16 chbase1,  const uint16 chbase2,uint16 chbase3,uint16 chbase4,uint16 chbase5) 
{
uint4 i;
uint j;
uint4 k;
uint4 c0,x0;
uint4 d0,d1,d2;
uint4 t1,t2,t3;
uint4 x1,SIZE;
uint4 c1,c2,x2;
uint4 t4;
uint4 input;
uint4 singlehash; 
__local uint crctable[256];

crctable[get_local_id(0)]=c_crctable[get_local_id(0)];
crctable[get_local_id(0)+64]=c_crctable[get_local_id(0)+64];
crctable[get_local_id(0)+128]=c_crctable[get_local_id(0)+128];
crctable[get_local_id(0)+192]=c_crctable[get_local_id(0)+192];

barrier(CLK_LOCAL_MEM_FENCE);


SIZE = (uint4)(size); 
i.s0=table[get_global_id(1)*4];
i.s1=table[get_global_id(1)*4+1];
i.s2=table[get_global_id(1)*4+2];
i.s3=table[get_global_id(1)*4+3];
j=table[get_global_id(0)]<<16;

k=(i|j);


input=(uint4)(chbase1.s0,chbase1.s1,chbase1.s2,chbase1.s3);
singlehash=(uint4)(chbase2.s0,chbase2.s1,chbase2.s2,chbase2.s3);
zip_long1(hashes,input, size, plains, found, singlehash,k,chbase5,crctable);


input=(uint4)(chbase1.s4,chbase1.s5,chbase1.s6,chbase1.s7);
singlehash=(uint4)(chbase2.s4,chbase2.s5,chbase2.s6,chbase2.s7);
zip_long1(hashes,input, size, plains, found, singlehash,k,chbase5,crctable);
}




__kernel void  __attribute__((reqd_work_group_size(64, 1, 1))) 
zip_long_normal( __global uint4 *hashes,  const uint size,  __global uint4 *plains, __global uint *found, __global const  uint * table,const uint16 chbase1,  const uint16 chbase2,uint16 chbase3,uint16 chbase4,uint16 chbase5) 
{
uint4 i,k;
uint j;
uint4 c0,x0;
uint4 d0,d1,d2;
uint4 t1,t2,t3;
uint4 x1,SIZE;
uint4 c1,c2,x2;
uint4 t4;
uint4 input;
uint4 singlehash; 
__local uint crctable[256];

crctable[get_local_id(0)]=c_crctable[get_local_id(0)];
crctable[get_local_id(0)+64]=c_crctable[get_local_id(0)+64];
crctable[get_local_id(0)+128]=c_crctable[get_local_id(0)+128];
crctable[get_local_id(0)+192]=c_crctable[get_local_id(0)+192];

barrier(CLK_LOCAL_MEM_FENCE);


SIZE = (uint4)(size); 
i.s0=table[get_global_id(1)*4];
i.s1=table[get_global_id(1)*4+1];
i.s2=table[get_global_id(1)*4+2];
i.s3=table[get_global_id(1)*4+3];
j=table[get_global_id(0)]<<16;

k=(i|j);


input=(uint4)(chbase1.s0,chbase1.s1,chbase1.s2,chbase1.s3);
singlehash=(uint4)(chbase2.s0,chbase2.s1,chbase2.s2,chbase2.s3);
zip_long1(hashes,input, size, plains, found, singlehash,k,chbase5,crctable);
}




#endif
#ifdef OLD_ATI

#define kCrcPoly 0xEDB88320


#define CRC_UPDATE_BYTE(crc, b) \
((uint4) ( \
          ((crctable[((crc.x) ^ (b.x)) & 0xFF] ^ ((crc.x) >> 8))), \
          ((crctable[((crc.y) ^ (b.y)) & 0xFF] ^ ((crc.y) >> 8))), \
          ((crctable[((crc.z) ^ (b.z)) & 0xFF] ^ ((crc.z) >> 8))), \
          ((crctable[((crc.w) ^ (b.w)) & 0xFF] ^ ((crc.w) >> 8))) \
          ))

#define GETBYTE(arr,bt)  \
((uint4) ((((arr[bt>>2]) >> ((bt&3)<<3) )&255)))


void zip_long1( __global uint4 *hashes, const uint4 input, const uint size,  __global uint4 *plains, __global uint *found,  uint4 singlehash,uint4 x0,uint16 salt,__local uint crctable[256]) 
{

uint ic,i,ia,ib;
uint4 key0 = 305419896;
uint4 key1 = 591751049;
uint4 key2 = 878082192;
uint4 k0,k1,k2,c;
uint4 kk0,kk1,kk2;
uint4 temp,temp1,temp2;
uint SIZE;
uint4 password[8];
uint4 bt,t;
uint4 verifier;

password[0] = x0;
password[1] = (uint4)input.y;
password[2] = (uint4)input.z;
password[3] = (uint4)input.w;



SIZE=salt.sF;


for (ic=0; ic<SIZE; ic++)
{
bt = GETBYTE(password,ic);
key0=CRC_UPDATE_BYTE(key0, bt);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);
}
k0=key0;k1=key1;k2=key2;



// Unroll the 12 iterations, iteration 1
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = salt.s0&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 2
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s0>>8)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 3
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s0>>16)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 4
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s0>>24)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 5
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s1>>0)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 6
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s1>>8)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 7
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s1>>16)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 8
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s1>>24)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 9
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s2>>0)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 10
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s2>>8)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 11
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s2>>16)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);


// Unroll the 12 iterations, iteration 12
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s2>>24)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

if (all(c!=(uint4)salt.s9)) return;
verifier=(c&255)^(uint4)salt.s9;

kk0=key0;
kk1=key1;
kk2=key2;


if (salt.sE>1)
{

key0=k0;key1=k1;key2=k2;
// Unroll the 12 iterations, iteration 1
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = salt.s3&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 2
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s3>>8)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 3
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s3>>16)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 4
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s3>>24)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 5
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s4>>0)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 6
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s4>>8)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 7
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s4>>16)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 8
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s4>>24)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 9
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s5>>0)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 10
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s5>>8)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 11
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s5>>16)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);


// Unroll the 12 iterations, iteration 12
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s5>>24)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

if (all(c!=(uint4)salt.sA)) return;
verifier+=c^(uint4)salt.sA;
}



if (salt.sE>2)
{
key0=k0;key1=k1;key2=k2;
// Unroll the 12 iterations, iteration 1
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = salt.s6&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 2
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s6>>8)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 3
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s6>>16)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 4
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s6>>24)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 5
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s7>>0)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 6
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s7>>8)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 7
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s7>>16)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 8
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s7>>24)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 9
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s8>>0)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 10
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s8>>8)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 11
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s8>>16)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);


// Unroll the 12 iterations, iteration 12
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (salt.s8>>24)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

if (all(c!=(uint4)salt.sB)) return;
verifier+=c^(uint4)salt.sB;
}



if (salt.sE>3)
{
key0=k0;key1=k1;key2=k2;
// Unroll the 12 iterations, iteration 1
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = singlehash.x&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 2
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (singlehash.x>>8)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 3
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (singlehash.x>>16)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 4
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (singlehash.x>>24)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 5
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (singlehash.y>>0)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 6
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (singlehash.y>>8)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 7
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (singlehash.y>>16)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 8
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (singlehash.y>>24)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 9
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (singlehash.z>>0)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 10
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (singlehash.z>>8)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

// Unroll the 12 iterations, iteration 11
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (singlehash.z>>16)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);


// Unroll the 12 iterations, iteration 12
temp = (key2) | 2;
temp1 = (((temp * (temp ^1)) >> 8))&255;
c = (singlehash.z>>24)&255 ^ temp1;
key0 = CRC_UPDATE_BYTE(key0,c);
key1 += key0 & 0xff;
key1 = key1 * 134775813 + 1;
t=(key1>>24)&255;
key2 = CRC_UPDATE_BYTE(key2,t);

if (all(c!=(uint4)singlehash.w)) return;
verifier+=c^(uint4)singlehash.w;
}

verifier+=(uint4)1;


uint res = found[0];
found[0]++;
hashes[res*4] = (uint4)(kk0.s0,kk1.s0,kk2.s0,verifier.s0);
hashes[res*4+1] = (uint4)(kk0.s1,kk1.s1,kk2.s1,verifier.s1);
hashes[res*4+2] = (uint4)(kk0.s2,kk1.s2,kk2.s2,verifier.s2);
hashes[res*4+3] = (uint4)(kk0.s3,kk1.s3,kk2.s3,verifier.s3);

uint4 xx1,xx2,xx3;
xx1=(uint4)input.y;
xx2=(uint4)input.z;
xx3=(uint4)input.w;
plains[res*4] = (uint4)(x0.s0,xx1.s0,xx2.s0,xx3.s0);
plains[res*4+1] = (uint4)(x0.s1,xx1.s1,xx2.s1,xx3.s1);
plains[res*4+2] = (uint4)(x0.s2,xx1.s2,xx2.s2,xx3.s2);
plains[res*4+3] = (uint4)(x0.s3,xx1.s3,xx2.s3,xx3.s3);
}



__kernel void  __attribute__((reqd_work_group_size(64, 1, 1))) 
zip_long_double( __global uint4 *hashes,  const uint size,  __global uint4 *plains, __global uint *found, __global const  uint *table,const uint16 chbase1,  const uint16 chbase2,uint16 chbase3,uint16 chbase4,uint16 chbase5) 
{
uint4 i;
uint j;
uint4 k;
uint4 c0,x0;
uint4 d0,d1,d2;
uint4 t1,t2,t3;
uint4 x1,SIZE;
uint4 c1,c2,x2;
uint4 t4;
uint4 input;
uint4 singlehash; 
__local uint crctable[256];

crctable[get_local_id(0)]=c_crctable[get_local_id(0)];
crctable[get_local_id(0)+64]=c_crctable[get_local_id(0)+64];
crctable[get_local_id(0)+128]=c_crctable[get_local_id(0)+128];
crctable[get_local_id(0)+192]=c_crctable[get_local_id(0)+192];

barrier(CLK_LOCAL_MEM_FENCE);


SIZE = (uint4)(size); 
i.s0=table[get_global_id(1)*4];
i.s1=table[get_global_id(1)*4+1];
i.s2=table[get_global_id(1)*4+2];
i.s3=table[get_global_id(1)*4+3];
j=table[get_global_id(0)]<<16;

k=(i|j);


input=(uint4)(chbase1.s0,chbase1.s1,chbase1.s2,chbase1.s3);
singlehash=(uint4)(chbase2.s0,chbase2.s1,chbase2.s2,chbase2.s3);
zip_long1(hashes,input, size, plains, found, singlehash,k,chbase5,crctable);


input=(uint4)(chbase1.s4,chbase1.s5,chbase1.s6,chbase1.s7);
singlehash=(uint4)(chbase2.s4,chbase2.s5,chbase2.s6,chbase2.s7);
zip_long1(hashes,input, size, plains, found, singlehash,k,chbase5,crctable);
}




__kernel void  __attribute__((reqd_work_group_size(64, 1, 1))) 
zip_long_normal( __global uint4 *hashes,  const uint size,  __global uint4 *plains, __global uint *found, __global const  uint * table,const uint16 chbase1,  const uint16 chbase2,uint16 chbase3,uint16 chbase4,uint16 chbase5) 
{
uint4 i,k;
uint j;
uint4 c0,x0;
uint4 d0,d1,d2;
uint4 t1,t2,t3;
uint4 x1,SIZE;
uint4 c1,c2,x2;
uint4 t4;
uint4 input;
uint4 singlehash; 
__local uint crctable[256];

crctable[get_local_id(0)]=c_crctable[get_local_id(0)];
crctable[get_local_id(0)+64]=c_crctable[get_local_id(0)+64];
crctable[get_local_id(0)+128]=c_crctable[get_local_id(0)+128];
crctable[get_local_id(0)+192]=c_crctable[get_local_id(0)+192];

barrier(CLK_LOCAL_MEM_FENCE);


SIZE = (uint4)(size); 
i.s0=table[get_global_id(1)*4];
i.s1=table[get_global_id(1)*4+1];
i.s2=table[get_global_id(1)*4+2];
i.s3=table[get_global_id(1)*4+3];
j=table[get_global_id(0)]<<16;

k=(i|j);


input=(uint4)(chbase1.s0,chbase1.s1,chbase1.s2,chbase1.s3);
singlehash=(uint4)(chbase2.s0,chbase2.s1,chbase2.s2,chbase2.s3);
zip_long1(hashes,input, size, plains, found, singlehash,k,chbase5,crctable);
}

#endif
