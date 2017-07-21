//
// Created by wx on 2017/7/10.
//

#include "jni.h"
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>
#include "speex/speex_echo.h"
#include "speex/speex_preprocess.h"

//#define NN 128
#define FilterLen 2048

extern "C" {
JNIEXPORT jint JNICALL native_Speex_proc(JNIEnv* env, jobject clazz, jstring echoFn, jbyteArray micBuffer, jstring outFn) {
    FILE *echo_fd, *out_fd;
    int NN = (env)->GetArrayLength(micBuffer);
    short echo_buf[NN], mic_buf[NN], out_buf[NN];
    SpeexEchoState *st;
    SpeexPreprocessState *den;
    int sampleRate = 16000;


    const char *echo_fn =  (env)->GetStringUTFChars(echoFn, false);
    (env)->GetByteArrayRegion(micBuffer, 0, NN, (jbyte *)mic_buf);
    const char *out_fn = (env)->GetStringUTFChars(outFn, false);
    if(!(echo_fd = fopen(echo_fn, "rb"))){
        printf("%s doesn't exist.\n", echo_fn);
    }
    if(!(out_fd = fopen(out_fn, "wb"))){
        printf("%s doesn't exist.\n", out_fn);
    }

    // Step1: 初始化结构
    st = speex_echo_state_init(NN, FilterLen);
    den = speex_preprocess_state_init(NN, sampleRate);

    //Step2: 设置相关参数
    speex_echo_ctl(st, SPEEX_ECHO_SET_SAMPLING_RATE, &sampleRate);
    speex_preprocess_ctl(den, SPEEX_PREPROCESS_SET_ECHO_STATE, st);

    while (!feof(echo_fd)) {
        int echoLen = fread(echo_buf, sizeof(short), NN, echo_fd);

        //Step3: 调用Api回声消除，ref_buf是麦克采集到的数据
        // echo_buf：是从speaker处获取到的数据
        // e_buf: 是回声消除后的数据
        speex_echo_cancellation(st, mic_buf, echo_buf, out_buf);
        speex_preprocess_run(den, out_buf);
        fwrite(out_buf, sizeof(short), NN, out_fd);
    }

    //Step4: 销毁结构 释放资源
    speex_echo_state_destroy(st);
    speex_preprocess_state_destroy(den);
    fclose(out_fd);
    fclose(echo_fd);
    (env)->ReleaseStringUTFChars(echoFn, echo_fn);
    (env)->ReleaseStringUTFChars(outFn, out_fn);
    return 0;
}

static JNINativeMethod method_table[] = {
        {"native_Speex_proc", "(Ljava/lang/String;[BLjava/lang/String;)I", (void *) native_Speex_proc}
};

JNIEXPORT jint JNI_OnLoad(JavaVM *vm, void *reserved) {
    //OnLoad方法是没有JNIEnv参数的，需要通过vm获取。
    JNIEnv *env = NULL;
    if (vm->AttachCurrentThread(&env, NULL) == JNI_OK) {
        //获取对应声明native方法的Java类
        jclass clazz = env->FindClass("com/example/wx/test/AudioRecorder");
        if (clazz == NULL) {
            return JNI_FALSE;
        }
        //注册方法，成功返回正确的JNIVERSION。
        if (env->RegisterNatives(clazz, method_table,
                                 sizeof(method_table) / sizeof(method_table[0])) == JNI_OK) {
            return JNI_VERSION_1_4;
        }
    }
    return JNI_FALSE;
}
}


