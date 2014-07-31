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
        return true;
    }
}

} // namespace WebCore



