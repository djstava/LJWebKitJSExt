#include "LJMediaPlayer.h"

namespace WebCore {

LJMediaPlayer::LJMediaPlayer() 
{ 
    BMedia_OpenSettings mediaSettings;
    DFB_PlatformSettings platformSettings;

    /* Get DirectFB Platform settings */
    DFB_Platform_GetSettings(&platformSettings);
    memset(&mediaSettings, 0, sizeof(BMedia_OpenSettings));
    mediaSettings.displayHandle = platformSettings.display[0].handle;
    mediaSettings.supportRvu = false;
    mediaSettings.audioMixer = NULL;

    printf(" === djstava creating new LJMediaPlayer. ===\n");
    s_handle = (void*)BMedia_Open(&mediaSettings);
}

/*=========================FUNCTION=====================================================
 *
 *      Name: setVolume
 *      Description: 
 *      Param: 
 *          float volume 
 *      Return: void
 *
 *======================================================================================
 */
void LJMediaPlayer::setVolume(long volume) 
{ 
    printf("=== djstava setVolume: %d \n",volume);
    m_volume = volume;
    BMedia_AudioSettings pSettings;
    BMedia_GetAudioSettings((BMediaHandle)(LJMediaPlayer::s_handle), &pSettings);
    pSettings.leftVolume = (int)(volume * 100 -3100);
    pSettings.rightVolume = (int)(volume * 100 -3100);
    
    BMedia_SetAudioSettings((BMediaHandle)(LJMediaPlayer::s_handle), &pSettings);
}

/*=========================FUNCTION=====================================================
 *
 *      Name: setMuted
 *      Description: 
 *      Param: 
 *          bool b 
 *      Return: void
 *
 *======================================================================================
  */
void LJMediaPlayer::setMuted(bool b)
{
    BMedia_AudioSettings audioSettings;
    audioSettings.muted = b;

    printf("=== djstava setMuted:%d \n",b);
    BMedia_SetAudioSettings((BMediaHandle)(LJMediaPlayer::s_handle), &audioSettings);
}

/*=========================FUNCTION=====================================================
 *
 *      Name: getMuteStatus
 *      Description: 
 *      Param: 
 *      Return: void
 *
 *======================================================================================
  */
bool LJMediaPlayer::getMuteStatus()
{
    BMedia_AudioSettings pSettings;
    BMedia_GetAudioSettings((BMediaHandle)(LJMediaPlayer::s_handle), &pSettings);
    return pSettings.muted;
}

/*=========================FUNCTION=====================================================
 *
 *      Name: getCurrentVolume
 *      Description: 
 *      Param: 
 *      Return: double
 *
 *======================================================================================
  */
long LJMediaPlayer::getCurrentVolume()
{
    printf("==== djstava getCurrentVolume:%l \n",m_volume);
    
    if(getMuteStatus())
        return 0;
    else
        return m_volume;
}

} // namespace WebCore


