#ifndef LJStandby_h 
#define LJStandby_h

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <wtf/PassRefPtr.h> 
#include <wtf/RefCounted.h>

#include "dfb_platform.h"

namespace WebCore {

    class LJStandby : public RefCounted<LJStandby> { 
    public: 
        static PassRefPtr<LJStandby> create() { return adoptRef(new LJStandby()); }

        bool setStandby(); 

    private: 
        LJStandby(); 
		bool standbyFlag;
    };

} // namespace WebCore

#endif // LJStandby_h

