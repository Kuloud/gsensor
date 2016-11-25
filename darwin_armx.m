// Copyright 2015 The Go Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// +build darwin
// +build arm arm64

#import <CoreMotion/CoreMotion.h>

CMMotionManager* manager = nil;
const double G = 9.80663;

void GoIOS_createManager() {
  manager = [[CMMotionManager alloc] init];
}

void GoIOS_startAccelerometer(float interval) {
  manager.accelerometerUpdateInterval = interval;
  [manager startAccelerometerUpdates];
}

void GoIOS_stopAccelerometer() {
  [manager stopAccelerometerUpdates];
}

void GoIOS_readAccelerometer(int64_t* timestamp, float* v) {
  CMAccelerometerData* data = manager.accelerometerData;
  *timestamp = (int64_t)(data.timestamp * 1000 * 1000);
  v[0] = data.acceleration.x;
  v[1] = data.acceleration.y;
  v[2] = data.acceleration.z;
}

void GoIOS_startGyro(float interval) {
  manager.gyroUpdateInterval = interval;
  [manager startGyroUpdates];
}

void GoIOS_stopGyro() {
  [manager stopGyroUpdates];
}

void GoIOS_readGyro(int64_t* timestamp, float* v) {
  CMGyroData* data = manager.gyroData;
  *timestamp = (int64_t)(data.timestamp * 1000 * 1000);
  v[0] = data.rotationRate.x;
  v[1] = data.rotationRate.y;
  v[2] = data.rotationRate.z;
}

void GoIOS_startMagneto(float interval) {
  manager.magnetometerUpdateInterval = interval;
  [manager startMagnetometerUpdates];
}

void GoIOS_stopMagneto() {
  [manager stopMagnetometerUpdates];
}

void GoIOS_readMagneto(int64_t* timestamp, float* v) {
  CMMagnetometerData* data = manager.magnetometerData;
  *timestamp = (int64_t)(data.timestamp * 1000 * 1000);
  v[0] = data.magneticField.x;
  v[1] = data.magneticField.y;
  v[2] = data.magneticField.z;
}

void GoIOS_startGravity(float interval) {
  manager.deviceMotionUpdateInterval = interval;
  [manager startDeviceMotionUpdates];
}
void GoIOS_stopGravity() {
  [manager stopDeviceMotionUpdates];
}
void GoIOS_readGravity(int64_t* timestamp, float* vector) {
  CMDeviceMotion* data = manager.deviceMotion;
  *timestamp = (int64_t)(data.timestamp * 1000 * 1000);
  v[0] = data.gravity.x * G;
  v[1] = data.gravity.y * G;
  v[2] = data.gravity.z * G;
}

void GoIOS_destroyManager() {
  [manager release];
  manager = nil;
}
