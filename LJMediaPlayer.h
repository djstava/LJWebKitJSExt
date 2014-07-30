#ifndef LJMediaPlayer_H 
#define LJMediaPlayer_H

#include <wtf/PassRefPtr.h> 
#include <wtf/RefCounted.h>

#include "PlatformString.h"

namespace WebCore {

    class LJMediaPlayer : public RefCounted<LJMediaPlayer> { 
    public: 
        static PassRefPtr<LJMediaPlayer> create() { return adoptRef(new LJMediaPlayer()); }

        unsigned long setVolume(unsigned long volume); 
        long setMute(long muteFlag);

    private: 
        LJMediaPlayer(); 
    };

} // namespace WebCore

#endif // LJMediaPlayer_H



