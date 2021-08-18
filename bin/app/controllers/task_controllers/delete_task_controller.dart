import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf/shelf.dart';

import '../../../config/env_config.dart';

class DeleteTaskController {
  static handle(Request request) async {
    Map<String, String> queryString = request.url.queryParameters;
    final db = await Db.create(Env.mongoUrl);
    await db.open();
    final store = db.collection('tasks');
    final result = await store.deleteOne(
      where.id(
        ObjectId.fromHexString(queryString['task-id'] ?? ''),
      ),
    );
    db.close();
    return Response.ok(
      JsonEncoder.withIndent(' ').convert({'is_success': result.isSuccess}),
    );
  }
}
