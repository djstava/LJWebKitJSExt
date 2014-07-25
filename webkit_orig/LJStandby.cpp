#include "LJStandby.h"

namespace WebCore {

LJStandby::LJStandby() 
{ 
}

String LJStandby::setStandby() const 
{ 
    return "Hello LJStandby.\n"; 
}

String LJStandby::getStandby() const
{
    return "getStandby() called.\n";
}

} // namespace WebCore

