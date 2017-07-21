#pragma once

#ifdef _WIN32
#define WEBRTC_AUDIO_OPTIMIZE_API __declspec(dllexport)
#else
#define WEBRTC_AUDIO_OPTIMIZE_API
#endif

namespace webrtc
{
class AudioProcessing;
class StreamConfig;
class Config;
}

//class TestFileWriter;
class WEBRTC_AUDIO_OPTIMIZE_API AudioOptimize
{
public:
	AudioOptimize();
	~AudioOptimize();

public:
	bool init(int in_samplerate, int in_channelnum, int out_samplerate, int out_channelnum);
    void processCapture(char* inBuf, int inLen, bool& o_VADLowPower); //MUST be 16bit PCM data!
	void processRemote(char* inBuf, int inLen); //MUST be 16bit PCM data!

    void setStreamDelay(int delay);

	void enableAGC(bool enable);
	void enableNS(bool enable);
	void enableVAD(bool enable);
	void enableECM(bool enable);
	void enableAEC(bool enable);
	void enableHPF(bool enable);
	void enableLE(bool enable);

private:
	webrtc::AudioProcessing*	m_pAudioProc;
	int m_nSamplesPerChannel;
	int m_nStreamDelay;
    int m_nAEC_driftSamples;
    int m_nAGC_analogLevel;

    webrtc::Config*         m_pConfig;
	webrtc::StreamConfig*	m_pInputConfig;
	webrtc::StreamConfig*	m_pOutputConfig;
	webrtc::StreamConfig*	m_pReverseConfig;
};
