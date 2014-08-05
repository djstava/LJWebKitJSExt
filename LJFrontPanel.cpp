#include "LJFrontPanel.h"


namespace WebCore {

LJFrontPanel::LJFrontPanel() 
{ 
}

bool LJFrontPanel::writeLed(const String& buff)
{
    char tmpBuff[5] = {0};

    if((buff.isEmpty()) == true){
        return false;
    }
    else{
	printf("tmpBuff=%s\n",buff.utf8().data());
        strncpy(tmpBuff,buff.utf8().data(),5);
        printf("===djstava buff= %x %x %x %x %x\n",tmpBuff[0],tmpBuff[1],tmpBuff[2],tmpBuff[3],tmpBuff[4]);
        return true;
    }
}

} // namespace WebCore



