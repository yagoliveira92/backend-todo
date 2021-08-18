import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf/shelf.dart';

import '../../../config/env_config.dart';
import '../../core/jwt_controller.dart';
import '../../model/todo_model.dart';

class CreateTaskController {
  static handle(Request request) async {
    Map<String, dynamic> response = json.decode(await request.readAsString());
    final db = await Db.create(Env.mongoUrl);
    await db.open();
    final store = db.collection('tasks');
    final todo = TodoModel.fromMap(response);
    final userToken = await JWTController.getUserJWT(request: request);
    final todoTask = todo.toMap();
    todoTask.addAll({'user-id': userToken!.id!.$oid});
    final result = await store.insert(todoTask);
    db.close();
    return Response.ok(
      JsonEncoder.withIndent(' ').convert(result),
    );
  }
}
