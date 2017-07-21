//
// Created by wx on 2017/7/14.
//

#include "jni.h"
#include <stdio.h>
#include <webrtc/audiooptimize.h>
#include "audiooptimize.h"

//#define NN 1280
AudioOptimize *audioOptimize = new AudioOptimize();

JNIEXPORT jint JNICALL native_webrtc_far(JNIEnv* env, jobject clazz, jbyteArray echoBuffer) {
    int echoLen = env->GetArrayLength(echoBuffer);
    char echo_buf[echoLen];

    int sampleRate = 16000;
    int channels = 1;
    audioOptimize->init(sampleRate, channels, sampleRate, channels);

    (env)->GetByteArrayRegion(echoBuffer, 0, echoLen, (jbyte *)echo_buf);
    audioOptimize->processRemote(echo_buf, echoLen);
    return 0;
}

JNIEXPORT jbyteArray JNICALL native_webrtc_near(JNIEnv* env, jobject clazz, jbyteArray  micBuffer){
    int NN = env->GetArrayLength(micBuffer);
    char mic_buf[NN];


    (env)->GetByteArrayRegion(micBuffer, 0, NN, (jbyte *)mic_buf);

    bool vadLowPower;
    audioOptimize->processCapture(mic_buf, NN, vadLowPower);

    jbyteArray out_buf = (env)->NewByteArray(NN);
    env->SetByteArrayRegion(out_buf, 0, NN, (jbyte *)mic_buf);

    return out_buf;
}


static JNINativeMethod nearmethod_table[] = {
        {"native_webrtc_near", "([B)[B", (void *) native_webrtc_near}
};

static  JNINativeMethod farmethod_table[] = {
        {"native_webrtc_far", "([B)I", (void *)native_webrtc_far}
};

JNIEXPORT jint JNI_OnLoad(JavaVM *vm, void *reserved) {
    //OnLoad方法是没有JNIEnv参数的，需要通过vm获取。
    JNIEnv *env = NULL;
    if (vm->AttachCurrentThread(&env, NULL) == JNI_OK) {
        //获取对应声明native方法的Java类
        jclass nearclazz = env->FindClass("com/example/wx/test/AudioRecorder");
        jclass farclazz = env->FindClass("com/example/wx/test/AudioPlayer");
        if (nearclazz == NULL) {
            return JNI_FALSE;
        }
        if(farclazz == NULL){
            return JNI_FALSE;
        }
        //注册方法，成功返回正确的JNIVERSION。
        if (env->RegisterNatives(nearclazz, nearmethod_table,
                                 sizeof(nearmethod_table) / sizeof(nearmethod_table[0])) == JNI_OK &&
                env->RegisterNatives(farclazz, farmethod_table,
                                     sizeof(farmethod_table) / sizeof(farmethod_table[0])) == JNI_OK) {
            return JNI_VERSION_1_4;
        }
    }
    return JNI_FALSE;
}

