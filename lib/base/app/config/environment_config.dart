// Copyright (c) 2023, Prime Holding JSC
// https://www.primeholding.com
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:io';

/// Environment configuration that enables you to define and read
/// environment specific properties (such as API endpoints, server secrets, ...)
enum EnvironmentConfig {
  development(
      androidEmulatorBaseApiUrl: 'https://api.themoviedb.org/',
      iosSimulatorBaseApiUrl: 'https://api.themoviedb.org/'),

  sit(
      androidEmulatorBaseApiUrl: 'https://api.themoviedb.org/',
      iosSimulatorBaseApiUrl: 'https://api.themoviedb.org/'),

  uat(
      androidEmulatorBaseApiUrl: 'https://api.themoviedb.org/',
      iosSimulatorBaseApiUrl: 'https://api.themoviedb.org/'),

  production(
      androidEmulatorBaseApiUrl: 'https://api.themoviedb.org/',
      iosSimulatorBaseApiUrl: 'https://api.themoviedb.org/');

  final String androidEmulatorBaseApiUrl;
  final String iosSimulatorBaseApiUrl;

  const EnvironmentConfig({
    required this.androidEmulatorBaseApiUrl,
    required this.iosSimulatorBaseApiUrl,
  });

  String get baseUrl =>
      Platform.isIOS ? iosSimulatorBaseApiUrl : androidEmulatorBaseApiUrl;
}
