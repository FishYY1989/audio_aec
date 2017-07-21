package com.example.wx.test;

import android.media.MediaPlayer;
import android.media.audiofx.AcousticEchoCanceler;


/**
 * Created by wx on 2017/7/10.
 */

public class AEC {
    private AcousticEchoCanceler canceler;
    private int audioSession;

    public AEC(){

    }

    public static boolean isDeviceSupport(){
        return AcousticEchoCanceler.isAvailable();
    }

    public  boolean initAEC(int audioSession){
        if(canceler != null){
            return true;
        }
        canceler = AcousticEchoCanceler.create(audioSession);
        canceler.setEnabled(true);
        return canceler.getEnabled();
    }

    public boolean setAECEnabled(boolean enable){
        if(null == canceler){
            return false;
        }
        canceler.setEnabled(enable);
        return canceler.getEnabled();
    }

    public boolean release(){
        if(null == canceler){
            return false;
        }
        canceler.setEnabled(false);
        canceler.release();
        return true;
    }
}
