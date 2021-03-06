// Copyright 2016-present, Facebook, Inc.
// All rights reserved.
//
// This source code is licensed under the license found in the
// LICENSE file in the root directory of this source tree.

#ifndef TH_GENERIC_FILE_
#define TH_GENERIC_FILE_ "generic/GPU/MaxPooling.cu"
#else
#include "MaxPooling.h"
#include "RuleBookIterator.h"

extern "C" void scn_DR_(MaxPooling_updateOutput)(
    THLongTensor *inputSize, THLongTensor *outputSize, THLongTensor *poolSize,
    THLongTensor *poolStride, void **m, THCTensor *input_features,
    THCTensor *output_features, long nFeaturesToDrop) {

  SCN_INITIALIZE_AND_REFERENCE(Metadata<Dimension>, m)
  uInt nPlanes = input_features->size[1] - nFeaturesToDrop;
  auto _rules =
      _m.getRuleBook(inputSize, outputSize, poolSize, poolStride, true);
  uInt nActive = _m.getNActive(outputSize);
  THCTensor_(resize2d)(state, output_features, nActive, nPlanes);
  THCTensor_(zero)(state, output_features);

  auto iF = THCTensor_(data)(state, input_features) + nFeaturesToDrop;
  auto oF = THCTensor_(data)(state, output_features);
  RULEBOOKITERATOR(
      MaxPooling_ForwardPass<real>(THCState_getCurrentStream(state), iF, oF,
                                   nPlanes, input_features->size[1],
                                   output_features->size[1], rbB, nHotB);
      , )
}
extern "C" void scn_DR_(MaxPooling_updateGradInput)(
    THLongTensor *inputSize, THLongTensor *outputSize, THLongTensor *poolSize,
    THLongTensor *poolStride, void **m, THCTensor *input_features,
    THCTensor *d_input_features, THCTensor *output_features,
    THCTensor *d_output_features, long nFeaturesToDrop) {

  SCN_INITIALIZE_AND_REFERENCE(Metadata<Dimension>, m)
  uInt nPlanes = input_features->size[1] - nFeaturesToDrop;
  auto _rules =
      _m.getRuleBook(inputSize, outputSize, poolSize, poolStride, true);
  uInt nActive = _m.getNActive(outputSize);
  THCTensor_(resizeAs)(state, d_input_features, input_features);
  THCTensor_(zero)(state, d_input_features);

  auto iF = THCTensor_(data)(state, input_features);
  auto oF = THCTensor_(data)(state, output_features);
  auto diF = THCTensor_(data)(state, d_input_features);
  auto doF = THCTensor_(data)(state, d_output_features);
  RULEBOOKITERATOR(
      MaxPooling_BackwardPass<real>(THCState_getCurrentStream(state), iF, diF,
                                    oF, doF, nPlanes, input_features->size[1],
                                    d_output_features->size[1], rbB, nHotB);
      , )
}
extern "C" void scn_DR_(RandomizedStrideMaxPooling_updateOutput)(
    THLongTensor *inputSize, THLongTensor *outputSize, THLongTensor *poolSize,
    THLongTensor *poolStride, void **m, THCTensor *input_features,
    THCTensor *output_features, long nFeaturesToDrop) {

  SCN_INITIALIZE_AND_REFERENCE(Metadata<Dimension>, m)
  uInt nPlanes = input_features->size[1] - nFeaturesToDrop;
  auto _rules =
      _m.getRandomizedStrideRuleBook(inputSize, outputSize, poolSize, poolStride, true);
  uInt nActive = _m.getNActive(outputSize);
  THCTensor_(resize2d)(state, output_features, nActive, nPlanes);
  THCTensor_(zero)(state, output_features);

  auto iF = THCTensor_(data)(state, input_features) + nFeaturesToDrop;
  auto oF = THCTensor_(data)(state, output_features);
  RULEBOOKITERATOR(
      MaxPooling_ForwardPass<real>(THCState_getCurrentStream(state), iF, oF,
                                   nPlanes, input_features->size[1],
                                   output_features->size[1], rbB, nHotB);
      , )
}
extern "C" void scn_DR_(RandomizedStrideMaxPooling_updateGradInput)(
    THLongTensor *inputSize, THLongTensor *outputSize, THLongTensor *poolSize,
    THLongTensor *poolStride, void **m, THCTensor *input_features,
    THCTensor *d_input_features, THCTensor *output_features,
    THCTensor *d_output_features, long nFeaturesToDrop) {

  SCN_INITIALIZE_AND_REFERENCE(Metadata<Dimension>, m)
  uInt nPlanes = input_features->size[1] - nFeaturesToDrop;
  auto _rules =
      _m.getRandomizedStrideRuleBook(inputSize, outputSize, poolSize, poolStride, true);
  uInt nActive = _m.getNActive(outputSize);
  THCTensor_(resizeAs)(state, d_input_features, input_features);
  THCTensor_(zero)(state, d_input_features);

  auto iF = THCTensor_(data)(state, input_features);
  auto oF = THCTensor_(data)(state, output_features);
  auto diF = THCTensor_(data)(state, d_input_features);
  auto doF = THCTensor_(data)(state, d_output_features);
  RULEBOOKITERATOR(
      MaxPooling_BackwardPass<real>(THCState_getCurrentStream(state), iF, diF,
                                    oF, doF, nPlanes, input_features->size[1],
                                    d_output_features->size[1], rbB, nHotB);
      , )
}
#endif
