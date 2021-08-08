// Copyright (c) 2021, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'app/interceptors/auth_interceptor.dart';
import 'app/routes/routes.dart';

Future main() async {
  final port = int.parse(Platform.environment['PORT'] ?? '8080');

  var handler = const Pipeline()
      .addMiddleware(AuthMiddleware.handle())
      .addMiddleware(logRequests())
      .addHandler(
        Routes.routes(),
      );

  final server = await shelf_io.serve(
    handler,
    InternetAddress.anyIPv4, // Allows external connections
    port,
  );

  print('Serving at http://${server.address.host}:${server.port}');
}
