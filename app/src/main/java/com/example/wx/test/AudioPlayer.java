package com.example.wx.test;

import android.media.AudioFormat;
import android.media.AudioManager;
import android.media.AudioRecord;
import android.media.AudioTrack;
import android.os.Environment;
import android.renderscript.RenderScript;

import java.io.BufferedInputStream;
import java.io.DataInputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

/**
 * Created by wx on 2017/7/7.
 */

public class AudioPlayer {
    private AudioTrack audioTrack = null;
    private int sampleRate;
    private int channel;
    private int audioMinBufSize;
    private String playFileName;
    private boolean isPlaying;
    private byte[] buffer;

    public String getPlayFileName() {
        return playFileName;
    }

    public void setPlayFileName(String playFileName) {
        this.playFileName = Environment.getExternalStorageDirectory().getAbsolutePath() + "/audio/" + playFileName;
    }

    public AudioPlayer(String fn){
        sampleRate = 16000;
        channel = 1;
        playFileName = Environment.getExternalStorageDirectory().getAbsolutePath() + "/audio/" + fn;
    }

    public void start(){
        init();
        isPlaying = true;
        new Thread(new Runnable() {
            @Override
            public void run() {
                DataInputStream readFile = null;
                try {
                    System.out.println(playFileName);
                    readFile = new DataInputStream(new BufferedInputStream(new FileInputStream(playFileName)));
                } catch (FileNotFoundException e) {
                    e.printStackTrace();
                }
                buffer = new byte[audioMinBufSize];
                audioTrack.play();
                try {
                    int readBytes = 0;
                    while (isPlaying && ((readBytes = readFile.read(buffer)) > 0)) {
                        audioTrack.write(buffer, 0, buffer.length);
                        native_webrtc_far(buffer);
                    }

                    readFile.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }).start();
    }

    public void stop(){
        isPlaying = false;
    }

    private boolean init(){
        audioMinBufSize = AudioTrack.getMinBufferSize(sampleRate, AudioFormat.CHANNEL_OUT_MONO, AudioFormat.ENCODING_PCM_16BIT);
        audioTrack = new AudioTrack(AudioManager.STREAM_MUSIC, sampleRate,
                AudioFormat.CHANNEL_OUT_MONO,
                AudioFormat.ENCODING_PCM_16BIT,
                audioMinBufSize,
                AudioTrack.MODE_STREAM);

        return true;
    }

    private native int native_webrtc_far(byte[] echoBuffer);
}
