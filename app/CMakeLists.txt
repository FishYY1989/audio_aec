
cmake_minimum_required(VERSION 3.4.1)

ADD_DEFINITIONS(-DFIXED_POINT -DUSE_KISS_FFT)
ADD_SUBDIRECTORY(src/main/cpp/webrtc)

set(SPEEX_SRC_PATH ./src/main/cpp/speex)

include_directories(${SPEEX_SRC_PATH}/
                      ${SPEEX_SRC_PATH}/../ )

add_library(speex
            SHARED
        ${SPEEX_SRC_PATH}/bits.c
        ${SPEEX_SRC_PATH}/buffer.c
	    ${SPEEX_SRC_PATH}/cb_search.c
	    ${SPEEX_SRC_PATH}/exc_10_16_table.c
        ${SPEEX_SRC_PATH}/exc_10_32_table.c
	    ${SPEEX_SRC_PATH}/exc_20_32_table.c
	    ${SPEEX_SRC_PATH}/exc_5_256_table.c
	    ${SPEEX_SRC_PATH}/exc_5_64_table.c
	    ${SPEEX_SRC_PATH}/exc_8_128_table.c
	    ${SPEEX_SRC_PATH}/fftwrap.c
	    ${SPEEX_SRC_PATH}/filterbank.c
	    ${SPEEX_SRC_PATH}/filters.c
	    ${SPEEX_SRC_PATH}/gain_table.c
	    ${SPEEX_SRC_PATH}/gain_table_lbr.c
	    ${SPEEX_SRC_PATH}/hexc_10_32_table.c
	    ${SPEEX_SRC_PATH}/hexc_table.c
	    ${SPEEX_SRC_PATH}/high_lsp_tables.c
	    ${SPEEX_SRC_PATH}/jitter.c
	    ${SPEEX_SRC_PATH}/kiss_fft.c
	    ${SPEEX_SRC_PATH}/kiss_fftr.c
	    ${SPEEX_SRC_PATH}/lpc.c
	    ${SPEEX_SRC_PATH}/lsp.c
	    ${SPEEX_SRC_PATH}/lsp_tables_nb.c
	    ${SPEEX_SRC_PATH}/ltp.c
	    ${SPEEX_SRC_PATH}/mdf.c
	    ${SPEEX_SRC_PATH}/modes.c
	    ${SPEEX_SRC_PATH}/modes_wb.c
	    ${SPEEX_SRC_PATH}/nb_celp.c
	    ${SPEEX_SRC_PATH}/preprocess.c
	    ${SPEEX_SRC_PATH}/quant_lsp.c
	    ${SPEEX_SRC_PATH}/resample.c
 	    ${SPEEX_SRC_PATH}/sb_celp.c
	    ${SPEEX_SRC_PATH}/scal.c
	    ${SPEEX_SRC_PATH}/smallft.c
	    ${SPEEX_SRC_PATH}/speex.c
	    ${SPEEX_SRC_PATH}/speex_callbacks.c
	    ${SPEEX_SRC_PATH}/speex_header.c
	    ${SPEEX_SRC_PATH}/stereo.c
	    ${SPEEX_SRC_PATH}/vbr.c
	    ${SPEEX_SRC_PATH}/vq.c
	    ${SPEEX_SRC_PATH}/window.c
	    ./src/main/cpp/speex_jni.cpp)

target_link_libraries(speex)