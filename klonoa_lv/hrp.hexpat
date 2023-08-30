#include <std/mem.pat>
#include <std/io.pat>
#pragma eval_depth 1024

enum PT_CMD : u16 {
    CALL = 0x0000,
    INC = 0x0000,
    END = 0x0001,
    TIME = 0x0002,
    SUB = 0x0003,
    RET = 0x0004,
    TYPE = 0x0005,
    POS = 0x0006,
    ROT = 0x0007,
    DRAW = 0x0008,
    JMP = 0x0009,
    FLAG = 0x000a,
    FLAGJ = 0x000b,
    POS_SPD = 0x000c,
    POS_ACC = 0x000d,
    ROT_SPD = 0x000e,
    ROT_ACC = 0x000f,
    POS_MV = 0x0010,
    CALLCLR = 0x0011,
    ROT_MV = 0x0012,
    TIME_MP = 0x0013,
    TIME_MF = 0x0014,
    NLIGHT = 0x0015,
    LTCOL = 0x0016,
    AMBIENT = 0x0017,
    SIZE = 0x0018,
    MES_DATA = 0x0019,
    MES_START = 0x001a,
    MES_WINDOW = 0x001b,
    MES_SPD = 0x001c,
    MES_RETA = 0x001d,
    GET_FT = 0x001e,
    POS_MVP = 0x001f,
    ROT_MVP = 0x0020,
    SCALE = 0x0021,
    POS_SPD1 = 0x0022,
    ROT_SPD1 = 0x0023,
    LIGHT_NO = 0x0024,
    LIGHT_SW = 0x0025,
    LTCOL_SPD = 0x0026,
    LTCOL_ACC = 0x0027,
    LTCOL_MV = 0x0028,
    LTCOL_MVP = 0x0029,
    LTCOL_SPD1 = 0x002a,
    LTROT_SPD = 0x002b,
    LTROT_ACC = 0x002c,
    LTROT_MV = 0x002d,
    LTROT_MVP = 0x002e,
    LTROT_SPD1 = 0x002f,
    EFFECT = 0x0030,
    COL = 0x0031,
    COL_IN = 0x0032,
    COL_OUT = 0x0033,
    POS_CP = 0x0034,
    ROT_CP = 0x0035,
    POS_MVPC = 0x0036,
    LTROT = 0x0037,
    VTMODE = 0x0038,
    POS_CPT = 0x0039,
    IDSET = 0x003a,
    CHRSET = 0x003b,
    EXIT = 0x003c,
    ACOL = 0x003d,
    ACOL_IN = 0x003e,
    ACOL_OUT = 0x003f,
    ECONT = 0x0040,
    XFADE = 0x0041,
    XFADE_W = 0x0042,
    POS_MH = 0x0043,
    ROT_MH = 0x0044,
    POS_MHP = 0x0045,
    ROT_MHP = 0x0046,
    MK_MAT = 0x0047,
    POS_CPM = 0x0048,
    CPY_FT = 0x0049,
    TIME_FT = 0x004a,
    LOOPS = 0x004b,
    BGMODE = 0x004c,
    FOGNEAR = 0x004d,
    FOGFAR = 0x004e,
    PTNEXT = 0x004f,
    VTWAVE = 0x0050,
    PTDEL = 0x0051,
    MESNSKIP = 0x0052,
    NTSCJ = 0x0053,
    PALJ = 0x0054,
          
    MOT_PLAY = 0x0100,
    MOT_WAIT = 0x0101,
    MIME_SET = 0x0102,
    LIPS = 0x0103,
    MOT_PLAYS = 0x0104,
    MOT_CLIP = 0x0105,
    MOT_LINE = 0x0106,
    LP_DATA = 0x0107,
    MOT_PLAYE = 0x0108,
    MOT_PLAYSE = 0x0109,
          
    CAM_POS = 0x0200,
    CAM_WORK = 0x0201,
    CAM_HOLD = 0x0202,
    CAM_VEC = 0x0203,
    CAM_MAT = 0x0204,
    INTE_HOLD = 0x0205,
    INTE_VEC = 0x0206,
    INTE_MAT = 0x0207,
    CAM_SPD = 0x0208,
    CAM_ACC = 0x0209,
    INTE_POS = 0x020a,
    INTE_SPD = 0x020b,
    INTE_ACC = 0x020c,
    ANG_SET = 0x020d,
    ANG_SPD = 0x020e,
    ANG_ACC = 0x020f,
    LEN_SET = 0x0210,
    LEN_SPD = 0x0211,
    LEN_ACC = 0x0212,
    CAM_MATG = 0x0213,
    ICAM_MATG = 0x0214,
    CAM_MVP = 0x0215,
    ICAM_MVP = 0x0216,
    CAM_VECG = 0x0217,
    ICAM_VECG = 0x0218,
    CAM_LRSET = 0x0219,
    CAM_LRSPD = 0x021a,
    CAM_LRACC = 0x021b,
    CAM_LRMVP = 0x021c,
    ICAM_LRSET = 0x021d,
    ICAM_LRSPD = 0x021e,
    ICAM_LRACC = 0x021f,
    ICAM_LRMVP = 0x0220,
    CAM_LRMV = 0x0221,
    ICAM_LRMV = 0x0222,
    CAM_MV = 0x0223,
    ICAM_MV = 0x0224,
    ANG_MV = 0x0225,
    ANG_MVP = 0x0226,
    CAM_SPD1 = 0x0227,
    ICAM_SPD1 = 0x0228,
    CAM_LRSPD1 = 0x0229,
    ICAM_LRSPD1 = 0x022a,
    ANG_SPD1 = 0x022b,
    CAMDATA = 0x022c,
    LEN_MVP = 0x022d,
    LEN_MV = 0x022e,
    PROJ_SET = 0x022f,
    PROJ_SPD = 0x0230,
    PROJ_ACC = 0x0231,
    PROJ_MVP = 0x0232,
    PROJ_MV = 0x0233,
    CAM_MHP = 0x0234,
    ICAM_MHP = 0x0235,
    CAM_LRMHP = 0x0236,
    ICAM_LRMHP = 0x0237,
    CAM_LRMH = 0x0238,
    ICAM_LRMH = 0x0239,
    CAM_MH = 0x023a,
    ICAM_MH = 0x023b,
    ANG_MH = 0x023c,
    ANG_MHP = 0x023d,
          
    K_RTDATA = 0x0300,
    K_RTPOS = 0x0301,
    K_RTSPD = 0x0302,
    K_RTACC = 0x0303,
    K_RTOFF = 0x0304,
    K_RTMV = 0x0305,
    K_RTMVP = 0x0306,
    K_STRT = 0x0307,
    K_STSW = 0x0308,
    K_RTWAIT = 0x0309,
    K_COPY = 0x030a,
    K_CAMCAT = 0x030b,
    K_CAMREL = 0x030c,
    K_W2RT = 0x030d,
    K_RT2W = 0x030e,
    K_GAMEJ = 0x030f,
    K_GAMER = 0x0310,
    K_BACK = 0x0311,
    K_POSJ = 0x0312,
    K_KEY = 0x0313,
    K_RTJMP = 0x0314,
    K_CENT = 0x0315,
    K_KEYJ = 0x0316,
    K_JUMP = 0x0317,
    K_SHADOW = 0x0318,
    K_STSW2 = 0x0319,
    K_MIR = 0x031a,
    K_MESP = 0x031b,
    K_MIRN = 0x031c,
    K_BACKV = 0x031d,
    K_BACKY = 0x031e,
    K_SWITCH = 0x031f,
    K_VCLR = 0x0320,
    K_RESET = 0x0321,
    K_NSKIP = 0x0322,
    K_LCOL = 0x0323,
          
    PTVOICE = 0x0400,
    PTSE = 0x0401,
    VC_DATA = 0x0402,
    PTSELP = 0x0403,
    PTSELPOFF = 0x0404,
    PTABGM = 0x0405,
    PTNBGM = 0x0406,
    SPITSET = 0x0407,
    SPITMV = 0x0408,
    SPITMVP = 0x0409,
    SVOLSET = 0x040a,
    SVOLMV = 0x040b,
    SVOLMVP = 0x040c,
    PTSEV = 0x040d,
    PTBGMSYNC = 0x040e,
    AC3J = 0x040f,
    AC3S = 0x0410,
};

struct PT32A { // 0x4
    /* 0x2 */ s16 ss0;
};

struct PT32B { // 0x4
    /* 0x2 */ u16 us0;
};

struct PT64A { // 0x8
    /* 0x2 */ s16 ss0;
    /* 0x4 */ s16 ss1;
    /* 0x6 */ s16 ss2;
};

struct PT64B { // 0x8
    /* 0x2 */ u16 us0;
    /* 0x4 */ s32 si0;
};

struct PT64C { // 0x8
    /* 0x2 */ u16 us0;
    /* 0x4 */ float f0;
};

struct PT64D { // 0x8
    /* 0x0 */ u16 code;
    /* 0x2 */ u8 uc0;
    /* 0x3 */ u8 uc1;
    /* 0x4 */ s32 si0;
} ;

struct PT64E { // 0x8
    /* 0x2 */ u16 us0;
    /* 0x4 */ u8 uc0;
    /* 0x5 */ u8 uc1;
    /* 0x6 */ u8 uc2;
    /* 0x7 */ u8 uc3;
};

struct PT64F { // 0x8
    /* 0x2 */ u8 uc0;
    /* 0x3 */ u8 uc1;
    /* 0x4 */ float f0;
};

struct PT96A { // 0xc
    /* 0x2 */ u16 us0;
    /* 0x4 */ u16 us1;
    /* 0x6 */ s16 ss0;
    /* 0x8 */ u32 ui0;
};

struct PT96B { // 0xc
    /* 0x2 */ u16 us0;
    /* 0x4 */ u16 us1;
    /* 0x6 */ s16 ss0;
    /* 0x8 */ float f0;
};

struct PT96C { // 0xc
    /* 0x2 */ u16 us0;
    /* 0x4 */ u32 ui0;
    /* 0x8 */ u32 ui1;
};

struct PT96D { // 0xc
    /* 0x2 */ u16 us0;
    /* 0x4 */ s32 si0;
    /* 0x8 */ float f0;
};

struct PT96E { // 0xc
    /* 0x2 */ u8 uc0;
    /* 0x3 */ u8 uc1;
    /* 0x4 */ s32 si0;
    /* 0x8 */ u32 ui0;
};

struct PT96F { // 0xc
    /* 0x2 */ u8 uc0;
    /* 0x3 */ u8 uc1;
    /* 0x4 */ float f0;
    /* 0x8 */ u32 ui0;
};

struct PT128A { // 0x10
    /* 0x2 */ s16 ss0;
    /* 0x4 */ float f0;
    /* 0x8 */ float f1;
    /* 0xc */ float f2;
};

struct PT128B { // 0x10
    /* 0x2 */ u8 uc0;
    /* 0x3 */ u8 uc1;
    /* 0x4 */ float f0;
    /* 0x8 */ float f1;
    /* 0xc */ float f2;
};

struct PT128C { // 0x10
    /* 0x2 */ u16 us0;
    /* 0x4 */ u16 us1;
    /* 0x6 */ s16 ss0;
    /* 0x8 */ u32 ui0;
    /* 0xc */ s16 ss1;
    /* 0xe */ s16 ss2;
};

struct PT160A { // 0x14
    /* 0x02 */ u8 uc0;
    /* 0x03 */ u8 uc1;
    /* 0x04 */ float f0;
    /* 0x08 */ float f1;
    /* 0x0c */ float f2;
    /* 0x10 */ s16 ss0;
    /* 0x12 */ s16 ss1;
};

struct LipData {
    u16 id;
    u16 ptr;
};

struct LipsData {
    s32 count;
    LipData lips[count];
};

struct MesData {
    u16 string[while(std::mem::read_unsigned($ - 2, 2) != 0xFFFF)];
};

struct VcData {
    s32 count;
    s32 voices[count];
};

struct Vector3<T> {
    T x;
    T y;
    T z;
};

struct CamDataFrame {
    Vector3<float> pos;
    Vector3<float> inte;
};

struct CamData {
    s32 count;
    CamDataFrame frames[count];
};

struct DumbStupidPointer<T> {
    u32 offset;
    T data @ $ + offset * 4 - 4;
};

using CommandBlock;

struct Command {
    PT_CMD code;
    
    match (code) {
        (PT_CMD::CALL): PT32A data;
        (PT_CMD::END): PT32A data;
        (PT_CMD::TIME): PT32A data;
        (PT_CMD::SUB): PT32A data;
        (PT_CMD::RET): PT32A data;
        (PT_CMD::TYPE): PT64A data;
        (PT_CMD::POS): PT128A data;
        (PT_CMD::ROT): PT128A data;
        (PT_CMD::DRAW): PT32B data;
        (PT_CMD::JMP): PT32A data;
        (PT_CMD::FLAG): PT96A data;
        (PT_CMD::FLAGJ): PT96A data;
        (PT_CMD::POS_SPD): PT128A data;
        (PT_CMD::POS_ACC): PT128A data;
        (PT_CMD::ROT_SPD): PT128A data;
        (PT_CMD::ROT_ACC): PT128A data;
        (PT_CMD::POS_MV): PT128B data;
        (PT_CMD::CALLCLR): PT32A data;
        (PT_CMD::ROT_MV): PT128B data;
        (PT_CMD::TIME_MP): PT32A data;
        (PT_CMD::TIME_MF): PT32A data;
        (PT_CMD::NLIGHT): PT128A data;
        (PT_CMD::LTCOL): PT128A data;
        (PT_CMD::AMBIENT): PT128A data;
        (PT_CMD::SIZE): PT32A data;
        (PT_CMD::MES_DATA): PT32A data;
        (PT_CMD::MES_START): PT32A data;
        (PT_CMD::MES_WINDOW): PT32B data;
        (PT_CMD::MES_SPD): PT32A data;
        (PT_CMD::MES_RETA): PT32A data;
        (PT_CMD::GET_FT): PT64A data;
        (PT_CMD::POS_MVP): PT128B data;
        (PT_CMD::ROT_MVP): PT128B data;
        (PT_CMD::SCALE): PT64C data;
        (PT_CMD::POS_SPD1): PT64C data;
        (PT_CMD::ROT_SPD1): PT64C data;
        (PT_CMD::LIGHT_NO): PT32A data;
        (PT_CMD::LIGHT_SW): PT64A data;
        (PT_CMD::LTCOL_SPD): PT128A data;
        (PT_CMD::LTCOL_ACC): PT128A data;
        (PT_CMD::LTROT_MV): PT128B data;
        (PT_CMD::LTROT_MVP): PT128B data;
        (PT_CMD::LTROT_SPD1): PT64C data;
        (PT_CMD::EFFECT): PT64A data;
        (PT_CMD::COL): PT64E data;
        (PT_CMD::COL_IN): PT64E data;
        (PT_CMD::COL_OUT): PT64E data;
        (PT_CMD::POS_CP): PT128A data;
        (PT_CMD::ROT_CP): PT128A data;
        (PT_CMD::POS_MVPC): PT160A data;
        (PT_CMD::LTROT): PT128A data;
        (PT_CMD::VTMODE): PT32B data;
        (PT_CMD::POS_CPT): PT160A data;
        (PT_CMD::IDSET): PT32A data;
        (PT_CMD::CHRSET): PT32A data;
        (PT_CMD::EXIT): PT32A data;
        (PT_CMD::ACOL): PT64E data;
        (PT_CMD::ACOL_IN): PT64E data;
        (PT_CMD::ACOL_OUT): PT64E data;
        (PT_CMD::ECONT): PT64A data;
        (PT_CMD::XFADE): PT32B data;
        (PT_CMD::XFADE_W): PT32A data;
        (PT_CMD::POS_MH): PT160A data;
        (PT_CMD::ROT_MH): PT160A data;
        (PT_CMD::POS_MHP): PT160A data;
        (PT_CMD::ROT_MHP): PT160A data;
        (PT_CMD::MK_MAT): PT32B data;
        (PT_CMD::POS_CPM): PT128A data;
        (PT_CMD::CPY_FT): PT32B data;
        (PT_CMD::TIME_FT): PT32B data;
        (PT_CMD::LOOPS): PT64A data;
        (PT_CMD::BGMODE): PT64A data;
        (PT_CMD::FOGNEAR): PT64B data;
        (PT_CMD::FOGFAR): PT64B data;
        (PT_CMD::PTNEXT): PT64A data;
        (PT_CMD::VTWAVE): PT32A data;
        (PT_CMD::PTDEL): PT32A data;
        (PT_CMD::MESNSKIP): PT32B data;
        (PT_CMD::NTSCJ): PT32A data;
        (PT_CMD::PALJ): PT32A data;
                    
        (PT_CMD::MOT_PLAY): PT64A data;
        (PT_CMD::MOT_WAIT): PT32B data;
        (PT_CMD::MIME_SET): PT32B data;
        (PT_CMD::LIPS): PT32B data;
        (PT_CMD::MOT_PLAYS): PT64A data;
        (PT_CMD::MOT_CLIP): PT32B data;
        (PT_CMD::MOT_LINE): PT32B data;
        (PT_CMD::LP_DATA): PT32A data;
        (PT_CMD::MOT_PLAYE): PT64A data;
        (PT_CMD::MOT_PLAYSE): PT64A data;
                    
        (PT_CMD::CAM_POS): PT128A data;
        (PT_CMD::CAM_WORK): PT32B data;
        (PT_CMD::CAM_HOLD): PT32B data;
        (PT_CMD::CAM_VEC): PT128A data;
        (PT_CMD::CAM_MAT): PT128A data;
        (PT_CMD::INTE_HOLD): PT32B data;
        (PT_CMD::INTE_VEC): PT128A data;
        (PT_CMD::INTE_MAT): PT128A data;
        (PT_CMD::CAM_SPD): PT128A data;
        (PT_CMD::CAM_ACC): PT128A data;
        (PT_CMD::INTE_POS): PT128A data;
        (PT_CMD::INTE_SPD): PT128A data;
        (PT_CMD::INTE_ACC): PT128A data;
        (PT_CMD::ANG_SET): PT128A data;
        (PT_CMD::ANG_SPD): PT128A data;
        (PT_CMD::ANG_ACC): PT128A data;
        (PT_CMD::LEN_SET): PT64C data;
        (PT_CMD::LEN_SPD): PT64C data;
        (PT_CMD::LEN_ACC): PT64C data;
        (PT_CMD::CAM_MATG): PT32A data;
        (PT_CMD::ICAM_MATG): PT32A data;
        (PT_CMD::CAM_MVP): PT128B data;
        (PT_CMD::ICAM_MVP): PT128B data;
        (PT_CMD::CAM_VECG): PT32A data;
        (PT_CMD::ICAM_VECG): PT32A data;
        (PT_CMD::CAM_LRSET): PT128A data;
        (PT_CMD::CAM_LRSPD): PT128A data;
        (PT_CMD::CAM_LRACC): PT128A data;
        (PT_CMD::CAM_LRMVP): PT128B data;
        (PT_CMD::ICAM_LRSET): PT128A data;
        (PT_CMD::ICAM_LRSPD): PT128A data;
        (PT_CMD::ICAM_LRACC): PT128A data;
        (PT_CMD::ICAM_LRMVP): PT128B data;
        (PT_CMD::CAM_LRMV): PT128B data;
        (PT_CMD::ICAM_LRMV): PT128B data;
        (PT_CMD::CAM_MV): PT128B data;
        (PT_CMD::ICAM_MV): PT128B data;
        (PT_CMD::ANG_MV): PT128B data;
        (PT_CMD::ANG_MVP): PT128B data;
        (PT_CMD::CAM_SPD1): PT64C data;
        (PT_CMD::ICAM_SPD1): PT64C data;
        (PT_CMD::CAM_LRSPD1): PT64C data;
        (PT_CMD::ICAM_LRSPD1): PT64C data;
        (PT_CMD::ANG_SPD1): PT64C data;
        (PT_CMD::CAMDATA): PT32A data;
        (PT_CMD::LEN_MVP): PT64F data;
        (PT_CMD::LEN_MV): PT64F data;
        (PT_CMD::PROJ_SET): PT64C data;
        (PT_CMD::PROJ_SPD): PT64C data;
        (PT_CMD::PROJ_ACC): PT64C data;
        (PT_CMD::PROJ_MVP): PT64F data;
        (PT_CMD::PROJ_MV): PT64F data;
        (PT_CMD::CAM_MHP): PT160A data;
        (PT_CMD::ICAM_MHP): PT160A data;
        (PT_CMD::CAM_LRMHP): PT160A data;
        (PT_CMD::ICAM_LRMHP): PT160A data;
        (PT_CMD::CAM_LRMH): PT160A data;
        (PT_CMD::ICAM_LRMH): PT160A data;
        (PT_CMD::CAM_MH): PT160A data;
        (PT_CMD::ICAM_MH): PT160A data;
        (PT_CMD::ANG_MH): PT160A data;
        (PT_CMD::ANG_MHP): PT160A data;
                    
        (PT_CMD::K_RTDATA): PT32A data;
        (PT_CMD::K_RTPOS): PT64B data;
        (PT_CMD::K_RTSPD): PT32A data;
        (PT_CMD::K_RTACC): PT32A data;
        (PT_CMD::K_RTOFF): PT32A data;
        (PT_CMD::K_RTMV): PT64D data;
        (PT_CMD::K_RTMVP): PT64D data;
        (PT_CMD::K_STRT): PT96A data;
        (PT_CMD::K_STSW): PT64A data;
        (PT_CMD::K_RTWAIT): PT96A data;
        (PT_CMD::K_COPY): PT32A data;
        (PT_CMD::K_CAMCAT): PT32A data;
        (PT_CMD::K_CAMREL): PT32A data;
        (PT_CMD::K_W2RT): PT64B data;
        (PT_CMD::K_RT2W): PT32B data;
        (PT_CMD::K_GAMEJ): PT64A data;
        (PT_CMD::K_GAMER): PT64B data;
        (PT_CMD::K_BACK): PT64B data;
        (PT_CMD::K_POSJ): PT96B data;
        (PT_CMD::K_KEY): PT64B data;
        (PT_CMD::K_RTJMP): PT128C data;
        (PT_CMD::K_CENT): PT32B data;
        (PT_CMD::K_KEYJ): PT96A data;
        (PT_CMD::K_JUMP): PT96D data;
        (PT_CMD::K_SHADOW): PT64C data;
        (PT_CMD::K_STSW2): PT64A data;
        (PT_CMD::K_MIR): PT32B data;
        (PT_CMD::K_MESP): PT64A data;
        (PT_CMD::K_MIRN): PT32B data;
        (PT_CMD::K_BACKV): PT32B data;
        (PT_CMD::K_BACKY): PT32A data;
        (PT_CMD::K_SWITCH): PT64A data;
        (PT_CMD::K_VCLR): PT32A data;
        (PT_CMD::K_RESET): PT32A data;
        (PT_CMD::K_NSKIP): PT32A data;
        (PT_CMD::K_LCOL): PT64E data;
                    
        (PT_CMD::PTVOICE): PT32B data;
        (PT_CMD::PTSE): PT64B data;
        (PT_CMD::VC_DATA): PT32A data;
        (PT_CMD::PTSELP): PT64B data;
        (PT_CMD::PTSELPOFF): PT64B data;
        (PT_CMD::PTABGM): PT32B data;
        (PT_CMD::PTNBGM): PT32B data;
        (PT_CMD::SPITSET): PT96E data;
        (PT_CMD::SPITMV): PT96E data;
        (PT_CMD::SPITMVP): PT96E data;
        (PT_CMD::SVOLSET): PT96F data;
        (PT_CMD::SVOLMV): PT96F data;
        (PT_CMD::SVOLMVP): PT96F data;
        (PT_CMD::PTSEV): PT96D data;
        (PT_CMD::PTBGMSYNC): PT32A data;
        (PT_CMD::AC3J): PT32A data;
        (PT_CMD::AC3S): PT32A data;
    }
    
    if (code == PT_CMD::LP_DATA) {
        LipsData lpdata @ $ + data.ss0 * 4 - 4;
    }
    
    if (code == PT_CMD::MES_DATA) {
        DumbStupidPointer<MesData> mesdata @ $ + data.ss0 * 4 - 4;
    }
    
    if (code == PT_CMD::VC_DATA) {
        VcData vcdata @ $ + data.ss0 * 4 - 4;
    }
    
    if (code == PT_CMD::CAMDATA) {
        DumbStupidPointer<CamData> camdata @ $ + data.ss0 * 4 - 4;
    }
    
    if (code == PT_CMD::K_RTDATA) {
        DumbStupidPointer<u32> rtdata @ $ + data.ss0 * 4 - 4;
    }
    
    if (code == PT_CMD::CALL) {
        CommandBlock call @ $ + data.ss0 * 4 - 4;
    }
    
    if (code == PT_CMD::K_POSJ || code == PT_CMD::K_KEYJ || code == PT_CMD::AC3J || code == PT_CMD::AC3S) {
        CommandBlock conditional @ $ + data.ss0 * 4 - 4;
    }
    
    if (code == PT_CMD::SUB) {
        CommandBlock sub @ $ + data.ss0 * 4 - 4;
    }
    
    if (code == PT_CMD::JMP) {
        CommandBlock jump @ $ + data.ss0 * 4 - 4;
    }
    
    if (code == PT_CMD::RET || code == PT_CMD::END || code == PT_CMD::EXIT) {
        break;
    }
} [[comment(code)]];

struct CommandBlock {
    Command commands[100];
};

CommandBlock root @ $;