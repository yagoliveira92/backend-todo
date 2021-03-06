import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf/shelf.dart';

import '../../../config/env_config.dart';
import '../../core/jwt_controller.dart';
import '../../model/todo_model.dart';

class EditTaskController {
  static handle(Request request) async {
    Map<String, dynamic> response = json.decode(await request.readAsString());
    Map<String, String> queryString = request.url.queryParameters;
    TodoModel taskObject = TodoModel(
      id: ObjectId(),
      dateToEnd: DateTime.now(),
      description: '',
      isDone: false,
      taskName: '',
    );
    final db = await Db.create(Env.mongoUrl);
    await db.open();
    final store = db.collection('tasks');
    final userToken = await JWTController.getUserJWT(request: request);
    final searchResultTask = await store.findOne(
      where.id(
        ObjectId.fromHexString(queryString['task-id'] ?? ''),
      ),
    );
    if (searchResultTask == null) {
      return Response.notFound(
          JsonEncoder.withIndent(' ').convert({'error': 'Não encontrado'}));
    }
    taskObject = TodoModel.fromMap(searchResultTask);
    final taskUpdate = taskObject.copyWith(
      dateToEnd: response['date-to-end'] != null
          ? DateTime.parse(response['date-to-end'] ?? '')
          : null,
      description: response['description'],
      isDone:
          response['is-done'] != null ? response['is-done'] == 'true' : null,
      taskName: response['task-name'],
    );
    final result = await store.updateOne(
      where
          .eq('_id', ObjectId.fromHexString(queryString['task-id']!))
          .eq('user-id', userToken!.id!.$oid),
      ModifierBuilder()
          .set('task-name', taskUpdate.taskName)
          .set('is-done', taskUpdate.isDone)
          .set('description', taskUpdate.description)
          .set('date-to-end', taskUpdate.dateToEnd),
    );
    db.close();
    return Response.ok(
      JsonEncoder.withIndent(' ').convert({'is_success': result.isSuccess}),
    );
  }
}
