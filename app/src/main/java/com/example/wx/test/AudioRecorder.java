package com.example.wx.test;

import android.media.AudioFormat;
import android.media.AudioRecord;
import android.media.MediaRecorder;
import android.os.Environment;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

import static android.os.Environment.getExternalStorageDirectory;

/**
 * Created by wx on 2017/7/7.
 */

public class AudioRecorder {
    private AudioRecord audioRecord;
    private int sampleRate;
    private int channel;
    private int audioMinBufSize;

    public int getAudioSessionID() {
        return audioSessionID;
    }

    private int audioSessionID;
    private String recordFileName;
    private boolean isRecording;
    private byte[] buffer;
    private AEC aec;

    public String getRecordFileName() {
        return recordFileName;
    }

    public void setRecordFileName(String recordFileName) {
        this.recordFileName = Environment.getExternalStorageDirectory().getAbsolutePath() + "/audio/" + recordFileName;
    }

    public AudioRecorder(String fn){
        sampleRate = 16000;
        channel = 1;
        isRecording = true;
        recordFileName = Environment.getExternalStorageDirectory().getAbsolutePath() + "/audio/" + fn;
    }

    public void start(){
        init();
        new Thread(new Runnable(){
            @Override
            public void run() {
                DataOutputStream writeFile = null;
                try {
                    System.out.println(recordFileName);
                    writeFile = new DataOutputStream(new BufferedOutputStream(new FileOutputStream(recordFileName)));
                } catch (FileNotFoundException e) {
                    e.printStackTrace();
                }
                buffer = new byte[audioMinBufSize];
                audioRecord.startRecording();
                try {
                    while (isRecording && (audioRecord.read(buffer, 0, buffer.length) > 0)) {
                        writeFile.write(buffer);

                    }
                    audioRecord.stop();
                    writeFile.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }).start();
    }

    public void start_webrtc(){
        init();
        new Thread(new Runnable() {
            @Override
            public void run() {
                DataOutputStream writeFile = null;
                DataOutputStream outFile = null;
                try {
                    System.out.println(recordFileName);
                    writeFile = new DataOutputStream(new BufferedOutputStream(new FileOutputStream(recordFileName)));
                    System.out.println(getExternalStorageDirectory().getAbsolutePath() + "/audio/out_webrtc.pcm");
                    outFile = new DataOutputStream(new BufferedOutputStream(new FileOutputStream(
                            getExternalStorageDirectory().getAbsolutePath() + "/audio/out_webrtc.pcm")));
                } catch (FileNotFoundException e) {
                    e.printStackTrace();
                }

                buffer = new byte[audioMinBufSize];
                byte[] outBuffer = null;
                audioRecord.startRecording();
                try{
                    while (isRecording && (audioRecord.read(buffer, 0, buffer.length) > 0)){
                        writeFile.write(buffer);
                        outBuffer = native_webrtc_near(buffer);
                        outFile.write(outBuffer);
                        }
                    audioRecord.stop();
                    writeFile.close();
                    outFile.close();
                }catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }).start();
    }

    public void start_speex(){
        init();
        new Thread(new Runnable() {
            @Override
            public void run() {
                DataOutputStream writeFile = null;
                try {
                    System.out.println(recordFileName);
                    writeFile = new DataOutputStream(new BufferedOutputStream(new FileOutputStream(recordFileName)));
                } catch (FileNotFoundException e) {
                    e.printStackTrace();
                }

                buffer = new byte[audioMinBufSize];
                audioRecord.startRecording();
                try{
                    while (isRecording && (audioRecord.read(buffer, 0, buffer.length) > 0)){
                        writeFile.write(buffer);
                        native_Speex_proc(getExternalStorageDirectory().getAbsolutePath() + "/audio/farend.pcm",
                                buffer,
                                getExternalStorageDirectory().getAbsolutePath() + "/audio/out_speex.pcm");
                    }
                    audioRecord.stop();
                    writeFile.close();
                }catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }).start();
    }

    public void stop(){
        isRecording = false;
    }

    public boolean init(){
        audioMinBufSize = AudioRecord.getMinBufferSize(sampleRate, AudioFormat.CHANNEL_IN_MONO, AudioFormat.ENCODING_PCM_16BIT);
        audioRecord = new AudioRecord(MediaRecorder.AudioSource.MIC,
                sampleRate,
                AudioFormat.CHANNEL_IN_MONO,
                AudioFormat.ENCODING_PCM_16BIT,
                audioMinBufSize);
        return true;
    }

    public  boolean init_aec(){
        audioMinBufSize = AudioRecord.getMinBufferSize(sampleRate, AudioFormat.CHANNEL_IN_MONO, AudioFormat.ENCODING_PCM_16BIT);
        audioRecord = new AudioRecord(MediaRecorder.AudioSource.MIC,
                sampleRate,
                AudioFormat.CHANNEL_IN_MONO,
                AudioFormat.ENCODING_PCM_16BIT,
                audioMinBufSize);
        audioSessionID = audioRecord.getAudioSessionId();
        if(aec == null) {
            aec = new AEC();
            if(aec.isDeviceSupport()) {
                aec.initAEC(audioSessionID);
            }
        }

        return true;
    }

    public void start_aec(){
        init_aec();
        new Thread(new Runnable(){
            @Override
            public void run() {
                DataOutputStream writeFile = null;
                try {
                    System.out.println(recordFileName);
                    writeFile = new DataOutputStream(new BufferedOutputStream(new FileOutputStream(recordFileName)));
                } catch (FileNotFoundException e) {
                    e.printStackTrace();
                }
                buffer = new byte[audioMinBufSize];
                audioRecord.startRecording();
                try {
                    while (isRecording && (audioRecord.read(buffer, 0, buffer.length) > 0)) {
                        writeFile.write(buffer);
                    }
                    audioRecord.stop();
                    writeFile.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }).start();
        aec.release();
    }

    public native int native_Speex_proc(String speFn, byte[] micBuffer, String outFn);
    private native byte[] native_webrtc_near(byte[] micBuffer);
}
