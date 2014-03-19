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

#include "xsi.h"

struct XSI_INFO xsi_info;



int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    work_m_00000000002352655529_1621107508_init();
    xilinxcorelib_ver_m_00000000001358910285_2751787280_init();
    xilinxcorelib_ver_m_00000000001687936702_0053822601_init();
    xilinxcorelib_ver_m_00000000000277421008_4022834315_init();
    xilinxcorelib_ver_m_00000000002856723387_0747763235_init();
    work_m_00000000000403262735_0984947828_init();
    xilinxcorelib_ver_m_00000000001358910285_3465963250_init();
    xilinxcorelib_ver_m_00000000001687936702_1597930495_init();
    xilinxcorelib_ver_m_00000000000277421008_3726015087_init();
    xilinxcorelib_ver_m_00000000002856723387_0811516366_init();
    work_m_00000000000403262735_3370108073_init();
    work_m_00000000001460544030_1704550970_init();
    work_m_00000000003448898517_3890841882_init();
    work_m_00000000004093713498_2073120511_init();


    xsi_register_tops("work_m_00000000003448898517_3890841882");
    xsi_register_tops("work_m_00000000004093713498_2073120511");


    return xsi_run_simulation(argc, argv);

}
