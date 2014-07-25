#ifndef LJStandby_h 
#define LJStandby_h

#include <wtf/PassRefPtr.h> 
#include <wtf/RefCounted.h>

#include "PlatformString.h"

namespace WebCore {

    class LJStandby : public RefCounted<LJStandby> { 
    public: 
        static PassRefPtr<LJStandby> create() { return adoptRef(new LJStandby()); }

        String setStandby() const; 
		String getStandby() const; 
    private: 
        LJStandby(); 
    };

} // namespace WebCore

#endif // LJStandby_h

