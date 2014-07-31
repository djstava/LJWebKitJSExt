#ifndef LJFrontPanel_H 
#define LJFrontPanel_H

#include <wtf/PassRefPtr.h> 
#include <wtf/RefCounted.h>

#include <stdio.h>
#include <string.h>
#include "CString.h"
#include "PlatformString.h"

namespace WebCore {

    class LJFrontPanel : public RefCounted<LJFrontPanel> { 
    public: 
        static PassRefPtr<LJFrontPanel> create() { return adoptRef(new LJFrontPanel()); }
        bool writeLed(const String&);

    private: 
        LJFrontPanel(); 
    };

} // namespace WebCore

#endif // LJFrontPanel_H




