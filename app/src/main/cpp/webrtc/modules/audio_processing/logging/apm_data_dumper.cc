/*
 *  Copyright (c) 2016 The WebRTC project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#include "webrtc/modules/audio_processing/logging/apm_data_dumper.h"

#include <sstream>

#include "webrtc/base/stringutils.h"

// Check to verify that the define is properly set.
#if !defined(WEBRTC_AEC_DEBUG_DUMP) || \
    (WEBRTC_AEC_DEBUG_DUMP != 0 && WEBRTC_AEC_DEBUG_DUMP != 1)
//#error "Set WEBRTC_AEC_DEBUG_DUMP to either 0 or 1"
#endif

namespace webrtc {

namespace {

#if WEBRTC_AEC_DEBUG_DUMP == 1
std::string FormFileName(const char* name,
                         int instance_index,
                         int reinit_index,
                         const std::string& suffix) {
  std::stringstream ss;
  ss << name << "_" << instance_index << "-" << reinit_index << suffix;
  return ss.str();
}
#endif

}  // namespace

#if WEBRTC_AEC_DEBUG_DUMP == 1
FILE* ApmDataDumper::GetRawFile(const char* name) {
  std::string filename =
      FormFileName(name, instance_index_, recording_set_index_, ".dat");
  auto& f = raw_files_[filename];
  if (!f) {
    f.reset(fopen(filename.c_str(), "wb"));
  }
  return f.get();
}

WavWriter* ApmDataDumper::GetWavFile(const char* name,
                                     int sample_rate_hz,
                                     int num_channels) {
  std::string filename =
      FormFileName(name, instance_index_, recording_set_index_, ".wav");
  auto& f = wav_files_[filename];
  if (!f) {
    f.reset(new WavWriter(filename.c_str(), sample_rate_hz, num_channels));
  }
  return f.get();
}

#endif

}  // namespace webrtc
