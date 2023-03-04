struct FVECTOR {
    float x;
    float y;
    float z;
    float w;
};

struct SI_WORK {
    FVECTOR pos;
    FVECTOR rot;
};

struct ITM {
    u32 itemcnt;
    u32 sisize;
    u32 flagsize;
    u32 dispsize;
    SI_WORK siwork[itemcnt];
    s32 flags[9];
    s32 disps[itemcnt];
};

ITM itm @ $;

