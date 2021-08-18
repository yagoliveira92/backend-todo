import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf/shelf.dart';

import '../../../config/env_config.dart';
import '../../core/jwt_controller.dart';
import '../../model/todo_model.dart';

class ReadTaskController {
  static handle(Request request) async {
    Map<String, String> queryString = request.url.queryParameters;
    final db = await Db.create(Env.mongoUrl);
    await db.open();
    final store = db.collection('tasks');
    final userToken = await JWTController.getUserJWT(request: request);
    List<TodoModel> searchResultTask = [];
    if (queryString['task-id'] != null) {
      final result = await store.findOne(
        where
            .id(
              ObjectId.fromHexString(queryString['task-id'] ?? ''),
            )
            .eq('user-id', userToken?.id!.$oid),
      );
      if (result == null) {
        return Response.notFound(
            JsonEncoder.withIndent(' ').convert({'error': 'Não encontrado'}));
      }
      searchResultTask.add(TodoModel.fromMap(result));
    } else {
      final result = await store
          .find(
            where.eq('user-id', userToken?.id!.$oid),
          )
          .toList();
      searchResultTask = result.map((json) => TodoModel.fromMap(json)).toList();
    }
    final resultList = searchResultTask.map((todo) => todo.toMap()).toList();
    db.close();
    return Response.ok(
      JsonEncoder.withIndent(' ').convert(resultList),
    );
  }
}
