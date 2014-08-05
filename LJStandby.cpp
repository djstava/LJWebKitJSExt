#include "LJStandby.h"

namespace WebCore {

LJStandby::LJStandby() 
{ 
}

bool LJStandby::setStandby() 
{ 
    /*
    if(standbyFlag){
        standbyFlag = false;
        system("/sbin/reboot");
    }
    else{
        standbyFlag = true;
        DFB_Platform_Uninit();
    }
    */
    printf("====djtsava enter into standby status.\n");
    DFB_Platform_Uninit();
    return true;
}

} // namespace WebCore

