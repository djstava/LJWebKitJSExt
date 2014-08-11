#ifndef LJMediaPlayer_H 
#define LJMediaPlayer_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <wtf/PassRefPtr.h> 
#include <wtf/RefCounted.h>

#include "PlatformString.h"
#include "dfb_platform.h"
#include "config.h"
#include "bdlna_types.h"

namespace WebCore {

    class LJMediaPlayer : public RefCounted<LJMediaPlayer> { 
    public: 
        static PassRefPtr<LJMediaPlayer> create() { return adoptRef(new LJMediaPlayer()); }

        void setVolume(long volume); 
        void setMuted(bool b);
		bool getMuteStatus();
		long getCurrentVolume();

    private: 
        LJMediaPlayer(); 
		void *s_handle;
		long m_volume;	
    };

} // namespace WebCore

#endif // LJMediaPlayer_H



