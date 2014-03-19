/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x79f3f3a8 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static int ng0[] = {0, 0};
static int ng1[] = {1, 0};
static int ng2[] = {2, 0};



static int sp_log2roundup(char *t1, char *t2)
{
    char t7[8];
    char t20[8];
    int t0;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t21;

LAB0:    t0 = 1;

LAB2:    t3 = ((char*)((ng0)));
    t4 = (t1 + 13244);
    xsi_vlogvar_assign_value(t4, t3, 0, 0, 32);
    t3 = (t1 + 13060);
    t4 = (t3 + 36U);
    t5 = *((char **)t4);
    t6 = ((char*)((ng1)));
    memset(t7, 0, 8);
    xsi_vlog_signed_greater(t7, 32, t5, 32, t6, 32);
    t8 = (t7 + 4);
    t9 = *((unsigned int *)t8);
    t10 = (~(t9));
    t11 = *((unsigned int *)t7);
    t12 = (t11 & t10);
    t13 = (t12 != 0);
    if (t13 > 0)
        goto LAB3;

LAB4:
LAB5:    t3 = (t1 + 13244);
    t4 = (t3 + 36U);
    t5 = *((char **)t4);
    t6 = (t1 + 13152);
    xsi_vlogvar_assign_value(t6, t5, 0, 0, 32);
    t0 = 0;

LAB1:    return t0;
LAB3:
LAB6:    t14 = ((char*)((ng1)));
    t15 = (t1 + 13336);
    xsi_vlogvar_assign_value(t15, t14, 0, 0, 32);

LAB7:    t3 = (t1 + 13336);
    t4 = (t3 + 36U);
    t5 = *((char **)t4);
    t6 = (t1 + 13060);
    t8 = (t6 + 36U);
    t14 = *((char **)t8);
    memset(t7, 0, 8);
    xsi_vlog_signed_less(t7, 32, t5, 32, t14, 32);
    t15 = (t7 + 4);
    t9 = *((unsigned int *)t15);
    t10 = (~(t9));
    t11 = *((unsigned int *)t7);
    t12 = (t11 & t10);
    t13 = (t12 != 0);
    if (t13 > 0)
        goto LAB8;

LAB9:    goto LAB5;

LAB8:
LAB10:    t16 = (t1 + 13244);
    t17 = (t16 + 36U);
    t18 = *((char **)t17);
    t19 = ((char*)((ng1)));
    memset(t20, 0, 8);
    xsi_vlog_signed_add(t20, 32, t18, 32, t19, 32);
    t21 = (t1 + 13244);
    xsi_vlogvar_assign_value(t21, t20, 0, 0, 32);
    t3 = (t1 + 13336);
    t4 = (t3 + 36U);
    t5 = *((char **)t4);
    t6 = ((char*)((ng2)));
    memset(t7, 0, 8);
    xsi_vlog_signed_multiply(t7, 32, t5, 32, t6, 32);
    t8 = (t1 + 13336);
    xsi_vlogvar_assign_value(t8, t7, 0, 0, 32);
    goto LAB7;

}

static int sp_divroundup(char *t1, char *t2)
{
    char t9[8];
    char t11[8];
    char t22[8];
    int t0;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t10;
    char *t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t23;

LAB0:    t0 = 1;

LAB2:    t3 = (t1 + 13428);
    t4 = (t3 + 36U);
    t5 = *((char **)t4);
    t6 = (t1 + 13520);
    t7 = (t6 + 36U);
    t8 = *((char **)t7);
    memset(t9, 0, 8);
    xsi_vlog_signed_divide(t9, 32, t5, 32, t8, 32);
    t10 = (t1 + 13704);
    xsi_vlogvar_assign_value(t10, t9, 0, 0, 32);
    t3 = (t1 + 13428);
    t4 = (t3 + 36U);
    t5 = *((char **)t4);
    t6 = (t1 + 13520);
    t7 = (t6 + 36U);
    t8 = *((char **)t7);
    memset(t9, 0, 8);
    xsi_vlog_signed_mod(t9, 32, t5, 32, t8, 32);
    t10 = ((char*)((ng0)));
    memset(t11, 0, 8);
    xsi_vlog_signed_not_equal(t11, 32, t9, 32, t10, 32);
    t12 = (t11 + 4);
    t13 = *((unsigned int *)t12);
    t14 = (~(t13));
    t15 = *((unsigned int *)t11);
    t16 = (t15 & t14);
    t17 = (t16 != 0);
    if (t17 > 0)
        goto LAB3;

LAB4:
LAB5:    t3 = (t1 + 13704);
    t4 = (t3 + 36U);
    t5 = *((char **)t4);
    t6 = (t1 + 13612);
    xsi_vlogvar_assign_value(t6, t5, 0, 0, 32);
    t0 = 0;

LAB1:    return t0;
LAB3:
LAB6:    t18 = (t1 + 13704);
    t19 = (t18 + 36U);
    t20 = *((char **)t19);
    t21 = ((char*)((ng1)));
    memset(t22, 0, 8);
    xsi_vlog_signed_add(t22, 32, t20, 32, t21, 32);
    t23 = (t1 + 13704);
    xsi_vlogvar_assign_value(t23, t22, 0, 0, 32);
    goto LAB5;

}

static void Always_3810_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;

LAB0:    t1 = (t0 + 14228U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    t2 = (t0 + 14424);
    *((int *)t2) = 1;
    t3 = (t0 + 14256);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:
LAB5:    t4 = (t0 + 7864U);
    t5 = *((char **)t4);
    t4 = (t0 + 12324);
    xsi_vlogvar_assign_value(t4, t5, 0, 0, 1);
    t2 = (t0 + 7956U);
    t3 = *((char **)t2);
    t2 = (t0 + 12416);
    xsi_vlogvar_assign_value(t2, t3, 0, 0, 1);
    t2 = (t0 + 6484U);
    t3 = *((char **)t2);
    t2 = (t0 + 12508);
    xsi_vlogvar_assign_value(t2, t3, 0, 0, 1);
    t2 = (t0 + 6576U);
    t3 = *((char **)t2);
    t2 = (t0 + 12600);
    xsi_vlogvar_assign_value(t2, t3, 0, 0, 1);
    t2 = (t0 + 6668U);
    t3 = *((char **)t2);
    t2 = (t0 + 12692);
    xsi_vlogvar_assign_value(t2, t3, 0, 0, 1);
    t2 = (t0 + 6760U);
    t3 = *((char **)t2);
    t2 = (t0 + 12784);
    xsi_vlogvar_assign_value(t2, t3, 0, 0, 1);
    t2 = (t0 + 6852U);
    t3 = *((char **)t2);
    t2 = (t0 + 12876);
    xsi_vlogvar_assign_value(t2, t3, 0, 0, 6);
    t2 = (t0 + 6944U);
    t3 = *((char **)t2);
    t2 = (t0 + 12968);
    xsi_vlogvar_assign_value(t2, t3, 0, 0, 32);
    goto LAB2;

}


extern void xilinxcorelib_ver_m_00000000002856723387_0747763235_init()
{
	static char *pe[] = {(void *)Always_3810_0};
	static char *se[] = {(void *)sp_log2roundup,(void *)sp_divroundup};
	xsi_register_didat("xilinxcorelib_ver_m_00000000002856723387_0747763235", "isim/Core_TB_isim_beh.exe.sim/xilinxcorelib_ver/m_00000000002856723387_0747763235.didat");
	xsi_register_executes(pe);
	xsi_register_subprogram_executes(se);
}
