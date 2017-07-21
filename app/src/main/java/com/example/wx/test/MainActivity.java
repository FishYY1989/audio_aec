package com.example.wx.test;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;


import static android.os.Environment.getExternalStorageDirectory;

public class MainActivity extends Activity {

    // Used to load the 'native-lib' library on application startup.
    static {
        System.loadLibrary("speex");
        System.loadLibrary("webrtc");
    }


    private Button play_btn = null;
    private Button pause_btn = null;
    private EditText play_et = null;
    private String playFile = null;

    private Button recordspe_btn = null;
    private Button spe_stop_btn = null;
    private EditText spe_et = null;
    private String speakerFile = null;


    private Button record_aec_btn = null;


    private EditText mic_et = null;
    private String micFile = null;

    private  Button speex_btn = null;
    private  Button webrtc_btn = null;
    private EditText speex_et = null;
    private String outFile = null;


    private AudioPlayer player = null;
    private AudioRecorder recorder = null;
    @Override
    protected void onCreate(final Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        play_btn = (Button)findViewById(R.id.btn_play);
        pause_btn = (Button)findViewById(R.id.play_pause);
        play_et = (EditText)findViewById(R.id.edit_play);
        //playFile = play_et.getText().toString();

        recordspe_btn = (Button)findViewById(R.id.record_spe);
        spe_stop_btn = (Button)findViewById(R.id.spe_stop);
        spe_et = (EditText)findViewById(R.id.edit_spe);
        //speakerFile = spe_et.getText().toString();

        mic_et = (EditText)findViewById(R.id.edit_mic);
        micFile = mic_et.getText().toString();

        record_aec_btn = (Button)findViewById(R.id.record_aec);

        speex_btn = (Button)findViewById(R.id.btn_speex);
        webrtc_btn = (Button)findViewById(R.id.btn_webrtc);
        speex_et = (EditText)findViewById(R.id.edit_speex);
        outFile = speex_et.getText().toString();

        play_btn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                switch (view.getId()) {
                    case R.id.btn_play:
                        playFile = play_et.getText().toString();
                        if (player == null) {
                            player = new AudioPlayer(playFile);
                            // AudioSystem audioSystem
                            //         = AudioSystem.getAudioSystem( AudioSystem.LOCATOR_PROTOCOL_AUDIORECORD);
                            // audioSession = audioSystem.getAudioSessionId();
                        }
                        else{
                            player.setPlayFileName(playFile);
                        }
                        player.start();
                        break;
                    default:
                        break;
                }
            }
        });

        pause_btn.setOnClickListener(new View.OnClickListener(){
            public void onClick(View view){
                 if(player != null)
                 {
                     player.stop();
                 }
            }
        });

        recordspe_btn.setOnClickListener(new View.OnClickListener(){
            public void onClick(View view){
                switch (view.getId()) {
                    case R.id.record_spe:
                        if(spe_et.getText().toString() == null) {
                            speakerFile = spe_et.getText().toString();
                        }else{
                            speakerFile = "speaker.pcm";
                        }
                        if (recorder == null) {

                            recorder = new AudioRecorder(speakerFile);
                        }
                        else{
                            recorder.setRecordFileName(speakerFile);
                        }
                        recorder.start();
                        break;
                    default:
                        break;
                }
            }
        });

        spe_stop_btn.setOnClickListener(new View.OnClickListener(){
            public void onClick(View view){
                if(recorder != null)
                {
                    recorder.stop();
                }
            }
        });

        speex_btn.setOnClickListener(new View.OnClickListener(){
            public void onClick(View view){
                switch (view.getId()) {
                    case R.id.btn_speex:
                        if(mic_et.getText().toString() == null) {
                            micFile = mic_et.getText().toString();
                        }
                        else{
                            micFile = "near_speex.pcm";
                        }
                        if(spe_et.getText().toString() == null){
                            speakerFile = spe_et.getText().toString();
                        }else {
                            speakerFile = "farend.pcm";
                        }
                        if (recorder == null) {
                            if (player == null) {
                                player = new AudioPlayer(speakerFile);
                            }
                            else{
                                player.setPlayFileName(speakerFile);
                            }
                            player.start();
                            recorder = new AudioRecorder(micFile);
                        }
                        else{
                            recorder.setRecordFileName(micFile);
                        }
                        recorder.start_speex();
                        break;
                    default:
                        break;
                }
            }
        });

        webrtc_btn.setOnClickListener(new View.OnClickListener(){
            public void onClick(View view){
                switch (view.getId()) {
                    case R.id.btn_webrtc:
                        if(mic_et.getText().toString() == null) {
                            micFile = mic_et.getText().toString();
                        }
                        else{
                            micFile = "near_webrtc.pcm";
                        }
                        if(spe_et.getText().toString() == null){
                            speakerFile = spe_et.getText().toString();
                        }else {
                            speakerFile = "farend.pcm";
                        }
                        if (recorder == null) {
                            if (player == null) {
                                player = new AudioPlayer(speakerFile);
                            }
                            else{
                                player.setPlayFileName(speakerFile);
                            }
                            player.start();
                            recorder = new AudioRecorder(micFile);
                        }
                        else{
                            recorder.setRecordFileName(micFile);
                        }
                        recorder.start_webrtc();
                        break;
                    default:
                        break;
                }
            }
        });
    }



}
