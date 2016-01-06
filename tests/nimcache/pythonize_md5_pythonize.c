/* Generated by Nim Compiler v0.12.0 */
/*   (c) 2015 Andreas Rumpf */
/* The generated code is subject to the original license. */
/* Compiled for: Linux, amd64, gcc */
/* Command for C compiler:
   gcc -c  -w -g3 -O0  -I/media/marco/Research/Applications/aporia/Nim/lib -o /home/marco/.nimble/pkgs/Pythonize27-1.0.0/tests/nimcache/pythonize_md5_pythonize.o /home/marco/.nimble/pkgs/Pythonize27-1.0.0/tests/nimcache/pythonize_md5_pythonize.c */
#define NIM_INTBITS 64

#include "nimbase.h"
#include <stdio.h>
#include <stdlib.h>
typedef struct NimStringDesc NimStringDesc;
typedef struct TGenericSeq TGenericSeq;
typedef struct Memregion31291 Memregion31291;
typedef struct Gcheap51418 Gcheap51418;
typedef struct Gcstack51416 Gcstack51416;
typedef struct Cellseq49363 Cellseq49363;
typedef struct Cell49347 Cell49347;
typedef struct Cellset49359 Cellset49359;
typedef struct Pagedesc49355 Pagedesc49355;
typedef struct Smallchunk31243 Smallchunk31243;
typedef struct Llchunk31285 Llchunk31285;
typedef struct Bigchunk31245 Bigchunk31245;
typedef struct Intset31217 Intset31217;
typedef struct Trunk31213 Trunk31213;
typedef struct Avlnode31289 Avlnode31289;
typedef struct Gcstat51414 Gcstat51414;
typedef struct TNimType TNimType;
typedef struct PythondictHEX3Aobjecttype130025 PythondictHEX3Aobjecttype130025;
typedef struct Tpyobject125574 Tpyobject125574;
typedef struct TY130058 TY130058;
typedef struct Basechunk31241 Basechunk31241;
typedef struct Freecell31233 Freecell31233;
typedef struct TNimNode TNimNode;
typedef struct Tpytypeobject125626 Tpytypeobject125626;
typedef struct Tpynumbermethods125556 Tpynumbermethods125556;
typedef struct Tpysequencemethods125560 Tpysequencemethods125560;
typedef struct Tpymappingmethods125564 Tpymappingmethods125564;
typedef struct Tpybufferprocs125568 Tpybufferprocs125568;
typedef struct Tpymethoddef125586 Tpymethoddef125586;
typedef struct Tpymemberdef125590 Tpymemberdef125590;
typedef struct Tpygetsetdef125598 Tpygetsetdef125598;
struct  TGenericSeq  {
NI len;
NI reserved;
};
struct  NimStringDesc  {
  TGenericSeq Sup;
NIM_CHAR data[SEQ_DECL_SIZE];
};
struct  Cellseq49363  {
NI len;
NI cap;
Cell49347** d;
};
struct  Cellset49359  {
NI counter;
NI max;
Pagedesc49355* head;
Pagedesc49355** data;
};
typedef Smallchunk31243* TY31306[512];
typedef Trunk31213* Trunkbuckets31215[256];
struct  Intset31217  {
Trunkbuckets31215 data;
};
struct  Memregion31291  {
NI minlargeobj;
NI maxlargeobj;
TY31306 freesmallchunks;
Llchunk31285* llmem;
NI currmem;
NI maxmem;
NI freemem;
NI lastsize;
Bigchunk31245* freechunkslist;
Intset31217 chunkstarts;
Avlnode31289* root;
Avlnode31289* deleted;
Avlnode31289* last;
Avlnode31289* freeavlnodes;
};
struct  Gcstat51414  {
NI stackscans;
NI cyclecollections;
NI maxthreshold;
NI maxstacksize;
NI maxstackcells;
NI cycletablesize;
NI64 maxpause;
};
struct  Gcheap51418  {
Gcstack51416* stack;
void* stackbottom;
NI cyclethreshold;
Cellseq49363 zct;
Cellseq49363 decstack;
Cellset49359 cycleroots;
Cellseq49363 tempstack;
NI recgclock;
Memregion31291 region;
Gcstat51414 stat;
};
struct  Cell49347  {
NI refcount;
TNimType* typ;
};
typedef N_CDECL_PTR(NI, TY126655) (Tpyobject125574* dp, NCSTRING key, Tpyobject125574* item);
typedef N_CDECL_PTR(Tpyobject125574*, TY126702) (NCSTRING str);
typedef N_CDECL_PTR(Tpyobject125574*, TY126681) (NCSTRING str, NI start, Tpyobject125574* globals, Tpyobject125574* locals);
typedef N_CDECL_PTR(void, TY126509) (void);
typedef N_CDECL_PTR(Tpyobject125574*, TY126648) (Tpyobject125574* dp, NCSTRING key);
typedef N_CDECL_PTR(void, TY127892) (void);
struct  Gcstack51416  {
Gcstack51416* prev;
Gcstack51416* next;
void* starts;
void* pos;
NI maxstacksize;
};
typedef NI TY31222[8];
struct  Pagedesc49355  {
Pagedesc49355* next;
NI key;
TY31222 bits;
};
struct  Basechunk31241  {
NI prevsize;
NI size;
NIM_BOOL used;
};
struct  Smallchunk31243  {
  Basechunk31241 Sup;
Smallchunk31243* next;
Smallchunk31243* prev;
Freecell31233* freelist;
NI free;
NI acc;
NF data;
};
struct  Llchunk31285  {
NI size;
NI acc;
Llchunk31285* next;
};
struct  Bigchunk31245  {
  Basechunk31241 Sup;
Bigchunk31245* next;
Bigchunk31245* prev;
NI align;
NF data;
};
struct  Trunk31213  {
Trunk31213* next;
NI key;
TY31222 bits;
};
typedef Avlnode31289* TY31296[2];
struct  Avlnode31289  {
TY31296 link;
NI key;
NI upperbound;
NI level;
};
typedef N_NIMCALL_PTR(void, TY3889) (void* p, NI op);
typedef N_NIMCALL_PTR(void*, TY3894) (void* p);
struct  TNimType  {
NI size;
NU8 kind;
NU8 flags;
TNimType* base;
TNimNode* node;
void* finalizer;
TY3889 marker;
TY3894 deepcopy;
};
struct  Tpyobject125574  {
NI obrefcnt;
Tpytypeobject125626* obtype;
};
struct  PythondictHEX3Aobjecttype130025  {
  Tpyobject125574 Sup;
};
struct  Freecell31233  {
Freecell31233* next;
NI zerofield;
};
struct  TNimNode  {
NU8 kind;
NI offset;
TNimType* typ;
NCSTRING name;
NI len;
TNimNode** sons;
};
typedef N_CDECL_PTR(void, Tpydestructor125508) (Tpyobject125574* ob);
typedef N_CDECL_PTR(NI, Tprintfunc125510) (Tpyobject125574* ob, FILE* f, NI i);
typedef N_CDECL_PTR(Tpyobject125574*, Tgetattrfunc125512) (Tpyobject125574* ob1, NCSTRING name);
typedef N_CDECL_PTR(NI, Tsetattrfunc125514) (Tpyobject125574* ob1, NCSTRING name, Tpyobject125574* ob2);
typedef N_CDECL_PTR(NI, Tcmpfunc125516) (Tpyobject125574* ob1, Tpyobject125574* ob2);
typedef N_CDECL_PTR(Tpyobject125574*, Treprfunc125518) (Tpyobject125574* ob);
typedef N_CDECL_PTR(NI32, Thashfunc125520) (Tpyobject125574* ob);
typedef N_CDECL_PTR(Tpyobject125574*, Tternaryfunc125492) (Tpyobject125574* ob1, Tpyobject125574* ob2, Tpyobject125574* ob3);
typedef N_CDECL_PTR(Tpyobject125574*, Tgetattrofunc125522) (Tpyobject125574* ob1, Tpyobject125574* ob2);
typedef N_CDECL_PTR(NI, Tsetattrofunc125524) (Tpyobject125574* ob1, Tpyobject125574* ob2, Tpyobject125574* ob3);
typedef N_CDECL_PTR(NI, Tvisitproc125536) (Tpyobject125574* ob1, void* p);
typedef N_CDECL_PTR(NI, Ttraverseproc125538) (Tpyobject125574* ob1, Tvisitproc125536 prc, void* p);
typedef N_CDECL_PTR(NI, Tinquiry125494) (Tpyobject125574* ob1);
typedef N_CDECL_PTR(Tpyobject125574*, Trichcmpfunc125540) (Tpyobject125574* ob1, Tpyobject125574* ob2, NI i);
typedef N_CDECL_PTR(Tpyobject125574*, Tgetiterfunc125542) (Tpyobject125574* ob1);
typedef N_CDECL_PTR(Tpyobject125574*, Titernextfunc125544) (Tpyobject125574* ob1);
typedef N_CDECL_PTR(Tpyobject125574*, Tdescrgetfunc125546) (Tpyobject125574* ob1, Tpyobject125574* ob2, Tpyobject125574* ob3);
typedef N_CDECL_PTR(NI, Tdescrsetfunc125548) (Tpyobject125574* ob1, Tpyobject125574* ob2, Tpyobject125574* ob3);
typedef N_CDECL_PTR(NI, Tinitproc125550) (Tpyobject125574* self, Tpyobject125574* args, Tpyobject125574* kwds);
typedef N_CDECL_PTR(Tpyobject125574*, Tallocfunc125554) (Tpytypeobject125626* self, NI nitems);
typedef N_CDECL_PTR(Tpyobject125574*, Tnewfunc125552) (Tpytypeobject125626* subtype, Tpyobject125574* args, Tpyobject125574* kwds);
struct  Tpytypeobject125626  {
  Tpyobject125574 Sup;
NI obsize;
NCSTRING tpname;
NI tpbasicsize;
NI tpitemsize;
Tpydestructor125508 tpdealloc;
Tprintfunc125510 tpprint;
Tgetattrfunc125512 tpgetattr;
Tsetattrfunc125514 tpsetattr;
Tcmpfunc125516 tpcompare;
Treprfunc125518 tprepr;
Tpynumbermethods125556* tpasnumber;
Tpysequencemethods125560* tpassequence;
Tpymappingmethods125564* tpasmapping;
Thashfunc125520 tphash;
Tternaryfunc125492 tpcall;
Treprfunc125518 tpstr;
Tgetattrofunc125522 tpgetattro;
Tsetattrofunc125524 tpsetattro;
Tpybufferprocs125568* tpasbuffer;
NI32 tpflags;
NCSTRING tpdoc;
Ttraverseproc125538 tptraverse;
Tinquiry125494 tpclear;
Trichcmpfunc125540 tprichcompare;
NI32 tpweaklistoffset;
Tgetiterfunc125542 tpiter;
Titernextfunc125544 tpiternext;
Tpymethoddef125586* tpmethods;
Tpymemberdef125590* tpmembers;
Tpygetsetdef125598* tpgetset;
Tpytypeobject125626* tpbase;
Tpyobject125574* tpdict;
Tdescrgetfunc125546 tpdescrget;
Tdescrsetfunc125548 tpdescrset;
NI32 tpdictoffset;
Tinitproc125550 tpinit;
Tallocfunc125554 tpalloc;
Tnewfunc125552 tpnew;
Tpydestructor125508 tpfree;
Tinquiry125494 tpisgc;
Tpyobject125574* tpbases;
Tpyobject125574* tpmro;
Tpyobject125574* tpcache;
Tpyobject125574* tpsubclasses;
Tpyobject125574* tpweaklist;
void* tpxxx7;
void* tpxxx8;
};
typedef N_CDECL_PTR(Tpyobject125574*, Tbinaryfunc125490) (Tpyobject125574* ob1, Tpyobject125574* ob2);
typedef N_CDECL_PTR(Tpyobject125574*, Tunaryfunc125488) (Tpyobject125574* ob1);
typedef N_CDECL_PTR(NI, Tcoercion125496) (Tpyobject125574** ob1, Tpyobject125574** ob2);
struct  Tpynumbermethods125556  {
Tbinaryfunc125490 nbadd;
Tbinaryfunc125490 nbsubstract;
Tbinaryfunc125490 nbmultiply;
Tbinaryfunc125490 nbdivide;
Tbinaryfunc125490 nbremainder;
Tbinaryfunc125490 nbdivmod;
Tternaryfunc125492 nbpower;
Tunaryfunc125488 nbnegative;
Tunaryfunc125488 nbpositive;
Tunaryfunc125488 nbabsolute;
Tinquiry125494 nbnonzero;
Tunaryfunc125488 nbinvert;
Tbinaryfunc125490 nblshift;
Tbinaryfunc125490 nbrshift;
Tbinaryfunc125490 nband;
Tbinaryfunc125490 nbxor;
Tbinaryfunc125490 nbor;
Tcoercion125496 nbcoerce;
Tunaryfunc125488 nbint;
Tunaryfunc125488 nblong;
Tunaryfunc125488 nbfloat;
Tunaryfunc125488 nboct;
Tunaryfunc125488 nbhex;
Tbinaryfunc125490 nbinplaceadd;
Tbinaryfunc125490 nbinplacesubtract;
Tbinaryfunc125490 nbinplacemultiply;
Tbinaryfunc125490 nbinplacedivide;
Tbinaryfunc125490 nbinplaceremainder;
Tternaryfunc125492 nbinplacepower;
Tbinaryfunc125490 nbinplacelshift;
Tbinaryfunc125490 nbinplacershift;
Tbinaryfunc125490 nbinplaceand;
Tbinaryfunc125490 nbinplacexor;
Tbinaryfunc125490 nbinplaceor;
Tbinaryfunc125490 nbfloordivide;
Tbinaryfunc125490 nbtruedivide;
Tbinaryfunc125490 nbinplacefloordivide;
Tbinaryfunc125490 nbinplacetruedivide;
};
typedef N_CDECL_PTR(Tpyobject125574*, Tintargfunc125498) (Tpyobject125574* ob1, NI i);
typedef N_CDECL_PTR(Tpyobject125574*, Tintintargfunc125500) (Tpyobject125574* ob1, NI i1, NI i2);
typedef N_CDECL_PTR(NI, Tintobjargproc125502) (Tpyobject125574* ob1, NI i, Tpyobject125574* ob2);
typedef N_CDECL_PTR(NI, Tintintobjargproc125504) (Tpyobject125574* ob1, NI i1, NI i2, Tpyobject125574* ob2);
typedef N_CDECL_PTR(NI, Tobjobjproc125534) (Tpyobject125574* ob1, Tpyobject125574* ob2);
struct  Tpysequencemethods125560  {
Tinquiry125494 sqlength;
Tbinaryfunc125490 sqconcat;
Tintargfunc125498 sqrepeat;
Tintargfunc125498 sqitem;
Tintintargfunc125500 sqslice;
Tintobjargproc125502 sqassitem;
Tintintobjargproc125504 sqassslice;
Tobjobjproc125534 sqcontains;
Tbinaryfunc125490 sqinplaceconcat;
Tintargfunc125498 sqinplacerepeat;
};
typedef N_CDECL_PTR(NI, Tobjobjargproc125506) (Tpyobject125574* ob1, Tpyobject125574* ob2, Tpyobject125574* ob3);
struct  Tpymappingmethods125564  {
Tinquiry125494 mplength;
Tbinaryfunc125490 mpsubscript;
Tobjobjargproc125506 mpasssubscript;
};
typedef N_CDECL_PTR(NI, Tgetreadbufferproc125526) (Tpyobject125574* ob1, NI i, void* p);
typedef N_CDECL_PTR(NI, Tgetwritebufferproc125528) (Tpyobject125574* ob1, NI i, void* p);
typedef N_CDECL_PTR(NI, Tgetsegcountproc125530) (Tpyobject125574* ob1, NI i);
typedef N_CDECL_PTR(NI, Tgetcharbufferproc125532) (Tpyobject125574* ob1, NI i, NCSTRING pstr);
struct  Tpybufferprocs125568  {
Tgetreadbufferproc125526 bfgetreadbuffer;
Tgetwritebufferproc125528 bfgetwritebuffer;
Tgetsegcountproc125530 bfgetsegcount;
Tgetcharbufferproc125532 bfgetcharbuffer;
};
typedef N_CDECL_PTR(Tpyobject125574*, Tpycfunction125486) (Tpyobject125574* self, Tpyobject125574* args);
struct  Tpymethoddef125586  {
NCSTRING mlname;
Tpycfunction125486 mlmeth;
NI mlflags;
NCSTRING mldoc;
};
struct  Tpymemberdef125590  {
NCSTRING name;
NI thetype;
NI offset;
NI flags;
NCSTRING doc;
};
typedef N_CDECL_PTR(Tpyobject125574*, Tgetter125592) (Tpyobject125574* obj, void* context);
typedef N_CDECL_PTR(NI, Tsetter125594) (Tpyobject125574* obj, Tpyobject125574* value, void* context);
struct  Tpygetsetdef125598  {
NCSTRING name;
Tgetter125592 get;
Tsetter125594 setter;
NCSTRING doc;
void* closure;
};
struct TY130058 {
  TGenericSeq Sup;
  Tpyobject125574* data[SEQ_DECL_SIZE];
};
N_NIMCALL(NimStringDesc*, copyStringRC1)(NimStringDesc* src);
static N_INLINE(void, nimGCunrefNoCycle)(void* p);
N_NIMCALL(NIM_BOOL, allocinv_38411)(Memregion31291* a);
static N_INLINE(Cell49347*, usrtocell_53046)(void* usr);
static N_INLINE(void, nimFrame)(TFrame* s);
N_NOINLINE(void, stackoverflow_23601)(void);
static N_INLINE(void, popFrame)(void);
N_NIMCALL(NIM_BOOL, isallocatedptr_38407)(Memregion31291* a, void* p);
static N_INLINE(void, Gcdisable_11201)(void);
N_NIMCALL(void, writestacktrace_20207)(void);
static N_INLINE(void, rtladdzct_54604)(Cell49347* c);
N_NOINLINE(void, addzct_53017)(Cellseq49363* s, Cell49347* c);
static N_INLINE(void, HEX5BHEX5DHEX3D_132009)(PythondictHEX3Aobjecttype130025* p, NimStringDesc* index, NimStringDesc* val);
static N_INLINE(void, setitem_132019)(PythondictHEX3Aobjecttype130025* p, NimStringDesc* index, NimStringDesc* val);
static N_INLINE(Tpyobject125574*, pythonify_130283)(NimStringDesc* x);
N_NIMCALL(NimStringDesc*, depythonify_132067)(Tpyobject125574* x);
static N_INLINE(Tpyobject125574*, HEX5BHEX5D_131477)(PythondictHEX3Aobjecttype130025* p, NimStringDesc* index);
static N_INLINE(Tpyobject125574*, getitem_131452)(PythondictHEX3Aobjecttype130025* p, NimStringDesc* index);
static N_INLINE(void, asgnRefNoCycle)(void** dest, void* src);
N_NOINLINE(void, raiseIndexError)(void);
N_NIMCALL(void, release_132212)(Tpyobject125574* op);
static N_INLINE(NI, addInt)(NI a, NI b);
N_NOINLINE(void, raiseOverflow)(void);
N_NIMCALL(void, failedassertimpl_91603)(NimStringDesc* msg);
static N_INLINE(void, initStackBottomWith)(void* locals);
N_NOINLINE(void, setStackBottom)(void* thestackbottom);
NIM_EXTERNC N_NOINLINE(void, systemInit000)(void);
NIM_EXTERNC N_NOINLINE(void, systemDatInit000)(void);
NIM_EXTERNC N_NOINLINE(void, HEX00_parseutilsInit000)(void);
NIM_EXTERNC N_NOINLINE(void, HEX00_parseutilsDatInit000)(void);
NIM_EXTERNC N_NOINLINE(void, HEX00_strutilsInit000)(void);
NIM_EXTERNC N_NOINLINE(void, HEX00_strutilsDatInit000)(void);
NIM_EXTERNC N_NOINLINE(void, HEX00_etcprivInit000)(void);
NIM_EXTERNC N_NOINLINE(void, HEX00_etcprivDatInit000)(void);
NIM_EXTERNC N_NOINLINE(void, HEX00_hashesInit000)(void);
NIM_EXTERNC N_NOINLINE(void, HEX00_hashesDatInit000)(void);
NIM_EXTERNC N_NOINLINE(void, HEX00_timesInit000)(void);
NIM_EXTERNC N_NOINLINE(void, HEX00_timesDatInit000)(void);
NIM_EXTERNC N_NOINLINE(void, HEX00_mathInit000)(void);
NIM_EXTERNC N_NOINLINE(void, HEX00_mathDatInit000)(void);
NIM_EXTERNC N_NOINLINE(void, HEX00_tablesInit000)(void);
NIM_EXTERNC N_NOINLINE(void, HEX00_tablesDatInit000)(void);
NIM_EXTERNC N_NOINLINE(void, HEX00_dynlibInit000)(void);
NIM_EXTERNC N_NOINLINE(void, HEX00_dynlibDatInit000)(void);
NIM_EXTERNC N_NOINLINE(void, python_pythonInit000)(void);
NIM_EXTERNC N_NOINLINE(void, python_pythonDatInit000)(void);
NIM_EXTERNC N_NOINLINE(void, pythonize_pythonizeInit000)(void);
NIM_EXTERNC N_NOINLINE(void, pythonize_pythonizeDatInit000)(void);
NIM_EXTERNC N_NOINLINE(void, md5_pythonizeInit000)(void);
NIM_EXTERNC N_NOINLINE(void, md5_pythonizeDatInit000)(void);
STRING_LITERAL(TMP511, "Hello world!", 12);
STRING_LITERAL(TMP512, "[SYSASSERT] ", 12);
STRING_LITERAL(TMP513, "begin nimGCunrefNoCycle", 23);
STRING_LITERAL(TMP514, "[GCASSERT] ", 11);
STRING_LITERAL(TMP515, "nimGCunrefNoCycle: isAllocatedPtr", 33);
STRING_LITERAL(TMP516, "end nimGCunrefNoCycle 2", 23);
STRING_LITERAL(TMP517, "end nimGCunrefNoCycle 5", 23);
STRING_LITERAL(TMP518, "text", 4);
STRING_LITERAL(TMP519, "encoded_text", 12);
STRING_LITERAL(TMP520, "Text: ", 6);
STRING_LITERAL(TMP521, "Encoded Text: ", 14);
STRING_LITERAL(TMP523, "len(a) == L seq modified while iterating over it", 48);
NimStringDesc* texttoencode_132004;
extern Gcheap51418 gch_51459;
extern TFrame* frameptr_20842;
extern TY126655 Dl_126654;
extern TY126702 Dl_126701;
extern Tpyobject125574* pythonenvironmentobject_130069;
extern TY126681 Dl_126680;
extern TY126509 Dl_126508;
NimStringDesc* encodedtext_132079;
extern TY126648 Dl_126647;
Tpyobject125574* pythonref_132096;
extern TY130058* pythonreferences_130059;
extern TY127892 Dl_127891;

static N_INLINE(void, nimFrame)(TFrame* s) {
	NI LOC1;
	LOC1 = 0;
	{
		if (!(frameptr_20842 == NIM_NIL)) goto LA4;
		LOC1 = ((NI) 0);
	}
	goto LA2;
	LA4: ;
	{
		LOC1 = ((NI) ((NI16)((*frameptr_20842).calldepth + ((NI16) 1))));
	}
	LA2: ;
	(*s).calldepth = ((NI16) (LOC1));
	(*s).prev = frameptr_20842;
	frameptr_20842 = s;
	{
		if (!((*s).calldepth == ((NI16) 2000))) goto LA9;
		stackoverflow_23601();
	}
	LA9: ;
}

static N_INLINE(void, popFrame)(void) {
	frameptr_20842 = (*frameptr_20842).prev;
}

static N_INLINE(Cell49347*, usrtocell_53046)(void* usr) {
	Cell49347* result;
	nimfr("usrToCell", "gc.nim")
	result = 0;
	nimln(131, "gc.nim");
	result = ((Cell49347*) ((NI)((NU64)(((NI) (usr))) - (NU64)(((NI)sizeof(Cell49347))))));
	popFrame();
	return result;
}

static N_INLINE(void, Gcdisable_11201)(void) {
	nimfr("GC_disable", "gc.nim")
	nimln(976, "gc.nim");
	gch_51459.recgclock += ((NI) 1);
	popFrame();
}

static N_INLINE(void, rtladdzct_54604)(Cell49347* c) {
	nimfr("rtlAddZCT", "gc.nim")
	nimln(212, "gc.nim");
	addzct_53017((&gch_51459.zct), c);
	popFrame();
}

static N_INLINE(void, nimGCunrefNoCycle)(void* p) {
	Cell49347* c;
	nimfr("nimGCunrefNoCycle", "gc.nim")
	nimln(1365, "system.nim");
	{
		NIM_BOOL LOC3;
		nimln(245, "gc.nim");
		LOC3 = 0;
		LOC3 = allocinv_38411((&gch_51459.region));
		if (!!(LOC3)) goto LA4;
		nimln(1366, "system.nim");
		printf("%s%s\012", ((NimStringDesc*) &TMP512)? (((NimStringDesc*) &TMP512))->data:"nil", ((NimStringDesc*) &TMP513)? (((NimStringDesc*) &TMP513))->data:"nil");
		nimln(1367, "system.nim");
		exit(((NI) 1));
	}
	LA4: ;
	nimln(246, "gc.nim");
	c = usrtocell_53046(p);
	nimln(114, "gc.nim");
	{
		NIM_BOOL LOC8;
		nimln(247, "gc.nim");
		LOC8 = 0;
		LOC8 = isallocatedptr_38407((&gch_51459.region), ((void*) (c)));
		if (!!(LOC8)) goto LA9;
		nimln(115, "gc.nim");
		printf("%s%s\012", ((NimStringDesc*) &TMP514)? (((NimStringDesc*) &TMP514))->data:"nil", ((NimStringDesc*) &TMP515)? (((NimStringDesc*) &TMP515))->data:"nil");
		nimln(116, "gc.nim");
		Gcdisable_11201();
		nimln(117, "gc.nim");
		writestacktrace_20207();
		nimln(118, "gc.nim");
		exit(((NI) 1));
	}
	LA9: ;
	nimln(248, "gc.nim");
	{
		nimln(180, "gc.nim");
		(*c).refcount -= ((NI) 8);
		nimln(181, "gc.nim");
		if (!((NU64)((*c).refcount) < (NU64)(((NI) 8)))) goto LA13;
		nimln(249, "gc.nim");
		rtladdzct_54604(c);
		nimln(1365, "system.nim");
		{
			NIM_BOOL LOC17;
			nimln(250, "gc.nim");
			LOC17 = 0;
			LOC17 = allocinv_38411((&gch_51459.region));
			if (!!(LOC17)) goto LA18;
			nimln(1366, "system.nim");
			printf("%s%s\012", ((NimStringDesc*) &TMP512)? (((NimStringDesc*) &TMP512))->data:"nil", ((NimStringDesc*) &TMP516)? (((NimStringDesc*) &TMP516))->data:"nil");
			nimln(1367, "system.nim");
			exit(((NI) 1));
		}
		LA18: ;
	}
	LA13: ;
	nimln(1365, "system.nim");
	{
		NIM_BOOL LOC22;
		nimln(251, "gc.nim");
		LOC22 = 0;
		LOC22 = allocinv_38411((&gch_51459.region));
		if (!!(LOC22)) goto LA23;
		nimln(1366, "system.nim");
		printf("%s%s\012", ((NimStringDesc*) &TMP512)? (((NimStringDesc*) &TMP512))->data:"nil", ((NimStringDesc*) &TMP517)? (((NimStringDesc*) &TMP517))->data:"nil");
		nimln(1367, "system.nim");
		exit(((NI) 1));
	}
	LA23: ;
	popFrame();
}

static N_INLINE(Tpyobject125574*, pythonify_130283)(NimStringDesc* x) {
	Tpyobject125574* result;
	Tpyobject125574* LOC1;
	nimfr("pythonify", "pythonize.nim")
	result = 0;
	nimln(119, "pythonize.nim");
	LOC1 = 0;
	LOC1 = Dl_126701(x->data);
	result = ((Tpyobject125574*) (LOC1));
	popFrame();
	return result;
}

static N_INLINE(void, setitem_132019)(PythondictHEX3Aobjecttype130025* p, NimStringDesc* index, NimStringDesc* val) {
	Tpyobject125574* LOC1;
	NI LOC2;
	nimfr("setItem", "pythonize.nim")
	nimln(545, "pythonize.nim");
	LOC1 = 0;
	LOC1 = pythonify_130283(val);
	LOC2 = 0;
	LOC2 = Dl_126654(((Tpyobject125574*) (p)), index->data, ((Tpyobject125574*) (LOC1)));
	popFrame();
}

static N_INLINE(void, HEX5BHEX5DHEX3D_132009)(PythondictHEX3Aobjecttype130025* p, NimStringDesc* index, NimStringDesc* val) {
	nimfr("[]=", "pythonize.nim")
	nimln(548, "pythonize.nim");
	setitem_132019(p, index, val);
	popFrame();
}

static N_INLINE(Tpyobject125574*, getitem_131452)(PythondictHEX3Aobjecttype130025* p, NimStringDesc* index) {
	Tpyobject125574* result;
	nimfr("getItem", "pythonize.nim")
	result = 0;
	nimln(530, "pythonize.nim");
	result = Dl_126647(((Tpyobject125574*) (p)), index->data);
	popFrame();
	return result;
}

static N_INLINE(Tpyobject125574*, HEX5BHEX5D_131477)(PythondictHEX3Aobjecttype130025* p, NimStringDesc* index) {
	Tpyobject125574* result;
	nimfr("[]", "pythonize.nim")
	result = 0;
	nimln(533, "pythonize.nim");
	result = getitem_131452(p, index);
	popFrame();
	return result;
}

static N_INLINE(void, asgnRefNoCycle)(void** dest, void* src) {
	nimfr("asgnRefNoCycle", "gc.nim")
	nimln(264, "gc.nim");
	{
		Cell49347* c;
		nimln(349, "system.nim");
		if (!!((src == NIM_NIL))) goto LA3;
		nimln(265, "gc.nim");
		c = usrtocell_53046(src);
		nimln(182, "gc.nim");
		(*c).refcount += ((NI) 8);
	}
	LA3: ;
	nimln(267, "gc.nim");
	{
		Cell49347* c;
		nimln(349, "system.nim");
		if (!!(((*dest) == NIM_NIL))) goto LA7;
		nimln(268, "gc.nim");
		c = usrtocell_53046((*dest));
		nimln(269, "gc.nim");
		{
			nimln(180, "gc.nim");
			(*c).refcount -= ((NI) 8);
			nimln(181, "gc.nim");
			if (!((NU64)((*c).refcount) < (NU64)(((NI) 8)))) goto LA11;
			nimln(270, "gc.nim");
			rtladdzct_54604(c);
		}
		LA11: ;
	}
	LA7: ;
	nimln(271, "gc.nim");
	(*dest) = src;
	popFrame();
}

static N_INLINE(NI, addInt)(NI a, NI b) {
	NI result;
{	result = 0;
	result = (NI)((NU64)(a) + (NU64)(b));
	{
		NIM_BOOL LOC3;
		LOC3 = 0;
		LOC3 = (((NI) 0) <= (NI)(result ^ a));
		if (LOC3) goto LA4;
		LOC3 = (((NI) 0) <= (NI)(result ^ b));
		LA4: ;
		if (!LOC3) goto LA5;
		goto BeforeRet;
	}
	LA5: ;
	raiseOverflow();
	}BeforeRet: ;
	return result;
}

static N_INLINE(void, initStackBottomWith)(void* locals) {
	setStackBottom(locals);
}
void PreMainInner() {
	systemInit000();
	HEX00_parseutilsDatInit000();
	HEX00_strutilsDatInit000();
	HEX00_etcprivDatInit000();
	HEX00_hashesDatInit000();
	HEX00_timesDatInit000();
	HEX00_mathDatInit000();
	HEX00_tablesDatInit000();
	HEX00_dynlibDatInit000();
	python_pythonDatInit000();
	pythonize_pythonizeDatInit000();
	md5_pythonizeDatInit000();
	HEX00_parseutilsInit000();
	HEX00_strutilsInit000();
	HEX00_etcprivInit000();
	HEX00_hashesInit000();
	HEX00_timesInit000();
	HEX00_mathInit000();
	HEX00_tablesInit000();
	HEX00_dynlibInit000();
	python_pythonInit000();
	pythonize_pythonizeInit000();
}

void PreMain() {
	void (*volatile inner)();
	systemDatInit000();
	inner = PreMainInner;
	initStackBottomWith((void *)&inner);
	(*inner)();
}

int cmdCount;
char** cmdLine;
char** gEnv;
N_CDECL(void, NimMainInner)(void) {
	md5_pythonizeInit000();
}

N_CDECL(void, NimMain)(void) {
	void (*volatile inner)();
	PreMain();
	inner = NimMainInner;
	initStackBottomWith((void *)&inner);
	(*inner)();
}

int main(int argc, char** args, char** env) {
	cmdLine = args;
	cmdCount = argc;
	gEnv = env;
	NimMain();
	return nim_program_result;
}

NIM_EXTERNC N_NOINLINE(void, md5_pythonizeInit000)(void) {
	NimStringDesc* LOC1;
	Tpyobject125574* LOC12;
	nimfr("md5_pythonize", "md5_pythonize.nim")
	nimln(6, "md5_pythonize.nim");
	LOC1 = 0;
	LOC1 = texttoencode_132004; texttoencode_132004 = copyStringRC1(((NimStringDesc*) &TMP511));
	if (LOC1) nimGCunrefNoCycle(LOC1);
	nimln(7, "md5_pythonize.nim");
	HEX5BHEX5DHEX3D_132009(((PythondictHEX3Aobjecttype130025*) (pythonenvironmentobject_130069)), ((NimStringDesc*) &TMP518), texttoencode_132004);
	nimln(70, "pythonize.nim");
	{
		Tpyobject125574* LOC4;
		LOC4 = 0;
		LOC4 = Dl_126680("import md5", ((NI) 257), pythonenvironmentobject_130069, pythonenvironmentobject_130069);
		if (!LOC4 == 0) goto LA5;
		nimln(71, "pythonize.nim");
		Dl_126508();
	}
	LA5: ;
	nimln(70, "pythonize.nim");
	{
		Tpyobject125574* LOC9;
		LOC9 = 0;
		LOC9 = Dl_126680("encoded_text = md5.md5(text).hexdigest()", ((NI) 257), pythonenvironmentobject_130069, pythonenvironmentobject_130069);
		if (!LOC9 == 0) goto LA10;
		nimln(71, "pythonize.nim");
		Dl_126508();
	}
	LA10: ;
	nimln(10, "md5_pythonize.nim");
	LOC12 = 0;
	LOC12 = HEX5BHEX5D_131477(((PythondictHEX3Aobjecttype130025*) (pythonenvironmentobject_130069)), ((NimStringDesc*) &TMP519));
	asgnRefNoCycle((void**) (&encodedtext_132079), depythonify_132067(LOC12));
	nimln(11, "md5_pythonize.nim");
	printf("%s%s\012", ((NimStringDesc*) &TMP520)? (((NimStringDesc*) &TMP520))->data:"nil", texttoencode_132004? (texttoencode_132004)->data:"nil");
	nimln(12, "md5_pythonize.nim");
	printf("%s%s\012", ((NimStringDesc*) &TMP521)? (((NimStringDesc*) &TMP521))->data:"nil", encodedtext_132079? (encodedtext_132079)->data:"nil");
	{
		NI i_132258;
		NI L_132260;
		nimln(3365, "system.nim");
		i_132258 = ((NI) 0);
		nimln(3366, "system.nim");
		L_132260 = (pythonreferences_130059 ? pythonreferences_130059->Sup.len : 0);
		{
			nimln(3367, "system.nim");
			while (1) {
				NI TMP522;
				if (!(i_132258 < L_132260)) goto LA15;
				nimln(3368, "system.nim");
				if ((NU)(i_132258) >= (NU)(pythonreferences_130059->Sup.len)) raiseIndexError();
				pythonref_132096 = pythonreferences_130059->data[i_132258];
				nimln(603, "pythonize.nim");
				release_132212(pythonref_132096);
				nimln(3369, "system.nim");
				TMP522 = addInt(i_132258, ((NI) 1));
				i_132258 = (NI)(TMP522);
				nimln(3370, "system.nim");
				{
					if (!!(((pythonreferences_130059 ? pythonreferences_130059->Sup.len : 0) == L_132260))) goto LA18;
					failedassertimpl_91603(((NimStringDesc*) &TMP523));
				}
				LA18: ;
			} LA15: ;
		}
	}
	nimln(604, "pythonize.nim");
	{
		if (!NIM_TRUE) goto LA22;
		nimln(596, "pythonize.nim");
		Dl_127891();
	}
	LA22: ;
	popFrame();
}

NIM_EXTERNC N_NOINLINE(void, md5_pythonizeDatInit000)(void) {
}
