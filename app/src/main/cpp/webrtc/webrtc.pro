TEMPLATE = lib
TARGET = webrtc
RC_FILE = webrtc.rc
INCLUDEPATH += .
INCLUDEPATH += ../
INCLUDEPATH += ../../
INCLUDEPATH += ../../../
INCLUDEPATH += $$PWD/../../depends/dx-internal/include
INCLUDEPATH += ../../interface
INCLUDEPATH += ./system_wrappers/include
INCLUDEPATH += ./modules/include
INCLUDEPATH += ./modules/audio_processing/include
CONFIG -= qt
CONFIG += c++11

DEFINES += SSL_USE_OPENSSL
DEFINES += WEBRTC_NS_FLOAT
DEFINES += FEATURE_ENABLE_SSL
DEFINES += WEBRTC_CLOCK_TYPE_REALTIME
#DEFINES += WEBRTC_AEC_DEBUG_DUMP

CONFIG(debug, debug|release) {
    DESTDIR = ../../../bin/debug
	win32:
	{
		LIBS += -L$$PWD/../../depends/dx-internal/win32/debug1    -llogsdk -lreichbase 
	}
} else {
    DESTDIR = ../../../bin/release
	win32:
	{
		LIBS += -L$$PWD/../../depends/dx-internal/win32/release1    -llogsdk -lreichbase 
	}
}

win32: {
    QMAKE_LFLAGS += /DEBUG
    DEFINES += WEBRTC_WIN
    DEFINES += NOMINMAX	
    DEFINES += WIN32_LEAN_AND_MEAN
    LIBS += winmm.lib
    LIBS += comctl32.lib
    LIBS += ws2_32.lib
}

macx:{
CONFIG += staticlib

	QMAKE_LFLAGS+= -framework Foundation
	QMAKE_LFLAGS+= -framework CoreFoundation
	QMAKE_LFLAGS+= -framework Carbon
	#QMAKE_LFLAGS+= -framework CFBundle
	QMAKE_LFLAGS+= -framework ApplicationServices
	QMAKE_LFLAGS+= -framework CoreServices
	DEFINES += WEBRTC_MAC
	DEFINES += WEBRTC_POSIX
	LIBS += -L$$PWD/../../depends/dx-internal/mac -llogsdk -lreichbase 
}

HEADERS += audiooptimize.h\
  base/arraysize.h \
   base/asyncfile.h \
   base/asyncinvoker.h \
   base/asyncresolverinterface.h \
   base/asyncsocket.h \
   base/bandwidthsmoother.h \
   base/base64.h \
   base/bind.h \
   base/callback.h \
   base/common.h \
   base/crc32.h \
   base/cryptstring.h \
   base/dbus.h \
   base/deprecation.h \
   base/filerotatingstream.h \
   base/fileutils.h \
   base/flags.h \
   base/format_macros.h \
   base/gunit.h \
   base/gunit_prod.h \
   base/ifaddrs_converter.h \
   base/ipaddress.h \
   base/libdbusglibsymboltable.h \
   base/linked_ptr.h \
   base/logsinks.h \
   base/location.h \
   base/mathutils.h \
   base/messagehandler.h \
   base/messagequeue.h \
   base/nethelpers.h \
	base/nullsocketserver.h \
   base/pathutils.h \
   base/physicalsocketserver.h \
   base/ratelimiter.h \
   base/referencecountedsingletonfactory.h \
   base/rollingaccumulator.h \
   #base/rtccertificate.h \
	base/sharedexclusivelock.h \
   base/scoped_autorelease_pool.h \
   base/scoped_ref_ptr.h \
   base/scopedptrcollection.h \
   base/sec_buffer.h \
   base/signalthread.h \
   base/sigslot.h \
   base/socketaddress.h \
   base/stream.h \
   base/thread.h \
   base/timing.h \
   base/transformadapter.h \
   base/urlencode.h \
   base/versionparsing.h \
   common_audio/include/audio_util.h \
   common_audio/resampler/include/resampler.h \
   common_audio/signal_processing/include/real_fft.h \
   common_audio/signal_processing/include/signal_processing_library.h \
   common_audio/signal_processing/include/spl_inl.h \
   common_audio/signal_processing/complex_fft_tables.h \
   common_audio/signal_processing/resample_by_2_internal.h \
   common_audio/vad/include/vad.h \
   common_audio/vad/include/webrtc_vad.h \
   common_audio/vad/mock/mock_vad.h \
   common_audio/vad/vad_core.h \
   common_audio/vad/vad_filterbank.h \
   common_audio/vad/vad_gmm.h \
   common_audio/vad/vad_sp.h \
   common_audio/audio_converter.h \
   common_audio/audio_ring_buffer.h \
   common_audio/blocker.h \
   common_audio/fft4g.h \
   common_audio/fir_filter.h \
   common_audio/fir_filter_neon.h \
   common_audio/fir_filter_sse.h \
   common_audio/lapped_transform.h \
   common_audio/real_fourier.h \
   common_audio/real_fourier_ooura.h \
   common_audio/ring_buffer.h \
   common_audio/sparse_fir_filter.h \
   common_audio/swap_queue.h \
   common_audio/wav_file.h \
   common_audio/wav_header.h \
   common_audio/window_generator.h \
   modules/audio_processing/aec/aec_common.h \
   modules/audio_processing/aec/aec_core.h \
   modules/audio_processing/aec/aec_core_optimized_methods.h \
   modules/audio_processing/aec/aec_rdft.h \
   modules/audio_processing/aec/aec_resampler.h \
   modules/audio_processing/aec/echo_cancellation.h \
   #modules/audio_processing/aec/echo_cancellation_internal.h \
   modules/audio_processing/aecm/aecm_defines.h \
   modules/audio_processing/aecm/aecm_core.h \
   modules/audio_processing/aecm/echo_control_mobile.h \
   modules/audio_processing/agc/legacy/analog_agc.h \
   modules/audio_processing/agc/legacy/digital_agc.h \
   modules/audio_processing/agc/legacy/gain_control.h \
   modules/audio_processing/agc/agc.h \
   modules/audio_processing/agc/agc_manager_direct.h \
   modules/audio_processing/agc/gain_map_internal.h \
   modules/audio_processing/agc/loudness_histogram.h \
   modules/audio_processing/agc/utility.h \
   modules/audio_processing/beamformer/array_util.h \
   modules/audio_processing/beamformer/beamformer.h \
   modules/audio_processing/beamformer/complex_matrix.h \
   modules/audio_processing/beamformer/covariance_matrix_generator.h \
   modules/audio_processing/beamformer/matrix.h \
   modules/audio_processing/beamformer/nonlinear_beamformer.h \
   modules/audio_processing/include/audio_processing.h \
   modules/audio_processing/intelligibility/intelligibility_enhancer.h \
   modules/audio_processing/intelligibility/intelligibility_utils.h \
   modules/audio_processing/logging/apm_data_dumper.h \
   modules/audio_processing/transient/common.h \
   modules/audio_processing/transient/daubechies_8_wavelet_coeffs.h \
   modules/audio_processing/transient/dyadic_decimator.h \
   modules/audio_processing/transient/moving_moments.h \
   modules/audio_processing/transient/transient_detector.h \
   modules/audio_processing/transient/transient_suppressor.h \
   modules/audio_processing/transient/wpd_node.h \
   modules/audio_processing/transient/wpd_tree.h \
   modules/audio_processing/utility/delay_estimator.h \
   modules/audio_processing/utility/delay_estimator_internal.h \
   modules/audio_processing/utility/delay_estimator_wrapper.h \
   modules/audio_processing/utility/block_mean_calculator.h \
   modules/audio_processing/vad/common.h \
   modules/audio_processing/vad/gmm.h \
   modules/audio_processing/vad/noise_gmm_tables.h \
   modules/audio_processing/vad/pitch_based_vad.h \
   modules/audio_processing/vad/pitch_internal.h \
   modules/audio_processing/vad/pole_zero_filter.h \
   modules/audio_processing/vad/standalone_vad.h \
   modules/audio_processing/vad/vad_audio_proc.h \
   modules/audio_processing/vad/vad_audio_proc_internal.h \
   modules/audio_processing/vad/vad_circular_buffer.h \
   modules/audio_processing/vad/voice_activity_detector.h \
   modules/audio_processing/vad/voice_gmm_tables.h \
   modules/audio_processing/audio_buffer.h \
   modules/audio_processing/audio_processing_impl.h \
   modules/audio_processing/common.h \
   modules/audio_processing/echo_cancellation_impl.h \
   modules/audio_processing/echo_control_mobile_impl.h \
   modules/audio_processing/gain_control_impl.h \
   modules/audio_processing/gain_control_for_experimental_agc.h \
   modules/audio_processing/high_pass_filter_impl.h \
   modules/audio_processing/level_estimator_impl.h \
   modules/audio_processing/level_controller/biquad_filter.h \
   modules/audio_processing/level_controller/level_controller.h \
   modules/audio_processing/level_controller/gain_applier.h \
   modules/audio_processing/level_controller/gain_selector.h \
   modules/audio_processing/level_controller/noise_level_estimator.h \
   modules/audio_processing/level_controller/noise_spectrum_estimator.h \
   modules/audio_processing/level_controller/signal_classifier.h \
   modules/audio_processing/level_controller/saturating_gain_estimator.h \
   modules/audio_processing/level_controller/peak_level_estimator.h \
   modules/audio_processing/level_controller/down_sampler.h \
   modules/audio_processing/noise_suppression_impl.h \
   modules/audio_processing/rms_level.h \
   modules/audio_processing/splitting_filter.h \
   modules/audio_processing/three_band_filter_bank.h \
   modules/audio_processing/typing_detection.h \
   modules/audio_processing/voice_detection_impl.h \
   modules/include/module.h \
   modules/include/module_common_types.h \
   system_wrappers/include/aligned_array.h \
   system_wrappers/include/aligned_malloc.h \
   system_wrappers/include/atomic32.h \
   system_wrappers/include/clock.h \
   system_wrappers/include/cpu_features_wrapper.h \
   system_wrappers/include/cpu_info.h \
   system_wrappers/include/critical_section_wrapper.h \
   system_wrappers/include/data_log.h \
   system_wrappers/include/data_log_c.h \
   system_wrappers/include/data_log_impl.h \
   system_wrappers/include/event_wrapper.h \
   system_wrappers/include/field_trial.h \
   system_wrappers/include/file_wrapper.h \
   system_wrappers/include/logging.h \
   system_wrappers/include/metrics.h \
   system_wrappers/include/ntp_time.h \
   system_wrappers/include/ref_count.h \
   system_wrappers/include/rtp_to_ntp.h \
   system_wrappers/include/rw_lock_wrapper.h \
   system_wrappers/include/scoped_vector.h \
   system_wrappers/include/sleep.h \
   system_wrappers/include/sort.h \
   system_wrappers/include/static_instance.h \
   system_wrappers/include/stl_util.h \
   system_wrappers/include/stringize_macros.h \
   #system_wrappers/include/tick_util.h \
   system_wrappers/include/timestamp_extrapolator.h \
   system_wrappers/include/trace.h \
   system_wrappers/source/file_impl.h \
   system_wrappers/source/trace_impl.h \
   common_types.h \
   config.h \
   engine_configurations.h \
   typedefs.h \
   base/atomicops.h \
   base/criticalsection.h \
   base/constructormagic.h \
   base/thread_annotations.h \
   base/platform_thread_types.h \
   base/scoped_ptr.h \
   base/event.h \
   base/basictypes.h \
   base/byteorder.h \
   base/timeutils.h \
   base/checks.h \
   base/logging.h \
   base/dscp.h \
   base/stringutils.h \
   base/buffer.h \
   base/platform_file.h \
   base/stringencode.h \
   base/bytebuffer.h \
   base/platform_thread.h \
   base/thread_checker.h \
   base/thread_checker_impl.h \
   base/event_tracer.h \
   base/safe_conversions.h \
   base/safe_conversions_impl.h \
   test/testsupport/gtest_prod_util.h \
   common_video/rotation.h \
   common.h \
   base/optional.h \
   #base/ifaddrs-android.h \
   base/refcount.h \
   base/template_util.h \
   base/trace_event.h \
   base/systeminfo.h \
   common_audio/resampler/include/push_resampler.h \
   common_audio/resampler/push_sinc_resampler.h \
   common_audio/resampler/sinc_resampler.h \
   common_audio/vad/vad_unittest.h \
   common_audio/channel_buffer.h \
   modules/audio_processing/ns/defines.h \
   modules/audio_processing/ns/noise_suppression.h \
   modules/audio_processing/ns/noise_suppression_x.h \
   modules/audio_processing/ns/ns_core.h \
   modules/audio_processing/ns/nsx_core.h \
   modules/audio_processing/ns/nsx_defines.h \
   modules/audio_processing/ns/windows_private.h \
   modules/audio_processing/vad/vad_audio_proc_internal.h \
   system_wrappers/include/logcat_trace_context.h \
   system_wrappers/source/spreadsortlib/constants.hpp \
   system_wrappers/source/spreadsortlib/spreadsort.hpp \
   system_wrappers/include/compile_assert_c.h \
   modules/utility/include/audio_frame_operations.h \
   modules/audio_coding/codecs/isac/main/source/arith_routines.h \
   modules/audio_coding/codecs/isac/main/source/bandwidth_estimator.h \
   modules/audio_coding/codecs/isac/main/source/codec.h \
   modules/audio_coding/codecs/isac/main/source/crc.h \
   modules/audio_coding/codecs/isac/main/source/encode_lpc_swb.h \
   modules/audio_coding/codecs/isac/main/source/entropy_coding.h \
   modules/audio_coding/codecs/isac/main/source/fft.h \
   modules/audio_coding/codecs/isac/main/source/filterbank_tables.h \
   modules/audio_coding/codecs/isac/main/source/isac_float_type.h \
   modules/audio_coding/codecs/isac/main/source/lpc_analysis.h \
   modules/audio_coding/codecs/isac/main/source/lpc_gain_swb_tables.h \
   modules/audio_coding/codecs/isac/main/source/lpc_shape_swb12_tables.h \
   modules/audio_coding/codecs/isac/main/source/lpc_shape_swb16_tables.h \
   modules/audio_coding/codecs/isac/main/source/lpc_tables.h \
   modules/audio_coding/codecs/isac/main/source/os_specific_inline.h \
   modules/audio_coding/codecs/isac/main/source/pitch_estimator.h \
   modules/audio_coding/codecs/isac/main/source/pitch_gain_tables.h \
   modules/audio_coding/codecs/isac/main/source/pitch_lag_tables.h \
   modules/audio_coding/codecs/isac/main/source/settings.h \
   modules/audio_coding/codecs/isac/main/source/spectrum_ar_model_tables.h \
   modules/audio_coding/codecs/isac/main/source/structs.h \
   modules/audio_coding/codecs/isac/main/include/isac.h

win32{
    HEADERS += \
	 base/win32.h \
	  base/unixfilesystem.h \
	system_wrappers/include/fix_interlocked_exchange_pointer_win.h \
	system_wrappers/include/utf_util_win.h \
	system_wrappers/source/condition_variable_event_win.h \
	system_wrappers/source/event_timer_win.h \
	system_wrappers/source/trace_win.h \
	system_wrappers/source/rw_lock_win.h \
    system_wrappers/include/utf_util_win.h \
	system_wrappers/source/rw_lock_winxp_win.h 
}

macx {
    HEADERS += \
    base/posix.h \  
    base/maccocoathreadhelper.h \
	base/macutils.h \
    system_wrappers/source/trace_posix.h \
    system_wrappers/source/rw_lock_posix.h \
    system_wrappers/source/event_timer_posix.h \
}

SOURCES += audiooptimize.cc \
	base/asyncfile.cc \
    base/asyncinvoker.cc \
    base/asyncpacketsocket.cc \
	base/asyncresolverinterface.cc \
    base/asyncsocket.cc \
    base/bandwidthsmoother.cc \
    base/base64.cc \
    base/common.cc \
    base/crc32.cc \
    base/cryptstring.cc \
    base/dbus.cc \
    base/filerotatingstream.cc \
	base/fileutils.cc \
    base/flags.cc \
    base/ipaddress.cc \
    base/libdbusglibsymboltable.cc \
    base/logsinks.cc \
	base/location.cc \
    base/messagehandler.cc \
	base/messagequeue.cc \
    base/nethelpers.cc \
	base/nullsocketserver.cc \
    base/pathutils.cc \
    base/physicalsocketserver.cc \
	base/ratelimiter.cc \
	#base/rtccertificate.cc \
	base/sharedexclusivelock.cc \
    base/signalthread.cc \
    base/sigslot.cc \
    base/socketaddress.cc \
    base/stream.cc \
    base/thread.cc \
    base/timing.cc \
    base/transformadapter.cc \
    base/urlencode.cc \
    base/versionparsing.cc \
    common_audio/resampler/resampler.cc \
    common_audio/vad/vad.cc \
    common_audio/audio_converter.cc \
    common_audio/audio_ring_buffer.cc \
    common_audio/audio_util.cc \
    common_audio/blocker.cc \
    common_audio/fir_filter.cc \
    common_audio/lapped_transform.cc \
    common_audio/real_fourier.cc \
    common_audio/real_fourier_ooura.cc \
    common_audio/sparse_fir_filter.cc \
    common_audio/wav_file.cc \
    common_audio/wav_header.cc \
    common_audio/window_generator.cc \
    modules/audio_processing/agc/agc.cc \
    modules/audio_processing/agc/agc_manager_direct.cc \
	modules/audio_processing/agc/loudness_histogram.cc \
    modules/audio_processing/agc/utility.cc \
    modules/audio_processing/beamformer/array_util.cc \
    modules/audio_processing/beamformer/covariance_matrix_generator.cc \
    modules/audio_processing/beamformer/nonlinear_beamformer.cc \
    modules/audio_processing/intelligibility/intelligibility_enhancer.cc \
    modules/audio_processing/intelligibility/intelligibility_utils.cc \
	modules/audio_processing/logging/apm_data_dumper.cc \
    modules/audio_processing/transient/moving_moments.cc \
    modules/audio_processing/transient/transient_detector.cc \
    modules/audio_processing/transient/transient_suppressor.cc \
    modules/audio_processing/transient/wpd_node.cc \
    modules/audio_processing/transient/wpd_tree.cc \
    modules/audio_processing/vad/gmm.cc \
    modules/audio_processing/vad/pitch_based_vad.cc \
    modules/audio_processing/vad/pitch_internal.cc \
    modules/audio_processing/vad/pole_zero_filter.cc \
    modules/audio_processing/vad/standalone_vad.cc \
    modules/audio_processing/vad/vad_audio_proc.cc \
    modules/audio_processing/vad/vad_circular_buffer.cc \
    modules/audio_processing/vad/voice_activity_detector.cc \
    modules/audio_processing/audio_buffer.cc \
    modules/audio_processing/audio_processing_impl.cc \
    modules/audio_processing/echo_cancellation_impl.cc \
    modules/audio_processing/echo_control_mobile_impl.cc \
    modules/audio_processing/gain_control_impl.cc \
	modules/audio_processing/gain_control_for_experimental_agc.cc \
    modules/audio_processing/high_pass_filter_impl.cc \
    modules/audio_processing/level_estimator_impl.cc \
	modules/audio_processing/level_controller/biquad_filter.cc \
	modules/audio_processing/level_controller/level_controller.cc \
	modules/audio_processing/level_controller/gain_applier.cc \
	modules/audio_processing/level_controller/gain_selector.cc \
	modules/audio_processing/level_controller/signal_classifier.cc \
	modules/audio_processing/level_controller/saturating_gain_estimator.cc \
	modules/audio_processing/level_controller/noise_level_estimator.cc \
	modules/audio_processing/level_controller/noise_spectrum_estimator.cc \
	modules/audio_processing/level_controller/peak_level_estimator.cc \
	modules/audio_processing/level_controller/down_sampler.cc \
    modules/audio_processing/noise_suppression_impl.cc \
    modules/audio_processing/rms_level.cc \
    modules/audio_processing/splitting_filter.cc \
    modules/audio_processing/three_band_filter_bank.cc \
    modules/audio_processing/typing_detection.cc \
    modules/audio_processing/voice_detection_impl.cc \
    system_wrappers/source/aligned_malloc.cc \
    system_wrappers/source/clock.cc \
    system_wrappers/source/cpu_features.cc \
    system_wrappers/source/cpu_info.cc \
    system_wrappers/source/data_log.cc \
    system_wrappers/source/data_log_c.cc \
    system_wrappers/source/event.cc \
    system_wrappers/source/file_impl.cc \
    system_wrappers/source/logging.cc \
    system_wrappers/source/rtp_to_ntp.cc \
    system_wrappers/source/rw_lock.cc \
    system_wrappers/source/sleep.cc \
    system_wrappers/source/sort.cc \
	#system_wrappers/source/tick_util.cc \
    system_wrappers/source/timestamp_extrapolator.cc \
    system_wrappers/source/trace_impl.cc \
    common_types.cc \
    config.cc \
	common_audio/signal_processing/spl_inl.c \
    common_audio/signal_processing/auto_corr_to_refl_coef.c \
    common_audio/signal_processing/auto_correlation.c \
    common_audio/signal_processing/complex_bit_reverse.c \
    common_audio/signal_processing/complex_fft.c \
    common_audio/signal_processing/copy_set_operations.c \
    common_audio/signal_processing/cross_correlation.c \
    common_audio/signal_processing/division_operations.c \
    common_audio/signal_processing/dot_product_with_scale.c \
    common_audio/signal_processing/downsample_fast.c \
    common_audio/signal_processing/energy.c \
    common_audio/signal_processing/filter_ar.c \
    common_audio/signal_processing/filter_ar_fast_q12.c \
    common_audio/signal_processing/filter_ma_fast_q12.c \
    common_audio/signal_processing/get_hanning_window.c \
    common_audio/signal_processing/get_scaling_square.c \
    common_audio/signal_processing/ilbc_specific_functions.c \
    common_audio/signal_processing/levinson_durbin.c \
    common_audio/signal_processing/lpc_to_refl_coef.c \
    common_audio/signal_processing/min_max_operations.c \
    common_audio/signal_processing/randomization_functions.c \
    common_audio/signal_processing/real_fft.c \
    common_audio/signal_processing/refl_coef_to_lpc.c \
    common_audio/signal_processing/resample.c \
    common_audio/signal_processing/resample_48khz.c \
    common_audio/signal_processing/resample_by_2.c \
    common_audio/signal_processing/resample_by_2_internal.c \
    common_audio/signal_processing/resample_fractional.c \
    common_audio/signal_processing/spl_init.c \
    common_audio/signal_processing/spl_sqrt.c \
    common_audio/signal_processing/spl_sqrt_floor.c \
    common_audio/signal_processing/sqrt_of_one_minus_x_squared.c \
    common_audio/signal_processing/vector_scaling_operations.c \
    common_audio/vad/vad_core.c \
    common_audio/vad/vad_filterbank.c \
    common_audio/vad/vad_gmm.c \
    common_audio/vad/vad_sp.c \
    common_audio/vad/webrtc_vad.c \
    common_audio/fft4g.c \
    common_audio/ring_buffer.c \
	modules/audio_processing/aec/aec_core.cc \
        modules/audio_processing/aec/aec_core_sse2.cc \
	#modules/audio_processing/aec/aec_core_mips.cc \
	#modules/audio_processing/aec/aec_core_neon.cc \
        modules/audio_processing/aec/aec_rdft.cc \
	#modules/audio_processing/aec/aec_rdft_mips.cc \
	#modules/audio_processing/aec/aec_rdft_neon.cc \
	modules/audio_processing/aec/aec_rdft_sse2.cc \
	modules/audio_processing/aec/aec_resampler.cc \
	modules/audio_processing/aec/echo_cancellation.cc \
	modules/audio_processing/aecm/aecm_core.cc \
	modules/audio_processing/aecm/aecm_core_c.cc \
	modules/audio_processing/aecm/echo_control_mobile.cc \
	modules/audio_processing/agc/legacy/analog_agc.c \
	modules/audio_processing/agc/legacy/digital_agc.c \
	modules/audio_processing/utility/delay_estimator.cc \
	modules/audio_processing/utility/delay_estimator_wrapper.cc \
	modules/audio_processing/utility/block_mean_calculator.cc \
    base/criticalsection.cc \
    base/timeutils.cc \
    base/checks.cc \
    base/stringutils.cc \
    base/buffer.cc \
    base/platform_file.cc \
    base/stringencode.cc \
    base/bytebuffer.cc \
    base/platform_thread.cc \
    base/event_tracer.cc \
    common_audio/resampler/push_resampler.cc \
    common_audio/resampler/push_sinc_resampler.cc \
    common_audio/resampler/sinc_resampler.cc \
    common_audio/channel_buffer.cc \
    modules/audio_processing/ns/noise_suppression.c \
    modules/audio_processing/ns/noise_suppression_x.c \
    modules/audio_processing/ns/ns_core.c \
    modules/audio_processing/ns/nsx_core.c \
    modules/audio_processing/ns/nsx_core_c.c \
    base/systeminfo.cc \
    base/thread_checker_impl.cc \
    system_wrappers/source/metrics_default.cc \
    base/skl_logging.cc \
    base/skl_event.cc \
    common_audio/signal_processing/skl_splitting_filter.c \
    common_audio/fir_filter_sse.cc \
    modules/utility/source/audio_frame_operations.cc \
    common_audio/resampler/sinc_resampler_sse.cc \
    modules/audio_coding/codecs/isac/main/source/audio_decoder_isac.cc \
    modules/audio_coding/codecs/isac/main/source/audio_encoder_isac.cc \
    modules/audio_coding/codecs/isac/main/source/arith_routines_hist.c \
    modules/audio_coding/codecs/isac/main/source/arith_routines_logist.c \
    modules/audio_coding/codecs/isac/main/source/arith_routines.c \
    modules/audio_coding/codecs/isac/main/source/bandwidth_estimator.c \
    modules/audio_coding/codecs/isac/main/source/crc.c \
    modules/audio_coding/codecs/isac/main/source/decode_bwe.c \
    modules/audio_coding/codecs/isac/main/source/decode.c \
    modules/audio_coding/codecs/isac/main/source/encode_lpc_swb.c \
    modules/audio_coding/codecs/isac/main/source/encode.c \
    modules/audio_coding/codecs/isac/main/source/entropy_coding.c \
    modules/audio_coding/codecs/isac/main/source/fft.c \
    modules/audio_coding/codecs/isac/main/source/filter_functions.c \
    modules/audio_coding/codecs/isac/main/source/filterbank_tables.c \
    modules/audio_coding/codecs/isac/main/source/filterbanks.c \
    modules/audio_coding/codecs/isac/main/source/intialize.c \
    modules/audio_coding/codecs/isac/main/source/isac.c \
    modules/audio_coding/codecs/isac/main/source/lattice.c \
    modules/audio_coding/codecs/isac/main/source/lpc_analysis.c \
    modules/audio_coding/codecs/isac/main/source/lpc_gain_swb_tables.c \
    modules/audio_coding/codecs/isac/main/source/lpc_shape_swb12_tables.c \
    modules/audio_coding/codecs/isac/main/source/lpc_shape_swb16_tables.c \
    modules/audio_coding/codecs/isac/main/source/lpc_tables.c \
    modules/audio_coding/codecs/isac/main/source/pitch_estimator.c \
    modules/audio_coding/codecs/isac/main/source/pitch_filter.c \
    modules/audio_coding/codecs/isac/main/source/pitch_gain_tables.c \
    modules/audio_coding/codecs/isac/main/source/pitch_lag_tables.c \
    modules/audio_coding/codecs/isac/main/source/spectrum_ar_model_tables.c \
    modules/audio_coding/codecs/isac/main/source/transform.c \
    modules/audio_coding/codecs/audio_decoder.cc \
    modules/audio_coding/codecs/audio_encoder.cc \
    modules/audio_coding/codecs/isac/locked_bandwidth_info.cc \

win32{
    SOURCES += \
    base/winping.cc \
	base/win32.cc \
	base/win32filesystem.cc \
	base/win32socketinit.cc \
    system_wrappers/source/atomic32_win.cc \
    system_wrappers/source/trace_win.cc  \
	system_wrappers/source/rw_lock_win.cc \
    system_wrappers/source/rw_lock_winxp_win.cc \
	system_wrappers/source/event_timer_win.cc \
	system_wrappers/source/condition_variable_event_win.cc \
}

macx{
    SOURCES += \
	  base/posix.cc \
	  base/macutils.cc \
	  base/unixfilesystem.cc \
	  #system_wrappers/source/aligned_malloc.cc \
	  system_wrappers/source/atomic32_darwin.cc \
	  #system_wrappers/source/atomic32_posix.cc \
      system_wrappers/source/event_timer_posix.cc \
      system_wrappers/source/rw_lock_posix.cc \
      system_wrappers/source/trace_posix.cc \
}

OBJECTIVE_SOURCES += \
   base/scoped_autorelease_pool.mm \
   base/maccocoathreadhelper.mm \
   base/logging_mac.mm
